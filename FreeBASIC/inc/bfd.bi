''
''
'' bfd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bfd_bi__
#define __bfd_bi__

'' back-compat - always define __BFD_VER__ now
#ifdef __BFD_216__
#define __BFD_VER__ 216
#elseif defined(__BFD_217__)
#define __BFD_VER__ 217
#endif

#ifndef __BFD_VER__
#define __BFD_VER__ 217
#print bfd.bi: warning: defaulting to bfd 2.17 header: please define __BFD_VER__
#endif

#if __BFD_VER__ = 216
#include once "bfd/bfd-216.bi"
#elseif __BFD_VER__ = 217
#include once "bfd/bfd-217.bi"
#elseif __BFD_VER__ = 218
#include once "bfd/bfd-218.bi"
#else
#error unsupported __BFD_VER__
#endif

#endif
