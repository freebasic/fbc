

#include once "windows.bi"
#include once "win/commctrl.bi"
#include once "win/ole2.bi"
#include once "movctrl/movctrl.bi"

const WIN_TITLE = "movie Test"

const WIN_WIDTH = 800
const WIN_HEIGHT = 600

const WIN_TOOLBAR_STYLE = TBSTYLE_FLAT or CCS_TOP

enum
	WIN_TOOLBAR_FIRSTID = WM_USER
	WIN_TOOLBAR_BUTTON_GOBACK = WIN_TOOLBAR_FIRSTID
	WIN_TOOLBAR_BUTTON_GOFORWARD
end enum

const WIN_TOOLBAR_BUTTONS = 2

'' globals
	dim shared as movctrl ptr movie = NULL
	dim shared as HWND toolbar = NULL
	
	dim shared as integer WIN_TOOLBAR_HEIGHT = 24

''::::
private sub movie_onresize _
	( _
		byval wdt as integer, _
		byval hgt as integer _
	)
		
	if( movie = NULL ) then
		exit sub
	end if

	if( hgt > WIN_TOOLBAR_HEIGHT ) then
		hgt -= WIN_TOOLBAR_HEIGHT
	else
		hgt = 0
	end if
		
	movie->move( 0, WIN_TOOLBAR_HEIGHT, wdt, hgt )

end sub

''::::
private sub toolbar_onresize _
	( _
		byval wdt as integer, _
		byval hgt as integer _
	)
	
	SendMessage( toolbar, WM_SIZE, 0, 0 )
	
end sub

''::::
private sub toolbar_onclick _
	( _
		byval hwnd as HWND, _
		byval id as integer _
	)
	
	if( movie = NULL ) then
		exit sub
	end if

	select case as const id
	case WIN_TOOLBAR_BUTTON_GOBACK
		'movctrl_GoBack( movie )
	case WIN_TOOLBAR_BUTTON_GOFORWARD
		'movctrl_GoForward( movie )
	end select
	
end sub

''::::
private function win_cb _
	( _
		byval hwnd as HWND, _
		byval uMsg as UINT, _
		byval wParam as WPARAM, _
		byval lParam as LPARAM _
	) as LRESULT
	
	select case uMsg
	case WM_SIZE
		dim as integer wdt = LOWORD( lParam ), _
					   hgt = HIWORD( lParam )
					   
		movie_onresize( wdt, hgt )
		
		toolbar_onresize( wdt, hgt )

		return 0
		
	case WM_DESTROY
		PostQuitMessage( 0 )
		return 0
	
	case WM_COMMAND
		if( lParam <> NULL ) then
			select case LOWORD( wParam )
			case WIN_TOOLBAR_FIRSTID to WIN_TOOLBAR_FIRSTID + WIN_TOOLBAR_BUTTONS - 1
				toolbar_onclick( cast( HWND, lParam ), LOWORD( wParam ) )
			end select
			
		end if
	end select

	return DefWindowProc( hwnd, uMsg, wParam, lParam )
	
end function

''::::
private function toolbar_oncreate _
	( _
		byval parent as HWND _
	) as HWND
	
	dim as HWND hwnd
	
	function = NULL
              
	InitCommonControlsEx( @type<INITCOMMONCONTROLSEX>( len( INITCOMMONCONTROLSEX ), ICC_BAR_CLASSES ) )

    hwnd = CreateWindowEx( WS_EX_DLGMODALFRAME, _ 
						   TOOLBARCLASSNAME, _
						   NULL, _ 
                       	   WS_CHILD or WS_VISIBLE or WIN_TOOLBAR_STYLE, _
                       	   0, _
                       	   0, _
                       	   CW_USEDEFAULT, _
                       	   CW_USEDEFAULT, _ 
                       	   parent, _
                       	   NULL, _ 
                       	   cast( HINSTANCE, GetWindowLong( parent, GWL_HINSTANCE ) ), _
                       	   NULL ) 
              
	if( hwnd = NULL ) then
		exit function
	end if
		
	SendMessage( hwnd, TB_BUTTONSTRUCTSIZE, len( TBBUTTON ), NULL ) 
	
    SendMessage( hwnd, TB_ADDBITMAP, 0, cint( @type<TBADDBITMAP>( HINST_COMMCTRL, IDB_HIST_LARGE_COLOR ) ) ) 

    dim as TBBUTTON button(0 to WIN_TOOLBAR_BUTTONS-1)

    '' go back
    with button(0)
		.iBitmap = HIST_BACK
		.fsState = TBSTATE_ENABLED 
        .fsStyle = TBSTYLE_BUTTON
        .idCommand = WIN_TOOLBAR_BUTTON_GOBACK
	end with

    '' go forward
    with button(1)
		.iBitmap = HIST_FORWARD
		.fsState = TBSTATE_ENABLED 
        .fsStyle = TBSTYLE_BUTTON
        .idCommand = WIN_TOOLBAR_BUTTON_GOFORWARD
	end with

	SendMessage( hwnd, TB_ADDBUTTONS, WIN_TOOLBAR_BUTTONS, cast( LPARAM, @button(0) ) ) 
	
	SendMessage( hwnd, TB_AUTOSIZE, 0, 0 )

	''
	dim as SIZE tbsize
	SendMessage( hwnd, TB_GETMAXSIZE, 0, cast( LPARAM, @tbsize ) )
	WIN_TOOLBAR_HEIGHT = tbsize.cy + HIWORD( SendMessage( hwnd, TB_GETPADDING, 0, 0 ) ) + 2

	function = hwnd

end function

''::::
private function window_oncreate _
	( _
		byval hInstance as HINSTANCE _
	) as HWND

	dim as zstring ptr className = @"movie_test"
	dim as WNDCLASSEX wc
	dim as HWND hwnd
	
	function = NULL

	with wc
		.cbSize 		= len( WNDCLASSEX )
		.lpfnWndProc 	= @win_cb
		.hInstance 		= hInstance
		.lpszClassName 	= className
		'.style			= CS_HREDRAW or CS_VREDRAW
	end with
	
	RegisterClassEx( @wc )

	hwnd = CreateWindowEx( 0, _
						   className, _
						   WIN_TITLE, _
						   WS_OVERLAPPEDWINDOW, _
						   CW_USEDEFAULT, _
						   WIN_WIDTH, _
						   CW_USEDEFAULT, _
						   WIN_HEIGHT, _
						   NULL, _
						   NULL, _
						   hInstance, _
						   0 )
		
	function = hwnd

end function

''::::
private function movie_oncreate _
	( _
		byval parent as HWND, _
		byval filename as wstring ptr _
	) as movctrl ptr
	
	dim as movctrl ptr movie
	
	function = NULL
		
	if( len( filename ) = 0 ) then
		exit function
	end if

	movie = new movctrl( parent, _
						 0, _
						 WIN_TOOLBAR_HEIGHT, _
						 WIN_WIDTH, _
						 WIN_HEIGHT-WIN_TOOLBAR_HEIGHT )

	if( movie = NULL ) then
		exit function
	end if
	
	if( movie->load( filename ) = FALSE ) then
		delete movie
		exit function
	end if
	
	if( movie->play( ) = FALSE ) then
		delete movie
		exit function
	end if
	
	function = movie

end function

''::::
private function WinMain _
	( _
		byval hInstance as HINSTANCE, _
        byval hPrevInstance as HINSTANCE, _
		byval szCmdLine as zstring ptr, _
        byval nCmdShow as integer _
	) as integer

	dim as MSG msg
	dim as HWND win
	
	if( len( *szCmdLine ) = 0 ) then
		print "Usage: test filename.ext"
		return 1
	end if
	
	''
	if( FAILED( CoInitialize( NULL ) ) ) then
		return 1
	end if

	''
	win = window_oncreate( hInstance )
	
	toolbar = toolbar_oncreate( win )

	movie = movie_oncreate( win, wstr(*szCmdLine) )
	if( movie = NULL ) then
		return 1
	end if
	
	''
	ShowWindow( win, nCmdShow )
	UpdateWindow( win )

	''
	do while( GetMessage( @msg, 0, 0, 0 ) )
		TranslateMessage( @msg )
		DispatchMessage( @msg )
	loop

	''
	CoUninitialize( )

	function = msg.wParam

end function


	end WinMain( GetModuleHandle( NULL ), NULL, Command( ), SW_NORMAL )