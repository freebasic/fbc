''
''
'' iupcontrols -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupcontrols_bi__
#define __iupcontrols_bi__

#inclib "iupcontrols"

#include once "IUP/iupdial.bi"
#include once "IUP/iupgauge.bi"
#include once "IUP/iuptabs.bi"
#include once "IUP/iupval.bi"
#include once "IUP/iupmatrix.bi"
#include once "IUP/iuptree.bi"
#include once "IUP/iupsbox.bi"
#include once "IUP/iupmask.bi"
#include once "IUP/iupgc.bi"
#include once "IUP/iupcb.bi"
#include once "IUP/iupgetparam.bi"

declare function IupControlsOpen cdecl alias "IupControlsOpen" () as integer
declare function IupControlsClose cdecl alias "IupControlsClose" () as integer

#endif
