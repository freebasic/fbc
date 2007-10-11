''
''
'' hash -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_hash_bi__
#define __xml_hash_bi__

#include once "xmlversion.bi"
#include once "parser.bi"

type xmlHashTable as _xmlHashTable
type xmlHashTablePtr as xmlHashTable ptr
type xmlHashDeallocator as any ptr
type xmlHashCopier as any ptr
type xmlHashScanner as any ptr
type xmlHashScannerFull as any ptr

extern "c"
declare function xmlHashCreate (byval size as integer) as xmlHashTablePtr
declare sub xmlHashFree (byval table as xmlHashTablePtr, byval f as xmlHashDeallocator)
declare function xmlHashAddEntry (byval table as xmlHashTablePtr, byval name as zstring ptr, byval userdata as any ptr) as integer
declare function xmlHashUpdateEntry (byval table as xmlHashTablePtr, byval name as zstring ptr, byval userdata as any ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashAddEntry2 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval name2 as zstring ptr, byval userdata as any ptr) as integer
declare function xmlHashUpdateEntry2 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval name2 as zstring ptr, byval userdata as any ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashAddEntry3 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval name2 as zstring ptr, byval name3 as zstring ptr, byval userdata as any ptr) as integer
declare function xmlHashUpdateEntry3 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval name2 as zstring ptr, byval name3 as zstring ptr, byval userdata as any ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashRemoveEntry (byval table as xmlHashTablePtr, byval name as zstring ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashRemoveEntry2 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval name2 as zstring ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashRemoveEntry3 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval name2 as zstring ptr, byval name3 as zstring ptr, byval f as xmlHashDeallocator) as integer
declare function xmlHashLookup (byval table as xmlHashTablePtr, byval name as zstring ptr) as any ptr
declare function xmlHashLookup2 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval name2 as zstring ptr) as any ptr
declare function xmlHashLookup3 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval name2 as zstring ptr, byval name3 as zstring ptr) as any ptr
declare function xmlHashQLookup (byval table as xmlHashTablePtr, byval name as zstring ptr, byval prefix as zstring ptr) as any ptr
declare function xmlHashQLookup2 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval prefix as zstring ptr, byval name2 as zstring ptr, byval prefix2 as zstring ptr) as any ptr
declare function xmlHashQLookup3 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval prefix as zstring ptr, byval name2 as zstring ptr, byval prefix2 as zstring ptr, byval name3 as zstring ptr, byval prefix3 as zstring ptr) as any ptr
declare function xmlHashCopy (byval table as xmlHashTablePtr, byval f as xmlHashCopier) as xmlHashTablePtr
declare function xmlHashSize (byval table as xmlHashTablePtr) as integer
declare sub xmlHashScan (byval table as xmlHashTablePtr, byval f as xmlHashScanner, byval data as any ptr)
declare sub xmlHashScan3 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval name2 as zstring ptr, byval name3 as zstring ptr, byval f as xmlHashScanner, byval data as any ptr)
declare sub xmlHashScanFull (byval table as xmlHashTablePtr, byval f as xmlHashScannerFull, byval data as any ptr)
declare sub xmlHashScanFull3 (byval table as xmlHashTablePtr, byval name as zstring ptr, byval name2 as zstring ptr, byval name3 as zstring ptr, byval f as xmlHashScannerFull, byval data as any ptr)
end extern

#endif
