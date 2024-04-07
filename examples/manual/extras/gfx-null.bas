'' examples/manual/extras/gfx-null.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'GFX_NULL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=SrcPgGfxNull
'' --------

'' Example of use of the GFX_NULL driver in windows
'' The GfxLib is set up in the ON_Create sub
'' The GFXLib buffer is drawn  to screen in th On_Paint Sub
'' The GfXLib is updated in the event loop

#include "fbgfx.bi"
#include Once "windows.bi"

Using fb

Dim Shared bmi As bitmapv4header
Dim Shared mywin As rect

''
''--------------------------------------------------------------------------
Function on_paint(ByVal hwnd As HWND,ByVal wparam As WPARAM,ByVal lparam As LPARAM) As Integer

	Dim rct As RECT
	Dim pnt As PAINTSTRUCT
	Dim hDC As HDC

	'draw the gfx buffer to screen
	hDC = BeginPaint(hWnd, @pnt)
	GetClientRect( hWnd, @rct )
	With rct
		StretchDIBits hDC, 0, 0,.Right-.Left+1,.bottom-.top+1, 0, 0, .Right-.Left+1,_
			.bottom-.top+1,ScreenPtr,CPtr(bitmapinfo Ptr, @bmi), DIB_RGB_COLORS, SRCCOPY
	End With

	EndPaint hWnd, @pnt

	Function = 0

End Function     

''
''---------------------------------------------------------------------------
Function on_Create(ByVal hwnd As HWND,ByVal wparam As WPARAM,ByVal lparam As LPARAM) As Integer
	Dim rct As RECT
	'set a gfxscreen of the size of the client area
	GetClientRect( hWnd, @mywin)
	ScreenRes mywin.right+1,mywin.bottom+1, 32, 1, GFX_NULL
	'and create a bmp header,required to paint it yo screen
	With bmi
	  .bV4Size = Len(BITMAPV4HEADER)
	  .bv4width=mywin.right+1
	  .bv4height=-(mywin.bottom+1)   'negative value=>top to bottom bmp
	  '(standard BMP's are bottom to top)
	  .bv4planes=  1
	  .bv4bitcount=32
	  .bv4v4compression=0
	  .bv4sizeimage=mywin.right+1*mywin.bottom+1*4
	  .bV4RedMask = &h0F00
	  .bV4GreenMask = &h00F0
	  .bV4BlueMask = &h000F
	  .bV4AlphaMask = &hF000
	End With

	Function = 0

End Function

''
''---------------------------------------------------------------------------
Function on_Destroy(ByVal hwnd As HWND,ByVal wparam As WPARAM,ByVal lparam As LPARAM) As Integer
	'clear arrays....
	PostQuitMessage( 0 )

	Function = 0

End Function

''
''----------------------------------------------------------------------------
Function WndProc ( ByVal hWnd As HWND,ByVal message As UINT, _
				   ByVal wParam As WPARAM,ByVal lParam As LPARAM ) As LRESULT
   
	Function = 0

	Select Case As Const  message
	Case WM_CREATE
		Function = On_create(hwnd,wparam,lparam)
	Case WM_PAINT
		Function = On_paint(hwnd,wparam,lparam)
	Case WM_DESTROY
		Function = On_destroy(hwnd,wparam,lparam)
	Case Else
		Function = DefWindowProc( hWnd, message, wParam, lParam )   
	End Select

End Function

''
''------------------------------------------------------------------------------
''main program create window + event loop

	Dim wMsg As MSG
	Dim wcls As WNDCLASS     
	Dim szAppName As ZString * 30 => "Random Rectangles"
	Dim hWnd As HWND
	Dim i As Integer

	With wcls
		.style         = CS_HREDRAW Or CS_VREDRAW
		.lpfnWndProc   = @WndProc
		.cbClsExtra    = 0
		.cbWndExtra    = 0
		.hInstance     = GetModuleHandle( null )
		.hIcon         = LoadIcon( NULL, IDI_APPLICATION )
		.hCursor       = LoadCursor( NULL, IDC_ARROW )
		.hbrBackground = GetStockObject(WHITE_BRUSH )
		.lpszMenuName  = NULL
		.lpszClassName = @szAppName
	End With

	If( RegisterClass( @wcls ) = False ) Then 
		End
	End If

	'make a non-resizable screen
	hWnd = CreateWindowEx( 0,szAppName,"Example of GFX_NULL",_
		WS_OVERLAPPEDWINDOW And Not (WS_sizebox Or ws_maximizebox),_
		CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT, CW_USEDEFAULT, _
		NULL,NULL, wcls.hinstance,NULL )

	ShowWindow( hWnd, SW_NORMAL )
	UpdateWindow( hWnd )

	While 1
		If PeekMessage( @wMsg, NULL, 0,0, PM_Remove) Then   
			If wmsg.message=WM_QUIT Then 
				Exit While
			End If
			TranslateMessage( @wMsg )
			DispatchMessage( @wMsg )
		Else
			'update the gfx buffer
			Line (Rnd*mywin.right,Rnd*mywin.bottom)-(Rnd*mywin.right,Rnd*mywin.bottom),_
			RGB(Rnd*255,Rnd*255,Rnd*255),bf
			redrawwindow (hwnd,0,0,rdw_invalidate)
		End If
	Wend

	End wMsg.wparam 
