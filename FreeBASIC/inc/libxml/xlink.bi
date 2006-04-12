''
''
'' xlink -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#define __xml_xlink_bi__
#define __xml_xlink_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"

type xlinkHRef as zstring ptr
type xlinkRole as zstring ptr
type xlinkTitle as zstring ptr

enum xlinkType
	XLINK_TYPE_NONE = 0
	XLINK_TYPE_SIMPLE
	XLINK_TYPE_EXTENDED
	XLINK_TYPE_EXTENDED_SET
end enum


enum xlinkShow
	XLINK_SHOW_NONE = 0
	XLINK_SHOW_NEW
	XLINK_SHOW_EMBED
	XLINK_SHOW_REPLACE
end enum


enum xlinkActuate
	XLINK_ACTUATE_NONE = 0
	XLINK_ACTUATE_AUTO
	XLINK_ACTUATE_ONREQUEST
end enum

type xlinkNodeDetectFunc as any ptr
type xlinkSimpleLinkFunk as any ptr
type xlinkExtendedLinkFunk as any ptr
type xlinkExtendedLinkSetFunk as any ptr
type xlinkHandler as _xlinkHandler
type xlinkHandlerPtr as xlinkHandler ptr

type _xlinkHandler
	simple as xlinkSimpleLinkFunk
	extended as xlinkExtendedLinkFunk
	set as xlinkExtendedLinkSetFunk
end type

declare function xlinkGetDefaultDetect cdecl alias "xlinkGetDefaultDetect" () as xlinkNodeDetectFunc
declare sub xlinkSetDefaultDetect cdecl alias "xlinkSetDefaultDetect" (byval func as xlinkNodeDetectFunc)
declare function xlinkGetDefaultHandler cdecl alias "xlinkGetDefaultHandler" () as xlinkHandlerPtr
declare sub xlinkSetDefaultHandler cdecl alias "xlinkSetDefaultHandler" (byval handler as xlinkHandlerPtr)
declare function xlinkIsLink cdecl alias "xlinkIsLink" (byval doc as xmlDocPtr, byval node as xmlNodePtr) as xlinkType

#endif
