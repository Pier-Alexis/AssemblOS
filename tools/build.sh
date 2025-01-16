#!/bin/bash

nasm -f bin -o boot.bin boot/boot.asm
nasm -f bin -o kernel.bin kernel/kernel.asm

cat boot.bin kernel.bin > os-image.bin

qemu-system-x86_64 -drive format=raw,file=os-image.bin