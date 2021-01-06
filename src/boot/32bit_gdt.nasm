gdt_start: ; labels must be kept to compute size/jumps
    ; mandatory null 8 byte
    dd 0x0 ; dd double word (4 byte)
    dd 0x0 

gdt_code: ; code segment descriptor
    ; base = 0x0, limit = 0xfffff
    ; 1st (present) 1 (privilege) 00 (descriptior type) 1 -> 1001b
    ; type flags (code) 1 (conforming)0 (Readable)1 accessed (0) -> 1010 b
    ; 2nd falgs: (granularity)1 (32-bit default) 1 (64-bit seg)0 (AVL)0 -> 1100b
    dw 0xffff ; limit (bits 0-15)
    dw 0x0 ; base (bits 0-15)
    db 0x0 ; base (bits 16-23)
    db 10011010b ; 1st, type flags
    db 11001111b ; 2nd flags, limit 9bits 16-19)
    db 0x0 ; base (bits 24-31)

gdt_data: ; data segment descriptor
    ; same as code seg except for type flags
    ; type flags: (code) 0 (expand down) 0 (writable)1 (accessed)0 -> 0010b
    dw 0xffff ; limit (bits 0-15)
    dw 0x0 ; base (bits 0-15)
    db 0x0 ; base (bits 16-23)
    db 10010010b; 1st, type flags
    db 11001111b ; 2nd flags, limit 9bits 16-19)
    db 0x0 ; base (bits 24-31)

gdt_end: ; put end label here so assembler can calculate size of gdt for gdt descriptor



gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size of gdt, always 1 less than true size
    dd gdt_start ; start address of gdt

; define some constants for GDT segment offsets

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start





