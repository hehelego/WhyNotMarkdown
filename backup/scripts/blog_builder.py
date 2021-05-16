#!/usr/bin/python

import os
import pprint
import queue
import re
import subprocess
import threading
from typing import Callable, List, Tuple, Dict

# List[Tuple[RegEx,Bool]]
# rules[(pattern, ruleType)]
# True : inclued path of this pattern
# False: exclude path of this pattern
pathRules = [
    (re.compile(r'course_note/'), True),
    (re.compile(r'record-and-tricks/'), True),
    (re.compile(r'杂谈/'), True),
    (re.compile(r'杂题/'), True),
    (re.compile(r'.*\.md$'), True),
    (re.compile(r'.*\.tex$'), True),

    (re.compile(r'static'), False),
    (re.compile(r'\.git'), False),
    (re.compile(r'.*\.py$'), False),
    (re.compile(r'.*\.vim$'), False),
    (re.compile(r'.*\.pdf$'), False),
]
def check(path:str, rules:List[Tuple[re.Pattern,bool]]) -> bool:
    c0,c1 = 0,0
    for (pattern, ruleType) in rules:
        if ruleType==True:
            c0 += 1 if re.search(pattern, path) else 0
        else:
            c1 += 1 if re.search(pattern, path) else 0
    return c0>0 and c1==0

# rules[(filetype, [suffix-extensions])]
filetypeRules = [
    ('markdown', ['md', 'markdown']),
    ('tex', ['latex', 'tex']),
    ('html', ['html', 'htm']),
]
def mimeQuery(path:str, rules:List[Tuple[str,List[str]]]) -> str:
    suf = path.split('.')[-1]
    for (ft,exts) in rules:
        if suf in exts:
            return ft
    return ''

class FileTree:
    def __init__(self, name:str, path:str) -> None:
        self.name = name
        self.path = path
        self.type = 'd' if os.path.isdir(path) else 'f'
        if self.type == 'd':
            self.path += '/'
            self.son = [FileTree(i, os.path.join(path, i)) for i in os.listdir(path)]
    def dump(self):
        if self.type == 'f':
            return self.path
        subInfo = [i.dump() for i in self.son]
        return {self.name: subInfo}
    def filter(self, rules:List[Tuple[re.Pattern,bool]]) -> None:
        self.son = [i for i in self.son if check(i.path, rules)]
        for i in filter(lambda s:s.type=='d',self.son):
            i.filter(rules)

class Converter:
    @staticmethod
    def wrapper(f:Callable, uuid:str, q:queue.Queue) -> Callable:
        def inner(*args,**kwargs) -> None:
            ret = f(*args, **kwargs)
            q.put((uuid,ret))
        return inner

    @staticmethod
    def run(cmd: List[str]) -> Dict:
        print(f'[DEBUG] running {cmd}')
        program = subprocess.run(cmd, capture_output=True)
        res = {
            'returncode': program.returncode,
            'stdout': program.stdout.decode(),
            'stderr': program.stderr.decode(),
        }
        return res

    @staticmethod
    def pandocToHTML(srcPath:str, destBase:str) -> Dict:
        # pandoc src.md -s -o page.html
        idx = srcPath.rfind('.')
        outputPath = ''
        if idx < 0:
            outputPath = os.path.join(destBase,srcPath+'.html')
        else:
            outputPath = os.path.join(destBase,srcPath[:idx]+'.html')
        return Converter.run(['pandoc', srcPath, '-s', '-o', outputPath, '--katex'])


    def __init__(self, fillTree:FileTree, destination:str):
        self.tree = fillTree
        self.dest = destination
        self.tasks:List[Tuple[str,str]] = []
        self.queue = queue.Queue()
        self.taskCnt = 0
        self.threads:List[threading.Thread] = []

    def convert(self) -> None:
        self.traverse(self.dest, self.tree)
        for i in map(lambda x:x[1],filter(lambda x:x[0]=='mkdir',self.tasks)):
            Converter.run(cmd=['mkdir', '-p', i])
        for i in map(lambda x:x[1],filter(lambda x:x[0]=='convert',self.tasks)):
            print(f'[LOG] start: converting {i}')
            thread = threading.Thread(
                target=Converter.wrapper(Converter.pandocToHTML, str(self.taskCnt), self.queue),
                kwargs=dict(
                    srcPath = i,
                    destBase = self.dest
                )
            )
            thread.start()
            self.threads.append(thread)
            self.taskCnt += 1
        for i in self.threads:
            i.join()
        while self.taskCnt > 0:
            uuid,msg = self.queue.get(block=True)
            if msg['returncode']==0:
                print(f'[LOG] task {uuid} succeeded')
            else:
                print(f'[LOG] task {uuid} failed: out={msg["stdout"]} err={msg["stderr"]}')
            self.taskCnt -= 1
        self.generateSiteMap()


    def traverse(self, prePath, treeNode:FileTree) -> None:
        prePath = os.path.join(prePath, treeNode.name)
        if treeNode.type == 'd':
            self.tasks.append(('mkdir',  prePath))
            for i in treeNode.son:
                self.traverse(prePath, i)
        else:
            self.tasks.append(('convert', treeNode.path))
    def generateSiteMap(self):
        tree = FileTree(self.dest,self.dest)
        siteMap = open('index.html','w')
        stack = []
        stack.append(tree)

        print(
'''<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>hehelego's github pages</title>
    </head>
<body>''',file=siteMap)
        level = 2
        while len(stack)>0:
            top = stack.pop()
            if type(top)==FileTree:
                node:FileTree = top
                if node.type=='d':
                    print(rf'<h{level}>{node.name}</h{level}> <ul>',file=siteMap)
                    stack.append(0)
                    stack.extend([s for s in node.son])
                    level += 1
                else:
                    print(rf'<li> <a href="{node.path}">{node.name}</a> </li>',file=siteMap)
            elif type(top)==int:
                print(r'</ul>',file=siteMap)
                level -= 1
            else:
                raise TypeError('Unexpected element in stack')
        print(
'''
</body>
</html>''',file=siteMap)
        siteMap.close()




def test():
    source = FileTree('WhyNotMarkdown', 'WhyNotMarkdown')
    source.filter(pathRules)
    pprint.pprint(source.dump())

def main():
    source = FileTree('WhyNotMarkdown', 'WhyNotMarkdown')
    source.filter(pathRules)
    convert = Converter(source, 'converted')
    convert.convert()

if __name__=='__main__':
    #  test()
    main()
