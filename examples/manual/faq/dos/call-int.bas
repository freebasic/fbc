'' examples/manual/faq/dos/call-int.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DOS related FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=FaqDOS
'' --------

#include "dos/dpmi.bi"

Type RegTypeX As __dpmi_regs

#define INTERRUPTX(v,r) __dpmi_int( v, @r )
