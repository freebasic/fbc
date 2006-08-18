''
'' CMovie - the movie "class"
''



#include once "win/dshow.bi"
#include once "CMovie.bi"

type CMovie_
	as HWND 				hwnd
    as IGraphBuilder ptr	graph
    as IMediaControl ptr 	medctrl
    as IMediaEvent ptr 		medevent
    as IMediaSeeking ptr 	medseek
    as IVideoWindow ptr 	vidwindow
    as IBasicVideo ptr 		basvideo
end type


'' constructor
function CMovie_New _
	( _
		byval _this as CMovie ptr, _
		byval hwnd as HWND _
	) as CMovie ptr
	
	dim as integer isstatic
	dim as HRESULT hr

	isstatic = (_this <> NULL)
	if( isstatic = FALSE ) then
		_this = cast( CMovie ptr, callocate( len( CMovie ) ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

	_this->hwnd = hwnd
	
	hr = CoCreateInstance( @CLSID_FilterGraph, NULL, CLSCTX_INPROC_SERVER, _
                      	   @IID_IGraphBuilder, cast( PVOID ptr, @_this->graph ) )	
                      	   
	if( FAILED( hr ) ) then
		CMovie_Delete( _this, isstatic )
		return NULL
	end if

    hr = IGraphBuilder_QueryInterface( _this->graph, @IID_IMediaControl, cast( PVOID ptr, @_this->medctrl ) )
    if( SUCCEEDED( hr ) ) then
    	hr = IGraphBuilder_QueryInterface( _this->graph, @IID_IMediaEvent, cast( PVOID ptr, @_this->medevent ) )
    	if( SUCCEEDED( hr ) ) then
    		hr = IGraphBuilder_QueryInterface( _this->graph, @IID_IMediaSeeking, cast( PVOID ptr, @_this->medseek ) )
    		if( SUCCEEDED( hr ) ) then
    			hr = IGraphBuilder_QueryInterface( _this->graph, @IID_IVideoWindow, cast( PVOID ptr, @_this->vidwindow ) )
    			if( SUCCEEDED( hr ) ) then
    				hr = IGraphBuilder_QueryInterface( _this->graph, @IID_IBasicVideo, cast( PVOID ptr, @_this->basvideo ) )
    			end if
    		end if
    	end if
    end if
	
	if( FAILED( hr ) ) then
		CMovie_Delete( _this, isstatic )
		return NULL
	end if
	
	function = _this

end function

'' destructor
sub CMovie_Delete _
	( _
		byval _this as CMovie ptr, _
		byval isstatic as integer _
	)

	CMovie_Remove( _this )

	if( _this->graph <> NULL ) then
	    if( _this->basvideo <> NULL ) then
	    	IBasicVideo_Release( _this->basvideo )
	    	_this->basvideo = NULL
		end if
	
		if( _this->vidwindow <> NULL ) then
			IVideoWindow_Release( _this->vidwindow )
			_this->vidwindow = NULL
		end if
		
		if( _this->medseek <> NULL ) then
			IMediaSeeking_Release( _this->medseek )
			_this->medseek = NULL
		end if
		
		if( _this->medevent <> NULL ) then
			IMediaEvent_Release( _this->medevent )
			_this->medevent = NULL
		end if
		
		if( _this->medctrl <> NULL ) then
			IMediaControl_Release( _this->medctrl )
			_this->medctrl = NULL
		end if
	
    	IGraphBuilder_Release( _this->graph )
		_this->graph = NULL
	end if
    
	if( isstatic = FALSE ) then
		if( _this <> NULL ) then
			deallocate( _this )
		end if
	end if

end sub

''::::
function CMovie_Insert _
	( _
		byval _this as CMovie ptr _
	) as BOOL

	function = TRUE

end function

''::::
function CMovie_Remove _
	( _
		byval _this as CMovie ptr _
	) as BOOL

	function = TRUE

end function

''::::
function CMovie_Resize _
	( _
		byval _this as CMovie ptr, _
		byval width_ as DWORD, _
		byval height as DWORD _
	) as BOOL

	dim as HRESULT hr
	
	function = FALSE

	if( _this->graph = NULL ) then
		exit function
	end if
	
	hr = IVideoWindow_put_Width( _this->vidwindow, width_ )
	if( SUCCEEDED( hr ) ) then
		hr = IVideoWindow_put_Height( _this->vidwindow, height )
	end if
	
	function = SUCCEEDED( hr )

end function

''::::
private function hSetOwner _
	( _
		byval _this as CMovie ptr _
	) as BOOL

    function = FALSE
    
    IVideoWindow_put_Owner( _this->vidwindow, cast( OAHWND, _this->hwnd ) )
    IVideoWindow_put_WindowStyle( _this->vidwindow, WS_CHILD or WS_CLIPSIBLINGS or WS_CLIPCHILDREN )
    'IVideoWindow_put_MessageDrain( _this->vidwindow, cast( OAHWND, _this->hwnd ) )
    'IVideoWindow_put_AutoShow( _this->vidwindow, OAFALSE )

    dim as RECT rc
    GetWindowRect( _this->hwnd, @rc )
    IVideoWindow_SetWindowPosition( _this->vidwindow, 0, 0, rc.right - rc.left, rc.bottom - rc.top )
		
	function = TRUE

end function

''::::
function CMovie_Load _
	( _
		byval _this as CMovie ptr, _
		byval filename as wstring ptr _
	) as BOOL

	dim as HRESULT hr

	function = FALSE
	
	if( _this->graph = NULL ) then
		exit function
	end if
	
    hr = IGraphBuilder_RenderFile( _this->graph, filename, NULL )
    
    hSetOwner( _this )
    
    function = SUCCEEDED( hr )

end function

''::::
function CMovie_Play _
	( _
		byval _this as CMovie ptr _
	) as BOOL

	dim as HRESULT hr

	function = FALSE
	
	if( _this->graph = NULL ) then
		exit function
	end if
	
    hr = IMediaControl_Run( _this->medctrl )
    
    function = SUCCEEDED( hr )

end function

''::::
function CMovie_Pause _
	( _
		byval _this as CMovie ptr _
	) as BOOL
	
	dim as HRESULT hr

	function = FALSE
	
	if( _this->graph = NULL ) then
		exit function
	end if
	
    hr = IMediaControl_Pause( _this->medctrl )
    
    function = SUCCEEDED( hr )
	
end function

''::::
function CMovie_Stop _
	( _
		byval _this as CMovie ptr _
	) as BOOL
	
	dim as HRESULT hr

	function = FALSE
	
	if( _this->graph = NULL ) then
		exit function
	end if
	
    hr = IMediaControl_Stop( _this->medctrl )
    if( FAILED( hr ) ) then
    	exit function
    end if

	dim as OAFilterState fs
    hr = IMediaControl_GetState( _this->medctrl, 100, @fs )
    if( FAILED( hr ) ) then
    	exit function
    end if

    hr = IMediaControl_StopWhenReady( _this->medctrl )
    
    function = SUCCEEDED( hr )
	
end function

