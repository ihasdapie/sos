#include "../drivers/ports.h"

void main() {
    port_byte_out(0x3d4, 14); // requesting high byte 
    // VGA control register = 0x3d4
    // query 14 for cursor position high byte
    // query 15 for cursor position low byte
    // 0000 0000 <- a short (2^16)
    // 0000 (000) <- low byte | high byte -> (0000) 0000

    // data is returned in VGA data register (0x3d5)
    int position = port_byte_in(0x3d5);
    position = position << 8; // get high byte with bit shift

    port_byte_out(0x3d4, 15); // requesting low byte
    position += port_byte_in(0x3d5); 

    int offset_from_vga = position * 2;
    // vga cells are: [char] [control_data]

    // just write to current cursor position 
    //
    char* vga = (char*) 0xb8000;
    vga[offset_from_vga] = 'X';
    vga[offset_from_vga+1] = 0x0f;  // white text on black
}


