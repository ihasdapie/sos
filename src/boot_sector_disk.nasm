; load 'dh' sectors from drive 'dl' into ES:BX

disk_load:
    pusha
    push dx ; push input params into stack for later use

    mov ah, 0x02 ; 0x02 -> ah = read mode
    mov al, dh ; num_sector_to_read -> al
    mov cl, 0x02 ;  0x01 is boot sector, 0x02 is first ava. sector
    mov ch, 0x00 ; cylinder -> ch
    mov dh, 0x00 ; head_number -> dh

    int 0x13 ; bios interrupt
    jc disk_error ; if error in carry bit

    pop dx
    cmp al, dh ; BIOs sets al to # sectors used.

    jne sectors_error ; if # sectors used is not as intended
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah ; ah = error code, dl = disk drive in error
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect n_sector read", 0

