; filepath: /kernel/isr.asm
BITS 32

global isr0, isr1, isr2, isr3, isr4, isr5, isr6, isr7, isr8, isr9, isr10, isr11, isr12, isr13, isr14, isr15

isr0:
    cli
    pusha
    mov al, '0'
    out 0xE9, al
    popa
    sti
    iret

isr1:
    cli
    pusha
    mov al, '1'
    out 0xE9, al
    popa
    sti
    iret

isr2:
    cli
    pusha
    mov al, '2'
    out 0xE9, al
    popa
    sti
    iret

isr3:
    cli
    pusha
    mov al, '3'
    out 0xE9, al
    popa
    sti
    iret

isr4:
    cli
    pusha
    mov al, '4'
    out 0xE9, al
    popa
    sti
    iret

isr5:
    cli
    pusha
    mov al, '5'
    out 0xE9, al
    popa
    sti
    iret

isr6:
    cli
    pusha
    mov al, '6'
    out 0xE9, al
    popa
    sti
    iret

isr7:
    cli
    pusha
    mov al, '7'
    out 0xE9, al
    popa
    sti
    iret

isr8:
    cli
    pusha
    mov al, '8'
    out 0xE9, al
    popa
    sti
    iret

isr9:
    cli
    pusha
    mov al, '9'
    out 0xE9, al
    popa
    sti
    iret

isr10:
    cli
    pusha
    mov al, 'A'
    out 0xE9, al
    popa
    sti
    iret

isr11:
    cli
    pusha
    mov al, 'B'
    out 0xE9, al
    popa
    sti
    iret

isr12:
    cli
    pusha
    mov al, 'C'
    out 0xE9, al
    popa
    sti
    iret

isr13:
    cli
    pusha
    mov al, 'D'
    out 0xE9, al
    popa
    sti
    iret

isr14:
    cli
    pusha
    mov al, 'E'
    out 0xE9, al
    popa
    sti
    iret

isr15:
    cli
    pusha
    mov al, 'F'
    out 0xE9, al
    popa
    sti
    iret
