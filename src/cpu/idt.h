#ifndef IDT_H
#define IDT_H

#include "types.h"

#define KERNEL_CS 0x08 // segment selector

// interrupt descriptor gate 
typedef struct {
    u16 low_offset; // lower 16 bits of handler function addr: where to jump to when interrupt fires 
    u16 sel; //kernel segment selector 
    u8 always0; // always 0 by convention/standard 
    
    u8 flags; 
    // bit 7: "interrupt is present"
    // bit 6-5: "priviledge level of caller: 0=kernel->3=user"
    // bit 4: 0 for interrupt gates
    // bit 4-0: bits 1110 = decimal 14 = "32 bit interrupt gate"

    u16 high_offset; // higher 16 bits of handler function address to jump to upon interrupt
} __attribute__ ((packed)) idt_gate_t;

 // https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#Common-Variable-Attributes
 // The packed attribute specifies that a structure member should have the smallest possible alignment—one bit for a bit-field and one byte otherwise, unless a larger value is specified with the aligned attribute. 



typedef struct {
    u16 limit;
    u32 base; // address of first idt_gate_t in the idt array
} __attribute__ ((packed)) idt_register_t;


#define IDT_ENTRIES 256

idt_gate_t idt[IDT_ENTRIES];
idt_register_t idt_reg;

void set_idt_gate(int n, u32 handler);
void set_idt();



#endif
