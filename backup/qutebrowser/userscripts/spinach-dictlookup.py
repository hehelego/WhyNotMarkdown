#!/usr/bin/python

from spinach_qutepy import Qute, Helper
import subprocess

# look up the selected word in YouDao dictionary using [ydcv-rs](https://github.com/farseerfc/ydcv-rs)
if __name__ == '__main__':
    qute = Qute()
    selected_text = qute.get_env('selected_text')
    if selected_text:
        Helper.log('selected:', selected_text)
        subprocess.run(['ydcv', '-n', selected_text])
