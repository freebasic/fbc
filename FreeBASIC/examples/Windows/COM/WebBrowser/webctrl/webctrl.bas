
'' to build: fbc -lib webctrl.bas CBrowser.bas CClientSite.bas CInPlaceSite.bas CInPlaceFrame.bas



#include once "windows.bi"
#include once "win/ole2.bi"
#include once "CBrowser.bi"
#include once "webctrl.bi"

const webctrl_name = "fb_webctrl_0_1"

type webctrl_ctx
	as HWND 			hwnd
	as WEBCTRL_FLAGS	flags		
	as CBrowser ptr 	browser
end type
	
''::::
private function win_cb _
	( _
		byval hwnd as HWND, _
		byval uMsg as UINT, _
		byval wParam as WPARAM, _
		byval lParam as LPARAM _
	) as LRESULT

	dim as webctrl ptr _this 
	
	_this = cast( webctrl ptr, GetWindowLong( hwnd, GWL_USERDATA ) )
	
	if( _this <> NULL ) then
		if( _this->ctx->browser <> NULL ) then
			select case uMsg
			case WM_SIZE
				_this->ctx->browser->resize( LOWORD( lParam ), HIWORD( lParam ) )
				return 0
		
			case WM_DESTROY
				if( _this->ctx->browser <> NULL ) then
					_this->ctx->browser->remove( )
					delete _this->ctx->browser
					_this->ctx->browser = NULL
				end if
				return 0
			
			end select
		end if
	end if

	return DefWindowProc( hwnd, uMsg, wParam, lParam )
	
end function

''::::
private function webctrl_GetRegClass _
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
		.lpszClassName 	= @webctrl_name
		''''''.style	= CS_HREDRAW or CS_VREDRAW  (not needed, the control takes the whole client area)
	end with
	
	RegisterClassEx( @wc )
	
	function = @wc

end function

''::::
constructor webctrl _
	( _
		byval parent as HWND, _
		byval x as integer, _
		byval y as integer, _
		byval width_ as integer, _
		byval height as integer, _
		byval flags as WEBCTRL_FLAGS _
	) 
	
	dim as WNDCLASSEX ptr wc
	dim as HINSTANCE hInstance
	
	hInstance = cast( .HINSTANCE, GetWindowLong( parent, GWL_HINSTANCE ) )
	
	wc = webctrl_GetRegClass( hInstance )
	
	ctx = new webctrl_ctx
	
	ctx->hwnd = CreateWindowEx( 0, _
						   		@webctrl_name, _
						   		"webctrwin_" + hex( @this ), _
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

	ctx->flags = flags

	''
	ctx->browser = new CBrowser( ctx->hwnd, (flags and WEBCTRL_MOZILLA) <> 0 )
		
	if( ctx->browser->insert( ) = FALSE ) then
		delete ctx->browser
		ctx->browser = NULL
	end if
	
end constructor

''::::
destructor webctrl _
	( _
		_
	)

	if( ctx->hwnd <> NULL ) then
		SetWindowLong( ctx->hwnd, GWL_USERDATA, cast( LONG, NULL ) )
		DestroyWindow( ctx->hwnd )
		ctx->hwnd = NULL
	end if
	
	if( ctx->browser <> NULL ) then
		ctx->browser->remove( )
		delete ctx->browser
		ctx->browser = NULL
	end if
	
	delete ctx

end destructor

''::::
function webctrl.move _
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
function webctrl.navigate _
	( _
		byval url as wstring ptr, _
		byval target as wstring ptr _
	) as BOOL

	if( ctx->hwnd = NULL ) then
		return FALSE
	end if

	function = ctx->browser->navigate( url, target )
	
end function 

''::::
function webctrl.render _
	( _
		byval text as wstring ptr _
	) as BOOL

	if( ctx->hwnd = NULL ) then
		return FALSE
	end if

	function = ctx->browser->render( text )
	
end function 

''::::
function webctrl.goBack _
	( _
		 _
	) as BOOL

	if( ctx->hwnd = NULL ) then
		return FALSE
	end if

	function = ctx->browser->goBack( )
	
end function 

''::::
function webctrl.goForward _
	( _
		 _
	) as BOOL

	if( ctx->hwnd = NULL ) then
		return FALSE
	end if

	function = ctx->browser->goForward( )
	
end function 

''::::
function webctrl.refresh _
	( _
		 _
	) as BOOL

	if( ctx->hwnd = NULL ) then
		return FALSE
	end if

	function = ctx->browser->refresh( )
	
end function 

''::::
function webctrl.stop _
	( _
		 _
	) as BOOL

	if( ctx->hwnd = NULL ) then
		return FALSE
	end if

	function = ctx->browser->stop( )
	
end function 