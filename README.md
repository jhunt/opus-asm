Opus :: Assembly Gauntlet
=========================

This repo contains a set of programs that I will be using to
master Intel x86-64 Assembly Language, for the Linux platform.

The Programs
------------

1. `hello/` - A simple Hello, World application, to exercise
   basic system calling conventions.

2. `cat/` - A primitive version of the POSIX `cat` utility,
   which reads from standard input, or treats its arguments as a
   list of file names to open and read from.  Output is printed to
   standard output.

2. `evenp/` - Reads numbers from standard input (treated as
   whitespace-separated tokens), and prints a message if the read
   token is an even number, an odd number, or not a number.

3. `uc/` - Reads standard input and converts all lowecase
   alphabetic characters to their uppercase equivalents.

4. `caps/` - Like `uc`, but only capitalized the first letter in
   each word.

5. `grep/` - A pale imitation of the POSIX `grep` utility.  Takes
   a string and a file, and looks for occurrences of the string in
   the file.  Prints the matching lines, newline-terminated.

I'm sure I'll add more as I come up with 

Building The Programs
---------------------

Each program lives in its own sub-directory.  To build one, cd
into its directory and issue the `make` command.  Requires `nasm`,
the Netwide Assembler.

Contributing
------------

I'm not currently accepting PRs for this project.
