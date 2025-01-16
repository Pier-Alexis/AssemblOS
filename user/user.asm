section .data
    prompt_username db "Enter username: ", 0
    prompt_password db "Do you want a password? (y/n): ", 0
    prompt_enter_password db "Enter password: ", 0
    invalid_choice db "Invalid choice. Exiting...", 0
    username db 32 dup(0)
    password db 32 dup(0)
    yes db 'y', 0
    no db 'n', 0

section .bss

section .text
    extern hash_password
    global _start

_start:
    ; Prompt for username
    mov edx, prompt_username_len
    mov ecx, prompt_username
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; Read username
    mov eax, 3
    mov ebx, 0
    mov ecx, username
    mov edx, 32
    int 0x80

    ; Prompt for password choice
    mov edx, prompt_password_len
    mov ecx, prompt_password
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; Read password choice
    mov eax, 3
    mov ebx, 0
    mov ecx, password
    mov edx, 1
    int 0x80

    ; Check if user wants a password
    cmp byte [password], 'y'
    je _ask_password
    cmp byte [password], 'n'
    je _exit

    ; Invalid choice
    mov edx, invalid_choice_len
    mov ecx, invalid_choice
    mov ebx, 1
    mov eax, 4
    int 0x80
    jmp _exit

_ask_password:
    ; Prompt for password
    mov edx, prompt_enter_password_len
    mov ecx, prompt_enter_password
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; Read password
    mov eax, 3
    mov ebx, 0
    mov ecx, password
    mov edx, 32
    int 0x80

    ; Call hash_password function
    push ecx
    call hash_password
    add esp, 4

_exit:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

prompt_username_len equ $ - prompt_username
prompt_password_len equ $ - prompt_password
prompt_enter_password_len equ $ - prompt_enter_password
invalid_choice_len equ $ - invalid_choice