'' examples/manual/defines/fbargv.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbargv
'' --------

Declare Function main _
  ( _
	ByVal argc As Integer, _
	ByVal argv As ZString Ptr Ptr _
  ) As Integer

  End main( __FB_ARGC__, __FB_ARGV__ )

Private Function main _
  ( _
	ByVal argc As Integer, _
	ByVal argv As ZString Ptr Ptr _
  ) As Integer

  Dim i As Integer
  For i = 0 To argc - 1
	    Print "arg "; i; " = '"; *argv[i]; "'"
  Next i

  Return 0

End Function
