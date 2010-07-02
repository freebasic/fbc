''
'' calendar demo, code by zydon (...@...)
''

#include once "windows.bi"
#include once "win/commctrl.bi"
	
	dim shared hInstance as HINSTANCE
	dim shared calClass as string 
	dim shared hCal as HWND
	
    hInstance = GetModuleHandle( NULL )
    calClass = MONTHCAL_CLASS 

	dim iccx as INITCOMMONCONTROLSEX 
	iccx.dwSize = len( iccx ) 
	iccx.dwICC  = ICC_DATE_CLASSES 
	InitCommonControlsEx( @iccx )



'' 
'' Window Procedure Handler 
'' 
function WndProc ( byval hWnd as HWND, _ 
                   byval uMsg as UINT, _ 
                   byval wParam as WPARAM, _ 
                   byval lParam as LPARAM ) as integer 

    function = 0 
    
    select case ( uMsg ) 
    case WM_CREATE 
		hCal = CreateWindowEx( 0, _ 
                               calClass, "", _ 
                               WS_CHILD or WS_VISIBLE, _ 
                               2, 2, 200, 160, _ 
                               hWnd, null, _ 
                               hInstance, null ) 
	
	case WM_KEYDOWN 
		if( lobyte( wParam ) = 27 ) then 
			PostMessage( hWnd, WM_CLOSE, 0, 0 )
        end if 
	
	case WM_DESTROY 
    	PostQuitMessage( 0 )
        exit function 
    end select 
    
    function = DefWindowProc( hWnd, uMsg, wParam, lParam )
        
end function 


	'' 
	'' Program entry 
	'' 
	dim wMsg as MSG 
	dim wcls as WNDCLASS      
	dim hWnd as HWND	

	dim appName as string 
    appName = "WinCal32" 

	with wcls
		.style         = CS_HREDRAW or CS_VREDRAW 
		.lpfnWndProc   = @WndProc
		.cbClsExtra    = 0 
		.cbWndExtra    = 0 
		.hInstance     = hInstance 
		.hIcon         = LoadIcon( null, IDI_APPLICATION ) 
		.hCursor       = LoadCursor( null, IDC_ARROW ) 
		.hbrBackground = cast( HGDIOBJ, 6 )  ' default color 
		.lpszMenuName  = null 
		.lpszClassName = strptr( appName ) 
	end with
      
	if( RegisterClass( @wcls ) = FALSE ) then 
   		MessageBox( null, "Failed to register wcls!", appName, MB_ICONERROR )
   		end 1
	end if 
    
	hWnd = CreateWindowEx( 0, _ 
        				   appName, "Calendar Demo [ESC to Quit]", _ 
         				   WS_CLIPCHILDREN or WS_DLGFRAME or WS_BORDER or WS_VISIBLE, _ 
         				   200, 200, 210, 190, _ 
         				   null, null, hInstance, null ) 
                          

	'' 
	'' messages loop 
	'' 
	do until( GetMessage( @wMsg, null, 0, 0 ) = FALSE )
		TranslateMessage( @wMsg )
		DispatchMessage( @wMsg )
	loop
   
	end 0
