'' examples/manual/console/input-n.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInputnum
'' --------

Print "Select a color by number" 
Print "1. blue"
Print "2. red"
Print "3. green"
Dim choice As String
Do
   choice = Input(1)
Loop Until choice >= "1" And choice <= "3"
