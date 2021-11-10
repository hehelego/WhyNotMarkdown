#!/usr/bin/python

from spinach_qutepy import Qute, Helper

if __name__ == '__main__':
    qute = Qute()
    selected_text = qute.get_env('selected_text')
    Helper.log('alert',f'jseval alert("{selected_text}")')
    qute.exec(f'jseval alert("{selected_text}")')
