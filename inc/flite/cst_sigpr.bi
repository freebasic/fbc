''
''
'' cst_sigpr -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_sigpr_bi__
#define __cst_sigpr_bi__

declare function lpc_resynth cdecl alias "lpc_resynth" (byval lpcres as cst_lpcres ptr) as cst_wave ptr
declare function lpc_resynth_fixedpoint cdecl alias "lpc_resynth_fixedpoint" (byval lpcres as cst_lpcres ptr) as cst_wave ptr
declare function lpc_resynth_spike cdecl alias "lpc_resynth_spike" (byval lpcres as cst_lpcres ptr) as cst_wave ptr

#endif
