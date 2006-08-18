''
'' bitmap drawing test
''



#include once "windows.bi"

declare function WinMain     ( byval hInstance as HINSTANCE, _
                               byval hPrevInstance as HINSTANCE, _
                               byref szCmdLine as string, _
                               byval iCmdShow as integer ) as integer


extern fblogo_data(0 to 3126-1) as ubyte

	end WinMain( GetModuleHandle( NULL ), NULL, command, SW_NORMAL )

#define SCALE_MULT 256
#define SCALE_CALC(x,s) (((x) * (s)) \ SCALE_MULT)

''::::
''
''
function WndProc ( byval hWnd as HWND, _
                   byval message as UINT, _
                   byval wParam as WPARAM, _
                   byval lParam as LPARAM ) as LRESULT

    dim as PAINTSTRUCT pnt 
    dim as HDC hDC 
    dim as RECT rct
  	
  	static logoinfo as BITMAPINFO ptr
    static logodib as HBITMAP
    static as integer x = 0, y = 0, scale = SCALE_MULT
    
    select case ( message )
       
	''
    case WM_CREATE            

		'' pointer to bitmap file
		dim logo as BITMAPFILEHEADER ptr = cast( any ptr, @fblogo_data(0) )

		'' pointer to bitmap header
  		logoinfo = cast(BITMAPINFO ptr, logo + 1)

  		'' create a DIB
  		logodib = CreateDIBitmap( GetDC( hWnd ), _
  								  @logoinfo->bmiHeader, _
  								  CBM_INIT, _
  								  cast(byte ptr, logo) + logo->bfOffBits, _
  								  logoinfo, _
  								  DIB_RGB_COLORS ) 
  	
        return 0
        
	''
	case WM_PAINT
          
    	hDC = BeginPaint( hWnd, @pnt )
            
        '' load DIB into a compatible DC
        dim memDC as HDC
        memDC = CreateCompatibleDC( hDC )
            
        dim oldobj as HGDIOBJ
        oldobj = SelectObject( memDC, logodib )
            
        '' blit the compatible DC to this window
        if( scale = SCALE_MULT ) then
        	BitBlt( hDC, _
        			x, y, logoinfo->bmiHeader.biWidth, logoinfo->bmiHeader.biHeight, _
           			memDC, 0, 0, _
           			SRCCOPY )
		
		else
        	StretchBlt( hDC, _
        				x, y, SCALE_CALC( logoinfo->bmiHeader.biWidth, scale ), SCALE_CALC( logoinfo->bmiHeader.biHeight, scale ), _
           				memDC, 0, 0, logoinfo->bmiHeader.biWidth, logoinfo->bmiHeader.biHeight, _
           				SRCCOPY )
		end if
            
        '' restore
        SelectObject( memDC, oldobj )
        DeleteDC( memDC )
            
        EndPaint( hWnd, @pnt )
            
        return 0
        
	''
	case WM_KEYDOWN
			
		dim doupdate as integer = FALSE
		
		select case lobyte( wParam )
		case VK_ESCAPE
			PostMessage( hWnd, WM_CLOSE, 0, 0 )
			return 0
		
		case VK_UP
			y -= 8
			doupdate = TRUE
		case VK_DOWN
			y += 8
			doupdate = TRUE
		case VK_LEFT
			x -= 8
			doupdate = TRUE
		case VK_RIGHT
			x += 8
			doupdate = TRUE
		case VK_ADD
			scale += 8
			doupdate = TRUE
		case VK_SUBTRACT
			scale -= 8
			doupdate = TRUE
		end select
			
		if( doupdate ) then
			with rct
				.left 	= x - 8
				.top 	= y - 8
				.right  = .left + SCALE_CALC( logoinfo->bmiHeader.biWidth, scale ) + 8 + 8
				.bottom = .top + SCALE_CALC( logoinfo->bmiHeader.biHeight, scale ) + 8 + 8
			end with

			InvalidateRect( hwnd, @rct, TRUE )
			return 0
		end if
        
	''
	case WM_DESTROY
    	
    	PostQuitMessage( 0 )
    	return 0
    
    end select
    
    ''
    return DefWindowProc( hWnd, message, wParam, lParam )    
    
end function

''::::
''
''
function WinMain ( byval hInstance as HINSTANCE, _
                   byval hPrevInstance as HINSTANCE, _
                   byref szCmdLine as string, _
                   byval iCmdShow as integer ) as integer    
     
    dim wMsg as MSG
    dim wcls as WNDCLASS     
    dim szAppName as string
    dim hWnd as HWND

    function = 0
     
    szAppName = "BitmapTest"
     
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
     
    if( RegisterClass( @wcls ) = false ) then
        exit function
    end if

    hWnd = CreateWindowEx( 0, szAppName, "Bitmap Test", WS_OVERLAPPEDWINDOW, _
                           CW_USEDEFAULT, CW_USEDEFAULT, 320, 200, _
                           null, null, hInstance, null )
                          

    ShowWindow( hWnd, iCmdShow )
    UpdateWindow( hWnd )
     
    while ( GetMessage( @wMsg, null, 0, 0 ) <> false )    
        TranslateMessage( @wMsg )
        DispatchMessage( @wMsg )
    wend
    
    function = wMsg.wParam

end function


''
'' the BMP file, converted by bin2bas
''
dim shared fblogo_data(0 to 3126-1) as ubyte = { _
&h42,&h4d,&h36,&hc,&h0,&h0,&h0,&h0,&h0,&h0,&h36,&h0,&h0,&h0,&h28,&h0,&h0,&h0,&h20,&h0,&h0,&h0,&h20,&h0,&h0,&h0,&h1,&h0,&h18,&h0,&h0, _
&h0,&h0,&h0,&h0,&hc,&h0,&h0,&hd2,&h1e,&h0,&h0,&hd2,&h1e,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hbf,&hbf,&hbf,&h43,&h43,&h43, _
&h5d,&h5d,&h5d,&hfe,&hfe,&hfe,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&he6,&he6,&he6,&h39,&h39,&h39,&h8a,&h8a,&h8a,&he3,&he3,&he3,&h80, _
&h80,&h80,&hbb,&hbb,&hbb,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&he7,&he7,&he7,&h19,&h19,&h19,&hfc,&hfc,&hfc,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hc4,&hc4,&hc4,&h36,&h36,&h36,&h53, _
&h53,&h53,&h70,&h70,&h70,&h39,&h39,&h39,&hba,&hba,&hba,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&he6,&he6,&he6,&h60,&h60,&h60,&hcd,&hcd,&hcd,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hf8, _
&hf8,&hf8,&h51,&h51,&h51,&hc0,&hc0,&hc0,&hce,&hce,&hce,&h1b,&h1b,&h1b,&hdf,&hdf,&hdf,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hca,&hca,&hca,&h16,&h16,&h16,&h88,&h88,&h88,&h69,&h69,&h69,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hed,&hed,&hed,&h49,&h49,&h49,&hef,&hef,&hef,&haa,&haa,&haa,&h41,&h41,&h41,&hf3,&hf3,&hf3,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hfd,&hfd,&hfd,&h56,&h56,&h56,&h2a,&h2a,&h2a,&h6f,&h6f,&h6f,&hd8,&hd8,&hd8,&h7,&h7,&h7,&hd5,&hd5,&hd5,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hcf,&hcf,&hcf,&h45,&h45,&h45,&hf3,&hf3,&hf3,&h7f,&h7f,&h7f,&h48,&h48,&h48,&hf6,&hf6,&hf6,&hff,&hff, _
&hff,&hff,&hff,&hff,&hd5,&hd5,&hd5,&he9,&he9,&he9,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hab,&hab,&hab,&h68,&h68,&h68,&he3,&he3,&he3,&hff,&hff,&hff,&hfd,&hfd,&hfd,&h3f,&h3f,&h3f,&h8b,&h8b,&h8b,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hfe,&hfe,&hfe,&h3d,&h3d,&h3d,&h4b,&h4b,&h4b,&hf9,&hf9,&hf9,&h1d,&h1d,&h1d,&h51,&h51, _
&h51,&hff,&hff,&hff,&hfe,&hfe,&hfe,&h58,&h58,&h58,&hf6,&hf6,&hf6,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hde,&hde,&hde,&h5d,&h5d,&h5d,&hfc,&hfc,&hfc,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hb7,&hb7,&hb7,&hc,&hc,&hc,&hce,&hce,&hce,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hef,&hef,&hef,&h2f,&h2f,&h2f,&h1,&h1,&h1,&h7d,&h7d,&h7d,&h2,&h2, _
&h2,&h65,&h65,&h65,&hff,&hff,&hff,&hf5,&hf5,&hf5,&h18,&h18,&h18,&hf8,&hf8,&hf8,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hfe,&hfe,&hfe,&h3b,&h3b,&h3b,&h77,&h77,&h77,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hf4,&hf4,&hf4,&h19,&h19,&h19,&h29, _
&h29,&h29,&hf0,&hf0,&hf0,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&h5e,&h5e,&h5e,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0, _
&h0,&h3f,&h3f,&h3f,&hf5,&hf5,&hf5,&hff,&hff,&hff,&hf6,&hf6,&hf6,&hb,&hb,&hb,&had,&had,&had,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&h6a,&h6a,&h6a,&h7,&h7,&h7,&h37,&h37,&h37,&h37,&h37,&h37,&h3d,&h3d,&h3d,&h45,&h45,&h45,&h6b,&h6b,&h6b,&h4d, _
&h4d,&h4d,&h0,&h0,&h0,&h26,&h26,&h26,&h3e,&h3e,&h3e,&h3a,&h3a,&h3a,&h60,&h60,&h60,&haa,&haa,&haa,&h85,&h85,&h85,&h3,&h3,&h3,&h0,&h0,&h0,&h0,&h0, _
&h0,&h0,&h0,&h0,&h81,&h81,&h81,&hfe,&hfe,&hfe,&hff,&hff,&hff,&hfe,&hfe,&hfe,&h35,&h35,&h35,&h1b,&h1b,&h1b,&he9,&he9,&he9,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hfb,&hfb,&hfb,&hd3,&hd3,&hd3,&h7f,&h7f,&h7f,&h3c,&h3c,&h3c,&h2,&h2,&h2,&h0,&h0,&h0,&h0, _
&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0, _
&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h1,&h1,&h1,&h80,&h80,&h80,&hfd,&hfd,&hfd,&hff,&hff,&hff,&h88,&h88,&h88,&h0,&h0,&h0,&h5a,&h5a,&h5a,&hfe,&hfe,&hfe, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&he7,&he7,&he7,&hd,&hd,&hd,&h0, _
&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h2,&h2,&h2,&h2,&h2,&h2,&h2,&h2,&h2,&h2,&h2,&h2,&h3,&h3,&h3,&h4,&h4,&h4,&h6,&h6, _
&h6,&h6,&h6,&h6,&h3,&h3,&h3,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h62,&h62,&h62,&hfd,&hfd,&hfd,&hed,&hed,&hed,&h10,&h10,&h10,&h3,&h3,&h3, _
&hc6,&hc6,&hc6,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hb4,&hb4,&hb4,&h0, _
&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h1,&h1,&h1,&h7,&h7,&h7,&h9,&h9,&h9,&ha,&ha,&ha,&h9,&h9,&h9,&h9,&h9,&h9,&h9,&h9,&h9,&h9,&h9, _
&h9,&ha,&ha,&ha,&h8,&h8,&h8,&h8,&h8,&h8,&h2,&h2,&h2,&h0,&h0,&h0,&h0,&h0,&h0,&h1,&h1,&h1,&hc9,&hc9,&hc9,&hff,&hff,&hff,&h75,&h75,&h75, _
&h0,&h0,&h0,&h48,&h48,&h48,&hfd,&hfd,&hfd,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hf1, _
&hf1,&hf1,&h24,&h24,&h24,&h0,&h0,&h0,&h0,&h0,&h0,&h6,&h6,&h6,&hb,&hb,&hb,&hf,&hf,&hf,&h10,&h10,&h10,&h10,&h10,&h10,&hf,&hf,&hf,&hd,&hd, _
&hd,&hd,&hd,&hd,&hc,&hc,&hc,&h8,&h8,&h8,&h8,&h8,&h8,&h2,&h2,&h2,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&ha8,&ha8,&ha8,&hff,&hff,&hff, _
&hc8,&hc8,&hc8,&h0,&h0,&h0,&h1,&h1,&h1,&haf,&haf,&haf,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hb5,&hb5,&hb5,&h1,&h1,&h1,&h0,&h0,&h0,&h7,&h7,&h7,&hd,&hd,&hd,&h10,&h10,&h10,&hf,&hf,&hf,&hc,&hc,&hc,&h8,&h8, _
&h8,&h7,&h7,&h7,&h7,&h7,&h7,&h6,&h6,&h6,&h5,&h5,&h5,&h2,&h2,&h2,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h5,&h5,&h5,&he2,&he2,&he2, _
&hff,&hff,&hff,&hb2,&hb2,&hb2,&h0,&h0,&h0,&h0,&h0,&h0,&h4d,&h4d,&h4d,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hfd,&hfd,&hfd,&ha0, _
&ha0,&ha0,&ha8,&ha8,&ha8,&hfd,&hfd,&hfd,&hfd,&hfd,&hfd,&h33,&h33,&h33,&h0,&h0,&h0,&h8,&h8,&h8,&h8,&h8,&h8,&h9,&h9,&h9,&h8,&h8,&h8,&h5,&h5, _
&h5,&h2,&h2,&h2,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h3c,&h3c,&h3c, _
&hfe,&hfe,&hfe,&hff,&hff,&hff,&h7c,&h7c,&h7c,&h0,&h0,&h0,&h0,&h0,&h0,&h6e,&h6e,&h6e,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hd0, _
&hd0,&hd0,&h1,&h1,&h1,&h15,&h15,&h15,&hf8,&hf8,&hf8,&hff,&hff,&hff,&h54,&h54,&h54,&h0,&h0,&h0,&h5,&h5,&h5,&h6,&h6,&h6,&h3,&h3,&h3,&h0,&h0, _
&h0,&h0,&h0,&h0,&h1,&h1,&h1,&h4,&h4,&h4,&h1,&h1,&h1,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0, _
&h72,&h72,&h72,&hc5,&hc5,&hc5,&h97,&h97,&h97,&h10,&h10,&h10,&h0,&h0,&h0,&h0,&h0,&h0,&h9f,&h9f,&h9f,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hde,&hde,&hde,&h1,&h1,&h1,&h1,&h1,&h1,&h7b,&h7b,&h7b,&hdd,&hdd,&hdd,&h10,&h10,&h10,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0, _
&h0,&h1,&h1,&h1,&h6b,&h6b,&h6b,&hd6,&hd6,&hd6,&he3,&he3,&he3,&hd3,&hd3,&hd3,&ha0,&ha0,&ha0,&h59,&h59,&h59,&he,&he,&he,&ha,&ha,&ha,&h2a,&h2a,&h2a, _
&h70,&h70,&h70,&h59,&h59,&h59,&h9,&h9,&h9,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&hc0,&hc0,&hc0,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hfb,&hfb,&hfb,&h18,&h18,&h18,&h0,&h0,&h0,&h0,&h0,&h0,&hf,&hf,&hf,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0, _
&h0,&h0,&h0,&h0,&h13,&h13,&h13,&he5,&he5,&he5,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hfe,&hfe,&hfe,&hf4,&hf4,&hf4,&hf1,&hf1,&hf1, _
&hfd,&hfd,&hfd,&hff,&hff,&hff,&hfe,&hfe,&hfe,&hd3,&hd3,&hd3,&h32,&h32,&h32,&h0,&h0,&h0,&h4,&h4,&h4,&h60,&h60,&h60,&hf8,&hf8,&hf8,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&h43,&h43,&h43,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0, _
&h0,&h0,&h0,&h0,&h1,&h1,&h1,&hae,&hae,&hae,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hf7,&hf7,&hf7,&hb5,&hb5,&hb5,&he4,&he4,&he4,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&h76,&h76,&h76,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0,&h0, _
&h0,&h0,&h0,&h0,&h5,&h5,&h5,&h8d,&h8d,&h8d,&hfe,&hfe,&hfe,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hdf,&hdf,&hdf,&h62,&h62,&h62,&h6,&h6,&h6,&h3,&h3,&h3,&h5,&h5, _
&h5,&he,&he,&he,&h41,&h41,&h41,&hc3,&hc3,&hc3,&hfe,&hfe,&hfe,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hfe,&hfe,&hfe,&hce,&hce,&hce,&hdf,&hdf, _
&hdf,&hf2,&hf2,&hf2,&hf5,&hf5,&hf5,&hfe,&hfe,&hfe,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff, _
&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff,&hff }


