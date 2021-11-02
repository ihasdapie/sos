
; reference: http://www.osdever.net/bkerndev/Docs/isrs.htm



; defined in isr.c
[extern isr_handler]


isr_common_stub:
    ; 1. save CPI state
    ; 2. call c handler
    ; 3. restore state
    pusha; 
    mov ax, ds ; lower 16 bits of eax = ds
    push eax ; save data segment descriptor
    mov ax, 0x10 
    ; kernel data segment descriptor
    ; put into segment ptrs 
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call isr_handler

    ; restore state
    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    popa
    add esp, 8 ; cleans up popped error code and usr number 
    sti
    iret ; pops CS, EIP, EGLFAGS, SS, and ESP


; must have different handler for every interrupt (no info given about which interrupt is caller when interrupt caller func run
; ssome interrupts will push error into stack, some won't
; have those that don't push a dummy code.


global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

; divide by 0
isr0:
    cli
    push byte 0
    push byte 0
    jmp isr_common_stub





























