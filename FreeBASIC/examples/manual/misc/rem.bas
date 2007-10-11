'' examples/manual/misc/rem.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRem
'' --------

/' this is a multi line 
comment as a header of
this example '/

Rem This Is a Single Line comment

' this is a single line comment

? "Hello" : Rem comment following a statement

Dim a As Integer ' comment following a statement

? "FreeBASIC" : ' also acceptable 

Dim b As /' can comment in here also '/    Integer

#if 0
	This way of commenting Out code was
	required before version 0.16
#endif

