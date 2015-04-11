'' FreeBASIC binding for mingw-w64-v4.0.1

#pragma once

#inclib "secur32"

#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "sspi.bi"
#include once "secext.bi"

#define NTLMSP_NAME_A "NTLM"
#define NTLMSP_NAME wstr("NTLM")
#define MICROSOFT_KERBEROS_NAME_A "Kerberos"
#define MICROSOFT_KERBEROS_NAME_W wstr("Kerberos")
#define MICROSOFT_KERBEROS_NAME MICROSOFT_KERBEROS_NAME_W
#define NEGOSSP_NAME_W wstr("Negotiate")
#define NEGOSSP_NAME_A "Negotiate"

#ifdef UNICODE
	#define NEGOSSP_NAME NEGOSSP_NAME_W
#else
	#define NEGOSSP_NAME NEGOSSP_NAME_A
#endif
