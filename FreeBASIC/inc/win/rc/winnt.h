#ifndef _WINNT_H
#define _WINNT_H
#if __GNUC__ >= 3
#pragma GCC system_header
#endif

/* translate GCC target defines to MS equivalents. Keep this synchronized
   with windows.h. */
#if defined(__i686__) && !defined(_M_IX86)
#define _M_IX86 600
#elif defined(__i586__) && !defined(_M_IX86)
#define _M_IX86 500
#elif defined(__i486__) && !defined(_M_IX86)
#define _M_IX86 400
#elif defined(__i386__) && !defined(_M_IX86)
#define _M_IX86 300
#endif
#if defined(_M_IX86) && !defined(_X86_)
#define _X86_
#elif defined(_M_ALPHA) && !defined(_ALPHA_)
#define _ALPHA_
#elif defined(_M_PPC) && !defined(_PPC_)
#define _PPC_
#elif defined(_M_MRX000) && !defined(_MIPS_)
#define _MIPS_
#elif defined(_M_M68K) && !defined(_68K_)
#define _68K_
#endif

#include <winerror.h>

#endif
