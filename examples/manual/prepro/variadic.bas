'' examples/manual/prepro/variadic.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDots
'' --------

'' Using a variadic macro to wrap a variadic function
#include "crt.bi"
#define eprintf(Format, args...) fprintf(stderr, Format, args)
eprintf(!"Hello from printf: %i %s %i\n", 5, "test", 123)

'' LISP-like accessors allowing to modify comma-separated lists
#define car(a, b...) a
#define cdr(a, b...) b
