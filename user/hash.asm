; filepath: /user/hash.asm
section .data
    passwd db 'Enter password: ', 0
    passwd_len equ $ - passwd
    hash_msg db 'Hashed password: ', 0
    hash_msg_len equ $ - hash_msg
    buffer db 64
    buffer_len equ $ - buffer

section .bss
    input resb 64
    hashed resb 32  ; SHA-256 produces a 32-byte hash

section .text
    extern sha256_init, sha256_update, sha256_final
    global _start

_start:
    ; Print prompt for password
    mov eax, 4
    mov ebx, 1
    mov ecx, passwd
    mov edx, passwd_len
    int 0x80

    ; Read password input
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 64
    int 0x80

    ; Initialize SHA-256 context
    lea ecx, [hashed]
    call sha256_init

    ; Update SHA-256 context with the input
    lea ecx, [input]
    mov edx, 64
    call sha256_update

    ; Finalize the SHA-256 hash
    lea ecx, [hashed]
    call sha256_final

    ; Print hashed password message
    mov eax, 4
    mov ebx, 1
    mov ecx, hash_msg
    mov edx, hash_msg_len
    int 0x80

    ; Print hashed password
    mov eax, 4
    mov ebx, 1
    mov ecx, hashed
    mov edx, 32  ; SHA-256 hash length
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80
