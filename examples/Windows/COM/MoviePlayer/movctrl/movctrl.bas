
'' to build: fbc -lib movctrl.bas CMovie.bas



#include once "win/dshow.bi"
#include once "CMovie.bi"
#include once "movctrl.bi"

const movctrl_name = "fb_movctrl_0_1"

type movctrl_ctx
	as HWND 			hwnd
	as CMovie ptr 		movie
end type
	
''::::
private function win_cb _
	( _
		byval hwnd as HWND, _
		byval uMsg as UINT, _
		byval wParam as WPARAM, _
		byval lParam as LPARAM _
	) as LRESULT

	dim as movctrl ptr _this 
	
	_this = cast( movctrl ptr, GetWindowLong( hwnd, GWL_USERDATA ) )
	
	if( _this <> NULL ) then
		if( _this->ctx->movie <> NULL ) then
			select case uMsg
			case WM_SIZE
				_this->ctx->movie->resize( LOWORD( lParam ), HIWORD( lParam ) )
				return 0
		
			case WM_DESTROY
				if( _this->ctx->movie <> NULL ) then
					_this->ctx->movie->Remove( )
					delete _this->ctx->movie
					_this->ctx->movie = NULL
				end if
				return 0
			
			end select
		end if
	end if

	return DefWindowProc( hwnd, uMsg, wParam, lParam )
	
end function

''::::
private function movctrl_GetRegClass _
	( _
		byval instance as HINSTANCE _
	) as WNDCLASSEX ptr
	
	static as WNDCLASSEX wc
	
	if( wc.lpfnWndProc <> NULL ) then
		return @wc
	end if
	
	with wc
		.cbSize 		= len( WNDCLASSEX )
		.lpfnWndProc 	= @win_cb
		.hInstance 		= instance
		.lpszClassName 	= @movctrl_name
		''''''.style	= CS_HREDRAW or CS_VREDRAW  (not needed, the control takes the whole client area)
	end with
	
	RegisterClassEx( @wc )
	
	function = @wc

end function

''::::
constructor movctrl _
	( _
		byval parent as HWND, _
		byval x as integer, _
		byval y as integer, _
		byval width_ as integer, _
		byval height as integer _
	)
	
	dim as movctrl ptr _this
	dim as WNDCLASSEX ptr wc
	dim as .HINSTANCE hInstance
	
	ctx = new movctrl_ctx
	
	hInstance = cast( .HINSTANCE, GetWindowLong( parent, GWL_HINSTANCE ) )
	
	wc = movctrl_GetRegClass( hInstance )
	
	ctx->hwnd = CreateWindowEx( 0, _
						   	    @movctrl_name, _
						   		"movctrwin_" + hex( _this ), _
						   		WS_CHILD or WS_VISIBLE or WS_CLIPCHILDREN or WS_CLIPSIBLINGS, _
						   		x, _
						   		width_, _
						   		y, _
						   		height, _
						   		parent, _
						   		NULL, _
						   		hInstance, _
						   		NULL )
	
	SetWindowLong( ctx->hwnd, GWL_USERDATA, cast( LONG, @this ) )

	ctx->movie = new CMovie( ctx->hwnd )
		
	if( ctx->movie->Insert( ) = FALSE ) then
		delete ctx->movie
		ctx->movie = NULL
		return
	end if
	
end constructor

''::::
destructor movctrl _
	( _
		_
	)

	if( ctx->hwnd <> NULL ) then
		SetWindowLong( ctx->hwnd, GWL_USERDATA, cast( LONG, NULL ) )
		DestroyWindow( ctx->hwnd )
		ctx->hwnd = NULL
	end if
	
	if( ctx->movie <> NULL ) then
		ctx->movie->Remove( )
		delete ctx->movie
		ctx->movie = NULL
	end if
	
	delete ctx

end destructor

''::::
function movctrl.move _
	( _
		byval x as integer, _
		byval y as integer, _
		byval width_ as integer, _
		byval height as integer _
	) as BOOL
	
	function = FALSE
	
	if( ctx->hwnd = NULL ) then
		exit function
	end if
	
	MoveWindow( ctx->hwnd, x, y, width_, height, FALSE )
	
	function = TRUE
	
end function

''::::
function movctrl.load _
	( _
		byval filename as wstring ptr _
	) as BOOL

	if( ctx->hwnd = NULL ) then
		return FALSE
	end if

	function = ctx->movie->Load( filename )
	
end function 

''::::
function movctrl.play _
	( _
		 _
	) as BOOL

	if( ctx->hwnd = NULL ) then
		return FALSE
	end if

	function = ctx->movie->play( )
	
end function 

''::::
function movctrl.pause _
	( _
		 _
	) as BOOL

	if( ctx->hwnd = NULL ) then
		return FALSE
	end if

	function = ctx->movie->pause( )
	
end function 

''::::
function movctrl.stop _
	( _
		 _
	) as BOOL

	if( ctx->hwnd = NULL ) then
		return FALSE
	end if

	function = ctx->movie->stop( )
	
end function 
