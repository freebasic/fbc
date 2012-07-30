''
''
'' ConvertI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ConvertI_bi__
#define __ConvertI_bi__

type ConverterTable as _ConverterRec ptr ptr

declare sub _XtAddDefaultConverters cdecl alias "_XtAddDefaultConverters" (byval as ConverterTable)
declare sub _XtSetDefaultConverterTable cdecl alias "_XtSetDefaultConverterTable" (byval as ConverterTable ptr)
declare sub _XtFreeConverterTable cdecl alias "_XtFreeConverterTable" (byval as ConverterTable)
declare sub _XtTableAddConverter cdecl alias "_XtTableAddConverter" (byval as ConverterTable, byval as XrmRepresentation, byval as XrmRepresentation, byval as XtTypeConverter, byval as XtConvertArgList, byval as Cardinal, byval as _XtBoolean, byval as XtCacheType, byval as XtDestructor, byval as _XtBoolean)
declare function _XtConvert cdecl alias "_XtConvert" (byval as Widget, byval as XrmRepresentation, byval as XrmValuePtr, byval as XrmRepresentation, byval as XrmValuePtr, byval as XtCacheRef ptr) as Boolean
declare sub _XtConvertInitialize cdecl alias "_XtConvertInitialize" ()

#endif
