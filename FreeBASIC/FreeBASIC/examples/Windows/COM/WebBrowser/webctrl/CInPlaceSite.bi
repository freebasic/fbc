''
'' CInPlaceSite - a "class" that implements the IOleInPlaceSite interface
'' 

#ifndef _CInPlaceSite_bi_
#define _CInPlaceSite_bi_ 1

type CInPlaceSite
	as IOleInPlaceSite			interface		'' must be the first field
	as CInPlaceFrame			frame
	as IOleObject ptr 			oleobj
	as IOleInPlaceObject ptr 	inplaceobj
end type

declare function 	CInPlaceSite_New 			( byval _this as CInPlaceSite ptr, byval hwnd as HWND ) as CInPlaceSite ptr

declare sub 		CInPlaceSite_Delete 		( byval _this as CInPlaceSite ptr, byval isstatic as integer )

declare sub 		CInPlaceSite_SetObject 		( byval _this as CInPlaceSite ptr, byval obj as IOleObject ptr )

declare function 	CInPlaceSite_GetHwnd 		( byval _this as CInPlaceSite ptr ) as HWND

#endif
