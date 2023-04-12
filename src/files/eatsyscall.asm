; Executable name : EATSYSCALL
; Version         : 1.0
; Created date    : 1/7/2009
; Last update     : 1/7/2009
; Author          : Jeff Duntemann
; Description     :  A simple assembly app for Linux, using NASM 2.05,
;                    demonstrating the use of Linux INT 80H syscalls
;                    to display text.
; Build using these commands:
;   nasm -f elf -g -F stabs eatsyscall.asm        (this is for 32-bit CPU)
;   or
;   nasm -f elf64 -g -F stabs eatsyscall.asm      (this is for 64-bit CPU)
;   ld -o eatsyscall eatsyscall.o

SECTION .data                   ; Section containing initialized data
EatMsg: db "Eat at Joe’s!",10
EatLen: equ $-EatMsg

SECTION .bss                    ; Section containing unintialized data
SECTION .text                   ; Section containing code

global _start                   ; Linker needs this to find the entry point!
_start:
        nop                     ; This no-op keeps gdb happy (see text)
        mov eax, 4              ; Specify sys_write syscall
        mov ebx, 1              ; Specify File Descriptor 1: Standard Output
        mov ecx, EatMsg         ; Pass offset of the message
        mov edx, EatLen         ; Pass the length of the message
        int 80H                 ; Make syscall to output the text to stdout

        mov eax, 1              ; Specify Exit syscall
        mov ebx, 0              ; Return a code of zero
        int 80H                 ; Make syscall to termninate the program
