''
''
'' atk -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atk_bi__
#define __atk_bi__

#ifdef __FB_WIN32__
# pragma push(msbitfields)
#endif

extern "c" lib "atk-1.0"

#include once "atk/atkobject.bi"
#include once "atk/atkaction.bi"
#include once "atk/atkcomponent.bi"
#include once "atk/atkdocument.bi"
#include once "atk/atkeditabletext.bi"
#include once "atk/atkgobjectaccessible.bi"
#include once "atk/atkhyperlink.bi"
#include once "atk/atkhypertext.bi"
#include once "atk/atkimage.bi"
#include once "atk/atknoopobject.bi"
#include once "atk/atknoopobjectfactory.bi"
#include once "atk/atkobjectfactory.bi"
#include once "atk/atkregistry.bi"
#include once "atk/atkrelation.bi"
#include once "atk/atkrelationset.bi"
#include once "atk/atkrelationtype.bi"
#include once "atk/atkselection.bi"
#include once "atk/atkstate.bi"
#include once "atk/atkstateset.bi"
#include once "atk/atkstreamablecontent.bi"
#include once "atk/atktable.bi"
#include once "atk/atktext.bi"
#include once "atk/atkutil.bi"
#include once "atk/atkvalue.bi"

end extern

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
