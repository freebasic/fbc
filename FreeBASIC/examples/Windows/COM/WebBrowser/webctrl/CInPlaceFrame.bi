''
'' CInPlaceFrame - a "class" that implements the IOleInPlaceFrame interface
'' 

#ifndef _CInPlaceFrame_bi_
#define _CInPlaceFrame_bi_ 1

type CInPlaceFrame
	as IOleInPlaceFrame	interface					'' must be the first field
	as HWND				hwnd
end type

declare function 	CInPlaceFrame_New 				( byval _this as CInPlaceFrame ptr, byval hwnd as HWND ) as CInPlaceFrame ptr

declare sub 		CInPlaceFrame_Delete 			( byval _this as CInPlaceFrame ptr, byval isstatic as integer )

#endif
