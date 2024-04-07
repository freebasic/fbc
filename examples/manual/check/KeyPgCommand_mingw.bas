'' examples/manual/check/KeyPgCommand_mingw.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'COMMAND'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCommand
'' --------

'' For MinGW.org and Cygwin runtimes:
Extern _CRT_glob Alias "_CRT_glob" As Long
Dim Shared _CRT_glob As Long = 0

'' For MinGW-w64 runtime:
Extern _dowildcard Alias "_dowildcard" As Long
Dim Shared _dowildcard As Long = 0
