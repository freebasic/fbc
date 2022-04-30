'' examples/manual/prepro/else.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#ELSE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpelse
'' --------

#define MODULE_VERSION 1
Dim a As String
#if (MODULE_VERSION > 0)
  a = "Release"
#else
  a = "Beta"
#endif
Print "Program is "; a
