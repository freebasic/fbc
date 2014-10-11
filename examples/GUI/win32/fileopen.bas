''
'' file open dialog demo
'' This demo displays a window containing some explanation text and a File menu.
'' On selecting "Open" in the file menu, the File Open dialog box appears and lets the user select a file name.
'' This demo should run on Windows.
''

#define WIN_INCLUDEALL
#include once "windows.bi"

''types, constants and enums

type TMENU
	hnd		as HMENU
end type

const MENUID_BASE		= 100

enum MENUID_ENUM
	MENUID_FILE_OPEN	= MENUID_BASE
	MENUID_FILE_EXIT
	MAXMENUS
end enum

''declare subs and functions visible to the outside user

declare sub 	 init_menus		( byval hWnd as HWND )

declare function WinMain     	( byval hInstance as HINSTANCE, _
                                  byval hPrevInstance as HINSTANCE, _
                                  byref szCmdLine as string, _
                                  byval iCmdShow as integer ) as integer
                                  
                                  
	''
	dim shared submenuTB(0 to MAXMENUS) as TMENU
    
    ''
	end WinMain( GetModuleHandle( null ), null, Command, SW_NORMAL )

''function to get a file name
''parameter: hWnd = handle to the caller who sent the message
''return value: selected file name

function file_getname( byval hWnd as HWND ) as string

''fill structure for dialog box

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

''call open file dialog, return empty string if no file selected, else return file name

	if( GetOpenFileName( @ofn ) = FALSE ) then
		return ""
	else
		return filename
	end if

end function

''Message handler
''handles any messages that come in
''This procedure runs every time a message comes in
''Parameters:
''hWnd: handle to the sender of the message
''message: code of the actual message
''wParam: first parameter (if applies)
''lParam: second parameter (if applies)

function WndProc ( byval hWnd as HWND, _
                   byval message as UINT, _
                   byval wParam as WPARAM, _
                   byval lParam as LPARAM ) as LRESULT

''declare certain things needed for message processing

    dim rct as RECT
    dim pnt as PAINTSTRUCT
    dim hDC as HDC
    
    static as string filetoopen

    function = 0
    
    ''see which message we got
    select case( message )
        
    ''on opening the window, initialize the menu
    case WM_CREATE            
		init_menus( hWnd )
		exit function
        
    ''on getting a menu command selected, see which one it is (wParam contains the menu ID)
    
	case WM_COMMAND
			
		select case loword( wParam )
		
		'' quit? then quit the application
		case MENUID_FILE_EXIT
			PostMessage( hWnd, WM_CLOSE, 0, 0 )
		
		'' open? then get the file name to open and invalidate the client rectangle
		case MENUID_FILE_OPEN
			filetoopen = file_getname( hWnd )
			GetClientRect( hWnd, @rct )
			InvalidateRect( hWnd, @rct, TRUE )
		end select
		
		exit function
			
	''on getting a repaint command, draw the explaning text into the window
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
        
	''on getting a keyboard input, close the application if the keycode = 27 (ESC)
		case WM_KEYDOWN
		if( lobyte( wParam ) = 27 ) then
			PostMessage( hWnd, WM_CLOSE, 0, 0 )
			exit function
		end if

	''on getting a destroy window request, post the quit message
    case WM_DESTROY
    	PostQuitMessage( 0 )
        exit function
    end select
    
    ''if this is reached, the message can't be handled here, so repost it to Windows
    function = DefWindowProc( hWnd, message, wParam, lParam )    
    
end function

''Function to create the application window and process any messages
''Parameters:
''hInstance...
''hPrevInstance...
''szCmdLine... parameter command line
''iCmdShow...
''Return value: parameter of last message received
''This function runs as long as the application is open

function WinMain ( byval hInstance as HINSTANCE, _
                   byval hPrevInstance as HINSTANCE, _
                   byref szCmdLine as string, _
                   byval iCmdShow as integer ) as integer    
     
    dim wMsg as MSG
    dim wcls as WNDCLASS     
    dim appName as string
    dim hWnd as HWND
     
    function = 0
    
    ''set application name
    
    appName = "FileOpenTest"
    
    '' fill parameters for wcls
     
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
          
    ''Try to register the wcl class and exit if unsuccessful
    
    if( RegisterClass( @wcls ) = FALSE ) then
       	exit function
    end if
    
    ''create the window, show and update it
    
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
     
    ''look for messages, translate and dispatch them
    
    while( GetMessage( @wMsg, NULL, 0, 0 ) <> FALSE )    
        TranslateMessage( @wMsg )
        DispatchMessage( @wMsg )
    wend
    
    ''return the parameter of the last message
    
    function = wMsg.wParam

end function

'':::::
''Subroutine for inserting a menu (top level)
'' (actually wrapping the InsertMenu function)
''Parameters:
''hmenu = menu structure to add
''submenu = parameter to pass to InsertMenu
''title = title of menu
''flags = flags to pass to the InsertMenu function

sub menu_insert( byval hmenu as HMENU, byval submenu as integer, byref title as string, byval flags as integer = 0 )
    
    with submenuTB(submenu)
    
    	.hnd 	= CreatePopupMenu( )
    
    	InsertMenu( hmenu, submenu, MF_BYPOSITION Or MF_POPUP Or MF_STRING or flags, cuint( .hnd ), title )
    	
    end with
    
end sub

'':::::
''Subroutine for adding a submenu to a menu
'' (actually wrapping the AppendMenu function)
''Parameters:
''submenu = ID of menu to add the item to
''id = ID of the menu to add
''title = title of the menu to add
''flags = flags to use for the AppendMenu function (see there)

sub menu_append( byval submenu as integer, byval id as integer, byref title as string, byval flags as integer = 0 )
    
    AppendMenu( submenuTB(submenu).hnd, MF_STRING or flags, id, title )
   
end sub

'':::::
''Subroutine for adding a separator to a menu
''Parameter: submenu = ID of menu to add a separator to

sub menu_separator( byval submenu as integer )

    AppendMenu( submenuTB(submenu).hnd, MF_SEPARATOR, 0, NULL )
   
end sub

'':::::
''Subroutine for initializing the menu
''Parameter: hWnd = handle to the window which should have the menu

sub init_menus( byval hWnd as HWND )
	dim menu as HMENU '' menu in its creation stage
 	
 	menu = CreateMenu( )
 	
 	'' add File menu, consisting of Open, separator and Exit
 	
 	menu_insert( menu, 0, "&File" )
    
    menu_append( 0, MENUID_FILE_OPEN, "&Open..." )
    menu_separator( 0 )
    menu_append( 0, MENUID_FILE_EXIT, "&Exit" )
    
    '' set the menu as the menu of the given window and draw it
    
    SetMenu( hWnd, menu )
    
    DrawMenuBar( hWnd )
    
end sub
