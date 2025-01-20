BITS 16

global read_cdrom

section .text
read_cdrom:
    push ax
    push bx
    push es
    push dx
    push cx

    ; Set up the drive parameters
    mov ah, 0x15          ; BIOS INT 13h - Get Drive Parameters
    mov dl, 0x02          ; Drive number (0x02 for CD-ROM)
    int 0x13              ; Call BIOS
    jc read_cdrom_error   ; Jump if carry flag is set (error)

    ; Set up the packet for extended read
    mov ah, 0x42          ; BIOS INT 13h - Extended Read
    mov dl, 0x02          ; Drive number (0x02 for CD-ROM)
    lea si, [cdrom_packet] ; Load address of packet into SI
    int 0x13              ; Call BIOS
    jc read_cdrom_error   ; Jump if carry flag is set (error)

    pop cx
    pop dx
    pop es
    pop bx
    pop ax
    clc                   ; Clear carry flag (no error)
    ret

read_cdrom_error:
    pop cx
    pop dx
    pop es
    pop bx
    pop ax
    stc                   ; Set carry flag (error)
    ret

section .data
cdrom_packet:
    db 0x10               ; Packet size (16 bytes)
    db 0x00               ; Reserved
    dw 0x0001             ; Number of blocks to read
    dw 0x0000             ; Address of buffer segment (will be set at runtime)
    dw 0x0000             ; Address of buffer offset (will be set at runtime)
    dq 0x0000000000000000 ; Starting LBA (will be set at runtime)
