'' examples/manual/faq/gfxlib2/bload-workaround.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=FaqPgbloadworkaround
'' --------

Sub _bsave( file As String, p As Any Ptr, sz As Integer ) 

  Dim As Integer ff 
  ff = FreeFile 
  
  Open file For Binary As ff 
	fb_fileput( ff, 0, ByVal p, sz ) 
	
  Close 
  
End Sub 

Sub _bload( file As String, p As Any Ptr ) 

  Dim As Integer ff 
  ff = FreeFile 
  
  Open file For Binary As ff 
	fb_fileget( ff, 0, ByVal p, LOF( ff ) ) 
	
  Close 
  
End Sub
