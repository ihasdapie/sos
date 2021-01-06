#include "../drivers/ports.h"
#include "../drivers/screen.h"


void main() {
    clear_screen();
    char* hello_world = "hello_world";
    kprint(hello_world);
}


