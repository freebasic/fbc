''
''
'' im_lib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_lib_bi__
#define __im_lib_bi__

#define IM_AUTHOR "Antonio Scuri"
#define IM_COPYRIGHT "Copyright (C) 1994-2012 Tecgraf, PUC-Rio."
#define IM_VERSION "3.8"
#define IM_VERSION_NUMBER 308000
#define IM_VERSION_DATE "2012/05/15"
#define IM_DESCRIPTION "Image Representation, Storage, Capture and Processing"
#define IM_NAME "IM - An Imaging Toolkit"

declare function imVersion cdecl alias "imVersion" () as zstring ptr
declare function imVersionDate cdecl alias "imVersionDate" () as zstring ptr
declare function imVersionNumber cdecl alias "imVersionNumber" () as integer

#endif
