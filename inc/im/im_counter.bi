''
''
'' im_counter -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_counter_bi__
#define __im_counter_bi__

type imCounterCallback as function cdecl(byval as integer, byval as any ptr, byval as zstring ptr, byval as integer) as integer

declare function imCounterSetCallback cdecl alias "imCounterSetCallback" (byval user_data as any ptr, byval counter_func as imCounterCallback) as imCounterCallback
declare function imCounterHasCallback cdecl alias "imCounterHasCallback" () as integer
declare function imCounterBegin cdecl alias "imCounterBegin" (byval title as zstring ptr) as integer
declare sub imCounterEnd cdecl alias "imCounterEnd" (byval counter as integer)
declare function imCounterInc cdecl alias "imCounterInc" (byval counter as integer) as integer
declare function imCounterIncTo cdecl alias "imCounterIncTo" (byval counter as integer, byval count as integer) as integer
declare sub imCounterTotal cdecl alias "imCounterTotal" (byval counter as integer, byval total as integer, byval message as zstring ptr)
declare function imCounterGetUserData cdecl alias "imCounterGetUserData" (byval counter as integer) as any ptr
declare sub imCounterSetUserData cdecl alias "imCounterSetUserData" (byval counter as integer, byval userdata as any ptr)

#endif
