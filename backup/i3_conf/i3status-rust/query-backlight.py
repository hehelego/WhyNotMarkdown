#!/usr/bin/python
import subprocess
import math

def main():
    msg = None
    try:
        handler = subprocess.run(['xbacklight','-getf'],
                                 capture_output=True,
                                 timeout=3)
        data = handler.stdout.decode()
        msg = round(float(data))
        assert 0 <= msg <= 100
    except Exception as _:
        msg = 'ERR'
    output = f'\uf0eb {msg}'
    print(output)

if __name__=='__main__':
    main()
