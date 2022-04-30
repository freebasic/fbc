'' examples/manual/prepro/variadic.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '... (Ellipsis)'
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
