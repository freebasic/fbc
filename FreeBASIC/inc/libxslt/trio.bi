''
''
'' trio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_trio_bi__
#define __xslt_trio_bi__

#include once "triodef.bi"

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

extern "c"
declare function trio_strerror (byval as integer) as zstring ptr
declare function trio_printf (byval format as zstring ptr, ...) as integer
declare function trio_vprintf (byval format as zstring ptr, byval args as va_list) as integer
declare function trio_printfv (byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_fprintf (byval file as FILE ptr, byval format as zstring ptr, ...) as integer
declare function trio_vfprintf (byval file as FILE ptr, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_fprintfv (byval file as FILE ptr, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_dprintf (byval fd as integer, byval format as zstring ptr, ...) as integer
declare function trio_vdprintf (byval fd as integer, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_dprintfv (byval fd as integer, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_cprintf (byval stream as trio_outstream_t, byval closure as trio_pointer_t, byval format as zstring ptr, ...) as integer
declare function trio_vcprintf (byval stream as trio_outstream_t, byval closure as trio_pointer_t, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_cprintfv (byval stream as trio_outstream_t, byval closure as trio_pointer_t, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_sprintf (byval buffer as zstring ptr, byval format as zstring ptr, ...) as integer
declare function trio_vsprintf (byval buffer as zstring ptr, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_sprintfv (byval buffer as zstring ptr, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_snprintf (byval buffer as zstring ptr, byval max as integer, byval format as zstring ptr, ...) as integer
declare function trio_vsnprintf (byval buffer as zstring ptr, byval bufferSize as integer, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_snprintfv (byval buffer as zstring ptr, byval bufferSize as integer, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_snprintfcat (byval buffer as zstring ptr, byval max as integer, byval format as zstring ptr, ...) as integer
declare function trio_vsnprintfcat (byval buffer as zstring ptr, byval bufferSize as integer, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_aprintf (byval format as zstring ptr, ...) as zstring ptr
declare function trio_vaprintf (byval format as zstring ptr, byval args as va_list) as zstring ptr
declare function trio_asprintf (byval ret as byte ptr ptr, byval format as zstring ptr, ...) as integer
declare function trio_vasprintf (byval ret as byte ptr ptr, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_scanf (byval format as zstring ptr, ...) as integer
declare function trio_vscanf (byval format as zstring ptr, byval args as va_list) as integer
declare function trio_scanfv (byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_fscanf (byval file as FILE ptr, byval format as zstring ptr, ...) as integer
declare function trio_vfscanf (byval file as FILE ptr, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_fscanfv (byval file as FILE ptr, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_dscanf (byval fd as integer, byval format as zstring ptr, ...) as integer
declare function trio_vdscanf (byval fd as integer, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_dscanfv (byval fd as integer, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_cscanf (byval stream as trio_instream_t, byval closure as trio_pointer_t, byval format as zstring ptr, ...) as integer
declare function trio_vcscanf (byval stream as trio_instream_t, byval closure as trio_pointer_t, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_cscanfv (byval stream as trio_instream_t, byval closure as trio_pointer_t, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare function trio_sscanf (byval buffer as zstring ptr, byval format as zstring ptr, ...) as integer
declare function trio_vsscanf (byval buffer as zstring ptr, byval format as zstring ptr, byval args as va_list) as integer
declare function trio_sscanfv (byval buffer as zstring ptr, byval format as zstring ptr, byval args as any ptr ptr) as integer
declare sub trio_locale_set_decimal_point (byval decimalPoint as zstring ptr)
declare sub trio_locale_set_thousand_separator (byval thousandSeparator as zstring ptr)
declare sub trio_locale_set_grouping (byval grouping as zstring ptr)
end extern

#endif
