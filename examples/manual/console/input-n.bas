'' examples/manual/console/input-n.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'INPUT()'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInputnum
'' --------

Print "Select a color by number" 
Print "1. blue"
Print "2. red"
Print "3. green"
Dim choice As String
Do
   choice = Input(1)
Loop Until choice >= "1" And choice <= "3"
