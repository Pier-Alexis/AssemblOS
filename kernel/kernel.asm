; filepath: /kernel/kernel.asm
BITS 32

global start
start:
    ; Afficher un message
    mov edx, msg
print:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0E
    int 0x10
    jmp print
done:

    ; Initialisation des interruptions
    cli
    lidt [idt_descriptor]
    sti

    ; Boucle infinie
hang:
    hlt
    jmp hang

msg db 'Kernel loaded!', 0

idt_start:
    times 256 dq 0
idt_end:

idt_descriptor:
    dw idt_end - idt_start - 1
    dd idt_start