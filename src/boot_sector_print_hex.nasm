; recieves hex data in 'dx'

print_hex:
    pusha
    mov cx, 0 ; index


hex_loop:
    cmp cx, 4 ; loop 4x
    je end

    ; convert last char in dx to ascii
    mov ax, dx
    and ax, 0x000f 
    add al, 0x30;  convert to ascii
    cmp al, 0x39 ; if > 9, represent 'A' -> F
    jle step2
    add al, 7 ; 'A' is ascii 65 not 58

step2:
    ; get pos of string to place ascii char
    ; bx <- base_addr + strlen - char_index

    mov bx, HEX_OUT + 5; base + length
    sub bx, cx ; index var
    mov [bx], al ; copy ascii on al to bx
    ror dx, 4 ; rotate right

    add cx, 1 ; increment and loop
    jmp hex_loop 

end:
    mov bx, HEX_OUT
    call print
    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; reserve memory for new string





