; filepath: /bootloader/bootloader.asm
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

    ; Afficher le menu de démarrage
    mov si, boot_menu
    call print_string

    ; Lire la sélection de l'utilisateur
    mov ah, 0x00
    int 0x16

    ; Vérifier la sélection
    cmp al, '1'
    je load_stage2
    cmp al, '2'
    je load_recovery
    jmp hang

load_stage2:
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

load_recovery:
    ; Charger le mode de récupération
    mov bx, 0x3000
    mov dh, 1
    mov dl, 0
    mov ch, 0
    mov cl, 3
    mov ah, 0x02
    int 0x13
    jc load_error

    ; Sauter au mode de récupération
    jmp 0x3000:0x0000

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

boot_menu db '1. Démarrer le système', 0x0D, 0x0A, '2. Mode de récupération', 0x0D, 0x0A, 'Choisissez une option: ', 0
err_msg db 'Erreur de chargement', 0

print_string:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0E
    int 0x10
    jmp print_string
done:
    ret

times 510-($-$$) db 0
dw 0xAA55
