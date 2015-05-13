''
''
'' iuptree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iuptree_bi__
#define __iuptree_bi__

#include once "iup.bi"
#include once "iupcpi.bi"

extern "c"
declare sub IupTreeOpen ()
declare sub IupTreeClose ()
declare function IupTree () as Ihandle ptr
declare function IupTreeSetUserId (byval h as Ihandle ptr, byval id as integer, byval userid as any ptr) as integer
declare function IupTreeGetUserId (byval h as Ihandle ptr, byval id as integer) as any ptr
declare function IupTreeGetId (byval h as Ihandle ptr, byval userid as any ptr) as integer
declare sub IupTreeSetAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval id as integer, byval v as zstring ptr)
declare sub IupTreeStoreAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval id as integer, byval v as zstring ptr)
declare function IupTreeGetAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval id as integer) as zstring ptr
declare function IupTreeGetInt (byval n as Ihandle ptr, byval a as zstring ptr, byval id as integer) as integer
declare function IupTreeGetFloat (byval n as Ihandle ptr, byval a as zstring ptr, byval id as integer) as single
declare sub IupTreeSetfAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval id as integer, byval f as zstring ptr, ...)
end extern

#define IUP_ADDLEAF "ADDLEAF"
#define IUP_ADDBRANCH "ADDBRANCH"
#define IUP_DELNODE "DELNODE"
#define IUP_IMAGELEAF "IMAGELEAF"
#define IUP_IMAGEBRANCHCOLLAPSED "IMAGEBRANCHCOLLAPSED"
#define IUP_IMAGEBRANCHEXPANDED "IMAGEBRANCHEXPANDED"
#define IUP_IMAGEEXPANDED "IMAGEEXPANDED"
#define IUP_KIND "KIND"
#define IUP_PARENT "PARENT"
#define IUP_DEPTH "DEPTH"
#ifndef IUP_MARKED
#define IUP_MARKED "MARKED"
#endif
#define IUP_ADDEXPANDED "ADDEXPANDED"
#define IUP_CTRL "CTRL"
#define IUP_SHIFT "SHIFT"
#define IUP_NAME "NAME"
#define IUP_STATE "STATE"
#define IUP_STARTING "STARTING"
#define IUP_LEAF "LEAF"
#define IUP_BRANCH "BRANCH"
#define IUP_SELECTED "SELECTED"
#define IUP_CHILDREN "CHILDREN"
#define IUP_ROOT "ROOT"
#define IUP_LAST "LAST"
#define IUP_PGUP "PGUP"
#define IUP_PGDN "PGDN"
#define IUP_NEXT "NEXT"
#define IUP_PREVIOUS "PREVIOUS"
#define IUP_INVERT "INVERT"
#define IUP_BLOCK "BLOCK"
#define IUP_CLEARALL "CLEARALL"
#define IUP_MARKALL "MARKALL"
#define IUP_INVERTALL "INVERTALL"
#ifndef IUP_REDRAW
#define IUP_REDRAW "REDRAW"
#endif
#define IUP_COLLAPSED "COLLAPSED"
#define IUP_EXPANDED "EXPANDED"
#define IUP_SELECTION_CB "SELECTION_CB"
#define IUP_BRANCHOPEN_CB "BRANCHOPEN_CB"
#define IUP_BRANCHCLOSE_CB "BRANCHCLOSE_CB"
#define IUP_RIGHTCLICK_CB "RIGHTCLICK_CB"
#define IUP_EXECUTELEAF_CB "EXECUTELEAF_CB"
#define IUP_RENAMENODE_CB "RENAMENODE_CB"
#define IUP_IMGLEAF "IMGLEAF"
#define IUP_IMGCOLLAPSED "IMGCOLLAPSED"
#define IUP_IMGEXPANDED "IMGEXPANDED"
#define IUP_IMGBLANK "IMGBLANK"
#define IUP_IMGPAPER "IMGPAPER"

#endif
