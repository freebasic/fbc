#pragma once

extern "C"

extern _XtQString as XrmQuark
type ConverterTable as _ConverterRec ptr ptr
declare sub _XtAddDefaultConverters(byval as ConverterTable)
declare sub _XtSetDefaultConverterTable(byval as ConverterTable ptr)
declare sub _XtFreeConverterTable(byval as ConverterTable)
declare sub _XtTableAddConverter(byval as ConverterTable, byval as XrmRepresentation, byval as XrmRepresentation, byval as XtTypeConverter, byval as XtConvertArgList, byval as Cardinal, byval as byte, byval as XtCacheType, byval as XtDestructor, byval as byte)
declare function _XtConvert(byval as Widget, byval as XrmRepresentation, byval as XrmValuePtr, byval as XrmRepresentation, byval as XrmValuePtr, byval as XtCacheRef ptr) as byte
declare sub _XtConvertInitialize()

end extern
