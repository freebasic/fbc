''
''
'' CvtCache -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CvtCache_bi__
#define __CvtCache_bi__

type _XmuCvtCache
	string_to_bitmap as XmuCvtCache__NESTED__string_to_bitmap
end type

type XmuCvtCache as _XmuCvtCache

type XmuCvtCache__NESTED__string_to_bitmap
	bitmapFilePath as byte ptr ptr
end type

declare sub _XmuStringToBitmapInitCache cdecl alias "_XmuStringToBitmapInitCache" (byval c as XmuCvtCache ptr)
declare sub _XmuStringToBitmapFreeCache cdecl alias "_XmuStringToBitmapFreeCache" (byval c as XmuCvtCache ptr)

#endif
