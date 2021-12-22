section .bss
string resb 8
buff resb 20

section .data
p1 db "Enter string:", 0x0A
p1len equ $-p1

section .text
global _start

    
%macro print_rep 1
    mov ecx, 0
    mov edx, 0
%%cycle:
    
    mov al, %1[ecx]
    cmp al, %1[ecx + 1]

    je %%found
    inc ecx
    cmp ecx, 8
    je %%end
    jmp %%cycle


%%found:
    mov buff[edx], al
    inc edx
    inc ecx

%%cpy_cycle:
    mov al, %1[ecx]
    mov buff[edx], al
    inc edx
    inc ecx
    cmp ecx, 8
    je %%sub_end

    cmp al, %1[ecx]
    je %%cpy_cycle
    mov buff[edx], BYTE 0x0A
    inc edx
    jmp %%cycle

%%sub_end:
    mov buff[edx], BYTE 0x0A
    inc edx

%%end:
    mov eax, 4
    mov ebx, 1
    mov ecx, buff
    int 0x80
%endmacro



_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, p1
    mov edx, p1len
    int 0x80

    mov eax, 3
    mov ebx, 2
    mov ecx, string
    mov edx, 9
    int 0x80

    print_rep string

    mov eax, 1
    mov ebx, 0
    int 0x80    




