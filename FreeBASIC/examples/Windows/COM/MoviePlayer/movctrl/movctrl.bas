
'' to build: fbc -lib movctrl.bas CMovie.bas



#include once "win/dshow.bi"
#include once "CMovie.bi"
#include once "movctrl.bi"

const movctrl_name = "fb_movctrl_0_1"

type movctrl_
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
		if( _this->movie <> NULL ) then
			select case uMsg
			case WM_SIZE
				CMovie_Resize( _this->movie, LOWORD( lParam ), HIWORD( lParam ) )
				return 0
		
			case WM_DESTROY
				if( _this->movie <> NULL ) then
					CMovie_Remove( _this->movie )
					CMovie_Delete( _this->movie, FALSE )
					_this->movie = NULL
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
function movctrl_Create _
	( _
		byval parent as HWND, _
		byval x as integer, _
		byval y as integer, _
		byval width_ as integer, _
		byval height as integer _
	) as movctrl ptr
	
	dim as movctrl ptr _this
	dim as WNDCLASSEX ptr wc
	dim as HINSTANCE hInstance
	
	_this = allocate( len( movctrl ) )
	
	hInstance = cast( HINSTANCE, GetWindowLong( parent, GWL_HINSTANCE ) )
	
	wc = movctrl_GetRegClass( hInstance )
	
	_this->hwnd = CreateWindowEx( 0, _
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
	
	SetWindowLong( _this->hwnd, GWL_USERDATA, cast( LONG, _this ) )

	_this->movie = CMovie_New( NULL, _this->hwnd )
		
	if( CMovie_Insert( _this->movie ) = FALSE ) then
		CMovie_Delete( _this->movie, FALSE )
		_this->movie = NULL
		return NULL
	end if
	
	function = _this
	
end function

''::::
function movctrl_Destroy _
	( _
		byval _this as movctrl ptr _
	) as BOOL

	function = FALSE
	
	if( _this = NULL ) then
		exit function
	end if
	
	if( _this->hwnd <> NULL ) then
		SetWindowLong( _this->hwnd, GWL_USERDATA, cast( LONG, NULL ) )
		DestroyWindow( _this->hwnd )
		_this->hwnd = NULL
	end if
	
	if( _this->movie <> NULL ) then
		CMovie_Remove( _this->movie )
		CMovie_Delete( _this->movie, FALSE )
		_this->movie = NULL
	end if
	
	deallocate( _this )

	function = TRUE
	
end function

''::::
function movctrl_Move _
	( _
		byval _this as movctrl ptr, _
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
function movctrl_Load _
	( _
		byval _this as movctrl ptr, _
		byval filename as wstring ptr _
	) as BOOL

	if( _this->hwnd = NULL ) then
		return FALSE
	end if

	function = CMovie_Load( _this->movie, filename )
	
end function 

''::::
function movctrl_Play _
	( _
		byval _this as movctrl ptr _
	) as BOOL

	if( _this->hwnd = NULL ) then
		return FALSE
	end if

	function = CMovie_Play( _this->movie )
	
end function 

''::::
function movctrl_Pause _
	( _
		byval _this as movctrl ptr _
	) as BOOL

	if( _this->hwnd = NULL ) then
		return FALSE
	end if

	function = CMovie_Pause( _this->movie )
	
end function 

''::::
function movctrl_Stop _
	( _
		byval _this as movctrl ptr _
	) as BOOL

	if( _this->hwnd = NULL ) then
		return FALSE
	end if

	function = CMovie_Stop( _this->movie )
	
end function 
