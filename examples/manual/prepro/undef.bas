'' examples/manual/prepro/undef.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#UNDEF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpundef
'' --------

#define ADD2(a_, b_)  ((a_) + (b_))
Print ADD2(1, 2)
' Macro no longer needed so get rid of it ...
#undef ADD2
