#pragma once

'' Concats a comma separated list of arguments

#define __MAC_CONCAT_ARG_LIST1(arg1) arg1
#define __MAC_CONCAT_ARG_LIST2(arg1, arg2) __FB_JOIN__(arg1, arg2)
#define __MAC_CONCAT_ARG_LIST3(arg1, arg2, arg3) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST2(arg2, arg3))
#define __MAC_CONCAT_ARG_LIST4(arg1, arg2, arg3, arg4) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST3(arg2, arg3, arg4))
#define __MAC_CONCAT_ARG_LIST5(arg1, arg2, arg3, arg4, arg5) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST4(arg2, arg3, arg4, arg5))
#define __MAC_CONCAT_ARG_LIST6(arg1, arg2, arg3, arg4, arg5, arg6) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST5(arg2, arg3, arg4, arg5, arg6))
#define __MAC_CONCAT_ARG_LIST7(arg1, arg2, arg3, arg4, arg5, arg6, arg7) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST6(arg2, arg3, arg4, arg5, arg6, arg7))
#define __MAC_CONCAT_ARG_LIST8(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST7(arg2, arg3, arg4, arg5, arg6, arg7, arg8))
#define __MAC_CONCAT_ARG_LIST9(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST8(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9))
#define __MAC_CONCAT_ARG_LIST10(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST9(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10))

#define __MAC_CONCAT_ARG_LIST_BUT_LAST1(arg1)
#define __MAC_CONCAT_ARG_LIST_BUT_LAST2(arg1, arg2) arg1
#define __MAC_CONCAT_ARG_LIST_BUT_LAST3(arg1, arg2, arg3) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST_BUT_LAST2(arg2, arg3))
#define __MAC_CONCAT_ARG_LIST_BUT_LAST4(arg1, arg2, arg3, arg4) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST_BUT_LAST3(arg2, arg3, arg4))
#define __MAC_CONCAT_ARG_LIST_BUT_LAST5(arg1, arg2, arg3, arg4, arg5) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST_BUT_LAST4(arg2, arg3, arg4, arg5))
#define __MAC_CONCAT_ARG_LIST_BUT_LAST6(arg1, arg2, arg3, arg4, arg5, arg6) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST_BUT_LAST5(arg2, arg3, arg4, arg5, arg6))
#define __MAC_CONCAT_ARG_LIST_BUT_LAST7(arg1, arg2, arg3, arg4, arg5, arg6, arg7) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST_BUT_LAST6(arg2, arg3, arg4, arg5, arg6, arg7))
#define __MAC_CONCAT_ARG_LIST_BUT_LAST8(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST_BUT_LAST7(arg2, arg3, arg4, arg5, arg6, arg7, arg8))
#define __MAC_CONCAT_ARG_LIST_BUT_LAST9(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST_BUT_LAST8(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9))
#define __MAC_CONCAT_ARG_LIST_BUT_LAST10(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) __FB_JOIN__(arg1, __MAC_CONCAT_ARG_LIST_BUT_LAST9(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9. 10))


'' Joins a comma separated list which are all contained in a 'args...' parameter
''
'' example 
'' #define FBType() __FB_JOIN__(__MAC_JOIN_ARG_LIST, __NumArgs)(.,args)
'' will produce 
'' MyNamespace.MySecondNamespace.MyType
'' when (MyNamespace, MySecondNamespace, MyType) are passed to a
'' variadic macro like #macro DefineListOf(args...)
#define __MAC_JOIN_ARG_LIST1(sep, arg1) arg1
#define __MAC_JOIN_ARG_LIST2(sep, arg1, arg2) __FB_JOIN__(arg1, __FB_JOIN__(sep, __MAC_JOIN_ARG_LIST1(sep, arg2)))
#define __MAC_JOIN_ARG_LIST3(sep, arg1, arg2, arg3) __FB_JOIN__(arg1, __FB_JOIN__(sep, __MAC_JOIN_ARG_LIST2(sep, arg2, arg3)))
#define __MAC_JOIN_ARG_LIST4(sep, arg1, arg2, arg3, arg4) __FB_JOIN__(arg1, __FB_JOIN__(sep, __MAC_JOIN_ARG_LIST3(sep, arg2, arg3, arg4)))
#define __MAC_JOIN_ARG_LIST5(sep, arg1, arg2, arg3, arg4, arg5) __FB_JOIN__(arg1, __FB_JOIN__(sep, __MAC_JOIN_ARG_LIST4(sep, arg2, arg3, arg4, arg5)))
#define __MAC_JOIN_ARG_LIST6(sep, arg1, arg2, arg3, arg4, arg5, arg6) __FB_JOIN__(arg1, __FB_JOIN__(sep, __MAC_JOIN_ARG_LIST5(sep, arg2, arg3, arg4, arg5, arg6)))
#define __MAC_JOIN_ARG_LIST7(sep, arg1, arg2, arg3, arg4, arg5, arg6, arg7) __FB_JOIN__(arg1, __FB_JOIN__(sep, __MAC_JOIN_ARG_LIST6(sep, arg2, arg3, arg4, arg5, arg6, arg7)))
#define __MAC_JOIN_ARG_LIST8(sep, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) __FB_JOIN__(arg1, __FB_JOIN__(sep, __MAC_JOIN_ARG_LIST7(sep, arg2, arg3, arg4, arg5, arg6, arg7, arg8)))
#define __MAC_JOIN_ARG_LIST9(sep, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) __FB_JOIN__(arg1, __FB_JOIN__(sep, __MAC_JOIN_ARG_LIST8(sep, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)))
#define __MAC_JOIN_ARG_LIST10(sep, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) __FB_JOIN__(arg1, __FB_JOIN__(sep, __MAC_JOIN_ARG_LIST9(sep, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)))

'' Returns the last value of a sequence
#define __MAC_LAST_ARG1(arg1) arg1
#define __MAC_LAST_ARG2(arg1, arg2) arg2
#define __MAC_LAST_ARG3(arg1, arg2, arg3) arg3
#define __MAC_LAST_ARG4(arg1, arg2, arg3, arg4) arg4
#define __MAC_LAST_ARG5(arg1, arg2, arg3, arg4, arg5) arg5
#define __MAC_LAST_ARG6(arg1, arg2, arg3, arg4, arg5, arg6) arg6
#define __MAC_LAST_ARG7(arg1, arg2, arg3, arg4, arg5, arg6, arg7) arg7
#define __MAC_LAST_ARG8(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) arg8
#define __MAC_LAST_ARG9(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) arg9
#define __MAC_LAST_ARG10(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) arg10

'' Replaces the last arg of a sequence
#define __MAC_REPLACE_LAST_ARG1(arg1, newArg) newArg
#define __MAC_REPLACE_LAST_ARG2(arg1, arg2, newArg) arg1, newArg
#define __MAC_REPLACE_LAST_ARG3(arg1, arg2, arg3, newArg) arg1, arg2, newArg
#define __MAC_REPLACE_LAST_ARG4(arg1, arg2, arg3, arg4, newArg) arg1, arg2, arg3, newArg
#define __MAC_REPLACE_LAST_ARG5(arg1, arg2, arg3, arg4, arg5, newArg) arg1, arg2, arg3, arg4, newArg
#define __MAC_REPLACE_LAST_ARG6(arg1, arg2, arg3, arg4, arg5, arg6, newArg) arg1, arg2, arg3, arg4, arg5, newArg
#define __MAC_REPLACE_LAST_ARG7(arg1, arg2, arg3, arg4, arg5, arg6, arg7, newArg) arg1, arg2, arg3, arg4, arg5, arg6, newArg
#define __MAC_REPLACE_LAST_ARG8(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, newArg) arg1, arg2, arg3, arg4, arg5, arg6, arg7, newArg
#define __MAC_REPLACE_LAST_ARG9(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, newArg) arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, newArg
#define __MAC_REPLACE_LAST_ARG10(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, newArg) arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, newArg
