'' examples/manual/gfx/cls-memset.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CLS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCls
'' --------

Dim scrbuf As Byte Ptr, scrsize As Integer
Dim As Long scrhei, scrpitch
Dim As Integer r = 0, dr = 1

ScreenRes 640, 480, 8

scrbuf = ScreenPtr: Assert( scrbuf <> 0 )
ScreenInfo( , scrhei, , , scrpitch )
scrsize = scrpitch * scrhei

Do
	
	'' lock the screen (must do this while working directly on screenbuffer)
	ScreenLock
		
		'' clear the screen (could use Cls here):
		Clear *scrbuf, 0, scrsize
		
		'' draw circle
		Circle (320, 240), r
		
	ScreenUnlock
	
	'' grow/shrink circle radius
	r += dr
	If r <= 0 Then dr = 1 Else If r >= 100 Then dr = -1
	
	'' short pause in each frame (prevents hogging the CPU)
	Sleep 1, 1
	
	'' run loop until user presses a key
Loop Until Len(Inkey) > 0
