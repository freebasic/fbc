'' examples/manual/system/dirfolder.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DIR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDir
'' --------

'' show any files that have directory attribute and don't care if it is system, hidden, read-only, or archive

#include Once "dir.bi"

'' allow everything
Var mask = fbDirectory Or fbHidden Or fbSystem Or fbArchive Or fbReadOnly

Var attrib = 0
Var f = Dir( "*.*", mask, attrib )
While( f > "" )
	'' show any files that have at least a directory attribute
	If( attrib And fbDirectory ) Then
		Print f
	End If
	f = Dir( attrib )
Wend
