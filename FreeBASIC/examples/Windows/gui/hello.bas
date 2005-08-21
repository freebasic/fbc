''
''
''
''
option explicit
option private

#include once "windows.bi"

declare function        WinMain     ( byval hInstance as HINSTANCE, _
                                      byval hPrevInstance as HINSTANCE, _
                                      szCmdLine as string, _
                                      byval iCmdShow as integer ) as integer
                                  
                                  
    ''
    '' Entry point    
    ''
	end WinMain( GetModuleHandle( null ), null, Command$, SW_NORMAL )

'' ::::::::
'' name: WndProc
'' desc: Processes windows messages
''
'' ::::::::
function WndProc ( byval hWnd as HWND, _
                   byval message as UINT, _
                   byval wParam as WPARAM, _
                   byval lParam as LPARAM ) as LRESULT
    
    function = 0
    
    ''
    '' Process messages
    ''
    select case( message )
        ''
        '' Window was created
        ''        
        case WM_CREATE            
            exit function
        
        ''
        '' Windows is being repainted
        ''
        case WM_PAINT
    		dim rct as RECT
    		dim pnt as PAINTSTRUCT
    		dim hDC as HDC
          
            hDC = BeginPaint( hWnd, @pnt )
            GetClientRect( hWnd, @rct )
            
            DrawText( hDC, _
            		  "Hello Windows from FreeBasic!", _
            		  -1, _
                      @rct, _
                      DT_SINGLELINE or DT_CENTER or DT_VCENTER )
            
            EndPaint( hWnd, @pnt )
            
            exit function            
        
		''
		'' Key pressed
		''
		case WM_KEYDOWN
			if( lobyte( wParam ) = 27 ) then
				PostMessage( hWnd, WM_CLOSE, 0, 0 )
			end if

        ''
        '' Window was closed
        ''
    	case WM_DESTROY
            PostQuitMessage( 0 )
            exit function
    end select
    
    ''
    '' Message doesn't concern us, send it to the default handler
    '' and get result
    ''
    function = DefWindowProc( hWnd, message, wParam, lParam )    
    
end function

'' ::::::::
'' name: WinMain
'' desc: A win2 gui program entry point
''
'' ::::::::
function WinMain ( byval hInstance as HINSTANCE, _
                   byval hPrevInstance as HINSTANCE, _
                   szCmdLine as string, _
                   byval iCmdShow as integer ) as integer    
     
    dim wMsg as MSG
    dim wcls as WNDCLASS     
    dim szAppName as string
    dim hWnd as HWND
     
    function = 0
     
    ''
    '' Setup window class
    ''
    szAppName = "HelloWin"
     
    with wcls
    	.style         = CS_HREDRAW or CS_VREDRAW
    	.lpfnWndProc   = @WndProc
    	.cbClsExtra    = 0
    	.cbWndExtra    = 0
    	.hInstance     = hInstance
    	.hIcon         = LoadIcon( NULL, IDI_APPLICATION )
    	.hCursor       = LoadCursor( NULL, IDC_ARROW )
    	.hbrBackground = GetStockObject( WHITE_BRUSH )
    	.lpszMenuName  = NULL
    	.lpszClassName = strptr( szAppName )
    end with
          
    ''
    '' Register the window class     
    ''     
    if( RegisterClass( @wcls ) = FALSE ) then
       MessageBox( null, "This program requires Windows NT!", szAppName, MB_ICONERROR )
       exit function
    end if
    
	''
    '' Create the window and show it
    ''
    hWnd = CreateWindowEx( 0, _
    			 		   szAppName, _
                           "The Hello Program", _
                           WS_OVERLAPPEDWINDOW, _
                           CW_USEDEFAULT, _
                           CW_USEDEFAULT, _
                           CW_USEDEFAULT, _
                           CW_USEDEFAULT, _
                           NULL, _
                           NULL, _
                           hInstance, _
                           NULL )
                          

    ShowWindow( hWnd, iCmdShow )
    UpdateWindow( hWnd )
     
    ''
    '' Process windows messages
    ''
    while( GetMessage( @wMsg, NULL, 0, 0 ) <> FALSE )    
        TranslateMessage( @wMsg )
        DispatchMessage( @wMsg )
    wend
    
    
    ''
    '' Program has ended
    ''
    function = wMsg.wParam

end function
