; filepath: /kernel/memory.asm
BITS 32

section .data
    memory_start equ 0x1000
    memory_end equ 0x2000
    memory_bitmap resb (memory_end - memory_start) / 8

section .text
global allocate_memory, free_memory

allocate_memory:
    ; Allouer de la mémoire
    mov eax, memory_start
    mov ebx, memory_end
    sub ebx, eax
    ret

free_memory:
    ; Libérer de la mémoire
    ret
