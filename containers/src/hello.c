#include <stdio.h>
#include <sys/reboot.h>

int main(void) {
    printf("hello, world 😁\n");
    reboot(0x4321fedc); // ACPI Power Down
    return 0;
}
