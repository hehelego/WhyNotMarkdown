#! /usr/bin/python
if __name__=="__main__":
    def main(args):
        if len(args)<2:
            print('markdown->pdf helper(built on pandoc+xelatx)')
            print(f'usage:python {args[0]} {{name}}')
            print(f'\t{{name}}.md->{{name}}.pdf')
            return 
        from os import system as run
        name=args[1]
        run(f'pandoc {name}.md -o {name}.pdf  --template eisvogel --listings --pdf-engine=xelatex')
    main(__import__('sys').argv)

