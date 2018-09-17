Linux passes the number of command line arguments (which includes
the _basename_ of the executable in position 0), as a 8-byte
aligned cells (64-bit for pointers) starting from %rsp.

Here is a the gdb memory inspection session, starting with a dump
of 16x 64-bit pointers from %rsp on up:

    (gdb) x /16a $rsp
    0x7fffffffe980:	0x6	0x7fffffffeba2
    0x7fffffffe990:	0x7fffffffebaf	0x7fffffffebc2
    0x7fffffffe9a0:	0x7fffffffebd6	0x7fffffffebdc
    0x7fffffffe9b0:	0x7fffffffebe0	0x0
    0x7fffffffe9c0:	0x7fffffffebe6	0x7fffffffebfc
    0x7fffffffe9d0:	0x7fffffffec04	0x7fffffffec10
    0x7fffffffe9e0:	0x7fffffffec1b	0x7fffffffed7a
    0x7fffffffe9f0:	0x7fffffffed89	0x7fffffffed94

    (gdb) x /s 0x7fffffffebaf
    0x7fffffffebaf:	"ARGUMENT-THE-FIRST"

    (gdb) x /s 0x7fffffffebc2
    0x7fffffffebc2:	"the-second-argument"

    (gdb) x /s 0x7fffffffebd6
    0x7fffffffebd6:	"third"

    (gdb) x /s 0x7fffffffebdc
    0x7fffffffebdc:	"and"

    (gdb) x /s 0x7fffffffebe0
    0x7fffffffebe0:	"fifth"

(the command was "cat ARGUMENT-THE-FIRST the-second-argument ...")

The moment of epiphany came when I realized I was placing the
value of rsp+16 into a register, instead of copying in the
_pointer at that memory location_; it's a double abstraction;
it's `char**`

Here's the patch that made all the difference:

    diff --git a/cat/cat.asm b/cat/cat.asm
    index d800202..b2ef970 100644
    --- a/cat/cat.asm
    +++ b/cat/cat.asm
    @@ -14,8 +14,7 @@ _start:
     
       ;; open(path, O_RDONLY)
       mov rax, 2
    -  mov rdi, rsp
    -  add rdi, 16
    +  mov rdi, [rsp+16]
       mov rsi, 0  ;; O_RDONLY
       syscall
     
