'' FreeBASIC binding for libICE-1.0.9

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "crt/stdio.bi"

extern "C"

#define _ICEUTIL_H_

type IceAuthFileEntry
	protocol_name as zstring ptr
	protocol_data_length as ushort
	protocol_data as zstring ptr
	network_id as zstring ptr
	auth_name as zstring ptr
	auth_data_length as ushort
	auth_data as zstring ptr
end type

type IceAuthDataEntry
	protocol_name as zstring ptr
	network_id as zstring ptr
	auth_name as zstring ptr
	auth_data_length as ushort
	auth_data as zstring ptr
end type

const IceAuthLockSuccess = 0
const IceAuthLockError = 1
const IceAuthLockTimeout = 2

declare function IceAuthFileName() as zstring ptr
declare function IceLockAuthFile(byval as const zstring ptr, byval as long, byval as long, byval as clong) as long
declare sub IceUnlockAuthFile(byval as const zstring ptr)
declare function IceReadAuthFileEntry(byval as FILE ptr) as IceAuthFileEntry ptr
declare sub IceFreeAuthFileEntry(byval as IceAuthFileEntry ptr)
declare function IceWriteAuthFileEntry(byval as FILE ptr, byval as IceAuthFileEntry ptr) as long
declare function IceGetAuthFileEntry(byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr) as IceAuthFileEntry ptr
declare function IceGenerateMagicCookie(byval as long) as zstring ptr
declare sub IceSetPaAuthData(byval as long, byval as IceAuthDataEntry ptr)

end extern
