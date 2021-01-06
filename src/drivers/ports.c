#include "ports.h"


unsigned char port_byte_in (unsigned short port) {
    unsigned char result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    // must use dx to store port addresses
    // "in" command -> input from port
    // store result in register al which is then put into c var result
    // set c variable result to e'a'x
    // map c variable port into e'd'x
    // input and output seperated by colons
    return result;
}

void port_byte_out(unsigned short port, unsigned char data) {
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
    // nothing is returned \threfore no "=" in asm syntax
    // "out" asm -> output to port

}
unsigned short port_word_in (unsigned short port) {
    unsigned short result;
    __asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return result;
}

void port_word_out (unsigned short port, unsigned short data){ 
    __asm__("out %%ax, %%dx" : : "a" (data), "d" (port));
}
    
//**********************
// example use of io calls to print characters to screen
//*********************
/* void main () { */
/*     port_byte_out(0x3d4, 14); // requesting high byte */ 
/*     // VGA control register = 0x3d4 */
/*     // query 14 for cursor position high byte */
/*     // query 15 for cursor position low byte */
/*     // 0000 0000 <- a short (2^16) */
/*     // 0000 (000) <- low byte | high byte -> (0000) 0000 */

/*     // data is returned in VGA data register (0x3d5) */
/*     int position = port_byte_in(0x3d5); */
/*     position = position << 8; // get high byte with bit shift */

/*     port_byte_out(0x3d4, 15); // requesting low byte */
/*     position += port_byte_in(0x3d5); */ 

/*     int offset_from_vga = position * 2; */
/*     // vga cells are: [char] [control_data] */

/*     // just write to current cursor position */ 
/*     // */
/*     char* vga = (char*) 0xb8000; */
/*     vga[offset_from_vga] = 'X'; */
/*     vga[offset_from_vga+1] = 0x0f;  // white text on black */
/*     vga[offset_from_vga+2] = 'P'; */
/*     vga[offset_from_vga+3] = 0x0f; */
/* } */
