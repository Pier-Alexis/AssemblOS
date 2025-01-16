; filepath: /kernel/kernel.asm
BITS 32

global start
extern isr0, isr1, isr2, isr3, isr4, isr5, isr6, isr7, isr8, isr9, isr10, isr11, isr12, isr13, isr14, isr15

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
    call setup_idt
    call remap_pic
    lidt [idt_descriptor]
    sti

    ; Boucle infinie
hang:
    hlt
    jmp hang

msg db 'Kernel loaded!', 0

setup_idt:
    ; Initialiser les entrées de l'IDT
    mov eax, isr0
    mov [idt + 0*8 + 0], ax
    shr eax, 16
    mov [idt + 0*8 + 6], ax
    ; Répétez pour les autres ISR (isr1, isr2, ...)
    ret

remap_pic:
    ; Remapper le PIC
    mov al, 0x11
    out 0x20, al
    out 0xA0, al
    mov al, 0x20
    out 0x21, al
    mov al, 0x28
    out 0xA1, al
    mov al, 0x04
    out 0x21, al
    mov al, 0x02
    out 0xA1, al
    mov al, 0x01
    out 0x21, al
    out 0xA1, al
    mov al, 0x0
    out 0x21, al
    out 0xA1, al
    ret

idt_start:
    times 256 dq 0
idt_end:

idt_descriptor:
    dw idt_end - idt_start - 1
    dd idt_start