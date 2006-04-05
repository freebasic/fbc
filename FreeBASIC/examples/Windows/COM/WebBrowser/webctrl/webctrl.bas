
'' to build: fbc -lib webctrl.bas CBrowser.bas CClientSite.bas CInPlaceSite.bas CInPlaceFrame.bas

option explicit

#include once "windows.bi"
#include once "win/ole2.bi"
#include once "CBrowser.bi"
#include once "webctrl.bi"

const webctrl_name = "fb_webctrl_0_1"

type webctrl_
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
		if( _this->browser <> NULL ) then
			select case uMsg
			case WM_SIZE
				CBrowser_Resize( _this->browser, LOWORD( lParam ), HIWORD( lParam ) )
				return 0
		
			case WM_DESTROY
				CBrowser_Remove( _this->browser )
				CBrowser_Delete( _this->browser, FALSE )
				_this->browser = NULL
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
function webctrl_Create _
	( _
		byval parent as HWND, _
		byval x as integer, _
		byval y as integer, _
		byval width_ as integer, _
		byval height as integer, _
		byval flags as WEBCTRL_FLAGS _
	) as webctrl ptr
	
	dim as webctrl ptr _this
	dim as WNDCLASSEX ptr wc
	dim as HINSTANCE hInstance
	
	_this = allocate( len( webctrl ) )
	
	hInstance = cast( HINSTANCE, GetWindowLong( parent, GWL_HINSTANCE ) )
	
	wc = webctrl_GetRegClass( hInstance )
	
	_this->hwnd = CreateWindowEx( 0, _
						   		  @webctrl_name, _
						   		  "webctrwin_" + hex( _this ), _
						   		  WS_CHILD or WS_VISIBLE or WS_CLIPCHILDREN or WS_CLIPSIBLINGS, _
						   		  x, _
						   		  width_, _
						   		  y, _
						   		  height, _
						   		  parent, _
						   		  NULL, _
						   		  hInstance, _
						   		  NULL )
	
	SetWindowLong( _this->hwnd, GWL_USERDATA, cast( LONG, _this ) )

	_this->flags = flags

	''
	_this->browser = CBrowser_New( NULL, _this->hwnd, (flags and WEBCTRL_MOZILLA) <> 0 )
		
	if( CBrowser_Insert( _this->browser ) = FALSE ) then
		CBrowser_Delete( _this->browser, FALSE )
		_this->browser = NULL
		return NULL
	end if
	
	function = _this
	
end function

''::::
function webctrl_Move _
	( _
		byval _this as webctrl ptr, _
		byval x as integer, _
		byval y as integer, _
		byval width_ as integer, _
		byval height as integer _
	) as BOOL
	
	function = FALSE
	
	if( _this->hwnd = NULL ) then
		exit function
	end if
	
	MoveWindow( _this->hwnd, x, y, width_, height, FALSE )
	
	function = TRUE
	
end function

''::::
function webctrl_Navigate _
	( _
		byval _this as webctrl ptr, _
		byval url as wstring ptr, _
		byval target as wstring ptr _
	) as BOOL

	if( _this->hwnd = NULL ) then
		return FALSE
	end if

	function = CBrowser_Navigate( _this->browser, url, target )
	
end function 

''::::
function webctrl_Render _
	( _
		byval _this as webctrl ptr, _
		byval text as wstring ptr _
	) as BOOL

	if( _this->hwnd = NULL ) then
		return FALSE
	end if

	function = CBrowser_Render( _this->browser, text )
	
end function 

''::::
function webctrl_GoBack _
	( _
		byval _this as webctrl ptr _
	) as BOOL

	if( _this->hwnd = NULL ) then
		return FALSE
	end if

	function = CBrowser_GoBack( _this->browser )
	
end function 

''::::
function webctrl_GoForward _
	( _
		byval _this as webctrl ptr _
	) as BOOL

	if( _this->hwnd = NULL ) then
		return FALSE
	end if

	function = CBrowser_GoForward( _this->browser )
	
end function 

''::::
function webctrl_Refresh _
	( _
		byval _this as webctrl ptr _
	) as BOOL

	if( _this->hwnd = NULL ) then
		return FALSE
	end if

	function = CBrowser_Refresh( _this->browser )
	
end function 

''::::
function webctrl_Stop _
	( _
		byval _this as webctrl ptr _
	) as BOOL

	if( _this->hwnd = NULL ) then
		return FALSE
	end if

	function = CBrowser_Stop( _this->browser )
	
end function 