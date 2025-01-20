; filepath: /kernel/filesystem.asm
BITS 32

section .data
    file_table times 10 dd 0  ; Table des fichiers

section .text
global read_file, write_file

read_file:
    ; Lire un fichier
    ret

write_file:
    ; Écrire un fichier
    ret
