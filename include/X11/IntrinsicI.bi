''
''
'' IntrinsicI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __IntrinsicI_bi__
#define __IntrinsicI_bi__

#define RectObjClassFlag &h02
#define WidgetClassFlag &h04
#define CompositeClassFlag &h08
#define ConstraintClassFlag &h10
#define ShellClassFlag &h20
#define WMShellClassFlag &h40
#define TopLevelClassFlag &h80
#define XFILESEARCHPATHDEFAULT "/usr/lib/X11/%L/%T/%N%S:/usr/lib/X11/%l/%T/%N%S:/usr/lib/X11/%T/%N%S"
#define XTERROR_PREFIX ""
#define XTWARNING_PREFIX ""
#define ERRORDB "/usr/lib/X11/XtErrorDB"

declare sub _XtAllocError cdecl alias "_XtAllocError" (byval as String)
declare sub _XtCompileResourceList cdecl alias "_XtCompileResourceList" (byval as XtResourceList, byval as Cardinal)
declare function _XtMakeGeometryRequest cdecl alias "_XtMakeGeometryRequest" (byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr, byval as Boolean ptr) as XtGeometryResult
declare function _XtIsHookObject cdecl alias "_XtIsHookObject" (byval as Widget) as Boolean
declare sub _XtAddShellToHookObj cdecl alias "_XtAddShellToHookObj" (byval as Widget)
declare sub _XtGClistFree cdecl alias "_XtGClistFree" (byval dpy as Display ptr, byval pd as XtPerDisplay)
declare function __XtMalloc cdecl alias "__XtMalloc" (byval as uinteger) as zstring ptr
declare function __XtCalloc cdecl alias "__XtCalloc" (byval as uinteger, byval as uinteger) as zstring ptr

#endif
