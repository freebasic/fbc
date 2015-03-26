#pragma once

extern "C"

#define _XtresourceI_h
#define StringToQuark(string) XrmStringToQuark(string)
#define StringToName(string) XrmStringToName(string)
#define StringToClass(string) XrmStringToClass(string)

declare sub _XtDependencies(byval as XtResourceList ptr, byval as Cardinal ptr, byval as XrmResourceList ptr, byval as Cardinal, byval as Cardinal)
declare sub _XtResourceDependencies(byval as WidgetClass)
declare sub _XtConstraintResDependencies(byval as ConstraintWidgetClass)
declare function _XtGetResources(byval as Widget, byval as ArgList, byval as Cardinal, byval as XtTypedArgList, byval as Cardinal ptr) as XtCacheRef ptr
declare sub _XtCopyFromParent(byval as Widget, byval as long, byval as XrmValue ptr)
declare sub _XtCopyToArg(byval src as zstring ptr, byval dst as XtArgVal ptr, byval size as ulong)
declare sub _XtCopyFromArg(byval src as XtArgVal, byval dst as zstring ptr, byval size as ulong)
declare function _XtCreateIndirectionTable(byval resources as XtResourceList, byval num_resources as Cardinal) as XrmResourceList ptr
declare sub _XtResourceListInitialize()

end extern
