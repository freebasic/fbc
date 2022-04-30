'' examples/manual/defines/fbverpatch.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_VER_PATCH__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdFBVerPatch
'' --------

Dim fbMajorVersion As Integer
Dim fbMinorVersion As Integer
Dim fbPatchVersion As Integer

fbMajorVersion = __FB_VER_MAJOR__
fbMinorVersion = __FB_VER_MINOR__
fbPatchVersion = __FB_VER_PATCH__

Print "Welcome to FreeBASIC " & fbMajorVersion & "." & fbMinorVersion & ", revision " & fbPatchVersion
