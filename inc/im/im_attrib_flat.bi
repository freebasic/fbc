''
''
'' im_attrib_flat -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_attrib_flat_bi__
#define __im_attrib_flat_bi__

type imAttribTableCallback as function cdecl(byval as any ptr, byval as integer, byval as zstring ptr, byval as integer, byval as integer, byval as any ptr) as integer

declare function imAttribTableCreate cdecl alias "imAttribTableCreate" (byval hash_size as integer) as imAttribTablePrivate ptr
declare sub imAttribTableDestroy cdecl alias "imAttribTableDestroy" (byval ptable as imAttribTablePrivate ptr)
declare function imAttribTableCount cdecl alias "imAttribTableCount" (byval ptable as imAttribTablePrivate ptr) as integer
declare sub imAttribTableRemoveAll cdecl alias "imAttribTableRemoveAll" (byval ptable as imAttribTablePrivate ptr)
declare function imAttribTableGet cdecl alias "imAttribTableGet" (byval ptable as imAttribTablePrivate ptr, byval name as zstring ptr, byval data_type as integer ptr, byval count as integer ptr) as any ptr
declare sub imAttribTableSet cdecl alias "imAttribTableSet" (byval ptable as imAttribTablePrivate ptr, byval name as zstring ptr, byval data_type as integer, byval count as integer, byval data as any ptr)
declare sub imAttribTableUnSet cdecl alias "imAttribTableUnSet" (byval ptable as imAttribTablePrivate ptr, byval name as zstring ptr)
declare sub imAttribTableCopyFrom cdecl alias "imAttribTableCopyFrom" (byval ptable_dst as imAttribTablePrivate ptr, byval ptable_src as imAttribTablePrivate ptr)
declare sub imAttribTableMergeFrom cdecl alias "imAttribTableMergeFrom" (byval ptable_dst as imAttribTablePrivate ptr, byval ptable_src as imAttribTablePrivate ptr)
declare sub imAttribTableForEach cdecl alias "imAttribTableForEach" (byval ptable as imAttribTablePrivate ptr, byval user_data as any ptr, byval attrib_func as imAttribTableCallback)
declare function imAttribArrayCreate cdecl alias "imAttribArrayCreate" (byval hash_size as integer) as imAttribTablePrivate ptr
declare function imAttribArrayGet cdecl alias "imAttribArrayGet" (byval ptable as imAttribTablePrivate ptr, byval index as integer, byval name as zstring ptr, byval data_type as integer ptr, byval count as integer ptr) as any ptr
declare sub imAttribArraySet cdecl alias "imAttribArraySet" (byval ptable as imAttribTablePrivate ptr, byval index as integer, byval name as zstring ptr, byval data_type as integer, byval count as integer, byval data as any ptr)
declare sub imAttribArrayCopyFrom cdecl alias "imAttribArrayCopyFrom" (byval ptable_dst as imAttribTablePrivate ptr, byval ptable_src as imAttribTablePrivate ptr)

#endif
