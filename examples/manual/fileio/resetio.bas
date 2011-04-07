'' examples/manual/fileio/resetio.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgReset
'' --------

Dim x As String

'' Read from STDIN from piped input
Open Cons For Input As #1
While EOF(1) = 0
  Input #1, x
  Print """"; x; """"
Wend
Close #1

'' Reset to read from the keyboard
Reset(0)

Print "Enter some text:"
Input x

'' Read from STDIN (now from keyboard)
Open Cons For Input As #1
While EOF(1) = 0
  Input #1, x
  Print """"; x; """"
Wend
Close #1
