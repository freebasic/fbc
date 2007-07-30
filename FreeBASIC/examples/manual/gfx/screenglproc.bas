'' examples/manual/gfx/screenglproc.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenglproc
'' --------

'' include fbgfx.bi for some useful definitions
#include "fbgfx.bi"

Dim SwapInterval As Function(ByVal interval As Integer) As Integer
Dim extensions As String

'' Setup OpenGL and retrieve supported extensions
ScreenRes 640, 480, 32,, FB.GFX_OPENGL
ScreenControl FB.GET_GL_EXTENSIONS, extensions

If (InStr(extensions, "WGL_EXT_swap_control") <> 0) Then
	'' extension supported, retrieve proc address
	SwapInterval = ScreenGLProc("wglSwapIntervalEXT")
	If (SwapInterval <> 0) Then
		'' Ok, we got it. Set OpenGL to wait for vertical sync on buffer swaps
		SwapInterval(1)
	End If
End If
