global _start

section .text
_start:
    xor rbx, rbx
    mov ebx, 'rld!'         ; keep strings in stack to ensure shellcode compliance, use ebx to avoid null padding
    push rbx
    mov rbx, 'Hello Wo'
    push rbx
    mov rsi, rsp            ; use rsp as string pointer

    xor rax, rax            ; call write
    mov al, 1
    xor rdi, rdi
    mov dil, 1
    xor rdx, rdx
    mov dl, 12
    syscall

    xor rax, rax            ; call exit
    add al, 60
    xor dil, dil
    syscall