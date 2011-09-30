'' examples/manual/proguide/comments/comment8.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgComments
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

