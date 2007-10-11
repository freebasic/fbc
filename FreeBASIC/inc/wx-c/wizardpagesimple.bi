''
''
'' wizardpagesimple -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_wizardpagesimple_bi__
#define __wxc_wizardpagesimple_bi__

#include once "wx.bi"
#include once "wizard.bi"


declare function wxWizPageSimp (byval parent as wxWizard ptr, byval prev as wxWizardPage ptr, byval next as wxWizardPage ptr) as wxWizardPageSimple ptr
declare sub wxWizPageSimp_Chain (byval page1 as wxWizardPageSimple ptr, byval page2 as wxWizardPageSimple ptr)

#endif
