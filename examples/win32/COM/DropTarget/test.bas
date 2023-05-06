''
'' IDropTarget example for text objects, translated from a C++ code written by J Brown 2004 (www.catch22.net)
''
'' to compile: fbc test.bas CDropTarget.bas
''
'' to test: open MS-WordPad, select some text and drag & drop it to this app's window

#include once "CDropTarget.bi"

const WIN_TITLE = "Text Drag&Drop Test"
const WIN_WIDTH = 800
const WIN_HEIGHT = 600

''::::
private function win_cb _
	( _
		byval hwnd as HWND, _
		byval uMsg as UINT, _
		byval wParam as WPARAM, _
		byval lParam as LPARAM _
	) as LRESULT

	static as CDropTarget ptr dropTarget = NULL
	static as HWND hwndEdit

	select case uMsg
	case WM_CREATE
		hwndEdit = CreateWindowEx( WS_EX_CLIENTEDGE, _
		                           "EDIT", _
		                           "", _
		                           WS_CHILD or WS_VISIBLE or ES_MULTILINE or ES_WANTRETURN or WS_VSCROLL, _
		                           0, 0, 0, 0, _
		                           hwnd, _
		                           0, _
		                           cast( HINSTANCE, GetWindowLong( hwnd, GWL_HINSTANCE ) ), _
		                           0 )

		SendMessage( hwndEdit, WM_SETFONT, cast(WPARAM,GetStockObject(ANSI_FIXED_FONT)), 0)

		'' make the Edit control into a DropTarget
		dropTarget = new CDropTarget( hwndEdit )

		SetFocus(hwndEdit)

		return 0

	case WM_DESTROY
		delete dropTarget
		dropTarget = NULL
		DestroyWindow(hwnd)
		PostQuitMessage( 0 )

		return 0

	case WM_SIZE
		'' resize editbox to fit in main window
		MoveWindow(hwndEdit, 0, 0, LOWORD(lParam), HIWORD(lParam), TRUE)
	end select

	return DefWindowProc( hwnd, uMsg, wParam, lParam )

end function

''::::
private function window_oncreate _
	( _
		byval hInstance as HINSTANCE _
	) as HWND

	dim as zstring ptr className = @"dragndrop_test"
	dim as WNDCLASSEX wc
	dim as HWND hwnd

	function = NULL

	with wc
		.cbSize         = len( WNDCLASSEX )
		.lpfnWndProc    = @win_cb
		.hInstance      = hInstance
		.lpszClassName  = className
	end with

	RegisterClassEx( @wc )

	hwnd = CreateWindowEx( 0, _
	                       className, _
	                       WIN_TITLE, _
	                       WS_VISIBLE or WS_OVERLAPPEDWINDOW, _
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
private function WinMain _
	( _
		byval hInstance as HINSTANCE, _
		byval hPrevInstance as HINSTANCE, _
		byval szCmdLine as zstring ptr, _
		byval nCmdShow as integer _
	) as integer

	dim as MSG msg
	dim as HWND win

	'' This program requires COM
	if( OleInitialize( NULL ) <> S_OK ) then
		return 1
	end if

	''
	win = window_oncreate( hInstance )

	''
	do while( GetMessage( @msg, 0, 0, 0 ) )
		TranslateMessage( @msg )
		DispatchMessage( @msg )
	loop

	'' Shutdown COM
	OleUninitialize( )

	function = msg.wParam

end function


	end WinMain( GetModuleHandle( NULL ), NULL, Command( ), SW_NORMAL )
