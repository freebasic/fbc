'' examples/manual/misc/rem.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'REM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRem
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

