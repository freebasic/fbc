#include once "windows.bi"
#include once "win/ole2.bi"

type CDropTarget
private:	
	'' implements IDropTarget
	dim as IDropTarget m_DropTarget = any

public:
	declare constructor(hwnd as HWND)
	declare destructor()

private:
	'' IDropTarget implementation (while there's no support for virtual methods and inheritance)
	declare static function QueryInterface _
		(pInst as IDropTarget ptr, _ 
		 iid as REFIID, ppvObject as any ptr ptr) as HRESULT
	
	declare static function AddRef _
		(pInst as IDropTarget ptr) as ULONG
	
	declare static function Release _
		(pInst as IDropTarget ptr) as ULONG
	
	declare static function DragEnter _
		(pInst as IDropTarget ptr, _ 
		 pDataObject as IDataObject ptr, grfKeyState as DWORD, _
		 pt as POINTL, pdwEffect as DWORD ptr) as HRESULT
	
	declare static function DragOver _
		(pInst as IDropTarget ptr, _ 
		 grfKeyState as DWORD, pt as POINTL, pdwEffect as DWORD ptr) as HRESULT
	
	declare static function DragLeave _
		(pInst as IDropTarget ptr) as HRESULT
	
	declare static function Drop _
		(pInst as IDropTarget ptr, _ 
		 pDataObject as IDataObject ptr, grfKeyState as DWORD, _
		 pt as POINTL, pdwEffect as DWORD ptr) as HRESULT
	
	'' internal helper function
	declare sub PositionCursor(pt as POINTL)
	declare sub DropData(pDataObject as IDataObject ptr)
	declare function DropEffect(grfKeyState as DWORD, pt as POINTL, dwAllowed as DWORD) as DWORD
	declare function QueryDataObject(pDataObject as IDataObject ptr) as integer

	'' member variables
	as LONG	m_lRefCount = any
	as HWND	m_hWnd = any
	as integer m_fAllowDrop = any
	as IDataObject ptr m_pDataObject = any
end type
