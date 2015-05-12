''
''
'' ICEutil -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ICEutil_bi__
#define __ICEutil_bi__

type IceAuthDataEntry
	protocol_name as zstring ptr
	network_id as zstring ptr
	auth_name as zstring ptr
	auth_data_length as ushort
	auth_data as zstring ptr
end type

#define IceAuthLockSuccess 0
#define IceAuthLockError 1
#define IceAuthLockTimeout 2

declare function IceAuthFileName cdecl alias "IceAuthFileName" () as zstring ptr
declare function IceLockAuthFile cdecl alias "IceLockAuthFile" (byval as zstring ptr, byval as integer, byval as integer, byval as integer) as integer
declare sub IceUnlockAuthFile cdecl alias "IceUnlockAuthFile" (byval as zstring ptr)
declare function IceReadAuthFileEntry cdecl alias "IceReadAuthFileEntry" (byval as FILE ptr) as IceAuthFileEntry ptr
declare sub IceFreeAuthFileEntry cdecl alias "IceFreeAuthFileEntry" (byval as IceAuthFileEntry ptr)
declare function IceWriteAuthFileEntry cdecl alias "IceWriteAuthFileEntry" (byval as FILE ptr, byval as IceAuthFileEntry ptr) as Status
declare function IceGetAuthFileEntry cdecl alias "IceGetAuthFileEntry" (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as IceAuthFileEntry ptr
declare function IceGenerateMagicCookie cdecl alias "IceGenerateMagicCookie" (byval as integer) as zstring ptr
declare sub IceSetPaAuthData cdecl alias "IceSetPaAuthData" (byval as integer, byval as IceAuthDataEntry ptr)

#endif
