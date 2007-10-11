''
''
'' iupmatrix -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupmatrix_bi__
#define __iupmatrix_bi__

extern "c"
declare sub IupMatrixOpen ()
declare sub IupMatrixClose ()
declare function IupMatrix (byval action as zstring ptr) as Ihandle ptr
declare sub IupMatSetAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval l as integer, byval c as integer, byval v as zstring ptr)
declare sub IupMatStoreAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval l as integer, byval c as integer, byval v as zstring ptr)
declare function IupMatGetAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval l as integer, byval c as integer) as zstring ptr
declare function IupMatGetInt (byval n as Ihandle ptr, byval a as zstring ptr, byval l as integer, byval c as integer) as integer
declare function IupMatGetFloat (byval n as Ihandle ptr, byval a as zstring ptr, byval l as integer, byval c as integer) as single
declare sub IupMatSetfAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval l as integer, byval c as integer, byval f as zstring ptr, ...)
end extern

#define IUP_ENTERITEM_CB "ENTERITEM_CB"
#define IUP_LEAVEITEM_CB "LEAVEITEM_CB"
#define IUP_EDITION_CB "EDITION_CB"
#define IUP_CLICK_CB "CLICK_CB"
#define IUP_DROP_CB "DROP_CB"
#define IUP_DROPSELECT_CB "DROPSELECT_CB"
#define IUP_DROPCHECK_CB "DROPCHECK_CB"
#ifndef IUP_SCROLL_CB
#define IUP_SCROLL_CB "SCROLL_CB"
#endif
#define IUP_VALUE_CB "VALUE_CB"
#define IUP_VALUE_EDIT_CB "VALUE_EDIT_CB"
#define IUP_FIELD_CB "FIELD_CB"
#define IUP_RESIZEMATRIX "RESIZEMATRIX"
#define IUP_ADDLIN "ADDLIN"
#define IUP_ADDCOL "ADDCOL"
#define IUP_DELLIN "DELLIN"
#define IUP_DELCOL "DELCOL"
#define IUP_NUMLIN "NUMLIN"
#define IUP_NUMCOL "NUMCOL"
#define IUP_NUMLIN_VISIBLE "NUMLIN_VISIBLE"
#define IUP_NUMCOL_VISIBLE "NUMCOL_VISIBLE"
#define IUP_MARKED "MARKED"
#define IUP_WIDTHDEF "WIDTHDEF"
#define IUP_HEIGHTDEF "HEIGHTDEF"
#define IUP_AREA "AREA"
#define IUP_MARK_MODE "MARK_MODE"
#define IUP_LIN "LIN"
#define IUP_COL "COL"
#define IUP_LINCOL "LINCOL"
#define IUP_CELL "CELL"
#define IUP_EDIT_MODE "EDIT_MODE"
#define IUP_FOCUS_CELL "FOCUS_CELL"
#define IUP_ORIGIN "ORIGIN"
#define IUP_REDRAW "REDRAW"
#define IUP_PREVIOUSVALUE "PREVIOUSVALUE"
#define IUP_MOUSEMOVE_CB "MOUSEMOVE_CB"

#endif
