# hello, world

Install a C compiler, like `gcc` and/or `clang` for example:
(BTW: Note how the clang package depends on the gcc package; e.g.
 [here](https://stackoverflow.com/questions/24349124/why-clang-selects-a-gcc-installation) and
 [here](https://stackoverflow.com/questions/32447465/is-clang-a-standalone-c-compiler-or-does-it-need-gcc) and
 [here](https://stackoverflow.com/questions/63476350/does-llvm-clang-ever-use-gcc) and
 [here](https://stackoverflow.com/questions/59019932/what-standard-c-library-does-clang-use-glibc-its-own-or-some-other-one)
  is why; also note [llvm-project's libc](https://github.com/llvm/llvm-project/tree/main/libc).)

    sudo pacman -S clang

Write a `hello.c` containing:

```c
#include <stdio.h>

int main(void) {
   puts("hello, world");
   return 0;
}
```

And build it using either `gcc hello.c -o hello` or `clang hello.c -o hello`, then run it with `./hello`.

See also [src/](../containers/src), and its [`learn.c`](../containers/src/learn.c):

    gcc -static learn.c -o learn

    ./learn

    strace ./learn

## Background Notes

- `gcc --target-help` is more interesting & useful than `gcc --help`

- `man syscalls` is the entry point to find the `man 2 write` system call

- Static linking (`man ld`) is used to avoid (quote `man strace`) _"tracing clutter is produced by systems employing shared libraries"._ (The resulting `learn` binary is therefore huge - 745 instead of 16 KB!)

## TODO

1. Why is it 745K - does't `gcc` or `ld` strip what's un-used?

1. Install glibc sources, and let VSC find `*.c` implementation of e.g. `write()` or `fprintf()`

1. How to without using and linking to glibc?

   - Would this require writing (glibc-like) assembly code for `write` and `exit` syscalls?
   - use `man 2 exit` instead of `main()`?

1. Disassemble the `learn` binary and study its assembly code

1. Build a Kernel (for `x86_64`) and run it and `learn` as init with `qemu`

1. Play with `-march` and `-mtune` CPU types (see `gcc --target-help`)

1. Cross compile `learn.c` for an ARM or RISC-V ISA, and disassemble

1. Cross compile an ARM or RISC-V Linux Kernel and run it and `learn` as init with `qemu`

1. https://strace.io

1. Use https://enola.dev Executable Markdown in this README 😄
