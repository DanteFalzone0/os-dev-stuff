print_char:
    mov     ah, 0x02        ; attrib = green on black
    mov     cx, ax          ; save char/attribute
    movzx   ax, byte [ypos]
    mov     dx, 160         ; 2 bytes (char/attrib)
    mul     dx              ; for 80 columns
    movzx   bx, byte [xpos]
    shl     bx, 1           ; times 2 to skip attrib

    mov     di, 0           ; start of video memory
    add     di, ax          ; add y offset
    add     di, bx          ; add x offset

    mov     ax, cx          ; restore char/attribute
    stosw                   ; write char/attribute
    add     byte [xpos], 1  ; advance to right

    ret

dochar:
    call    print_char      ; print one character

print_string:
    lodsb                   ; string char to AL
    cmp     al, 0
    jne     dochar          ; else, we're done
    add     byte [ypos], 1  ;down one row
    mov     byte [xpos], 0  ;back to left
    ret
