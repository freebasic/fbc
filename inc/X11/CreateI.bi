''
''
'' CreateI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CreateI_bi__
#define __CreateI_bi__

declare function _XtCreatePopupShell cdecl alias "_XtCreatePopupShell" (byval name as zstring ptr, byval widget_class as WidgetClass, byval parent as Widget, byval args as ArgList, byval num_args as Cardinal, byval typed_args as XtTypedArgList, byval num_typed_args as Cardinal) as Widget
declare function _XtAppCreateShell cdecl alias "_XtAppCreateShell" (byval name as zstring ptr, byval class as zstring ptr, byval widget_class as WidgetClass, byval display as Display ptr, byval args as ArgList, byval num_args as Cardinal, byval typed_args as XtTypedArgList, byval num_typed_args as Cardinal) as Widget
declare function _XtCreateHookObj cdecl alias "_XtCreateHookObj" (byval screen as Screen ptr) as Widget

#endif
