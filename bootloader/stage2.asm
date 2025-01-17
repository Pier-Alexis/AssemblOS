; filepath: /home/pariki/AssemblOS/bootloader/bootloader.asm
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

    ; Charger le stage2
    mov bx, 0x2000
    mov dh, 1
    mov dl, 0
    mov ch, 0
    mov cl, 2
    mov ah, 0x02
    int 0x13
    jc load_error

    ; Sauter à stage2
    jmp 0x2000:0x0000

load_error:
    ; Afficher un message d'erreur
    mov si, err_msg
print_error:
    lodsb
    cmp al, 0
    je hang
    mov ah, 0x0E
    int 0x10
    jmp print_error

hang:
    hlt
    jmp hang

err_msg db 'Erreur de chargement du stage2', 0

times 510-($-$$) db 0
dw 0xAA55