''
'' toolbar demo, code by zydon (...@...)
''

#include once "windows.bi"
#include once "win/commctrl.bi"
	
const TBSTYLES = TBSTYLE_FLAT or CCS_ADJUSTABLE or CCS_NODIVIDER 

	dim shared hInstance as HINSTANCE
	
	hInstance = GetModuleHandle( null )
	

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
        '' Toolbar object handle    
        dim hTools as HWND
              
        '' Toolbar button constructors 
        dim tbAddBmp as TBADDBITMAP 
        dim tbb as TBBUTTON

        '' setting common control mode 
        dim iccx as INITCOMMONCONTROLSEX 
        iccx.dwSize = len( iccx ) 
        iccx.dwICC  = ICC_BAR_CLASSES 

        '' bitmap for each button 
        static tbBmp(0 to 6) as BYTE = {STD_FILENEW, STD_FILEOPEN, STD_FILESAVE, STD_CUT, STD_COPY, STD_PASTE }

        '' initialize common controls 32 
        InitCommonControlsEx( @iccx )

        '' Lets build a new toolbar 
        hTools = CreateWindowEx( WS_EX_DLGMODALFRAME, _ 
        						 TOOLBARCLASSNAME, NULL, _ 
                       			 WS_CHILD or WS_VISIBLE or TBSTYLES, _ 
                       			 0, 0, 0, 0, _ 
                       			 hWnd, NULL, _ 
                       			 hInstance, NULL ) 
              
		'' paint toolbar buttons now 
    	if ( hTools <> NULL ) then                 
        	'' draw toolbar panel 
            SendMessage( hTools, TB_BUTTONSTRUCTSIZE, len( tbb ), NULL ) 
            tbAddBmp.hInst = HINST_COMMCTRL 
            tbAddBmp.nID   = IDB_STD_SMALL_COLOR 
            SendMessage( hTools, TB_ADDBITMAP, 0, cint( @tbAddBmp ) ) 

            '' apply bitmap to toolbar buttons 
            with tbb
            	dim i as LONG 
				for i = 0 to 6 
					.iBitmap   = tbBmp(i)
                	.fsState   = TBSTATE_ENABLED 
                	.fsStyle   = iif( i = 3, TBSTYLE_SEP, TBSTYLE_BUTTON )
                	.idCommand = -1 
                	.dwData    = 0 
                	SendMessage( hTools, TB_ADDBUTTONS, 1, cint( @tbb ) ) 
				next 
			end with
		end if 
        
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
    appName = "WinToolBar" 
    
	with wcls
		.style         = CS_HREDRAW or CS_VREDRAW 
		.lpfnWndProc   = @WndProc
		.cbClsExtra    = 0 
		.cbWndExtra    = 0 
		.hInstance     = hInstance 
		.hIcon         = LoadIcon( null, IDI_APPLICATION ) 
		.hCursor       = LoadCursor( null, IDC_ARROW ) 
		.hbrBackground = cast( HGDIOBJ, 16 )  ' btnface color 
		.lpszMenuName  = null 
		.lpszClassName = strptr( appName ) 
	end with
      
	if ( RegisterClass( @wcls ) = false ) then 
   		MessageBox( null, "Failed to register wcls!", appName, MB_ICONERROR )
   		end 1
	end if 
    
	hWnd = CreateWindowEx( 0, _ 
                           appName, "ToolBar Demo", _ 
         			  	   WS_OVERLAPPEDWINDOW or WS_VISIBLE, _ 
         				   100, 100, 300, 200, _ 
         				   null, null, hInstance, null ) 
                          
	'' 
	'' messages loop 
	'' 
	do until( GetMessage( @wMsg, null, 0, 0 ) = FALSE )
		TranslateMessage( @wMsg )
   		DispatchMessage( @wMsg )
	loop
	
	end 0
