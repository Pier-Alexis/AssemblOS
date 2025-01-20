; filepath: /user/auth.asm
BITS 32

section .data
    username db 'admin', 0
    password db 'password', 0

section .text
global authenticate

authenticate:
    ; Authentifier l'utilisateur
    ret
