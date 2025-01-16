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
; Charger le noyau
mov bx, 0x1000  ; Adresse de chargement du noyau
mov dh, 0x02    ; Nombre de secteurs à lire
mov dl, 0x00    ; Numéro de disque (0x00 pour le disque de démarrage)
mov ch, 0x00    ; Numéro de piste
mov cl, 0x02    ; Numéro de secteur (le premier secteur après le bootloader)
mov ah, 0x02    ; Fonction de lecture de secteur
int 0x13        ; Appel d'interruption du BIOS pour lire le secteur

; Vérifier si la lecture a réussi
jc disk_error   ; S'il y a une erreur, sauter à disk_error

; Sauter à l'adresse de chargement du noyau
jmp 0x1000:0000

disk_error:
; Afficher un message d'erreur
mov si, err_msg
print_err:
lodsb
cmp al, 0
je hang
mov ah, 0x0E
int 0x10
jmp print_err

err_msg db 'Erreur de chargement du noyau!', 0
    ; Boucle infinie
hang:
    hlt
    jmp hang

msg db 'Stage2 loaded!', 0

times 510-($-$$) db 0
dw 0xAA55