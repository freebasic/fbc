''
'' ddrawtest -- shows how to use DirectDraw (version 7) directly from FB
''
'' code looks hard to read because all the COM interface "hacking" needed, as FB
'' has no OO-support (yet :P)
''				
'' based on C++ DX tutorials found on the Net
''


#include once "windows.bi"
#include once "win/ddraw.bi"

const SCR_WIDTH 		= 320
const SCR_HEIGHT 		= 240
const SCR_SIZE 			= (SCR_WIDTH * SCR_HEIGHT)
const SCR_BPP 			= 16					'' \
#define SCR_TYPE		ushort					'' /

#define VAL2RGB(v) (((v) shl 11) or ((v) shl 5) or (v))

declare function WinMain     ( byval hInstance as HINSTANCE, _
                               byval hPrevInstance as HINSTANCE, _
                               byref szCmdLine as string, _
                               byval iCmdShow as integer ) as integer


'' globals
	dim shared hInst as HINSTANCE
	
	dim shared pDD as IDirectDraw7 ptr
	dim shared pDDSFront as IDirectDrawSurface7 ptr
	dim shared pDDSBack as IDirectDrawSurface7 ptr
	dim shared ddsd AS DDSURFACEDESC2


	end WinMain( GetModuleHandle( null ), null, Command, SW_NORMAL )



'':::::
function InitDirectDraw( byval hWnd as HWND ) as integer	
	dim ddscaps as DDSCAPS2

	function = FALSE	
	
	' create an interface to DDraw
	if( DirectDrawCreateEx( NULL, @pDD, @IID_IDirectDraw7, NULL ) <> DD_OK ) then
       exit function
	end if

	' set the access mode (full screen)
	if( IDirectDraw7_SetCooperativeLevel( pDD, hWnd, DDSCL_EXCLUSIVE or DDSCL_FULLSCREEN ) <> DD_OK ) then
		exit function
	end if
	
	' set the display mode
	if( IDirectDraw7_SetDisplayMode( pDD, SCR_WIDTH, SCR_HEIGHT, SCR_BPP, 0, 0 ) <> DD_OK ) then
		exit function
	end if

	' create the primary surface with 1 back-buffer
	clear ddsd, 0, len( ddsd )
	with ddsd
		.dwSize 			= len( ddsd )
		.dwFlags 			= DDSD_CAPS or DDSD_BACKBUFFERCOUNT
		.ddsCaps.dwCaps 	= DDSCAPS_PRIMARYSURFACE or DDSCAPS_FLIP or DDSCAPS_COMPLEX
		.dwBackBufferCount 	= 1
	end with

	if( IDirectDraw7_CreateSurface( pDD, @ddsd, @pDDSFront, NULL ) <> DD_OK ) then
		exit function
	end if

	'' get a pointer to the back buffer
	clear ddscaps, 0, len( ddscaps )
	ddscaps.dwCaps 			= DDSCAPS_BACKBUFFER

	if( IDirectDrawSurface7_GetAttachedSurface( pDDSFront, @ddscaps, @pDDSBack ) <> DD_OK ) then
		exit function
	end if

	function = TRUE
	
end function

'':::::
sub doRendering	
	static seed as integer = &h12345
	dim dst as SCR_TYPE ptr
	dim noise as integer, carry as integer
	dim x as integer, y as integer
	
	'' lock the back buffer before start drawing on it
	if( IDirectDrawSurface7_Lock( pDDSBack, NULL, @ddsd, DDLOCK_WAIT, NULL ) <> DD_OK ) then
		exit sub
	end if
	
	'' get the pointer to back-buffer
	dst = ddsd.lpSurface
	
   	'' draw some static (code from ptc_test)
   	for y = 0 to SCR_HEIGHT-1
   		for x = 0 to SCR_WIDTH-1
			noise = (seed shr 3) xor seed
       		carry = noise and 1
       		seed = (seed shr 1) or (carry shl 30)
       		noise = (noise shr 1) and &hFF
			*dst = VAL2RGB(noise)
			dst += 1
		next x
		'' advance to next scanline
		cast(byte ptr, dst) += ddsd.lPitch - (SCR_WIDTH * len( SCR_TYPE ))
   	next y
	
	'' unlock it, no more needed
	IDirectDrawSurface7_Unlock( pDDSBack, NULL )

end sub

'':::::
sub CleanUp

    '' free the back-buffer
    if( pDDSBack <> NULL ) then
        IDirectDrawSurface7_Release( pDDSBack )
        pDDSBack = NULL
    end if

    '' and the primary one
    if( pDDSFront <> NULL ) then
        IDirectDrawSurface7_Release( pDDSFront )
        pDDSFront = NULL
    end if

    '' and for last the ddraw interface
    if( pDD <> NULL ) then
        IDirectDraw7_Release( pDD )
        pDD = NULL
    end if

end sub

'':::::
function ProcessIdle as integer
    dim hRet as integer
    
    function = FALSE

	'' buffers were not allocated? exit
	if( (pDDSBack = NULL) or (pDDSFront = NULL) ) then
		exit function
	end if

    '' draw onto back-buffer
    doRendering( )

    '' turn it visible (flip)
    do        
        hRet = IDirectDrawSurface7_Flip( pDDSFront, NULL, 0 )
        
        '' flip done? exit
        if( hRet = DD_OK ) then
        	exit do
        
        '' surface lost? (user switched to desktop??)
        elseif( hRet = DDERR_SURFACELOST ) then        
            IDirectDrawSurface7_Restore( pDDSFront )
        
        '' wait until all current drawing is being done
        elseif( hRet <> DDERR_WASSTILLDRAWING ) then
        	exit do
    	end if
    loop

	function = TRUE

end function

'':::::
function WndProc ( byval hWnd as HWND, _
                   byval uMsg as UINT, _
                   byval wParam as WPARAM, _
                   byval lParam as LPARAM ) as LRESULT

	function = 0
	
	'' process messages
	select case uMsg
	case WM_CREATE
		if( InitDirectDraw( hWnd ) = FALSE ) then
			CleanUp( )
			PostMessage( hWnd, WM_CLOSE, 0, 0 )
		end if

	case WM_DESTROY
		PostQuitMessage( 0 )

	case WM_KEYDOWN
		if( lobyte( wParam ) = 27 ) then
			CleanUp( )
			PostMessage( hWnd, WM_CLOSE, 0, 0 )
		end if

	case else
		function = DefWindowProc( hWnd, uMsg, wParam, lParam )
	end select

end function

'':::::
function WinMain ( byval hInstance as HINSTANCE, _
                   byval hPrevInstance as HINSTANCE, _
                   byref szCmdLine as string, _
                   byval iCmdShow as integer ) as integer    
	
	dim appName as string
	dim wc as WNDCLASS
	dim hWnd as HWND
	dim msg as MSG

	hInst = hInstance

	'' create an window
	appName = "DD test"
	
	with wc
		.style 			= CS_HREDRAW or CS_VREDRAW
   		.lpfnWndProc 	= @WndProc
   		.cbClsExtra 	= 0
   		.cbWndExtra 	= 0
   		.hInstance 		= hInst
   		.hIcon 			= LoadIcon( hInst, IDI_APPLICATION )
   		.hCursor 		= LoadCursor( NULL, IDC_ARROW )
   		.hbrBackground 	= GetStockObject( BLACK_BRUSH )
   		.lpszMenuName 	= NULL
   		.lpszClassName 	= strptr( appName )
   	end with
   	
	if( RegisterClass( @wc ) = 0 ) then
		exit function
	end if

	hWnd = CreateWindowEx( WS_EX_TOPMOST, appName, appName, WS_POPUP, NULL, NULL, _
						   SCR_WIDTH, SCR_HEIGHT, _
						   NULL, NULL, hInst, NULL )

	if( hWnd = null ) then
		exit function
	end if

	'' show it
	ShowWindow( hWnd, iCmdShow )
	UpdateWindow( hWnd )
	SetFocus( hWnd )

	'' check for messages and do the rendering if idle
	do while( hWnd )
		if( PeekMessage( @msg, hWnd, 0, 0, PM_REMOVE ) ) then

			if( msg.message = WM_QUIT ) then
				exit do
			end if

			TranslateMessage( @msg )
			DispatchMessage( @msg )
		
		else
			if( ProcessIdle( ) = FALSE ) then
				exit do
			end if
		end if
	loop

	''
	function = msg.wParam
	
end function

