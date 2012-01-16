''
'' file open dialog demo
''

#define WIN_INCLUDEALL
#include once "windows.bi"

type TMENU
	hnd		as HMENU
end type

const MENUID_BASE		= 100

enum MENUID_ENUM
	MENUID_FILE_OPEN	= MENUID_BASE
	MENUID_FILE_EXIT
	MAXMENUS
end enum

declare sub 	 init_menus		( byval hWnd as HWND )

declare function WinMain     	( byval hInstance as HINSTANCE, _
                                  byval hPrevInstance as HINSTANCE, _
                                  byref szCmdLine as string, _
                                  byval iCmdShow as integer ) as integer
                                  
                                  
	''
	dim shared submenuTB(0 to MAXMENUS) as TMENU
    
    ''
	end WinMain( GetModuleHandle( null ), null, Command, SW_NORMAL )

'':::::
function file_getname( byval hWnd as HWND ) as string

	dim ofn as OPENFILENAME
	dim filename as zstring * MAX_PATH+1
	
	with ofn
		.lStructSize 		= sizeof( OPENFILENAME )
		.hwndOwner	 		= hWnd
		.hInstance	 		= GetModuleHandle( NULL )
		.lpstrFilter 		= strptr( !"All Files, (*.*)\0*.*\0Bas Files, (*.BAS)\0*.bas\0\0" )
		.lpstrCustomFilter 	= NULL
		.nMaxCustFilter 	= 0
		.nFilterIndex 		= 1
		.lpstrFile			= @filename
		.nMaxFile			= sizeof( filename )
		.lpstrFileTitle		= NULL
		.nMaxFileTitle		= 0
		.lpstrInitialDir	= NULL
		.lpstrTitle			= @"File Open Test"
		.Flags				= OFN_EXPLORER or OFN_FILEMUSTEXIST or OFN_PATHMUSTEXIST
		.nFileOffset		= 0
		.nFileExtension		= 0
		.lpstrDefExt		= NULL
		.lCustData			= 0
		.lpfnHook			= NULL
		.lpTemplateName		= NULL
	end with
	
	if( GetOpenFileName( @ofn ) = FALSE ) then
		return ""
	else
		return filename
	end if

end function

'':::::
function WndProc ( byval hWnd as HWND, _
                   byval message as UINT, _
                   byval wParam as WPARAM, _
                   byval lParam as LPARAM ) as LRESULT
    
    dim rct as RECT
    dim pnt as PAINTSTRUCT
    dim hDC as HDC
    
    static as string filetoopen

    function = 0
    
    ''
    select case( message )
        
    ''
    case WM_CREATE            
		init_menus( hWnd )
		exit function
        
    ''
	case WM_COMMAND
			
		select case loword( wParam )
		'' quit?
		case MENUID_FILE_EXIT
			PostMessage( hWnd, WM_CLOSE, 0, 0 )
		
		'' open?
		case MENUID_FILE_OPEN
			filetoopen = file_getname( hWnd )
			GetClientRect( hWnd, @rct )
			InvalidateRect( hWnd, @rct, TRUE )
		end select
		
		exit function
			
	''
    case WM_PAINT
    	hDC = BeginPaint( hWnd, @pnt )
        GetClientRect( hWnd, @rct )
            
        if( len( filetoopen ) = 0 ) then
       		filetoopen = "Select a file using the File->Open... menu"
    	end if
        	
        DrawText( hDC, _
           		  !"\"" & filetoopen & !"\"", _
           		  -1, _
           		  @rct, _
           		  DT_SINGLELINE or DT_CENTER or DT_VCENTER )
            
        EndPaint( hWnd, @pnt )
            
        exit function            
        
	''
	case WM_KEYDOWN
		if( lobyte( wParam ) = 27 ) then
			PostMessage( hWnd, WM_CLOSE, 0, 0 )
			exit function
		end if

	''
    case WM_DESTROY
    	PostQuitMessage( 0 )
        exit function
    end select
    
    ''
    function = DefWindowProc( hWnd, message, wParam, lParam )    
    
end function

'':::::
function WinMain ( byval hInstance as HINSTANCE, _
                   byval hPrevInstance as HINSTANCE, _
                   byref szCmdLine as string, _
                   byval iCmdShow as integer ) as integer    
     
    dim wMsg as MSG
    dim wcls as WNDCLASS     
    dim appName as string
    dim hWnd as HWND
     
    function = 0
    
    ''
    appName = "FileOpenTest"
     
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
    	.lpszClassName = strptr( appName )
    end with
          
    ''     
    if( RegisterClass( @wcls ) = FALSE ) then
       	exit function
    end if
    
    ''
    hWnd = CreateWindowEx( 0, _
    			 		   appName, _
                           "File Open", _
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
    while( GetMessage( @wMsg, NULL, 0, 0 ) <> FALSE )    
        TranslateMessage( @wMsg )
        DispatchMessage( @wMsg )
    wend
    
    ''
    function = wMsg.wParam

end function

'':::::
sub menu_insert( byval hmenu as HMENU, byval submenu as integer, byref title as string, byval flags as integer = 0 )
    
    with submenuTB(submenu)
    
    	.hnd 	= CreatePopupMenu( )
    
    	InsertMenu( hmenu, submenu, MF_BYPOSITION Or MF_POPUP Or MF_STRING or flags, cuint( .hnd ), title )
    	
    end with
    
end sub

'':::::
sub menu_append( byval submenu as integer, byval id as integer, byref title as string, byval flags as integer = 0 )
    
    AppendMenu( submenuTB(submenu).hnd, MF_STRING or flags, id, title )
   
end sub

'':::::
sub menu_separator( byval submenu as integer )

    AppendMenu( submenuTB(submenu).hnd, MF_SEPARATOR, 0, NULL )
   
end sub

'':::::
sub init_menus( byval hWnd as HWND )
	dim menu as HMENU
 	
 	menu = CreateMenu( )
 	
 	'' File
 	menu_insert( menu, 0, "&File" )
    
    menu_append( 0, MENUID_FILE_OPEN, "&Open..." )
    menu_separator( 0 )
    menu_append( 0, MENUID_FILE_EXIT, "&Exit" )
    
    ''
    SetMenu( hWnd, menu )
    
    DrawMenuBar( hWnd )
    
end sub
