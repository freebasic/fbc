''
'' CInPlaceSite - a "class" that implements the IOleInPlaceSite interface
'' 



#include "Common.bi"
#include "crt/string.bi"

''::::
private function CInPlaceSite_QueryInterface _
	( _
		byval _this as IOleInPlaceSite ptr, _
		byval riid as REFIID, _
		byval ppvObj as PVOID ptr _
	) as HRESULT

	dim as CInPlaceSite ptr self_ = cast( CInPlaceSite ptr, _this )

	LOG_FUNC()
	
	if( memcmp( riid, @IID_IOleInPlaceSite, len( GUID ) ) = 0 ) then
		*ppvObj = @self_->interface
		return S_OK
	end if
	
	function = self_->frame.interface.lpVtbl->QueryInterface( @self_->frame.interface, riid, ppvObj )

end function

''::::
private function CInPlaceSite_AddRef _
	( _
		byval _this as IOleInPlaceSite ptr _
	) as ULONG

	LOG_FUNC()
	
	function = 1
	
end function

''::::
private function CInPlaceSite_Release _
	( _
		byval _this as IOleInPlaceSite ptr _
	) as ULONG

	LOG_FUNC()
	
	function = 1
	
end function

''::::
private function CInPlaceSite_GetWindow _
	( _
		byval _this as IOleInPlaceSite ptr, _
		byval lphwnd as HWND ptr _
	) as HRESULT

	LOG_FUNC()
	
	*lphwnd = cast( CInPlaceSite ptr, _this )->frame.hwnd

	function = S_OK
	
end function

''::::
private function CInPlaceSite_ContextSensitiveHelp _
	( _
		byval _this as IOleInPlaceSite ptr, _
		byval fEnterMode as BOOL _
	) as HRESULT

	LOG_FUNC()
	
	function = E_NOTIMPL
	
end function

''::::
private function CInPlaceSite_CanInPlaceActivate _
	( _
		byval _this as IOleInPlaceSite ptr _
	) as HRESULT

	LOG_FUNC()
	
	function = S_OK
	
end function

''::::
private function CInPlaceSite_OnInPlaceActivate _
	( _
		byval _this as IOleInPlaceSite ptr _
	) as HRESULT

	dim as CInPlaceSite ptr self_ = cast( CInPlaceSite ptr, _this )
	
	LOG_FUNC()
	
	self_->oleobj->lpVtbl->QueryInterface( self_->oleobj, _
										   @IID_IOleInPlaceObject, _
										   cast( PVOID ptr, @self_->inplaceobj ) )
	
	function = S_OK
	
end function

''::::
private function CInPlaceSite_OnUIActivate _
	( _
		byval _this as IOleInPlaceSite ptr _
	) as HRESULT

	LOG_FUNC()
	
	function = S_OK
	
end function

''::::
private function CInPlaceSite_GetWindowContext _
	( _
		byval _this as IOleInPlaceSite ptr, _
		byval lplpFrame as LPOLEINPLACEFRAME ptr, _
		byval lplpDoc as LPOLEINPLACEUIWINDOW ptr, _
		byval lprcPosRect as LPRECT, _
		byval lprcClipRect as LPRECT, _
		byval lpFrameInfo as LPOLEINPLACEFRAMEINFO _
	) as HRESULT

	dim as CInPlaceSite ptr self_ = cast( CInPlaceSite ptr, _this )
	
	LOG_FUNC()
	
	*lplpFrame = cast( LPOLEINPLACEFRAME, @self_->frame.interface )

	*lplpDoc = NULL
	
	dim as RECT rect
	GetClientRect( self_->frame.hwnd, @rect )
	*lprcPosRect = rect
	*lprcClipRect = rect

	lpFrameInfo->cb = len( OLEINPLACEFRAMEINFO )
	lpFrameInfo->fMDIApp = FALSE
	lpFrameInfo->hwndFrame = self_->frame.hwnd
	lpFrameInfo->haccel = NULL
	lpFrameInfo->cAccelEntries = 0
			
	function = S_OK
	
end function

''::::
private function CInPlaceSite_Scroll _
	( _
		byval _this as IOleInPlaceSite ptr, _
		byval scrollExtent as SIZE _
	) as HRESULT

	LOG_FUNC()
	
	function = E_NOTIMPL
	
end function

''::::
private function CInPlaceSite_OnUIDeactivate _
	( _
		byval _this as IOleInPlaceSite ptr, _
		byval fUndoable as BOOL _
	) as HRESULT

	LOG_FUNC()
	
	function = S_OK
	
end function

''::::
private function CInPlaceSite_OnInPlaceDeactivate _
	( _
		byval _this as IOleInPlaceSite ptr _
	) as HRESULT

	dim as CInPlaceSite ptr self_ = cast( CInPlaceSite ptr, _this )
	
	LOG_FUNC()
	
	self_->inplaceobj->lpVtbl->Release( self_->inplaceobj )
	self_->inplaceobj = NULL
	
	function = S_OK
	
end function

''::::
private function CInPlaceSite_DiscardUndoState _
	( _
		byval _this as IOleInPlaceSite ptr _
	) as HRESULT

	LOG_FUNC()
	
	function = E_NOTIMPL
	
end function

''::::
private function CInPlaceSite_DeactivateAndUndo _
	( _
		byval _this as IOleInPlaceSite ptr _
	) as HRESULT

	LOG_FUNC()
	
	function = E_NOTIMPL
	
end function

''::::
private function CInPlaceSite_OnPosRectChange _
	( _
		byval _this as IOleInPlaceSite ptr, _
		byval lprcPosRect as LPCRECT _
	) as HRESULT

#if 0
	dim as CInPlaceSite ptr self_ = cast( CInPlaceSite ptr, _this )

	LOG_FUNC()
	
	self_->inplaceobj->lpVtbl->SetObjectRects( self_->inplaceobj, lprcPosRect, lprcPosRect )

	function = S_OK

#else
	function = E_NOTIMPL
#endif
	
end function

'' constructor
function CInPlaceSite_New _
	( _
		byval _this as CInPlaceSite ptr, _
		byval hwnd as HWND _
	) as CInPlaceSite ptr

	static as IOleInPlaceSiteVtbl vtbl = _
		 ( _
			@CInPlaceSite_QueryInterface, _
			@CInPlaceSite_AddRef, _
			@CInPlaceSite_Release, _
			@CInPlaceSite_GetWindow, _
			@CInPlaceSite_ContextSensitiveHelp, _
			@CInPlaceSite_CanInPlaceActivate, _
			@CInPlaceSite_OnInPlaceActivate, _
			@CInPlaceSite_OnUIActivate, _
			@CInPlaceSite_GetWindowContext, _
			@CInPlaceSite_Scroll, _
			@CInPlaceSite_OnUIDeactivate, _
			@CInPlaceSite_OnInPlaceDeactivate, _
			@CInPlaceSite_DiscardUndoState, _
			@CInPlaceSite_DeactivateAndUndo, _
			@CInPlaceSite_OnPosRectChange _
		)
	
	if( _this = NULL ) then
		_this = cast( CInPlaceSite ptr, allocate( len( CInPlaceSite ) ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

	_this->interface.lpVtbl = @vtbl

	CInPlaceFrame_New( @_this->frame, hwnd )
	_this->inplaceobj = NULL
	
	function = _this

end function

'' destructor
sub CInPlaceSite_Delete _
	( _
		byval _this as CInPlaceSite ptr, _
		byval isstatic as integer _
	)

	if( _this->inplaceobj <> NULL ) then
		_this->inplaceobj->lpVtbl->Release( _this->inplaceobj )
		_this->inplaceobj = NULL
	end if

	CInPlaceFrame_Delete( @_this->frame, TRUE )
	
	if( isstatic = FALSE ) then
		if( _this <> NULL ) then
			deallocate( _this )
		end if
	end if

end sub

''::::
sub CInPlaceSite_SetObject _
	( _
		byval _this as CInPlaceSite ptr, _
		byval obj as IOleObject ptr _
	)

	_this->oleobj = obj

end sub

''::::
function CInPlaceSite_GetHwnd _
	( _
		byval _this as CInPlaceSite ptr _
	) as HWND

	function = _this->frame.hwnd

end function
