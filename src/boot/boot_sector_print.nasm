; prints ascii in 'bx'

print:
    pusha

start:
    mov al, [bx] ; bx is base address of string
    cmp al, 0
    je done ; exit if at 0 (null-terminated string)

    mov ah, 0x0e ; tty
    int 0x10 ; al already contains first char

    add bx, 1; ; increment pointer, loo
    jmp start

print_nl: ;prints newline
    pusha 
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10

    popa
    ret

done:
    popa
    ret

