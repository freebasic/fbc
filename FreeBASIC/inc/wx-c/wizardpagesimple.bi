''
''
'' wizardpagesimple -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wizardpagesimple_bi__
#define __wizardpagesimple_bi__

#include once "wx-c/wx.bi"
#include once "wx-c/wizard.bi"


declare function wxWizPageSimp cdecl alias "wxWizPageSimp_ctor" (byval parent as wxWizard ptr, byval prev as wxWizardPage ptr, byval next as wxWizardPage ptr) as wxWizardPageSimple ptr
declare sub wxWizPageSimp_Chain cdecl alias "wxWizPageSimp_Chain" (byval page1 as wxWizardPageSimple ptr, byval page2 as wxWizardPageSimple ptr)

#endif
