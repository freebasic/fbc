''
''
'' Shell -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Shell_bi__
#define __Shell_bi__
extern XtShellStrings alias "XtShellStrings" as zstring * 

type ShellWidgetClass as _ShellClassRec ptr
type OverrideShellWidgetClass as _OverrideShellClassRec ptr
type WMShellWidgetClass as _WMShellClassRec ptr
type TransientShellWidgetClass as _TransientShellClassRec ptr
type TopLevelShellWidgetClass as _TopLevelShellClassRec ptr
type ApplicationShellWidgetClass as _ApplicationShellClassRec ptr
type SessionShellWidgetClass as _SessionShellClassRec ptr

#endif
