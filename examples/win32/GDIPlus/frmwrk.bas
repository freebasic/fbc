
#include once "frmwrk.bi"

namespace frmwrk

	dim shared as Context ptr g_ctx = NULL
	dim shared as ULONG_PTR g_token = NULL

	'':::::
	private function _InitGdiPlus as integer
		dim as GdiPlus.GdiplusStartupInput gsi

		gsi.GdiplusVersion = 1

		function = GdiPlus.GdiplusStartup( @g_token, @gsi, NULL ) = 0

	end function

	'':::::
	private sub _EndGdiPlus

		GdiPlus.GdiplusShutdown( g_token )

	end sub

	'':::::
	private function _WndProc _
		( _
			byval hWnd as HWND, _
	        byval wMsg as UINT, _
	        byval wParam as WPARAM, _
	        byval lParam as LPARAM _
		) as LRESULT

	    function = 0

	    select case( wMsg )
	        case WM_CREATE
				g_ctx->doCreate( g_ctx, hwnd )
	            exit function

	        case WM_PAINT
				dim as HDC hDC = any
				dim as PAINTSTRUCT pntst = any
				dim as GdiPlus.GpGraphics ptr gfx = any

				hDC = BeginPaint( hWnd, @pntst )

				GdiPlus.GdipCreateFromHDC( hdc, @gfx )

	            g_ctx->doPaint( g_ctx, hwnd, gfx )

				GdiPlus.GdipDeleteGraphics( gfx )
				EndPaint( hWnd, @pntst )

	            exit function

			case WM_KEYDOWN
				if( lobyte( wParam ) = 27 ) then
					PostMessage( hWnd, WM_CLOSE, 0, 0 )
					exit function
				end if

			case WM_DESTROY
	            g_ctx->doDestroy( g_ctx, hwnd )
	            PostQuitMessage( 0 )
	            exit function
	    end select

	    function = DefWindowProc( hWnd, wMsg, wParam, lParam )

	end function

	'':::::
	private function _WinMain _
		( _
			byval hInstance as HINSTANCE, _
	        byval hPrevInstance as HINSTANCE, _
			byval szCmdLine as zstring ptr, _
	        byval iCmdShow as integer _
		) as integer

	    dim as MSG wMsg
	    dim as WNDCLASS wcls
	    dim as HWND hWnd

	    function = 0

		if( _InitGdiPlus( ) = FALSE ) then
			exit function
		end if

	    with wcls
			.style         = CS_HREDRAW or CS_VREDRAW
			.lpfnWndProc   = @_WndProc
			.cbClsExtra    = 0
			.cbWndExtra    = 0
			.hInstance     = hInstance
			.hIcon         = LoadIcon( NULL, IDI_APPLICATION )
			.hCursor       = LoadCursor( NULL, IDC_ARROW )
			.hbrBackground = GetStockObject( LTGRAY_BRUSH )
			.lpszMenuName  = NULL
			.lpszClassName = @"GdiPlus"
	    end with

	    if( RegisterClass( @wcls ) = FALSE ) then
	       MessageBox( null, "Failed to register wcls!", "Error", MB_ICONERROR )
	       exit function
	    end if

	    hWnd = CreateWindowEx( 0, _
	                           "GdiPlus", _
	                           "GdiPlus Test", _
	                           WS_OVERLAPPEDWINDOW, _
	                           0, _
	                           0, _
	                           480, _
	                           480, _
	                           NULL, _
	                           NULL, _
	                           hInstance, _
	                           NULL )

	    ShowWindow( hWnd, iCmdShow )
	    UpdateWindow( hWnd )

	    while( GetMessage( @wMsg, NULL, 0, 0 ) )
	        TranslateMessage( @wMsg )
	        DispatchMessage( @wMsg )
	    wend

	    _EndGdiPlus( )

	    function = wMsg.wParam

	end function

	function run _
		( _
			byval ctx as Context ptr _
		) as integer

		g_ctx = ctx

		function = frmwrk._WinMain( GetModuleHandle( null ), null, Command( ), SW_NORMAL )

	end function

end namespace

'':::::


