#!/bin/bash

nasm -f bin -o boot.bin boot/bootloader.asm
nasm -f bin -o cdrom.bin boot/cdrom.asm
nasm -f bin -o stage2.bin boot/stage2.asm


nasm -f bin -o kernel.bin kernel/kernel.asm
nasm -f bin -o hello.bin kernel/hello.asm
nasm -f bin -o isr.bin kernel/isr.asm

nasm -f bin -o hash.bin user/hash.asm
nasm -f bin -o preferences.bin user/preferences.asm
nasm -f bin -o user.bin /user/user.asm

nasm -f bin windows_init.bin
nasm -f bin windows_manager.bin

cat boot.bin kernel.bin > os-image.bin

qemu-system-x86_64 -drive format=raw,file=os-image.bin