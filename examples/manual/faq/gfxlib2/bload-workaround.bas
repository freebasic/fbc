'' examples/manual/faq/gfxlib2/bload-workaround.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BLOAD/BSAVE text mode work-around'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=FaqPgbloadworkaround
'' --------

Sub _bsave( file As String, p As Any Ptr, sz As Integer ) 

  Dim As Long ff 
  ff = FreeFile 
  
  Open file For Binary As ff 
	fb_fileput( ff, 0, ByVal p, sz ) 
	
  Close 
  
End Sub 

Sub _bload( file As String, p As Any Ptr ) 

  Dim As Long ff 
  ff = FreeFile 
  
  Open file For Binary As ff 
	fb_fileget( ff, 0, ByVal p, LOF( ff ) ) 
	
  Close 
  
End Sub
