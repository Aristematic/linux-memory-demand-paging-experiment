section .text
global _start

_start:

    mov r12, 1000000      ; loop counter

loop:

    mov rax, 9            ; syscall: mmap
    xor rdi, rdi          ; addr = NULL
    mov rsi, 4096         ; allocate one page
    mov rdx, 3            ; PROT_READ | PROT_WRITE
    mov r10, 34           ; MAP_PRIVATE | MAP_ANONYMOUS
    mov r8, -1
    xor r9, r9
    syscall

    mov rbx, rax          ; returned memory pointer
    mov byte [rbx], 1     ; touch page (forces page allocation)

    dec r12
    jnz loop

    mov rax, 60
    xor rdi, rdi
    syscall

