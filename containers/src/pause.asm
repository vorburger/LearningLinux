BITS 64
SECTION .text
GLOBAL _start
_start:
    mov    rax, 34 ; 34 = pause, see https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_64.tbl and "man pause" from "man syscalls"
    syscall        ; ends up in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/signal.c
