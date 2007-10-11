#ifndef __dj_include_sys_exceptn_h__
#define __dj_include_sys_exceptn_h__

extern "C"

#ifdef __dj_include_setjmp_h_
extern __djgpp_exception_state_ptr alias "__djgpp_exception_state_ptr" as jmp_buf ptr
#define __djgpp_exception_state (*__djgpp_exception_state_ptr)
#endif

extern __djgpp_our_DS alias "__djgpp_our_DS" as ushort
extern __djgpp_app_DS alias "__djgpp_app_DS" as ushort
extern __djgpp_ds_alias alias "__djgpp_ds_alias" as ushort
extern __djgpp_dos_sel alias "__djgpp_dos_sel" as ushort

extern __djgpp_hwint_flags alias "__djgpp_hwint_flags" as ushort
extern __djgpp_cbrk_count alias "__djgpp_cbrk_count" as uinteger
extern __djgpp_exception_inprog alias "__djgpp_exception_inprog" as integer

extern __djgpp_sigint_key alias "__djgpp_sigint_key" as ushort
extern __djgpp_sigquit_key alias "__djgpp_sigquit_key" as ushort
extern __djgpp_sigint_mask alias "__djgpp_sigint_mask" as ushort
extern __djgpp_sigquit_mask alias "__djgpp_sigquit_mask" as ushort

declare sub __djgpp_exception_toggle cdecl()
declare function __djgpp_set_ctrl_c cdecl(byval as integer) as integer
declare function __djgpp_set_sigint_key cdecl(byval as integer) as integer
declare function __djgpp_set_sigquit_key cdecl(byval as integer) as integer

end extern

#endif
