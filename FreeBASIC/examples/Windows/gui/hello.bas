''
''
''
''
defint a-z
option explicit
option private

'$include once:'win\kernel32.bi'
'$include once:'win\user32.bi'
'$include once:'win\gdi32.bi'



declare function        WinMain     ( byval hInstance as long, _
                                      byval hPrevInstance as long, _
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
defint a-z
function WndProc ( byval hWnd as long, _
                   byval message as long, _
                   byval wParam as long, _
                   byval lParam as long ) as integer
    dim rct as RECT
    dim pnt as PAINTSTRUCT
    dim hDC as long
    
    WndProc = 0
    
    ''
    '' Process message
    ''
    select case ( message )
       
        ''
        ''
        ''        
        case WM_CREATE            
            exit function
        
        ''
        '' Windows is being repainted
        ''
        case WM_PAINT
          
            hDC = BeginPaint( hWnd, pnt )
            GetClientRect hWnd, rct
            
            DrawText hDC,"Hello Windows from FreeBasic!", -1, _
                     rct, DT_SINGLELINE or DT_CENTER or DT_VCENTER
            
            EndPaint hWnd, pnt
            
            exit function            
        
		''
		''
		''
		case WM_KEYDOWN
			if( lobyte( wParam ) = 27 ) then
				PostMessage hWnd, WM_CLOSE, 0, 0
			end if

        ''
        '' Window was closed
        ''
        case WM_DESTROY
            PostQuitMessage 0            
            exit function
    end select
    
    ''
    '' Message doesn't concern us, send it to the default handler
    '' and get result
    ''
    WndProc = DefWindowProc( hWnd, message, wParam, lParam )    
    
end function




'' ::::::::
'' name: WinMain
'' desc: A win2 gui program entry point
''
'' ::::::::
defint a-z
function WinMain ( byval hInstance as long, _
                   byval hPrevInstance as long, _
                   szCmdLine as string, _
                   byval iCmdShow as integer ) as integer    
     
     dim wMsg as MSG
     dim wcls as WNDCLASS     
     dim szAppName as string
     dim hWnd as unsigned long

     
     WinMain = 0
     
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
     	.hIcon         = LoadIcon( null, IDI_APPLICATION )
     	.hCursor       = LoadCursor( null, IDC_ARROW )
     	.hbrBackground = GetStockObject( WHITE_BRUSH )
     	.lpszMenuName  = null
     	.lpszClassName = strptr( szAppName )
     end with
     
     
     ''
     '' Register the window class     
     ''     
     if ( RegisterClass( wcls ) = false ) then
        MessageBox null, "This program requires Windows NT!", szAppName, MB_ICONERROR               
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
                          null, _
                          null, _
                          hInstance, _
                          null )
                          

    ShowWindow   hWnd, iCmdShow
    UpdateWindow hWnd
     

    ''
    '' Process windows messages
    ''
    while ( GetMessage( wMsg, null, 0, 0 ) <> false )    
        TranslateMessage wMsg
        DispatchMessage  wMsg
    wend
    
    
    ''
    '' Program has ended
    ''
    WinMain = wMsg.wParam

end function






