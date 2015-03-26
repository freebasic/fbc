#pragma once

#include once "crt/stdarg.bi"

extern "C"

#define _XtcreateI_h
declare function _XtCreateWidget(byval name as String_, byval widget_class as WidgetClass, byval parent as Widget, byval args as ArgList, byval num_args as Cardinal, byval typed_args as XtTypedArgList, byval num_typed_args as Cardinal) as Widget
declare function _XtCreatePopupShell(byval name as String_, byval widget_class as WidgetClass, byval parent as Widget, byval args as ArgList, byval num_args as Cardinal, byval typed_args as XtTypedArgList, byval num_typed_args as Cardinal) as Widget
declare function _XtAppCreateShell(byval name as String_, byval class as String_, byval widget_class as WidgetClass, byval display as Display ptr, byval args as ArgList, byval num_args as Cardinal, byval typed_args as XtTypedArgList, byval num_typed_args as Cardinal) as Widget
declare function _XtCreateHookObj(byval screen as Screen ptr) as Widget
declare function _XtVaOpenApplication(byval app_context_return as XtAppContext ptr, byval application_class as const zstring ptr, byval options as XrmOptionDescList, byval num_options as Cardinal, byval argc_in_out as long ptr, byval argv_in_out as String_ ptr, byval fallback_resources as String_ ptr, byval widget_class as WidgetClass, byval var_args as va_list) as Widget
declare function _XtVaAppInitialize(byval app_context_return as XtAppContext ptr, byval application_class as const zstring ptr, byval options as XrmOptionDescList, byval num_options as Cardinal, byval argc_in_out as long ptr, byval argv_in_out as String_ ptr, byval fallback_resources as String_ ptr, byval var_args as va_list) as Widget

end extern
