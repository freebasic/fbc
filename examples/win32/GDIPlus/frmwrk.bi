
#include once "win/GdiPlus.bi"

namespace frmwrk

	type Context
		doCreate as function _
		( _
			byval ctx as Context ptr, _
			byval hWnd as HWND _
		) as integer

		doPaint as function _
		( _
			byval ctx as Context ptr, _
			byval hWnd as HWND, _
			byval gfx as Gdiplus.GpGraphics ptr _
		) as integer

		doDestroy as function _
		( _
			byval ctx as Context ptr, _
			byval hWnd as HWND _
		) as integer
	end type

	declare function run _
		( _
			byval ctx as Context ptr _
		) as integer

end namespace
