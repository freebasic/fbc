'' examples/manual/prepro/else.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpelse
'' --------

#define MODULE_VERSION 1
Dim a As String
#if (MODULE_VERSION > 0)
  a = "Release"
#else
  a = "Beta"
#endif
Print "Program is "; a
