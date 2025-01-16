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

; Répétez pour les autres ISR (isr2, isr3, ...)