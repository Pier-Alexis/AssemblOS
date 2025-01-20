; filepath: /kernel/kernel.asm
BITS 32

extern isr0, isr1, isr2, isr3, isr4, isr5, isr6, isr7, isr8, isr9, isr10, isr11, isr12, isr13, isr14, isr15

global _start

_start:
    ; Initialisation du segment de pile
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov esp, 0x7C00

    ; Initialisation du contrôleur d'interruptions
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

    ; Configurer les ISR
    mov eax, isr0
    mov [0x00], eax
    mov eax, isr1
    mov [0x04], eax
    mov eax, isr2
    mov [0x08], eax
    mov eax, isr3
    mov [0x0C], eax
    mov eax, isr4
    mov [0x10], eax
    mov eax, isr5
    mov [0x14], eax
    mov eax, isr6
    mov [0x18], eax
    mov eax, isr7
    mov [0x1C], eax
    mov eax, isr8
    mov [0x20], eax
    mov eax, isr9
    mov [0x24], eax
    mov eax, isr10
    mov [0x28], eax
    mov eax, isr11
    mov [0x2C], eax
    mov eax, isr12
    mov [0x30], eax
    mov eax, isr13
    mov [0x34], eax
    mov eax, isr14
    mov [0x38], eax
    mov eax, isr15
    mov [0x3C], eax

    ; Activer les interruptions
    sti

    ; Boucle infinie
    jmp $
