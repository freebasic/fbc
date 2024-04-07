#include once "frmwrk.bi"

	using GdiPlus

'':::::
private function doCreate _
		( _
			byval ctx as frmwrk.Context ptr, _
			byval hWnd as HWND _
		) as integer

	function = TRUE

end function

'':::::
private function doPaint _
		( _
			byval ctx as frmwrk.Context ptr, _
			byval hWnd as HWND, _
			byval gfx as GpGraphics ptr _
		) as integer

	'' PathGradientBrush is a kind of Brush
	dim as GpPathGradient ptr grad

	'' create a brush
	static as GpPoint pntTb(0 to 3) = _
	{ _
		GpPoint(0, 0), _
		GpPoint(100, 0), _
		GpPoint(100, 100), _
		GpPoint(0, 100) _
	}

	GdipCreatePathGradientI( @pntTb(0), 4, WrapModeTile, @grad )

	GdipSetPathGradientCenterColor( grad, BGRA(63, 127, 255, 255) )

	'' draw an ellipse
	dim as .RECT rc = any
	GetClientRect( hWnd, @rc )
	GdipFillEllipseI( gfx, cast( GpBrush ptr, grad ), 0, 0, rc.right, rc.bottom )

	'' destroy the brush
	GdipDeleteBrush( cast( GpBrush ptr, grad ) )

	function = TRUE

end function

'':::::
private function doDestroy _
		( _
			byval ctx as frmwrk.Context ptr, _
			byval hWnd as HWND _
		) as integer

	function = TRUE

end function

'':::::
	frmwrk.run( @type<frmwrk.Context>( @doCreate, @doPaint, @doDestroy ) )
