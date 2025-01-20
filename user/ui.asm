; filepath: /user/ui.asm
BITS 32

section .data
    prompt db 'Command: ', 0

section .text
global ui_loop

ui_loop:
    ; Boucle de l'interface utilisateur
    ret
