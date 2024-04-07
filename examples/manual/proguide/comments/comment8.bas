'' examples/manual/proguide/comments/comment8.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Comments'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgComments
'' --------

/' this is a multi line 
comment as a header of
this example '/

Rem This Is a Single Line comment

'this is a single line comment

Dim a As Integer   'comment following a statement

Dim b As /' can comment in here also '/    Integer


#if 0
	before version 0.16, This was the
	only way of commenting Out sections
	With multiple lines of code.
#endif

