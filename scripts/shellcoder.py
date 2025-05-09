#!/usr/bin/python3

import sys
from pwn import *

context(os="linux", arch="amd64", log_level="error")

file = ELF(sys.argv[1])
shellcode = file.section(".text")

# print generated shellcode
print(shellcode.hex())

# print byte count and whether there are null bytes
print("%d bytes - Found NULL Byte" % len(shellcode)) if [i for i in shellcode if i == 0] else print ("%d bytes - No NULL Bytes" % len(shellcode))