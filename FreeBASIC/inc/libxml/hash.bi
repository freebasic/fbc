''
''
'' hash -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __hash_bi__
#define __hash_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/parser.bi"

type xmlHashTable as _xmlHashTable
type xmlHashTablePtr as xmlHashTable ptr
type xmlHashDeallocator as any ptr
type xmlHashCopier as any ptr
type xmlHashScanner as any ptr
type xmlHashScannerFull as any ptr

declare function xmlHashCreate cdecl alias "xmlHashCreate" (byval size as integer) as xmlHashTablePtr
declare sub xmlHashFree cdecl alias "xmlHashFree" (byval table as xmlHashTablePtr, byval f as xmlHashDeallocator)
declare function xmlHashAddEntry cdecl alias "xmlHashAddEntry" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval userdata as any ptr) as integer
declare function xmlHashUpdateEntry cdecl alias "xmlHashUpdateEntry" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval userdata as any ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashAddEntry2 cdecl alias "xmlHashAddEntry2" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval name2 as xmlChar ptr, byval userdata as any ptr) as integer
declare function xmlHashUpdateEntry2 cdecl alias "xmlHashUpdateEntry2" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval name2 as xmlChar ptr, byval userdata as any ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashAddEntry3 cdecl alias "xmlHashAddEntry3" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval name2 as xmlChar ptr, byval name3 as xmlChar ptr, byval userdata as any ptr) as integer
declare function xmlHashUpdateEntry3 cdecl alias "xmlHashUpdateEntry3" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval name2 as xmlChar ptr, byval name3 as xmlChar ptr, byval userdata as any ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashRemoveEntry cdecl alias "xmlHashRemoveEntry" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashRemoveEntry2 cdecl alias "xmlHashRemoveEntry2" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval name2 as xmlChar ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashRemoveEntry3 cdecl alias "xmlHashRemoveEntry3" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval name2 as xmlChar ptr, byval name3 as xmlChar ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashLookup cdecl alias "xmlHashLookup" (byval table as xmlHashTablePtr, byval name as xmlChar ptr) as any ptr
declare function xmlHashLookup2 cdecl alias "xmlHashLookup2" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval name2 as xmlChar ptr) as any ptr
declare function xmlHashLookup3 cdecl alias "xmlHashLookup3" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval name2 as xmlChar ptr, byval name3 as xmlChar ptr) as any ptr
declare function xmlHashQLookup cdecl alias "xmlHashQLookup" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval prefix as xmlChar ptr) as any ptr
declare function xmlHashQLookup2 cdecl alias "xmlHashQLookup2" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval prefix as xmlChar ptr, byval name2 as xmlChar ptr, byval prefix2 as xmlChar ptr) as any ptr
declare function xmlHashQLookup3 cdecl alias "xmlHashQLookup3" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval prefix as xmlChar ptr, byval name2 as xmlChar ptr, byval prefix2 as xmlChar ptr, byval name3 as xmlChar ptr, byval prefix3 as xmlChar ptr) as any ptr
declare function xmlHashCopy cdecl alias "xmlHashCopy" (byval table as xmlHashTablePtr, byval f as xmlHashCopier) as xmlHashTablePtr
declare function xmlHashSize cdecl alias "xmlHashSize" (byval table as xmlHashTablePtr) as integer
declare sub xmlHashScan cdecl alias "xmlHashScan" (byval table as xmlHashTablePtr, byval f as xmlHashScanner, byval data as any ptr)
declare sub xmlHashScan3 cdecl alias "xmlHashScan3" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval name2 as xmlChar ptr, byval name3 as xmlChar ptr, byval f as xmlHashScanner, byval data as any ptr)
declare sub xmlHashScanFull cdecl alias "xmlHashScanFull" (byval table as xmlHashTablePtr, byval f as xmlHashScannerFull, byval data as any ptr)
declare sub xmlHashScanFull3 cdecl alias "xmlHashScanFull3" (byval table as xmlHashTablePtr, byval name as xmlChar ptr, byval name2 as xmlChar ptr, byval name3 as xmlChar ptr, byval f as xmlHashScannerFull, byval data as any ptr)

#endif
