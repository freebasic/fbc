''
''
'' ICEmsg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ICEmsg_bi__
#define __ICEmsg_bi__

declare sub _IceReadSkip cdecl alias "_IceReadSkip" (byval as IceConn, byval as uinteger)
declare sub _IceWrite cdecl alias "_IceWrite" (byval as IceConn, byval as uinteger, byval as zstring ptr)
declare sub _IceErrorBadMinor cdecl alias "_IceErrorBadMinor" (byval as IceConn, byval as integer, byval as integer, byval as integer)
declare sub _IceErrorBadState cdecl alias "_IceErrorBadState" (byval as IceConn, byval as integer, byval as integer, byval as integer)
declare sub _IceErrorBadLength cdecl alias "_IceErrorBadLength" (byval as IceConn, byval as integer, byval as integer, byval as integer)
declare sub _IceErrorBadValue cdecl alias "_IceErrorBadValue" (byval as IceConn, byval as integer, byval as integer, byval as integer, byval as integer, byval as IcePointer)
declare function _IcePoMagicCookie1Proc cdecl alias "_IcePoMagicCookie1Proc" (byval as IceConn, byval as IcePointer ptr, byval as Bool, byval as Bool, byval as integer, byval as IcePointer, byval as integer ptr, byval as IcePointer ptr, byval as byte ptr ptr) as IcePoAuthStatus
declare function _IcePaMagicCookie1Proc cdecl alias "_IcePaMagicCookie1Proc" (byval as IceConn, byval as IcePointer ptr, byval as Bool, byval as integer, byval as IcePointer, byval as integer ptr, byval as IcePointer ptr, byval as byte ptr ptr) as IcePaAuthStatus

#endif
