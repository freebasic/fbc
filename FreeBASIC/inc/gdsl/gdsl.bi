''
''
'' gdsl -- Generic Data Structures Library
''		   (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdsl_bi__
#define __gdsl_bi__

#inclib "gdsl"

#include once "gdsl_types.bi"
#include once "gdsl_macros.bi"
#include once "gdsl_list.bi"
#include once "gdsl_stack.bi"
#include once "gdsl_queue.bi"
#include once "gdsl_2darray.bi"
#include once "gdsl_bstree.bi"
#include once "gdsl_perm.bi"
#include once "gdsl_rbtree.bi"
#include once "gdsl_hash.bi"
#include once "gdsl_sort.bi"
#include once "_gdsl_list.bi"
#include once "_gdsl_bintree.bi"
#include once "_gdsl_bstree.bi"

extern "c"
declare function gdsl_get_version () as zstring ptr
end extern

#endif
