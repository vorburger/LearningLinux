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

See also [src/](../containers/src).
