''
''
'' xmlautomata -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xmlautomata_bi__
#define __xml_xmlautomata_bi__

#include once "xmlversion.bi"
#include once "tree.bi"
#include once "xmlregexp.bi"

type xmlAutomata as _xmlAutomata
type xmlAutomataPtr as xmlAutomata ptr
type xmlAutomataState as _xmlAutomataState
type xmlAutomataStatePtr as xmlAutomataState ptr

extern "c"
declare function xmlNewAutomata () as xmlAutomataPtr
declare sub xmlFreeAutomata (byval am as xmlAutomataPtr)
declare function xmlAutomataGetInitState (byval am as xmlAutomataPtr) as xmlAutomataStatePtr
declare function xmlAutomataSetFinalState (byval am as xmlAutomataPtr, byval state as xmlAutomataStatePtr) as integer
declare function xmlAutomataNewState (byval am as xmlAutomataPtr) as xmlAutomataStatePtr
declare function xmlAutomataNewTransition (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewTransition2 (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval token2 as zstring ptr, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewCountTrans (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval min as integer, byval max as integer, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewCountTrans2 (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval token2 as zstring ptr, byval min as integer, byval max as integer, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewOnceTrans (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval min as integer, byval max as integer, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewOnceTrans2 (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval token2 as zstring ptr, byval min as integer, byval max as integer, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewAllTrans (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval lax as integer) as xmlAutomataStatePtr
declare function xmlAutomataNewEpsilon (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr) as xmlAutomataStatePtr
declare function xmlAutomataNewCountedTrans (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval counter as integer) as xmlAutomataStatePtr
declare function xmlAutomataNewCounterTrans (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval counter as integer) as xmlAutomataStatePtr
declare function xmlAutomataNewCounter (byval am as xmlAutomataPtr, byval min as integer, byval max as integer) as integer
declare function xmlAutomataCompile (byval am as xmlAutomataPtr) as xmlRegexpPtr
declare function xmlAutomataIsDeterminist (byval am as xmlAutomataPtr) as integer
end extern

#endif
