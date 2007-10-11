''
'' CClientSite - a "class" that implements the IOleClientSite interface
'' 

#ifndef _CClientSite_bi_
#define _CClientSite_bi_ 1

type CClientSite
	as IOleClientSite	interface				'' must be the first field
	as CInPlaceSite		site
	as IViewObject ptr	viewobj
end type


declare function 	CClientSite_New 			( byval _this as CClientSite ptr, _
												  byval hwnd as HWND ) as CClientSite ptr

declare sub 		CClientSite_Delete 			( byval _this as CClientSite ptr, _
												  byval isstatic as integer )

declare function 	CClientSite_SetObject 		( byval _this as CClientSite ptr, _
												  byval obj as IOleObject ptr ) as BOOL

#endif
