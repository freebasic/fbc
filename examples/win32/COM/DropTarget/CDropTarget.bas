''
'' IDropTarget example for text objects, translated from a C++ code written by J Brown 2004 (www.catch22.net)
''

#include once "CDropTarget.bi"
#include once "crt/string.bi"

''
'' Constructor for the CDropTarget class
''
constructor CDropTarget(hwnd as HWND)
	'' IDropTarget implementation (while there's no support for virtual methods and inheritance)
	static as IDropTargetVtbl vtbl = _
	( _
		@CDropTarget.QueryInterface, _
		@CDropTarget.AddRef, _
		@CDropTarget.Release, _'
		@CDropTarget.DragEnter, _
		@CDropTarget.DragOver, _
		@CDropTarget.DragLeave, _
		@CDropTarget.Drop _
	)

	m_DropTarget.lpVtbl = @vtbl

	m_lRefCount  = 1
	m_hWnd = hwnd
	m_fAllowDrop = false

	'' acquire a strong lock
	CoLockObjectExternal(cast(LPUNKNOWN, @this), TRUE, FALSE)

	'' tell OLE that the window is a drop target
	RegisterDragDrop(m_hWnd, cast(LPDROPTARGET, @this))
	
end constructor

''
'' Destructor for the CDropTarget class
''
destructor CDropTarget()

	'' remove drag+drop
	RevokeDragDrop(m_hWnd)

	'' remove the strong lock
	CoLockObjectExternal(cast(LPUNKNOWN, @this), FALSE, TRUE)

	'' release our own reference
	m_DropTarget.lpVtbl->Release(@m_DropTarget)
	
end destructor


''
''	IUnknown::QueryInterface
''
private function CDropTarget.QueryInterface _
	(pInst as IDropTarget ptr, _ 
	 iid as REFIID, ppvObject as any ptr ptr) as HRESULT
	 
	dim as CDropTarget ptr _this = cast(CDropTarget ptr, pInst)
	
	if( (memcmp( iid, @IID_IUnknown, len( GUID ) ) = 0) or _
		(memcmp( iid, @IID_IDropTarget, len( GUID ) ) = 0) ) then
		CDropTarget.AddRef( pInst )
		*ppvObject = pInst
		return S_OK
	else
		*ppvObject = NULL
		return E_NOINTERFACE
	end if
	
end function

''
''	IUnknown::AddRef
''
private function CDropTarget.AddRef _
	(pInst as IDropTarget ptr) as ULONG
	
	dim as CDropTarget ptr _this = cast(CDropTarget ptr, pInst)
	
	return InterlockedIncrement(@_this->m_lRefCount)
end function

''
''	IUnknown::Release
''
private function CDropTarget.Release _
	(pInst as IDropTarget ptr) as ULONG
	
	dim as CDropTarget ptr _this = cast(CDropTarget ptr, pInst)
	
	dim as LONG count = InterlockedDecrement(@_this->m_lRefCount)
		
	if(count = 0) then
		return 0
	else
		return count
	end if
end function

''
''	IDropTarget::DragEnter
''
private function CDropTarget.DragEnter _
	(pInst as IDropTarget ptr, _ 
	 pDataObject as IDataObject ptr, grfKeyState as DWORD, _
	 pt as POINTL, pdwEffect as DWORD ptr) as HRESULT
	
	dim as CDropTarget ptr _this = cast(CDropTarget ptr, pInst)
	
	'' does the dataobject contain data we want?
	_this->m_fAllowDrop = _this->QueryDataObject(pDataObject)
	
	if(_this->m_fAllowDrop) then
		'' get the dropeffect based on keyboard state
		*pdwEffect = _this->DropEffect(grfKeyState, pt, *pdwEffect)

		SetFocus(_this->m_hWnd)

		_this->PositionCursor(pt)
	else
		*pdwEffect = DROPEFFECT_NONE
	end if

	return S_OK
end function

''
''	IDropTarget::DragOver
''
private function CDropTarget.DragOver _
	(pInst as IDropTarget ptr, _ 
	 grfKeyState as DWORD, pt as POINTL, pdwEffect as DWORD ptr) as HRESULT

	dim as CDropTarget ptr _this = cast(CDropTarget ptr, pInst)
	
	if(_this->m_fAllowDrop) then
		*pdwEffect = _this->DropEffect(grfKeyState, pt, *pdwEffect)
		_this->PositionCursor(pt)
	else
		*pdwEffect = DROPEFFECT_NONE
	end if

	return S_OK
end function

''
''	IDropTarget::DragLeave
''
private function CDropTarget.DragLeave _
	(pInst as IDropTarget ptr) as HRESULT
	
	dim as CDropTarget ptr _this = cast(CDropTarget ptr, pInst)
	
	return S_OK
end function

''
''	IDropTarget::Drop
''
private function CDropTarget.Drop _
	(pInst as IDropTarget ptr, _ 
	 pDataObject as IDataObject ptr, grfKeyState as DWORD, _
	 pt as POINTL, pdwEffect as DWORD ptr) as HRESULT
	
	dim as CDropTarget ptr _this = cast(CDropTarget ptr, pInst)
	
	_this->PositionCursor(pt)

	if(_this->m_fAllowDrop) then
		_this->DropData(pDataObject)

		*pdwEffect = _this->DropEffect(grfKeyState, pt, *pdwEffect)
	else
		*pdwEffect = DROPEFFECT_NONE
	end if

	return S_OK
end function

''
'' Position the edit control's caret under the mouse
''
private sub CDropTarget.PositionCursor _
	(pt as POINTL)
	
	dim as DWORD curpos
		
	'' get the character position of mouse
	ScreenToClient(m_hWnd, cast(POINT ptr, @pt))
	curpos = SendMessage(m_hWnd, EM_CHARFROMPOS, 0, MAKELPARAM(pt.x, pt.y))

	'' set cursor position
	SendMessage(m_hWnd, EM_SETSEL, LOWORD(curpos), LOWORD(curpos))
end sub

''
''
''
private sub CDropTarget.DropData _
	(pDataObject as IDataObject ptr)
	
	'' construct a FORMATETC object
	dim as FORMATETC fmtetc = ( CF_TEXT, 0, DVASPECT_CONTENT, -1, TYMED_HGLOBAL )
	dim as STGMEDIUM stgmed

	'' See if the dataobject contains any TEXT stored as a HGLOBAL
	if( pDataObject->lpVtbl->QueryGetData(pDataObject, @fmtetc) = S_OK) then
		'' Yippie! the data is there, so go get it!
		if(pDataObject->lpVtbl->GetData(pDataObject, @fmtetc, @stgmed) = S_OK) then
			'' we asked for the data as a HGLOBAL, so access it appropriately
			dim as PVOID data_ = GlobalLock(stgmed.hGlobal)

			SetWindowText(m_hWnd, cast(zstring ptr, data_))

			GlobalUnlock(stgmed.hGlobal)

			'' release the data using the COM API
			ReleaseStgMedium(@stgmed)
		end if
	end if
end sub

''
''	QueryDataObject private helper routine
''
private function CDropTarget.QueryDataObject _
	(pDataObject as IDataObject ptr) as integer
	
	dim as FORMATETC fmtetc = ( CF_TEXT, 0, DVASPECT_CONTENT, -1, TYMED_HGLOBAL )

	'' does the data object support CF_TEXT using a HGLOBAL?
	return pDataObject->lpVtbl->QueryGetData(pDataObject, @fmtetc) = S_OK
end function

''
''	DropEffect private helper routine
''
private function CDropTarget.DropEffect _
	(grfKeyState as DWORD, pt as POINTL, dwAllowed as DWORD ) as DWORD
	
	dim as DWORD dwEffect = 0

	'' 1. check "pt" -> do we allow a drop at the specified coordinates?
	
	'' 2. work out that the drop-effect should be based on grfKeyState
	if(grfKeyState and MK_CONTROL) then
		dwEffect = dwAllowed and DROPEFFECT_COPY
	elseif(grfKeyState and MK_SHIFT) then
		dwEffect = dwAllowed and DROPEFFECT_MOVE
	end if
	
	'' 3. no key-modifiers were specified (or drop effect not allowed), so
	''    base the effect on those allowed by the dropsource
	if(dwEffect = 0) then
		if(dwAllowed and DROPEFFECT_COPY) then dwEffect = DROPEFFECT_COPY
		if(dwAllowed and DROPEFFECT_MOVE) then dwEffect = DROPEFFECT_MOVE
	end if
	
	return dwEffect
end function

