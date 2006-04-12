''
''
'' xmlautomata -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#define __xml_xmlautomata_bi__
#define __xml_xmlautomata_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/xmlregexp.bi"

type xmlAutomata as _xmlAutomata
type xmlAutomataPtr as xmlAutomata ptr
type xmlAutomataState as _xmlAutomataState
type xmlAutomataStatePtr as xmlAutomataState ptr

declare function xmlNewAutomata cdecl alias "xmlNewAutomata" () as xmlAutomataPtr
declare sub xmlFreeAutomata cdecl alias "xmlFreeAutomata" (byval am as xmlAutomataPtr)
declare function xmlAutomataGetInitState cdecl alias "xmlAutomataGetInitState" (byval am as xmlAutomataPtr) as xmlAutomataStatePtr
declare function xmlAutomataSetFinalState cdecl alias "xmlAutomataSetFinalState" (byval am as xmlAutomataPtr, byval state as xmlAutomataStatePtr) as integer
declare function xmlAutomataNewState cdecl alias "xmlAutomataNewState" (byval am as xmlAutomataPtr) as xmlAutomataStatePtr
declare function xmlAutomataNewTransition cdecl alias "xmlAutomataNewTransition" (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewTransition2 cdecl alias "xmlAutomataNewTransition2" (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval token2 as zstring ptr, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewCountTrans cdecl alias "xmlAutomataNewCountTrans" (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval min as integer, byval max as integer, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewCountTrans2 cdecl alias "xmlAutomataNewCountTrans2" (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval token2 as zstring ptr, byval min as integer, byval max as integer, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewOnceTrans cdecl alias "xmlAutomataNewOnceTrans" (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval min as integer, byval max as integer, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewOnceTrans2 cdecl alias "xmlAutomataNewOnceTrans2" (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as zstring ptr, byval token2 as zstring ptr, byval min as integer, byval max as integer, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewAllTrans cdecl alias "xmlAutomataNewAllTrans" (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval lax as integer) as xmlAutomataStatePtr
declare function xmlAutomataNewEpsilon cdecl alias "xmlAutomataNewEpsilon" (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr) as xmlAutomataStatePtr
declare function xmlAutomataNewCountedTrans cdecl alias "xmlAutomataNewCountedTrans" (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval counter as integer) as xmlAutomataStatePtr
declare function xmlAutomataNewCounterTrans cdecl alias "xmlAutomataNewCounterTrans" (byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval counter as integer) as xmlAutomataStatePtr
declare function xmlAutomataNewCounter cdecl alias "xmlAutomataNewCounter" (byval am as xmlAutomataPtr, byval min as integer, byval max as integer) as integer
declare function xmlAutomataCompile cdecl alias "xmlAutomataCompile" (byval am as xmlAutomataPtr) as xmlRegexpPtr
declare function xmlAutomataIsDeterminist cdecl alias "xmlAutomataIsDeterminist" (byval am as xmlAutomataPtr) as integer

#endif
