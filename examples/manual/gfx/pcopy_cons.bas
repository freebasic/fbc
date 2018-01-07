'' examples/manual/gfx/pcopy_cons.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPcopy
'' --------

'' Console mode example:

'' Set the working page number to 0, and the visible page number to 1
#if __FB_LANG__ = "QB"
Screen ,, 0, 1
#else
Screen , 0, 1
#endif

Dim As Integer i, frames, fps
Dim As Double t

t = Timer

Do
	'' Fill working page with a certain color and character
	Cls
	Locate 1, 1
	Color (i And 15), 0
	Print String$(80 * 25, Hex$(i, 1));
	i += 1

	'' Show frames per second
	Color 15, 0
	Locate 1, 1
	Print "fps: " & fps,
	If Int(t) <> Int(Timer) Then
		t = Timer
		fps = frames
		frames = 0
	End If
	frames += 1

	'' Copy working page to visible page
	PCopy

	'' Sleep 50ms per frame to free up cpu time
	Sleep 50, 1

	'' Run loop until the user presses a key
Loop Until Len(Inkey$)
