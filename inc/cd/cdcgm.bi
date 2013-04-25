''
''
'' cdcgm -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cdcgm_bi__
#define __cdcgm_bi__

declare function cdContextCGM cdecl alias "cdContextCGM" () as cdContext ptr

#define CD_CGMCOUNTERCB 1
#define CD_CGMSCLMDECB 2
#define CD_CGMVDCEXTCB 3
#define CD_CGMBEGPICTCB 4
#define CD_CGMBEGPICTBCB 5
#define CD_CGMBEGMTFCB 6

#endif
