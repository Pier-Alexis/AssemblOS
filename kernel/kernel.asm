bits 32

section .data
idt_pointer:
    dw 256 * 8 - 1       ; Taille de l'IDT
    dd idt_table         ; Adresse de l'IDT

section .bss
align 8
idt_table resb 256 * 8  ; 256 entrées, 8 octets par entrée

section .text
global start, load_idt

start:
    ; Initialisation du noyau
    call load_idt
    hlt

load_idt:
    ; Charger le registre IDT
    lidt [idt_pointer]
    ret
