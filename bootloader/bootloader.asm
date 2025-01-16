; filepath: /boot/boot.asm
BITS 16
ORG 0x7C00

start:
    ; Initialisation du segment de pile
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Afficher un message
    mov si, msg
print:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0E
    int 0x10
    jmp print
done:

    ; Charger le kernel
    mov bx, 0x1000
    mov dh, 1
    mov dl, 0
    mov ch, 0
    mov cl, 2
    mov ah, 0x02
    int 0x13

    ; Passer en mode protégé
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:protected_mode

[bits 32]
protected_mode:
    ; Initialisation des segments
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000

    ; Appeler le kernel
    call 0x1000

hang:
    hlt
    jmp hang

msg db 'Booting...', 0

gdt_start:
    dq 0x0000000000000000
    dq 0x00CF9A000000FFFF
    dq 0x00CF92000000FFFF
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

times 510-($-$$) db 0
dw 0xAA55