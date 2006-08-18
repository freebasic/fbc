''
'' CClientSite - a "class" that implements the IOleClientSite interface
'' 



#include once "Common.bi"
#include once "crt/string.bi"

''::::
private function CClientSite_QueryInterface _
	( _
		byval _this as IOleClientSite ptr, _
		byval riid as REFIID, _
		byval ppvObj as PVOID ptr _
	) as HRESULT
														
	dim as CClientSite ptr self_ = cast( CClientSite ptr, _this )
	
	LOG_FUNC()
	
	if( (memcmp( riid, @IID_IUnknown, len( GUID ) ) = 0) or _
		(memcmp( riid, @IID_IOleClientSite, len( GUID ) ) = 0) ) then
		*ppvObj = @self_->interface
		return S_OK
	end if
		
	function = self_->site.interface.lpVtbl->QueryInterface( @self_->site.interface, riid, ppvObj )
	
end function

''::::
private function CClientSite_AddRef _
	( _
		byval _this as IOleClientSite ptr _
	) as ULONG

	LOG_FUNC()
	
	function = 1

end function

''::::
private function CClientSite_Release _
	( _
		byval _this as IOleClientSite ptr _
	) as ULONG

	LOG_FUNC()
	
	function = 1

end function

''::::
private function CClientSite_SaveObject _
	( _
		byval _this as IOleClientSite ptr _
	) as HRESULT

	LOG_FUNC()
	
	function = S_OK
	
end function

''::::
private function CClientSite_GetMoniker _
	( _
		byval _this as IOleClientSite ptr, _
		byval dwAssign as DWORD, _
		byval dwWhichMoniker as DWORD, _
		byval ppmk as IMoniker ptr ptr _
	) as HRESULT

	LOG_FUNC()
	
	function = E_NOTIMPL

end function

''::::
private function CClientSite_GetContainer _
	( _
		byval _this as IOleClientSite ptr, _
		byval ppContainer as LPOLECONTAINER ptr _
	) as HRESULT
	
	LOG_FUNC()
	
	*ppContainer = NULL

	function = E_NOINTERFACE

end function

''::::
private function CClientSite_ShowObject _
	( _
		byval _this as IOleClientSite ptr _
	) as HRESULT

	dim as CClientSite ptr self_ = cast( CClientSite ptr, _this )

	LOG_FUNC()

	if( self_->viewobj <> NULL ) then
		dim as HWND hwnd = CInPlaceSite_GetHwnd( @self_->site )
		dim as HDC hdc = getDC( hwnd )
		dim as RECT rect
		GetClientRect( hwnd, @rect )
		
		self_->viewobj->lpVtbl->Draw( self_->viewobj, _
									  DVASPECT_CONTENT, _
									  -1, _
									  NULL, _
									  NULL, _
									  NULL, _
									  hdc, _
									  cast( RECTL ptr, @rect ), _
									  cast( RECTL ptr, @rect ), _
									  NULL, _
									  NULL )
	end if
	
	function = NOERROR

end function

''::::
private function CClientSite_OnShowWindow _
	( _
		byval _this as IOleClientSite ptr, _
		byval fShow as BOOL _
	) as HRESULT

	LOG_FUNC()
	
	function = E_NOTIMPL

end function

''::::
private function CClientSite_RequestNewObjectLayout _
	( _
		byval _this as IOleClientSite ptr _
	) as HRESULT

	LOG_FUNC()
	
	function = E_NOTIMPL

end function

'' constructor
function CClientSite_New _
	( _
		byval _this as CClientSite ptr, _
		byval hwnd as HWND _
	) as CClientSite ptr

	static as IOleClientSiteVtbl vtbl = _
		( _
			@CClientSite_QueryInterface, _
			@CClientSite_AddRef, _
			@CClientSite_Release, _
			@CClientSite_SaveObject, _
			@CClientSite_GetMoniker, _
			@CClientSite_GetContainer, _
			@CClientSite_ShowObject, _
			@CClientSite_OnShowWindow, _
			@CClientSite_RequestNewObjectLayout _
		)

	if( _this = NULL ) then
		_this = cast( CClientSite ptr, allocate( len( CClientSite ) ) )
		if( _this = NULL )then
			return NULL
		end if
	end if

	_this->interface.lpVtbl = @vtbl

	CInPlaceSite_New( @_this->site, hwnd )
	_this->viewobj = NULL	
	
	function = _this

end function

'' destructor
sub CClientSite_Delete _
	( _
		byval _this as CClientSite ptr, _
		byval isstatic as integer _
	)

	if( _this->viewobj <> NULL ) then
		_this->viewobj->lpVtbl->Release( _this->viewobj )
		_this->viewobj = NULL
	end if
	
	CInPlaceSite_Delete( @_this->site, TRUE )
	
	if( isstatic = FALSE ) then
		if( _this <> NULL ) then
			deallocate( _this )
		end if
	end if

end sub

''::::
function CClientSite_SetObject _
	( _
		byval _this as CClientSite ptr, _
		byval obj as IOleObject ptr _
	) as BOOL

	function = FALSE

	CInPlaceSite_SetObject( @_this->site, obj )

	if( obj->lpVtbl->SetClientSite( obj, @_this->interface ) <> S_OK ) then
		exit function
	end if
	
	if( OleSetContainedObject( cast( IUnknown ptr, obj ), TRUE ) <> S_OK ) then
		exit function
	end if

	if( obj->lpVtbl->QueryInterface( obj, @IID_IViewObject, @_this->viewobj ) <> S_OK ) then	
		_this->viewobj = NULL
	end if

	function = TRUE
	
end function
