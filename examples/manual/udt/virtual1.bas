'' examples/manual/udt/virtual1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVirtual
'' --------

'' Example with overriding subroutines


Type Hello Extends Object
	Declare Virtual Sub hi( )
End Type

Type HelloEnglish Extends Hello
	Declare Sub hi( )            '' overriding subroutine
End Type

Type HelloFrench Extends Hello
	Declare Sub hi( )            '' overriding subroutine
End Type

Type HelloGerman Extends Hello
	Declare Sub hi( )            '' overriding subroutine
End Type


Sub Hello.hi( )
	Print "hi!"
End Sub

Sub HelloEnglish.hi( )           '' overriding subroutine
	Print "hello!"
End Sub

Sub HelloFrench.hi( )            '' overriding subroutine
	Print "Salut!"
End Sub

Sub HelloGerman.hi( )            '' overriding subroutine
	Print "Hallo!"
End Sub


Randomize( Timer( ) )

Dim As Hello Ptr h

For i As Integer = 0 To 9
	Select Case( Int( Rnd( ) * 4 ) + 1 )
	Case 1
		h = New HelloEnglish
	Case 2
		h = New HelloFrench
	Case 3
		h = New HelloGerman
	Case Else
		h = New Hello
	End Select

	h->hi( )
	Delete h
Next

Sleep
