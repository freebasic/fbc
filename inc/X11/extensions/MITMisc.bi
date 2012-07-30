''
''
'' MITMisc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __MITMisc_bi__
#define __MITMisc_bi__

#define X_MITSetBugMode 0
#define X_MITGetBugMode 1
#define MITMiscNumberEvents 0
#define MITMiscNumberErrors 0

declare function XMITMiscGetBugMode cdecl alias "XMITMiscGetBugMode" (byval as Display ptr) as Bool

#endif
