[org 0x7c00] ; bootloader offset
KERNEL_OFFSET equ 0x1000 ; same as when linking kernel (-Ttext 0x1000)

    mov [BOOT_DRIVE], dl ; bios sets boot drive in dl on boot 
    mov bp, 0x9000 
    mov sp, bp ; set stack

    mov bx, MSG_REAL_MODE
    call print
    call print_nl

    call load_kernel
    call switch_to_pm
    jmp $


%include "boot/boot_sector_disk.nasm"
%include "boot/boot_sector_print.nasm"
%include "boot/boot_sector_print_hex.nasm"
%include "boot/32bit_gdt.nasm"
%include "boot/32bit_print.nasm"
%include "boot/32bit_switch.nasm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; read from disk and store in 0x1000
    mov dh, 16 ; to account for larger future kernels
    mov dl, [BOOT_DRIVE]
    call disk_load ; moves 2 sectors (dh) into dl (boot drive)
    ret


[bits 32] ; why must this come after include?
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; give control to kernek
    jmp $ ; hang here if kernel gives control back


BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0


; magic number bootsector
times 510-($-$$) db 0
dw 0xaa55






