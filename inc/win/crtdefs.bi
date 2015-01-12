#pragma once

#include once "_mingw.bi"

type __lc_time_data as __lc_time_data_
type lconv as lconv_
type rsize_t as uinteger

#define _INC_CRTDEFS
#define _CRTNOALIAS
#define _CRTRESTRICT
#define _RSIZE_T_DEFINED
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_0_0(__ret, __func, __dsttype, __dst)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_0_1(__ret, __func, __dsttype, __dst, __type1, __arg1)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_0_2(__ret, __func, __dsttype, __dst, __type1, __arg1, __type2, __arg2)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_0_3(__ret, __func, __dsttype, __dst, __type1, __arg1, __type2, __arg2, __type3, __arg3)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_0_4(__ret, __func, __dsttype, __dst, __type1, __arg1, __type2, __arg2, __type3, __arg3, __type4, __arg4)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_1_1(__ret, __func, __type0, __arg0, __dsttype, __dst, __type1, __arg1)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_1_2(__ret, __func, __type0, __arg0, __dsttype, __dst, __type1, __arg1, __type2, __arg2)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_1_3(__ret, __func, __type0, __arg0, __dsttype, __dst, __type1, __arg1, __type2, __arg2, __type3, __arg3)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_2_0(__ret, __func, __type1, __arg1, __type2, __arg2, __dsttype, __dst)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_0_1_ARGLIST(__ret, __func, __vfunc, __dsttype, __dst, __type1, __arg1)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_0_2_ARGLIST(__ret, __func, __vfunc, __dsttype, __dst, __type1, __arg1, __type2, __arg2)
#define __DEFINE_CPP_OVERLOAD_SECURE_FUNC_SPLITPATH(__ret, __func, __dsttype, __src)

type pthreadlocinfo as threadlocaleinfostruct ptr
type pthreadmbcinfo as threadmbcinfostruct ptr

type localeinfo_struct
	locinfo as pthreadlocinfo
	mbcinfo as pthreadmbcinfo
end type

type _locale_tstruct as localeinfo_struct
type _locale_t as localeinfo_struct ptr

#define _TAGLC_ID_DEFINED

type tagLC_ID
	wLanguage as ushort
	wCountry as ushort
	wCodePage as ushort
end type

type LC_ID as tagLC_ID
type LPLC_ID as tagLC_ID ptr

#define _THREADLOCALEINFO

type __threadlocaleinfostruct_lc_category
	locale as zstring ptr
	wlocale as wstring ptr
	refcount as long ptr
	wrefcount as long ptr
end type

type threadlocaleinfostruct
	refcount as long
	lc_codepage as ulong
	lc_collate_cp as ulong
	lc_handle(0 to 5) as ulong
	lc_id(0 to 5) as LC_ID
	lc_category(0 to 5) as __threadlocaleinfostruct_lc_category
	lc_clike as long
	mb_cur_max as long
	lconv_intl_refcount as long ptr
	lconv_num_refcount as long ptr
	lconv_mon_refcount as long ptr
	lconv as lconv ptr
	ctype1_refcount as long ptr
	ctype1 as ushort ptr
	pctype as const ushort ptr
	pclmap as const ubyte ptr
	pcumap as const ubyte ptr
	lc_time_curr as __lc_time_data ptr
end type

type threadlocinfo as threadlocaleinfostruct

#define __crt_typefix(ctype)
