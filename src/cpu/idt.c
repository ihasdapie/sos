#include "idt.h"
#include "../kernel/util.h"



void set_idt_gate(int n, u32 handler) { 
    // idt defined in idt.h as idt_gate_t array
    idt[n].low_offset = low_16(handler); // types.h included in idt.h
    idt[n].sel = KERNEL_CS;
    idt[n].always0 = 0;
    idt[n].flags=0x8E;
    idt[n].high_offset = high_16(handler);
}

// programming idt is just filling in idt array
// creating a idt_reg to point to idt[] appropriately
// and then using `lidt` to set it

void set_idt() {
    idt_reg.base = (u32) &idt;
    idt_reg.limit = IDT_ENTRIES * sizeof(idt_gate_t) -1;
    
    // always load &idt_reg, not &idt
    __asm__ __volatile__("lidtl (%0)" : : "r" (&idt_reg));
}



