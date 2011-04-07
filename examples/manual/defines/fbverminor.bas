'' examples/manual/defines/fbverminor.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdFBVerMinor
'' --------

Dim fbMajorVersion As Integer
Dim fbMinorVersion As Integer

fbMajorVersion = __FB_VER_MAJOR__
fbMinorVersion = __FB_VER_MINOR__

Print "Welcome to freebasic ";fbMajorVersion;".";fbMinorVersion
