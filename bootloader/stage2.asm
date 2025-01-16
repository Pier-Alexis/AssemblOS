bits 16

start_stage2:
    mov ah, 0x0e
    mov al, 'S'
    int 0x10
    mov al, '2'
    int 0x10
    hlt
