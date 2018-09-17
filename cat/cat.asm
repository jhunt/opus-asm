;; vim:ft=nasm
;; cat - Read from standard input, write to standard output

global _start
section .text
_start:
  ;; argc is at RSP
  ;; argv stretches from RSP+8
  ;;                  to RSP+8 + (8 * argc)

  mov r13, [rsp]
  cmp r13, 1
  je read1      ;; no arguments, use stdin

  xor r12, r12
.next:
  inc r12
  cmp r13, r12
  je .done

  ;; open(path, O_RDONLY)
  mov rax, 2
  mov rdi, [rsp+8+8*r12]
  mov rsi, 0  ;; O_RDONLY
  syscall

  cmp rax, 0
  jl .failed

  mov [fd], rax
  call read1
  jmp .next

.failed:
  ;; exit(1)
  mov rax, 60
  mov rdi, 2
  syscall

.done:
  ;; exit(0)
  mov rax, 60
  mov rdi, 2
  syscall

read1:
.again:
  ;; read(fd, buf, len)
  mov rax, 0
  mov rdi, [fd]
  mov rsi, buf
  mov rdx, len
  syscall

  cmp rax, 0
  je .done    ;; RAX = 0 means nothing to reade
  jl .failed  ;; RAX < 0 means an error

.write:
  ;; write(1, buf, ...)
  mov rdx, rax
  mov rax, 1   ; has to be last, since return value of
               ; read(...) call was in RAX, which we need
               ; to pass to write(...) via RDX.
  mov rdi, 1
  ;; NB: RSI is unchanged from the read(...) call
  syscall
  jmp .again

.done:
  ret

.failed:
  ;; exit(1)
  mov rax, 60
  mov rdi, 1
  syscall

section .data
  fd dd 0
section .bss
  len equ 8192
  buf resb $len
