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

#include once "iupdial.bi"
#include once "iupgauge.bi"
#include once "iuptabs.bi"
#include once "iupval.bi"
#include once "iupmatrix.bi"
#include once "iuptree.bi"
#include once "iupsbox.bi"
#include once "iupmask.bi"
#include once "iupgc.bi"
#include once "iupcb.bi"
#include once "iupgetparam.bi"

extern "c"
declare function IupControlsOpen () as integer
declare function IupControlsClose () as integer
end extern

#endif
