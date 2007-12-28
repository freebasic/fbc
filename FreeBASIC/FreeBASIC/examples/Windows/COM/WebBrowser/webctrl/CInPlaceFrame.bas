''
'' CInPlaceFrame - a "class" that implements the IOleInPlaceFrame interface
'' 



#include once "Common.bi"
#include "crt/string.bi"

''::::
private function CInPlaceFrame_QueryInterface _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval riid as REFIID, _
		byval ppvObj as PVOID ptr _
	) as HRESULT

	dim as CInPlaceFrame ptr self_ = cast( CInPlaceFrame ptr, _this )
	
	LOG_FUNC()
	
	if( memcmp( riid, @IID_IOleInPlaceFrame, len( GUID ) ) = 0 ) then
		*ppvObj = @self_->interface
		return S_OK
	end if

	*ppvObj = NULL
	function = E_NOINTERFACE
	
end function

''::::
private function CInPlaceFrame_AddRef _
	( _
		byval _this as IOleInPlaceFrame ptr _
	) as ULONG
	
	LOG_FUNC()

	function = 1
	
end function

''::::
private function CInPlaceFrame_Release _
	( _
		byval _this as IOleInPlaceFrame ptr _
	) as ULONG
	
	LOG_FUNC()

	function = 1
	
end function

''::::
private function CInPlaceFrame_GetWindow _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval lphwnd as HWND ptr _
	) as HRESULT
	
	LOG_FUNC()

	*lphwnd = cast( CInPlaceFrame ptr, _this )->hwnd
	
	function = S_OK

end function

''::::
private function CInPlaceFrame_ContextSensitiveHelp _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval fEnterMode as BOOL _
	) as HRESULT
	
	LOG_FUNC()

	function = E_NOTIMPL

end function

''::::
private function CInPlaceFrame_GetBorder _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval lprectBorder as LPRECT _
	) as HRESULT
	
	LOG_FUNC()

	function = E_NOTIMPL

end function

''::::
private function CInPlaceFrame_RequestBorderSpace _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval pborderwidths as LPCBORDERWIDTHS _
	) as HRESULT
	
	LOG_FUNC()

	function = E_NOTIMPL

end function

''::::
private function CInPlaceFrame_SetBorderSpace _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval pborderwidths as LPCBORDERWIDTHS _
	) as HRESULT
	
	LOG_FUNC()

	function = E_NOTIMPL

end function

''::::
private function CInPlaceFrame_SetActiveObject _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval pActiveObject as IOleInPlaceActiveObject ptr, _
		byval pszObjName as LPCOLESTR _
	) as HRESULT
	
	LOG_FUNC()

	function = S_OK

end function

''::::
private function CInPlaceFrame_InsertMenus _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval hmenuShared as HMENU, _
		byval lpMenuWidths as LPOLEMENUGROUPWIDTHS _
	) as HRESULT
	
	LOG_FUNC()

	function = E_NOTIMPL

end function

''::::
private function CInPlaceFrame_SetMenu _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval hmenuShared as HMENU, _
		byval holemenu as HOLEMENU, _
		byval hwndActiveObject as HWND _
	) as HRESULT
	
	LOG_FUNC()

	function = S_OK

end function

''::::
private function CInPlaceFrame_RemoveMenus _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval hmenuShared as HMENU _
	) as HRESULT
	
	LOG_FUNC()

	function = E_NOTIMPL

end function

''::::
private function CInPlaceFrame_SetStatusText _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval pszStatusText as LPCOLESTR _
	) as HRESULT
	
	LOG_FUNC()

	function = S_OK

end function

''::::
private function CInPlaceFrame_EnableModeless _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval fEnable as BOOL _
	) as HRESULT
	
	LOG_FUNC()

	function = S_OK

end function

''::::
private function CInPlaceFrame_TranslateAccelerator _
	( _
		byval _this as IOleInPlaceFrame ptr, _
		byval lpmsg as LPMSG, _
		byval wID as WORD _
	) as HRESULT
	
	LOG_FUNC()

	function = E_NOTIMPL

end function

'' constructor
function CInPlaceFrame_New _
	( _
		byval _this as CInPlaceFrame ptr, _
		byval hwnd as HWND _
	) as CInPlaceFrame ptr

	static as IOleInPlaceFrameVtbl vtbl = _
		( _
			@CInPlaceFrame_QueryInterface, _
			@CInPlaceFrame_AddRef, _
			@CInPlaceFrame_Release, _
			@CInPlaceFrame_GetWindow, _
			@CInPlaceFrame_ContextSensitiveHelp, _
			@CInPlaceFrame_GetBorder, _
			@CInPlaceFrame_RequestBorderSpace, _
			@CInPlaceFrame_SetBorderSpace, _
			@CInPlaceFrame_SetActiveObject, _
			@CInPlaceFrame_InsertMenus, _
			@CInPlaceFrame_SetMenu, _
			@CInPlaceFrame_RemoveMenus, _
			@CInPlaceFrame_SetStatusText, _
			@CInPlaceFrame_EnableModeless, _
			@CInPlaceFrame_TranslateAccelerator _
		)

	if( _this = NULL ) then
		_this = cast( CInPlaceFrame ptr, allocate( len( CInPlaceFrame ) ) )
		if( _this = NULL )then
			return NULL
		end if
	end if

	_this->interface.lpVtbl = @vtbl
	
	_this->hwnd = hwnd

	function = _this

end function

'' destructor
sub CInPlaceFrame_Delete _
	( _
		byval _this as CInPlaceFrame ptr, _
		byval isstatic as integer _
	)

	if( isstatic = FALSE ) then
		if( _this <> NULL ) then
			deallocate( _this )
		end if
	end if

end sub
