'' examples/manual/gfx/screenptr2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenptr
'' --------

Const SCREEN_WIDTH = 256, SCREEN_HEIGHT = 256
Dim As Integer w, h, bypp, pitch

'' Make 32-bit screen.
ScreenRes SCREEN_WIDTH, SCREEN_HEIGHT, 32

'' Get screen info (w and h should match the constants above, bypp should be 4)
ScreenInfo w, h, , bypp, pitch

'' Get the address of the frame buffer. An Any Ptr 
'' is used here to allow simple pointer arithmetic
Dim buffer As Any Ptr = ScreenPtr()
If (buffer = 0) Then
	Print "Error: graphics screen not initialized."
	Sleep
	End -1
End If

'' Lock the screen to allow direct framebuffer access
ScreenLock()
	
	'' Set row address to the start of the buffer
	Dim As Any Ptr row = buffer
	
	'' Iterate over all the pixels in the screen:
	
	For y As Integer = 0 To h - 1
	    
	    '' Set pixel address to the start of the row
	    '' It's a 32-bit pixel, so use a UInteger Ptr
	    Dim As UInteger Ptr pixel = row
	    
	    For x As Integer = 0 To w - 1
	        
	        '' Set the pixel value
	        *pixel = RGB(x, x Xor y, y) 
	        
	        '' Get the next pixel address 
	        '' (UInteger Ptr will increment by 4 bytes)
	        pixel += 1
	        
	    Next x
	    
	    '' Go to the next row
	    row += pitch
	    
	Next y

'' Unlock the screen.
ScreenUnlock()

'' Wait for the user to press a key before closing the program
Sleep
