#include once "windows.bi"
#include once "win/ole2.bi"

type CDropTarget
private:
	'' implements IDropTarget
	dim as IDropTarget m_DropTarget = any

public:
	declare constructor(byval hwnd as HWND)
	declare destructor()

private:
	'' IDropTarget implementation (while there's no support for virtual methods and inheritance)
	declare static function QueryInterface _
		(byval pInst as IDropTarget ptr, _
		 byval iid as REFIID, byval ppvObject as any ptr ptr) as HRESULT

	declare static function AddRef _
		(byval pInst as IDropTarget ptr) as ULONG

	declare static function Release _
		(byval pInst as IDropTarget ptr) as ULONG

	declare static function DragEnter _
		(byval pInst as IDropTarget ptr, _
		 byval pDataObject as IDataObject ptr, byval grfKeyState as DWORD, _
		 byval pt as POINTL, byval pdwEffect as DWORD ptr) as HRESULT

	declare static function DragOver _
		(byval pInst as IDropTarget ptr, _
		 byval grfKeyState as DWORD, byval pt as POINTL, byval pdwEffect as DWORD ptr) as HRESULT

	declare static function DragLeave _
		(byval pInst as IDropTarget ptr) as HRESULT

	declare static function Drop _
		(byval pInst as IDropTarget ptr, _
		 byval pDataObject as IDataObject ptr, byval grfKeyState as DWORD, _
		 byval pt as POINTL, byval pdwEffect as DWORD ptr) as HRESULT

	'' internal helper function
	declare sub PositionCursor(byval pt as POINTL)
	declare sub DropData(byval pDataObject as IDataObject ptr)
	declare function DropEffect(byval grfKeyState as DWORD, byval pt as POINTL, byval dwAllowed as DWORD) as DWORD
	declare function QueryDataObject(byval pDataObject as IDataObject ptr) as integer

	'' member variables
	as LONG m_lRefCount = any
	as HWND m_hWnd = any
	as integer m_fAllowDrop = any
	as IDataObject ptr m_pDataObject = any
end type
