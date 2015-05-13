#ifndef _INITGUID_BI
#define _INITGUID_BI

#ifndef DEFINE_GUID
#include "win/basetyps.bi"
#endif

#undef DEFINE_GUID
#define DEFINE_GUID( n, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8 ) _
	extern n alias #n as GUID : _
	dim shared n as GUID = ( l, w1, w2, { b1, b2, b3, b4, b5, b6, b7, b8 } )

#endif '' _INITGUID_BI
