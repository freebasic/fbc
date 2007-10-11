'' examples/manual/system/command.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCommand
'' --------

''
'' command-line arguments example
''

 	Print "exe name= "; Command( 0 )

 	Dim argc As Integer, argv As String

 	argc = 1
 	Do
 		argv = Command( argc )

 		If( Len( argv ) = 0 ) Then
 			Exit Do
 		End If

 		Print "arg"; argc; " = """; argv; """"

 		argc += 1
 	Loop

 	If( argc = 1 ) Then
 		Print "(no arguments)"
 	End If
 	Print "The complete list: ";Command
