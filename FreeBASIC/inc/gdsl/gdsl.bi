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

#include once "gdsl/gdsl_types.bi"
#include once "gdsl/gdsl_macros.bi"
#include once "gdsl/gdsl_list.bi"
#include once "gdsl/gdsl_stack.bi"
#include once "gdsl/gdsl_queue.bi"
#include once "gdsl/gdsl_2darray.bi"
#include once "gdsl/gdsl_bstree.bi"
#include once "gdsl/gdsl_perm.bi"
#include once "gdsl/gdsl_rbtree.bi"
#include once "gdsl/gdsl_hash.bi"
#include once "gdsl/gdsl_sort.bi"
#include once "gdsl/_gdsl_list.bi"
#include once "gdsl/_gdsl_bintree.bi"
#include once "gdsl/_gdsl_bstree.bi"

declare function gdsl_get_version cdecl alias "gdsl_get_version" () as zstring ptr

#endif
