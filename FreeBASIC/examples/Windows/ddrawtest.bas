''
'' ddrawtest -- shows how to use DirectDraw directly from FB
''
'' code looks hard to read because all the COM interface "hacking" needed, as FB
'' has no OO-support (yet :P)
''				
'' based on C++ DX tutorials found on the Net
''

defint a-z
option explicit
option private

#include once "win\kernel32.bi"
#include once "win\user32.bi"
#include once "win\gdi32.bi"
#include once "win\ddraw.bi"


const SCR_WIDTH 		= 320
const SCR_HEIGHT 		= 240
const SCR_SIZE 			= (SCR_WIDTH * SCR_HEIGHT)
const SCR_BPP 			= 16					'' changing BPP and doRendering has to be updated too

declare function WinMain( byval hInstance as integer, byval hPrevInst as integer, lpszCmdLine AS string, byval lCmdShow as integer ) as integer


'' globals
	dim shared hInst as integer
	
	dim shared pDD as IDirectDraw ptr
	dim shared pDDSFront as IDirectDrawSurface ptr
	dim shared pDDSBack as IDirectDrawSurface ptr
	dim shared ddsd AS DDSURFACEDESC


	end WinMain( GetModuleHandle( null ), null, Command$, SW_NORMAL )



'':::::
function InitDirectDraw( byval hWnd as integer ) as integer	
	dim ddscaps as DDSCAPS

	InitDirectDraw = FALSE	
	
	' create an interface to DDraw
	if( DirectDrawCreate( NULL, @pDD, NULL ) <> DD_OK ) then
       exit function
	end if

	' set the access mode (full screen)
	if( IDirectDraw_SetCooperativeLevel( pDD, hWnd, DDSCL_EXCLUSIVE or DDSCL_FULLSCREEN ) <> DD_OK ) then
		exit function
	end if
	
	' set the display mode
	if( IDirectDraw_SetDisplayMode( pDD, SCR_WIDTH, SCR_HEIGHT, SCR_BPP ) <> DD_OK ) then
		exit function
	end if

	' create the primary surface with 1 back-buffer
	clear ddsd, 0, len( ddsd )
	ddsd.dwSize 			= len( ddsd )
	ddsd.dwFlags 			= DDSD_CAPS or DDSD_BACKBUFFERCOUNT
	ddsd.ddsCaps.dwCaps 	= DDSCAPS_PRIMARYSURFACE or DDSCAPS_FLIP or DDSCAPS_COMPLEX
	ddsd.dwBackBufferCount 	= 1

	if( IDirectDraw_CreateSurface( pDD, @ddsd, @pDDSFront, NULL ) <> DD_OK ) then
		exit function
	end if

	'' get a pointer to the back buffer
	clear ddscaps, 0, len( ddscaps )
	ddscaps.dwCaps 			= DDSCAPS_BACKBUFFER

	if( IDirectDrawSurface_GetAttachedSurface( pDDSFront, @ddscaps, @pDDSBack ) <> DD_OK ) then
		exit function
	end if

	InitDirectDraw = TRUE
	
end function

'':::::
sub doRendering	
	static seed as integer
	dim dst as ushort ptr
	dim noise as integer, carry as integer
	dim x as integer, y as integer
	
	'' lock the back buffer before start drawing on it
	if( IDirectDrawSurface_Lock( pDDSBack, NULL, @ddsd, DDLOCK_WAIT, NULL ) <> DD_OK ) then
		exit function
	end if
	
	if( seed = 0 ) then seed = &h12345
	
	'' get pointer to back-buffer
	dst = ddsd.lpSurface
	
   	'' draw some static (code from ptc_test)
   	for y = 0 to SCR_HEIGHT-1
   		for x = 0 to SCR_WIDTH-1
			noise = (seed shr 3) xor seed
       		carry = noise and 1
       		seed = (seed shr 1) or (carry shl 30)
       		noise = (noise shr 1) and &hFF
			*dst = (noise shl 11) or (noise shl 5) or noise
			dst = dst + len( ushort )
		next x
		dst += ddsd.lPitch - (SCR_WIDTH * len( ushort ))
   	next y
	
	'' unlock it, no more needed
	IDirectDrawSurface_Unlock( pDDSBack, NULL )

end sub

'':::::
sub CleanUp

    '' free the back-buffer
    if( pDDSBack <> NULL ) then
        IDirectDrawSurface_Release( pDDSBack )
        pDDSBack = NULL
    end if

    '' and the primary one
    if( pDDSFront <> NULL ) then
        IDirectDrawSurface_Release( pDDSFront )
        pDDSFront = NULL
    end if

    '' and for last the ddraw interface
    if( pDD <> NULL ) then
        IDirectDraw_Release( pDD )
        pDD = NULL
    end if

end sub

'':::::
function ProcessIdle
    dim hRet as integer
    
    ProcessIdle = FALSE

	'' buffers were not allocated? exit
	if( (pDDSBack = NULL) or (pDDSFront = NULL) ) then
		exit function
	end if

    '' draw onto back-buffer
    doRendering

    '' turn it visible (flip)
    do        
        hRet = IDirectDrawSurface_Flip( pDDSFront, NULL, 0 )
        
        '' flip done? exit
        if( hRet = DD_OK ) then
        	exit do
        
        '' surface lost? (user switched to desktop??)
        elseif( hRet = DDERR_SURFACELOST ) then        
            IDirectDrawSurface_Restore( pDDSFront )
        
        '' wait until all current drawing is being done
        elseif( hRet <> DDERR_WASSTILLDRAWING ) then
        	exit do
    	end if
    loop

	ProcessIdle = TRUE

end function

'':::::
function WndProc(byval hWnd as integer, byval uMsg as integer, byval wParam as integer, byval lParam as integer) as integer

	WndProc = 0
	
	'' process messages
	select case uMsg
	case WM_CREATE
		if( InitDirectDraw( hWnd ) = FALSE ) then
			CleanUp
			PostMessage hWnd, WM_CLOSE, 0, 0
		end if

	case WM_DESTROY
		PostQuitMessage 0

	case WM_KEYDOWN
		if( (wParam and &hff) = 27 ) then
			CleanUp
			PostMessage hWnd, WM_CLOSE, 0, 0
		end if

	case else
		WndProc = DefWindowProc( hWnd, uMsg, wParam, lParam )
	end select

end function

'':::::
function WinMain( byval hInstance as integer, byval hPrevInst as integer, lpszCmdLine AS string, byval lCmdShow as integer ) as integer
	dim szAppName as string
	dim wc as WNDCLASS
	dim hWnd as integer
	dim msg as MSG

	hInst = hInstance

	'' create an window
	szAppName = "DD test"
	
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
   		.lpszClassName 	= strptr( szAppName )
   	end with
   	
	if( RegisterClass( wc ) = 0 ) then
		exit function
	end if

	hWnd = CreateWindowEx( WS_EX_TOPMOST, szAppName, szAppName, WS_POPUP, NULL, NULL, SCR_WIDTH, SCR_HEIGHT, _
						   NULL, NULL, hInst, NULL )

	if( hWnd = null ) then
		exit function
	end if

	'' show it
	ShowWindow hWnd, lCmdShow
	UpdateWindow hWnd
	SetFocus hWnd

	'' check for messages and do the rendering if idle
	do while( hWnd )
		if( PeekMessage( msg, hWnd, 0, 0, PM_REMOVE ) ) then

			if( msg.message = WM_QUIT ) then
				exit do
			end if

			TranslateMessage msg
			DispatchMessage msg
		
		else
			if( ProcessIdle = FALSE ) then
				exit do
			end if
		end if
	loop

	''
	WinMain = msg.wParam
	
end function

