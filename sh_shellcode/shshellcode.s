global _start

section .text
_start:
    mov al, 59          ; execve syscall number
    xor rdx, rdx
    push rdx           ; push NULL string terminator
    mov rdi, '/bin//sh' ; first arg
    push rdi
    mov rdi, rsp        ; move pointer to ['/bin//sh']
    push rdx
    push rdi            ; push second arg to ['/bin//sh']
    mov rsi, rsp        ; pointer to args
    syscall
