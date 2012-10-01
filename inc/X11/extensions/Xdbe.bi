''
''
'' Xdbe -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xdbe_bi__
#define __Xdbe_bi__

#define XdbeBadBuffer 0

type XdbeBackBuffer as Drawable
type XdbeSwapAction as ubyte

type XdbeSwapInfo
	swap_window as Window
	swap_action as XdbeSwapAction
end type

type XdbeBackBufferAttributes
	window as Window
end type

type XdbeBufferError
	type as integer
	display as Display ptr
	buffer as XdbeBackBuffer
	serial as uinteger
	error_code as ubyte
	request_code as ubyte
	minor_code as ubyte
end type

declare function XdbeAllocateBackBufferName cdecl alias "XdbeAllocateBackBufferName" (byval as Display ptr, byval as Window, byval as XdbeSwapAction) as XdbeBackBuffer
declare function XdbeDeallocateBackBufferName cdecl alias "XdbeDeallocateBackBufferName" (byval as Display ptr, byval as XdbeBackBuffer) as Status
declare function XdbeSwapBuffers cdecl alias "XdbeSwapBuffers" (byval as Display ptr, byval as XdbeSwapInfo ptr, byval as integer) as Status
declare function XdbeBeginIdiom cdecl alias "XdbeBeginIdiom" (byval as Display ptr) as Status
declare function XdbeEndIdiom cdecl alias "XdbeEndIdiom" (byval as Display ptr) as Status
declare function XdbeGetVisualInfo cdecl alias "XdbeGetVisualInfo" (byval as Display ptr, byval as Drawable ptr, byval as integer ptr) as XdbeScreenVisualInfo ptr
declare sub XdbeFreeVisualInfo cdecl alias "XdbeFreeVisualInfo" (byval as XdbeScreenVisualInfo ptr)
declare function XdbeGetBackBufferAttributes cdecl alias "XdbeGetBackBufferAttributes" (byval as Display ptr, byval as XdbeBackBuffer) as XdbeBackBufferAttributes ptr

#endif
