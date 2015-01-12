

#include once "windows.bi"

const POLY_VERTICES = 5

#define DEG2RAD(x) x * (3.141593 / 180)

declare function        WinMain     ( byval hInstance as HINSTANCE, _
                                      byval hPrevInstance as HINSTANCE, _
                                      byval szCmdLine as zstring ptr, _
                                      byval iCmdShow as integer ) as integer
                                  
                                  
'':::::
	end WinMain( GetModuleHandle( null ), null, Command( ), SW_NORMAL )

'':::::
sub create_poly (byval x as integer, byval y as integer, _
				 byval radius as integer, byval vertices as integer, _
				 byval ang as integer, _
				 vertTb() as POINT )
     
	dim as integer cx = x - radius, cy = y
	dim as integer stp = 180 \ vertices, df = 180 mod vertices
	dim as integer diam = radius * 2
	dim as integer deg = (ang \ 2) - stp
	dim as integer v = vertices
	dim as integer i
	
	for i = 0 to vertices
		v -= df
		if v <= 0 then
			v += vertices
		end if
     
     	deg += stp
     	dim as double r = diam * cos( DEG2RAD(deg) )
    	
    	with vertTb(i)
     		.x = cx + r * cos( DEG2RAD(deg) )
     		.y = cy + r * sin( DEG2RAD(deg) )
     	end with
	next

end sub

'':::::
function WndProc ( byval hWnd as HWND, _
                   byval wMsg as UINT, _
                   byval wParam as WPARAM, _
                   byval lParam as LPARAM ) as LRESULT
    
	dim as RECT rect
	static as POINT vertTB( 0 to POLY_VERTICES )

    function = 0
    
    select case( wMsg )
        case WM_CREATE            
        	GetClientRect( hWnd, @rect )
        	
        	create_poly( rect.right \ 2, _
        				 rect.bottom \ 2, _
        				 iif(rect.right < rect.bottom, rect.right, rect.bottom) \ 2, _
        				 POLY_VERTICES, _
        				 0, _
        				 vertTb() )
            
            SetWindowRgn( hWnd, CreatePolygonRgn( @vertTb(0), POLY_VERTICES, WINDING ), TRUE )
            
            exit function
        
        case WM_PAINT
    		dim as PAINTSTRUCT pnt 
    		dim as HDC hDC
          
            hDC = BeginPaint( hWnd, @pnt )
            GetClientRect( hWnd, @rect )
            
            SetBkMode( hDC, TRANSPARENT	)
            SetTextColor( hDC, BGR( 63, 127, 255 ) )
            
            DrawText( hDC, _
              	  	  "Hello, World!", _
              	  	  -1, _
               	  	  @rect, _
               	  	  DT_SINGLELINE or DT_CENTER or DT_VCENTER )
               	  	  
            EndPaint( hWnd, @pnt )
            
            exit function            
        
		case WM_LBUTTONDOWN
			SendMessage( hWnd, WM_NCLBUTTONDOWN, HTCAPTION, NULL )

		case WM_KEYDOWN
			if( lobyte( wParam ) = 27 ) then
				PostMessage( hWnd, WM_CLOSE, 0, 0 )
				exit function
			end if

    	case WM_DESTROY
            PostQuitMessage( 0 )
            exit function
    end select
    
    function = DefWindowProc( hWnd, wMsg, wParam, lParam )    
    
end function

'':::::
sub remove_caption(byval hwnd as HWND )
	dim as RECT rect

  	dim as integer style = GetWindowLong( hwnd, GWL_STYLE ) and (not WS_CAPTION)
  	SetWindowLong( hwnd, GWL_STYLE, style ) 
  	GetClientRect( hwnd, @rect )
	AdjustWindowRect( @rect, style, (GetMenu( hwnd ) <> NULL) )
  	SetWindowPos( hwnd, 0, 0, 0, rect.Right, rect.Bottom, _
				  SWP_NOMOVE or SWP_NOZORDER or SWP_FRAMECHANGED or SWP_NOSENDCHANGING )
end sub

'':::::
function WinMain ( byval hInstance as HINSTANCE, _
                   byval hPrevInstance as HINSTANCE, _
                   byval szCmdLine as zstring ptr, _
                   byval iCmdShow as integer ) as integer    
     
    dim as MSG wMsg 
    dim as WNDCLASS wcls 
    dim as HWND hWnd 
     
    function = 0
     
    with wcls
    	.style         = CS_HREDRAW or CS_VREDRAW
    	.lpfnWndProc   = @WndProc
    	.cbClsExtra    = 0
    	.cbWndExtra    = 0
    	.hInstance     = hInstance
    	.hIcon         = LoadIcon( NULL, IDI_APPLICATION )
    	.hCursor       = LoadCursor( NULL, IDC_ARROW )
    	.hbrBackground = GetStockObject( LTGRAY_BRUSH )
    	.lpszMenuName  = NULL
    	.lpszClassName = @"HelloWin"
    end with
          
    if( RegisterClass( @wcls ) = FALSE ) then
       MessageBox( null, "Failed to register wcls!", "Error", MB_ICONERROR )
       exit function
    end if
    
    hWnd = CreateWindowEx( 0, _
    			 		   "HelloWin", _
                           NULL, _
                           WS_OVERLAPPED, _
                           0, _
                           0, _
                           480, _
                           480, _
                           NULL, _
                           NULL, _
                           hInstance, _
                           NULL )
                          
    remove_caption( hWnd )
    
    ShowWindow( hWnd, iCmdShow )
    UpdateWindow( hWnd )
     
    while( GetMessage( @wMsg, NULL, 0, 0 ) <> FALSE )    
        TranslateMessage( @wMsg )
        DispatchMessage( @wMsg )
    wend
    
    
    function = wMsg.wParam

end function
