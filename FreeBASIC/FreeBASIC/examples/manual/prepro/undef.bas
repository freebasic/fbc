'' examples/manual/prepro/undef.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpundef
'' --------

#define ADD2(a_, b_)  ((a_) + (b_))
Print ADD2(1, 2)
' Macro no longer needed so get rid of it ...
#undef ADD2
