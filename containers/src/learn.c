#include <unistd.h>

int main(int argc, char* argv[]) {

    const char *HELLO = "hello, world.\n";

    // man 2 write
    // #include <string.h>
    // write(0, HELLO, strlen(HELLO));
    // The count 14 is strlen(HELLO)
    // TODO double check if 0 == STDOUT ?
    write(0, HELLO, 14);

    // #include <stdio.h>
    // fprintf(stdout, "I am %s\n", argv[0]);
}
