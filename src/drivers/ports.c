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



