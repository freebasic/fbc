'' examples/manual/faq/dos/call-int.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=FaqDOS
'' --------

#include "dos/dpmi.bi"

Type RegTypeX As __dpmi_regs

#define INTERRUPTX(v,r) __dpmi_int( v, @r )
