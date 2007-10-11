''
''
'' secext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_secext_bi__
#define __win_secext_bi__

enum EXTENDED_NAME_FORMAT
	NameUnknown = 0
	NameFullyQualifiedDN = 1
	NameSamCompatible = 2
	NameDisplay = 3
	NameUniqueId = 6
	NameCanonical = 7
	NameUserPrincipal = 8
	NameCanonicalEx = 9
	NameServicePrincipal = 10
	NameDnsDomain = 12
end enum

#ifdef UNICODE
declare function GetComputerObjectName alias "GetComputerObjectNameW" (byval as EXTENDED_NAME_FORMAT, byval as LPWSTR, byval as PULONG) as BOOLEAN
declare function GetUserNameEx alias "GetUserNameExW" (byval as EXTENDED_NAME_FORMAT, byval as LPWSTR, byval as PULONG) as BOOLEAN
declare function TranslateName alias "TranslateNameW" (byval as LPCWSTR, byval as EXTENDED_NAME_FORMAT, byval as EXTENDED_NAME_FORMAT, byval as LPWSTR, byval as PULONG) as BOOLEAN
#else ''UNICODE
declare function GetComputerObjectName alias "GetComputerObjectNameA" (byval as EXTENDED_NAME_FORMAT, byval as LPSTR, byval as PULONG) as BOOLEAN
declare function GetUserNameEx alias "GetUserNameExA" (byval as EXTENDED_NAME_FORMAT, byval as LPSTR, byval as PULONG) as BOOLEAN
declare function TranslateName alias "TranslateNameA" (byval as LPCSTR, byval as EXTENDED_NAME_FORMAT, byval as EXTENDED_NAME_FORMAT, byval as LPSTR, byval as PULONG) as BOOLEAN
#endif ''UNICODE

#endif
