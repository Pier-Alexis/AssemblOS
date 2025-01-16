; filepath: /kernel/kernel.asm
BITS 32

global start
section .text
start:
    mov edx, msg
print:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    jmp print
done:
    cli
    call init_idt
    sti
    call init_window_manager
    call logon
hang:
    hlt
    jmp hang

section .data
msg db 'Kernel loaded!', 0

section .bss
align 16
idt_start:
    resq 256
idt_end:

section .data
idt_descriptor:
    dw idt_end - idt_start - 1
    dd idt_start

clear_screen:
    mov ax, 0x0600
    mov bh, 0x07
    mov cx, 0x0000
    mov dx, 0x184F
    int 0x10
    ret

set_cursor:
    mov ah, 0x02
    mov bh, 0x00
    mov dh, [row]
    mov dl, [col]
    int 0x10
    ret

print_char:
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    mov al, [char]
    int 0x10
    ret

print_string:
    mov esi, string
print_loop:
    lodsb
    cmp al, 0
    je print_done
    call print_char
    jmp print_loop
print_done:
    ret

init_window_manager:
    call clear_screen
    mov byte [row], 0
    mov byte [col], 0
    call set_cursor
    ret

create_logon_window:
    mov byte [row], 5
    mov byte [col], 10
    call set_cursor
    mov esi, logon_window_border
draw_border_loop:
    lodsb
    cmp al, 0
    je draw_border_done
    call print_char
    jmp draw_border_loop
draw_border_done:
    mov byte [row], 7
    mov byte [col], 12
    call set_cursor
    mov esi, username_label
    call print_string
    mov byte [row], 9
    mov byte [col], 12
    call set_cursor
    mov esi, password_label
    call print_string
    ret

keyboard_handler:
    pusha
    mov ah, 0
    int 0x16
    mov [key], al
    popa
    iret

init_idt:
    mov eax, keyboard_handler
    mov [idt_start + 4 * 9], eax
    lidt [idt_descriptor]
    ret

logon:
    call create_logon_window
    call get_username
    call get_password
    call verify_credentials
    ret

get_username:
    mov byte [row], 8
    mov byte [col], 12
    call set_cursor
    call read_input
    mov esi, username
    call store_input
    ret

get_password:
    mov byte [row], 10
    mov byte [col], 12
    call set_cursor
    call read_input
    mov esi, password
    call store_input
    ret

read_input:
    ; Read input from user
    ; (Add your code here)
    ret

store_input:
    ; Store input in the provided buffer
    ; (Add your code here)
    ret

verify_credentials:
    ; Call user.asm to verify credentials
    ; (Add your code here)
    ret

section .data
row db 0
col db 0
char db 0
string db 'Hello, World!', 0
key db 0
logon_window_border db '####################', 0
username_label db 'Username:', 0
password_label db 'Password:', 0
username db 32 dup(0)
password db 32 dup(0)
