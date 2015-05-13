''
''
'' ResourceI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ResourceI_bi__
#define __ResourceI_bi__

declare sub _XtResourceDependencies cdecl alias "_XtResourceDependencies" (byval as WidgetClass)
declare sub _XtConstraintResDependencies cdecl alias "_XtConstraintResDependencies" (byval as ConstraintWidgetClass)
declare function _XtGetResources cdecl alias "_XtGetResources" (byval as Widget, byval as ArgList, byval as Cardinal, byval as XtTypedArgList, byval as Cardinal ptr) as XtCacheRef ptr
declare sub _XtCopyFromParent cdecl alias "_XtCopyFromParent" (byval as Widget, byval as integer, byval as XrmValue ptr)
declare sub _XtCopyToArg cdecl alias "_XtCopyToArg" (byval src as zstring ptr, byval dst as XtArgVal ptr, byval size as uinteger)
declare sub _XtCopyFromArg cdecl alias "_XtCopyFromArg" (byval src as XtArgVal, byval dst as zstring ptr, byval size as uinteger)
declare function _XtCreateIndirectionTable cdecl alias "_XtCreateIndirectionTable" (byval resources as XtResourceList, byval num_resources as Cardinal) as XrmResourceList ptr
declare sub _XtResourceListInitialize cdecl alias "_XtResourceListInitialize" ()

#endif
