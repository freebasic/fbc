''
''
'' libart-features -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __libart_features_bi__
#define __libart_features_bi__

#define LIBART_FEATURES_H 1
#define LIBART_MAJOR_VERSION (2)
#define LIBART_MINOR_VERSION (3)
#define LIBART_MICRO_VERSION (16)
#define LIBART_VERSION "2.3.16"

declare sub libart_preinit (byval app as any ptr, byval modinfo as any ptr)
declare sub libart_postinit (byval app as any ptr, byval modinfo as any ptr)

#endif
