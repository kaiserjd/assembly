global _start
extern printf

section .data
    message db "Fibonacci Sequence:", 0x0a
    outFormat db "%d", 0x0a, 0x00

section .text
_start:
    call printMessage
    call initFib
    call loopFib
    call Exit

printMessage:
    mov rax, 1      ; rax: 'write' syscall number (1)
    mov rdi, 1      ; rdi: fd 1 (sysout)
    mov rsi, message; rsi: pointer to message
    mov rdx, 20     ; rdx: print length of 20 bytes
    syscall         ; call the write syscall for our intro message
    ret

printFib:
    push rax            ; save registers to stack
    push rbx

    mov rdi, outFormat  ; set 1st argument (print format)
    mov rsi, rbx        ; set 2nd argument (fib number to be printed)
    call printf         ; printf(outFormat, rbx)

    pop rbx             ; get registers back
    pop rax
    ret

initFib:
    xor rax, rax    ; init rax to 0 (extra performant way)
    xor rbx, rbx    ; init rbx to 0
    inc rbx         ; first fib number
    ret

loopFib:
    add rax, rbx    ; get next fibonacci number
    xchg rax, rbx   ; swap rax and rbx

    cmp rbx, 10     ; do rbx - 10
    js loopFib      ; jump if result < 0
    ret

Exit:
    mov rax, 60     ; rax: 'exit' syscall number (60)
    mov rdi, 0      ; rdi: exit syscall code (0, or no error)
    syscall         ; call the exit syscall to exit our program (without a segfault)