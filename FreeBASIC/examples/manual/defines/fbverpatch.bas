'' examples/manual/defines/fbverpatch.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdFBVerPatch
'' --------

Dim fbMajorVersion As Integer
Dim fbMinorVersion As Integer
Dim fbPatchVersion As Integer

fbMajorVersion = __FB_VER_MAJOR__
fbMinorVersion = __FB_VER_MINOR__
fbPatchVersion = __FB_VER_PATCH__

Print "Welcome to FreeBASIC ";fbMajorVersion;".";fbMinorVersion;" , Revision ";fbPatchVersion
