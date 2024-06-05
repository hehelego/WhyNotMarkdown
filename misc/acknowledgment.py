from base64 import b64encode as enc, b64decode as dec
from sys import stderr
def proc(msg): m=msg.split(",")[0]; m=m+m; return m+dec(b"LOS7peS4int95a2X5Z2H5Li65pys5Lq66K6k55yf5pKw5YaZ").decode().format(len(m))
message = b'5oSf6LCi'
quine = 'from base64 import b64encode as enc, b64decode as dec\nfrom sys import stderr\ndef proc(msg): m=msg.split(",")[0]; m=m+m; return m+dec(b"LOS7peS4int95a2X5Z2H5Li65pys5Lq66K6k55yf5pKw5YaZ").decode().format(len(m))\nmessage = {0}\nquine = {1}\nnew = proc(dec(message).decode())\nprint(new, file=stderr)\nprint(quine.format(enc(new.encode()), repr(quine)))'
new = proc(dec(message).decode())
print(new, file=stderr)
print(quine.format(enc(new.encode()), repr(quine)))
