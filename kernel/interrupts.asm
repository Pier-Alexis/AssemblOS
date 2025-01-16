section .text
global isr_common_stub
extern isr_handler

isr_common_stub:
    ; Save the processor state
    pusha
    push ds
    push es
    push fs
    push gs

    ; Load the kernel data segment descriptor
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Call the C handler
    push esp
    call isr_handler
    add esp, 4

    ; Restore the processor state
    pop gs
    pop fs
    pop es
    pop ds
    popa
    add esp, 4 ; Skip error code
    iret
