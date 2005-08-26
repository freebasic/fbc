''
''
'' trio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __trio_bi__
#define __trio_bi__

#include once "libxslt/triodef.bi"

enum 
	TRIO_EOF = 1
	TRIO_EINVAL = 2
	TRIO_ETOOMANY = 3
	TRIO_EDBLREF = 4
	TRIO_EGAP = 5
	TRIO_ENOMEM = 6
	TRIO_ERANGE = 7
	TRIO_ERRNO = 8
	TRIO_ECUSTOM = 9
end enum

type trio_outstream_t as function cdecl(byval as trio_pointer_t, byval as integer) as integer
type trio_instream_t as function cdecl(byval as trio_pointer_t) as integer

declare function trio_strerror cdecl alias "trio_strerror" (byval as integer) as zstring ptr
declare function trio_printf cdecl alias "trio_printf" (byval format as zstring ptr, ...) as integer
declare function trio_vprintf cdecl alias "trio_vprintf" (byval format as zstring ptr, byval args as va_list) as integer
declare function trio_printfv cdecl alias "trio_printfv" (byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_fprintf cdecl alias "trio_fprintf" (byval file as FILE ptr, byval format as zstring ptr, ...) as integer
declare function trio_vfprintf cdecl alias "trio_vfprintf" (byval file as FILE ptr, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_fprintfv cdecl alias "trio_fprintfv" (byval file as FILE ptr, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_dprintf cdecl alias "trio_dprintf" (byval fd as integer, byval format as zstring ptr, ...) as integer
declare function trio_vdprintf cdecl alias "trio_vdprintf" (byval fd as integer, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_dprintfv cdecl alias "trio_dprintfv" (byval fd as integer, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_cprintf cdecl alias "trio_cprintf" (byval stream as trio_outstream_t, byval closure as trio_pointer_t, byval format as zstring ptr, ...) as integer
declare function trio_vcprintf cdecl alias "trio_vcprintf" (byval stream as trio_outstream_t, byval closure as trio_pointer_t, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_cprintfv cdecl alias "trio_cprintfv" (byval stream as trio_outstream_t, byval closure as trio_pointer_t, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_sprintf cdecl alias "trio_sprintf" (byval buffer as zstring ptr, byval format as zstring ptr, ...) as integer
declare function trio_vsprintf cdecl alias "trio_vsprintf" (byval buffer as zstring ptr, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_sprintfv cdecl alias "trio_sprintfv" (byval buffer as zstring ptr, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_snprintf cdecl alias "trio_snprintf" (byval buffer as zstring ptr, byval max as integer, byval format as zstring ptr, ...) as integer
declare function trio_vsnprintf cdecl alias "trio_vsnprintf" (byval buffer as zstring ptr, byval bufferSize as integer, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_snprintfv cdecl alias "trio_snprintfv" (byval buffer as zstring ptr, byval bufferSize as integer, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_snprintfcat cdecl alias "trio_snprintfcat" (byval buffer as zstring ptr, byval max as integer, byval format as zstring ptr, ...) as integer
declare function trio_vsnprintfcat cdecl alias "trio_vsnprintfcat" (byval buffer as zstring ptr, byval bufferSize as integer, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_aprintf cdecl alias "trio_aprintf" (byval format as zstring ptr, ...) as zstring ptr
declare function trio_vaprintf cdecl alias "trio_vaprintf" (byval format as zstring ptr, byval args as va_list) as zstring ptr
declare function trio_asprintf cdecl alias "trio_asprintf" (byval ret as byte ptr ptr, byval format as zstring ptr, ...) as integer
declare function trio_vasprintf cdecl alias "trio_vasprintf" (byval ret as byte ptr ptr, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_scanf cdecl alias "trio_scanf" (byval format as zstring ptr, ...) as integer
declare function trio_vscanf cdecl alias "trio_vscanf" (byval format as zstring ptr, byval args as va_list) as integer
declare function trio_scanfv cdecl alias "trio_scanfv" (byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_fscanf cdecl alias "trio_fscanf" (byval file as FILE ptr, byval format as zstring ptr, ...) as integer
declare function trio_vfscanf cdecl alias "trio_vfscanf" (byval file as FILE ptr, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_fscanfv cdecl alias "trio_fscanfv" (byval file as FILE ptr, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_dscanf cdecl alias "trio_dscanf" (byval fd as integer, byval format as zstring ptr, ...) as integer
declare function trio_vdscanf cdecl alias "trio_vdscanf" (byval fd as integer, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_dscanfv cdecl alias "trio_dscanfv" (byval fd as integer, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_cscanf cdecl alias "trio_cscanf" (byval stream as trio_instream_t, byval closure as trio_pointer_t, byval format as zstring ptr, ...) as integer
declare function trio_vcscanf cdecl alias "trio_vcscanf" (byval stream as trio_instream_t, byval closure as trio_pointer_t, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_cscanfv cdecl alias "trio_cscanfv" (byval stream as trio_instream_t, byval closure as trio_pointer_t, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_sscanf cdecl alias "trio_sscanf" (byval buffer as zstring ptr, byval format as zstring ptr, ...) as integer
declare function trio_vsscanf cdecl alias "trio_vsscanf" (byval buffer as zstring ptr, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_sscanfv cdecl alias "trio_sscanfv" (byval buffer as zstring ptr, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare sub trio_locale_set_decimal_point cdecl alias "trio_locale_set_decimal_point" (byval decimalPoint as zstring ptr)
declare sub trio_locale_set_thousand_separator cdecl alias "trio_locale_set_thousand_separator" (byval thousandSeparator as zstring ptr)
declare sub trio_locale_set_grouping cdecl alias "trio_locale_set_grouping" (byval grouping as zstring ptr)

#endif
