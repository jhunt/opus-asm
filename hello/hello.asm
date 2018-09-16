;; vim:ft=nasm

global _start
section .text
_start:
  mov rax, 1 ; write(2)
  mov rdi, 1 ; stdout
  mov rsi, hello
  mov rdx, len
  syscall

  mov rax, 60 ; exit(2)
  mov rdi, 0
  syscall

section .data
  hello db "Hello, Assembler!",0xa
  len equ $-hello
