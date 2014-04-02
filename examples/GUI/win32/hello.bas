

#include once "windows.bi"

declare function        WinMain     ( byval hInstance as HINSTANCE, _
                                      byval hPrevInstance as HINSTANCE, _
                                      byval szCmdLine as zstring ptr, _
                                      byval iCmdShow as integer ) as integer
                                  
                                  
	end WinMain( GetModuleHandle( null ), null, Command( ), SW_NORMAL )

'':::::
function WndProc ( byval hWnd as HWND, _
                   byval wMsg as UINT, _
                   byval wParam as WPARAM, _
                   byval lParam as LPARAM ) as LRESULT
    
    function = 0
    
    select case( wMsg )
        case WM_CREATE            
            exit function

        case WM_PAINT
    		dim rct as RECT
    		dim pnt as PAINTSTRUCT
    		dim hDC as HDC
          
            hDC = BeginPaint( hWnd, @pnt )
            GetClientRect( hWnd, @rct )
            
            DrawText( hDC, _
            		  "Hello, World!", _
            		  -1, _
                      @rct, _
                      DT_SINGLELINE or DT_CENTER or DT_VCENTER )
            
            EndPaint( hWnd, @pnt )
            
            exit function            
        
		case WM_KEYDOWN
			if( lobyte( wParam ) = 27 ) then
				PostMessage( hWnd, WM_CLOSE, 0, 0 )
			end if

    	case WM_DESTROY
            PostQuitMessage( 0 )
            exit function
    end select
    
    function = DefWindowProc( hWnd, wMsg, wParam, lParam )    
    
end function

'':::::
function WinMain ( byval hInstance as HINSTANCE, _
                   byval hPrevInstance as HINSTANCE, _
                   byval szCmdLine as zstring ptr, _
                   byval iCmdShow as integer ) as integer    
     
    dim wMsg as MSG
    dim wcls as WNDCLASS     
    dim hWnd as HWND
     
    function = 0
     
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
    	.lpszClassName = @"HelloWin"
    end with
          
    if( RegisterClass( @wcls ) = FALSE ) then
       MessageBox( null, "Failed to register wcls", "Error", MB_ICONERROR )
       exit function
    end if
    
    hWnd = CreateWindowEx( 0, _
    			 		   @"HelloWin", _
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
     
    while( GetMessage( @wMsg, NULL, 0, 0 ) <> FALSE )    
        TranslateMessage( @wMsg )
        DispatchMessage( @wMsg )
    wend
    
    function = wMsg.wParam

end function
