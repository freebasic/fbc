''
''
'' Xauth -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xauth_bi__
#define __Xauth_bi__

type xauth
	family as ushort
	address_length as ushort
	address as zstring ptr
	number_length as ushort
	number as zstring ptr
	name_length as ushort
	name as zstring ptr
	data_length as ushort
	data as zstring ptr
end type

type Xauth as xauth

#define FamilyLocal (256)
#define FamilyWild (65535)
#define FamilyNetname (254)
#define FamilyKrb5Principal (253)
#define FamilyLocalHost (252)

declare function XauWriteAuth cdecl alias "XauWriteAuth" (byval as FILE ptr, byval as Xauth ptr) as integer
declare sub XauDisposeAuth cdecl alias "XauDisposeAuth" (byval as Xauth ptr)

#define LOCK_SUCCESS 0
#define LOCK_ERROR 1
#define LOCK_TIMEOUT 2

#endif
