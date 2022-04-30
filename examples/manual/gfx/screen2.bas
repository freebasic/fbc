'' examples/manual/gfx/screen2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREEN (GRAPHICS)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreengraphics
'' --------

#include "fbgfx.bi"
#if __FB_LANG__ = "fb"
Using FB '' Screen mode flags are in the FB namespace in lang FB
#endif

' Sets screen mode 18 (640*480) with 32bpp color depth and 4 pages, in windowed mode; switching disabled
Screen 18, 32, 4, (GFX_WINDOWED Or GFX_NO_SWITCH)

' Check to make sure Screen was opened successfully
If ScreenPtr = 0 Then
	Print "Error setting video mode!"
	End
End If

Print "Successfully set video mode"
Sleep
