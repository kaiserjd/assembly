global _start

section .data
    message db "Fibonacci Sequence:", 0x0a
    buffer db "0", 0x0a ; buffer for our number to be printed

section .text
_start:
    mov rax, 1      ; rax: 'write' syscall number (1)
    mov rdi, 1      ; rdi: fd 1 (sysout)
    mov rsi, message; rsi: pointer to message
    mov rdx, 20     ; rdx: print length of 20 bytes
    syscall         ; call the write syscall for our intro message

    xor rax, rax    ; init rax to 0 (extra performant way)
    xor rbx, rbx    ; init rbx to 0
    inc rbx         ; first fib number

loopFib:
    add rax, rbx    ; get next fibonacci number
    xchg rax, rbx   ; swap rax and rbx

    push rax        ; push rax to stack for later
    push rbx        ; push rbx to stack too

    add bl, '0'    ; convert current fibonacci number to ASCII
    mov [buffer],bl; move number to buffer for printing

    mov rax, 1      ; write syscall number
    mov rdi, 1      ; sysout
    mov rsi, buffer ; pointer to buffer with number
    mov rdx, 2      ; print length
    syscall         ; write syscall

    pop rbx         ; get rbx back
    pop rax         ; welcome back rax

    cmp rbx, 10     ; do rbx - 10
    js loopFib      ; jump if result < 0

    mov rax, 60     ; rax: 'exit' syscall number (60)
    mov rdi, 0      ; rdi: exit syscall code (0, or no error)
    syscall         ; call the exit syscall to exit our program (without a segfault)