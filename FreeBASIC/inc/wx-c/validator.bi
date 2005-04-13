''
''
'' validator -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __validator_bi__
#define __validator_bi__

#include once "wx-c/wx.bi"

declare function wxValidator cdecl alias "wxValidator_ctor" () as wxValidator ptr

#endif
