; filepath: /home/pariki/AssemblOS/stage2/stage2.asm
BITS 16
ORG 0x2000

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

    ; Boucle infinie
hang:
    hlt
    jmp hang

msg db 'Stage2 loaded!', 0

times 510-($-$$) db 0
dw 0xAA55