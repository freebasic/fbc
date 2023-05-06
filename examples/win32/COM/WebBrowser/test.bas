

#include once "windows.bi"
#include once "win/commctrl.bi"
#include once "win/ole2.bi"
#include once "webctrl/webctrl.bi"

const WIN_BROWSER = WEBCTRL_IE 		'' or WEBCTRL_MOZILLA
const WIN_TITLE = "Browser Test"

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
	dim shared as webctrl ptr browser = NULL
	dim shared as HWND toolbar = NULL
	
	dim shared as integer WIN_TOOLBAR_HEIGHT = 24

''::::
private sub browser_onresize _
	( _
		byval wdt as integer, _
		byval hgt as integer _
	)
		
	if( browser = NULL ) then
		exit sub
	end if

	if( hgt > WIN_TOOLBAR_HEIGHT ) then
		hgt -= WIN_TOOLBAR_HEIGHT
	else
		hgt = 0
	end if
		
	browser->move( 0, WIN_TOOLBAR_HEIGHT, wdt, hgt )

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
	
	if( browser = NULL ) then
		exit sub
	end if

	select case as const id
	case WIN_TOOLBAR_BUTTON_GOBACK
		browser->goBack(  )
	case WIN_TOOLBAR_BUTTON_GOFORWARD
		browser->goForward(  )
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
					   
		browser_onresize( wdt, hgt )
		
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

#if 0
''::::
private function toolbar_editbox_oncreate _
	( _
		byval parent as HWND, _
		byval tbsize as SIZE ptr, _
	) as HWND

	dim as integer pad = SendMessage( parent, TB_GETPADDING, 0, 0 )
	
	dim as TEXTMETRIC tm
	GetTextMetrics( GetDC( parent ), @tm )
	dim as integer h = tm.tmHeight + 4
	dim as integer x = tbsize->cx + LOWORD( pad ), y = HIWORD( pad )

	dim as HWND hwnd
	hwnd = CreateWindowEx( 0, _
						   "Edit", _
						   NULL, _
						   WS_CHILD or WS_BORDER or WS_VISIBLE or ES_LEFT or ES_AUTOHSCROLL, _
   						   x, _
   						   y, _
   						   400, _
   						   h, _
   						   cast( GetWindowLong( parent, GWL_HWNDPARENT ) ), _
   						   cast( HMENU, WIN_TOOLBAR_EDIT ), _
   						   cast( HINSTANCE, GetWindowLong( parent, GWL_HINSTANCE ) ), _
   						   NULL )
   
	SetParent( hwnd, parent )
	
	function = hwnd
	
end function
#endif

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

#if 0	
	toolbar_editbox_oncreate( hwnd, @tbsize )
#endif
	
	function = hwnd

end function

''::::
private function window_oncreate _
	( _
		byval hInstance as HINSTANCE _
	) as HWND

	dim as zstring ptr className = @"browser_test"
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
private function browser_oncreate _
	( _
		byval parent as HWND _
	) as webctrl ptr
	
	dim as webctrl ptr browser
	
	browser = new webctrl( parent, _
						   0, _
						   WIN_TOOLBAR_HEIGHT, _
						   WIN_WIDTH, _
						   WIN_HEIGHT-WIN_TOOLBAR_HEIGHT, _
						   WIN_BROWSER )

	if( browser <> NULL ) then
		browser->navigate( "file://" + curdir + "/frameset.html" )
	end if
	
	function = browser

end function

''::::
private sub browser_ondestroy _
	( _
		byval browser as webctrl ptr _
	) 
	
	if( browser <> NULL ) then
		delete browser
	end if
	
end sub

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
	
	''
	if( OleInitialize( NULL ) <> S_OK ) then
		return 1
	end if

	''
	win = window_oncreate( hInstance )
	
	toolbar = toolbar_oncreate( win )

	browser = browser_oncreate( win )
	
	''
	ShowWindow( win, nCmdShow )
	UpdateWindow( win )

	''
	do while( GetMessage( @msg, 0, 0, 0 ) )
		TranslateMessage( @msg )
		DispatchMessage( @msg )
	loop

	''
	browser_ondestroy( browser )
	
	''
	OleUninitialize( )

	function = msg.wParam

end function


	end WinMain( GetModuleHandle( NULL ), NULL, Command( ), SW_NORMAL )