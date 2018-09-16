PROG := cat

all: $(PROG)
clean:
	rm -f $(PROG) *.o
$(PROG): $(PROG).o
	ld $+ -o $@
%.o: %.asm
	nasm -f elf64 -F dwarf $+ -o $@ -l $*.lst
.PHONY: all clean
