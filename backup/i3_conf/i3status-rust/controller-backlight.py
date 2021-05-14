import subprocess

from PyQt5.QtWidgets import (QApplication, QWidget, QSlider, QLCDNumber, QVBoxLayout, QPushButton)
from PyQt5.QtCore import Qt

class backlightController(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()
    def setBrightness(self):
        v = self.sld.value()
        print(f'change applied {v}')
        subprocess.run(['xbacklight','-set',f'{v}'])

    def initUI(self):
        self.btn = QPushButton("apply change",self)
        self.lcd = QLCDNumber(self)
        self.sld = QSlider(Qt.Horizontal, self)

        self.sld.setMinimum(0)
        self.sld.setMaximum(100)
        self.sld.valueChanged.connect(self.lcd.display)
        self.btn.clicked.connect(self.setBrightness)

        self.vbox = QVBoxLayout()
        self.vbox.addWidget(self.lcd)
        self.vbox.addWidget(self.sld)
        self.vbox.addWidget(self.btn)
        self.setLayout(self.vbox)
        self.setGeometry(0, 0, 1200, 800)
        self.setWindowTitle('backlight brightness controller (press <Esc> to exit)')
        self.show()
    def keyPressEvent(self, e):
        if e.key() == Qt.Key_Escape:
            self.close()

if __name__ == '__main__':
    import sys
    app = QApplication(sys.argv)
    window = backlightController()
    sys.exit(app.exec_())
