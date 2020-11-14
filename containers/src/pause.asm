bits 64
global _start
section .text
  _start:
    mov    rax, 34 ; 34 = pause(), see "man pause" from "man syscalls"
    syscall        ; ends up in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/signal.c
