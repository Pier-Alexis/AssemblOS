; filepath: /kernel/process.asm
BITS 32

section .data
    process_table times 10 dd 0  ; Table des processus

section .text
global create_process, switch_process

create_process:
    ; Créer un processus
    ret

switch_process:
    ; Changer de processus
    ret
