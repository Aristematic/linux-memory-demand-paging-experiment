#!/bin/bash

nasm -f elf64 memstress.asm -o memstress.o
ld memstress.o -o memstress

echo "Build complete"