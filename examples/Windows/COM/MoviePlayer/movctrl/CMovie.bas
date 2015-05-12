''
'' CMovie - the movie "class"
''

#include once "win/dshow.bi"
#include once "CMovie.bi"

type CMovieCtx
	as HWND 				hwnd
    as IGraphBuilder ptr	graph
    as IMediaControl ptr 	medctrl
    as IMediaEvent ptr 		medevent
    as IMediaSeeking ptr 	medseek
    as IVideoWindow ptr 	vidwindow
    as IBasicVideo ptr 		basvideo
end type

'' 
constructor CMovie _
	( _
		byval hwnd as HWND _
	)
	
	dim as integer isstatic
	dim as HRESULT hr

	ctx = new CMovieCtx

	ctx->hwnd = hwnd
	
	hr = CoCreateInstance( @CLSID_FilterGraph, NULL, CLSCTX_INPROC_SERVER, _
                      	   @IID_IGraphBuilder, cast( PVOID ptr, @ctx->graph ) )	
                      	   
	if( FAILED( hr ) ) then
		return
	end if

    hr = IGraphBuilder_QueryInterface( ctx->graph, @IID_IMediaControl, cast( PVOID ptr, @ctx->medctrl ) )
    if( SUCCEEDED( hr ) ) then
    	hr = IGraphBuilder_QueryInterface( ctx->graph, @IID_IMediaEvent, cast( PVOID ptr, @ctx->medevent ) )
    	if( SUCCEEDED( hr ) ) then
    		hr = IGraphBuilder_QueryInterface( ctx->graph, @IID_IMediaSeeking, cast( PVOID ptr, @ctx->medseek ) )
    		if( SUCCEEDED( hr ) ) then
    			hr = IGraphBuilder_QueryInterface( ctx->graph, @IID_IVideoWindow, cast( PVOID ptr, @ctx->vidwindow ) )
    			if( SUCCEEDED( hr ) ) then
    				hr = IGraphBuilder_QueryInterface( ctx->graph, @IID_IBasicVideo, cast( PVOID ptr, @ctx->basvideo ) )
    			end if
    		end if
    	end if
    end if
	
	if( FAILED( hr ) ) then
		return
	end if
	
end constructor

'' 
destructor CMovie _
	( _
		_
	)

	remove( )

	if( ctx->graph <> NULL ) then
	    if( ctx->basvideo <> NULL ) then
	    	IBasicVideo_Release( ctx->basvideo )
	    	ctx->basvideo = NULL
		end if
	
		if( ctx->vidwindow <> NULL ) then
			IVideoWindow_Release( ctx->vidwindow )
			ctx->vidwindow = NULL
		end if
		
		if( ctx->medseek <> NULL ) then
			IMediaSeeking_Release( ctx->medseek )
			ctx->medseek = NULL
		end if
		
		if( ctx->medevent <> NULL ) then
			IMediaEvent_Release( ctx->medevent )
			ctx->medevent = NULL
		end if
		
		if( ctx->medctrl <> NULL ) then
			IMediaControl_Release( ctx->medctrl )
			ctx->medctrl = NULL
		end if
	
    	IGraphBuilder_Release( ctx->graph )
		ctx->graph = NULL
	end if
    
	delete ctx

end destructor

''::::
function CMovie.insert _
	( _
		_
	) as BOOL

	function = TRUE

end function

''::::
function CMovie.remove _
	( _
		_
	) as BOOL

	function = TRUE

end function

''::::
function CMovie.resize _
	( _
		byval width_ as DWORD, _
		byval height as DWORD _
	) as BOOL

	dim as HRESULT hr
	
	function = FALSE

	if( ctx->graph = NULL ) then
		exit function
	end if
	
	hr = IVideoWindow_put_Width( ctx->vidwindow, width_ )
	if( SUCCEEDED( hr ) ) then
		hr = IVideoWindow_put_Height( ctx->vidwindow, height )
	end if
	
	function = SUCCEEDED( hr )

end function

''::::
private function hSetOwner _
	( _
		byval hwnd as HWND, _
		byval vidwindow as IVideoWindow ptr _
	) as BOOL

    function = FALSE
    
    IVideoWindow_put_Owner( vidwindow, cast( OAHWND, hwnd ) )
    IVideoWindow_put_WindowStyle( vidwindow, WS_CHILD or WS_CLIPSIBLINGS or WS_CLIPCHILDREN )
    'IVideoWindow_put_MessageDrain( vidwindow, cast( OAHWND, hwnd ) )
    'IVideoWindow_put_AutoShow( vidwindow, OAFALSE )

    dim as RECT rc
    GetWindowRect( hwnd, @rc )
    IVideoWindow_SetWindowPosition( vidwindow, 0, 0, rc.right - rc.left, rc.bottom - rc.top )
		
	function = TRUE

end function

''::::
function CMovie.load _
	( _
		byval filename as wstring ptr _
	) as BOOL

	dim as HRESULT hr

	function = FALSE
	
	if( ctx->graph = NULL ) then
		exit function
	end if
	
    hr = IGraphBuilder_RenderFile( ctx->graph, filename, NULL )
    
    hSetOwner( ctx->hwnd, ctx->vidwindow )
    
    function = SUCCEEDED( hr )

end function

''::::
function CMovie.play _
	( _
		_
	) as BOOL

	dim as HRESULT hr

	function = FALSE
	
	if( ctx->graph = NULL ) then
		exit function
	end if
	
    hr = IMediaControl_Run( ctx->medctrl )
    
    function = SUCCEEDED( hr )

end function

''::::
function CMovie.pause _
	( _
		_
	) as BOOL
	
	dim as HRESULT hr

	function = FALSE
	
	if( ctx->graph = NULL ) then
		exit function
	end if
	
    hr = IMediaControl_Pause( ctx->medctrl )
    
    function = SUCCEEDED( hr )
	
end function

''::::
function CMovie.stop _
	( _
		_
	) as BOOL
	
	dim as HRESULT hr

	function = FALSE
	
	if( ctx->graph = NULL ) then
		exit function
	end if
	
    hr = IMediaControl_Stop( ctx->medctrl )
    if( FAILED( hr ) ) then
    	exit function
    end if

	dim as OAFilterState fs
    hr = IMediaControl_GetState( ctx->medctrl, 100, @fs )
    if( FAILED( hr ) ) then
    	exit function
    end if

    hr = IMediaControl_StopWhenReady( ctx->medctrl )
    
    function = SUCCEEDED( hr )
	
end function

