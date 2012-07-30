''
''
'' Xag -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xag_bi__
#define __Xag_bi__

#define X_XagQueryVersion 0
#define X_XagCreate 1
#define X_XagDestroy 2
#define X_XagGetAttr 3
#define X_XagQuery 4
#define X_XagCreateAssoc 5
#define X_XagDestroyAssoc 6
#define XagBadAppGroup 0
#define XagNumberErrors (0+1)
#define XagNsingleScreen 7
#define XagNdefaultRoot 1
#define XagNrootVisual 2
#define XagNdefaultColormap 3
#define XagNblackPixel 4
#define XagNwhitePixel 5
#define XagNappGroupLeader 6

type XagQueryVersion as Bool

declare function XagCreateEmbeddedApplicationGroup cdecl alias "XagCreateEmbeddedApplicationGroup" (byval as Display ptr, byval as VisualID, byval as Colormap, byval as uinteger, byval as uinteger, byval as XAppGroup ptr) as Status
declare function XagCreateNonembeddedApplicationGroup cdecl alias "XagCreateNonembeddedApplicationGroup" (byval as Display ptr, byval as XAppGroup ptr) as Status
declare function XagDestroyApplicationGroup cdecl alias "XagDestroyApplicationGroup" (byval as Display ptr, byval as XAppGroup) as Status
declare function XagGetApplicationGroupAttributes cdecl alias "XagGetApplicationGroupAttributes" (byval as Display ptr, byval as XAppGroup, ...) as Status
declare function XagQueryApplicationGroup cdecl alias "XagQueryApplicationGroup" (byval as Display ptr, byval as XID, byval as XAppGroup ptr) as Status
declare function XagCreateAssociation cdecl alias "XagCreateAssociation" (byval as Display ptr, byval as Window ptr, byval as any ptr) as Status
declare function XagDestroyAssociation cdecl alias "XagDestroyAssociation" (byval as Display ptr, byval as Window) as Status

#endif
