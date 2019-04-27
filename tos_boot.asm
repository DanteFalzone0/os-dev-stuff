; Largely copied from the OSDev wiki
;=====================================
; nasm boot.asm -f bin -o boot.bin

    [org    0x7c00]      ; add to offsets

    xor     ax, ax       ; make it zero
    mov     ds, ax       ; DS=0
    mov     ss, ax       ; stack starts at 0
    mov     sp, 0x9c00   ; 2000h past code start

    cld

    mov     ax, 0xb800   ; text video memory
    mov     es, ax


    mov     si, welcome  ; print a text string
    call    print_string ; from prints.asm
    mov     si, line0
    call    print_string
    mov     si, line1
    call    print_string
    mov     si, line2
    call    print_string
    mov     si, line3
    call    print_string
    mov     si, line4
    call    print_string
    mov     si, msg
    call    print_string

    mov     ax, 0xb800   ; look at video mem
    mov     gs, ax
    mov     bx, 0x0000   ; 'W'=57 attrib=0F
    mov     ax, [gs:bx]

hang:
    jmp hang

;----------------------

%include "prints.asm"

; data section

xpos    db 0
ypos    db 0
msg     db "Attempting to enter 32-bit protected mode...", 0
welcome db "Welcome to Dante's operating system, TOS!", 0

line0   db "######   ####    #####  ", 0
line1   db "  ##    ##  ##  ##      ", 0
line2   db "  ##    ##  ##   ###    ", 0
line3   db "  ##    ##  ##      ##  ", 0
line4   db "  ##     ####   #####   ", 0

times 510-($-$$) db 0
db 0x55
db 0xAA
;==================================
