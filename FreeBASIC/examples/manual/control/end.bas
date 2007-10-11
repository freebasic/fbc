'' examples/manual/control/end.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgEnd
'' --------

'' This program stores input from the user in a string, checks the strings length,
'' by calling valid_string, and either displays the string, or an error message

Function valid_string( s As String ) As Integer
   Return Len( s )
End Function

'' assign input to text string (a string of spaces will input as an empty string)
Dim As String text
Print "Type in some text ( try ""abc"" ): " ;
Input text

'' check if string is valid (not empty). If so, print an error message and return
'' to the OS with error code -1
If( Not valid_string( text ) ) Then
   Print "ERROR: you must enter a valid string"
   Sleep : End -1
End If

'' string is valid, so print the string and return to the OS with error code 0
Print "You entered: " ; text
Sleep : End 0
