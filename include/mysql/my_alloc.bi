''
''
'' my_alloc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __my_alloc_bi__
#define __my_alloc_bi__

#define ALLOC_MAX_BLOCK_TO_DROP 4096
#define ALLOC_MAX_BLOCK_USAGE_BEFORE_DROP 10

type st_used_mem
	next as st_used_mem ptr
	left as uinteger
	size as uinteger
end type

type USED_MEM as st_used_mem

type st_mem_root
	free as USED_MEM ptr
	used as USED_MEM ptr
	pre_alloc as USED_MEM ptr
	min_malloc as uinteger
	block_size as uinteger
	block_num as uinteger
	first_block_usage as uinteger
	error_handler as sub()
end type

type MEM_ROOT as st_mem_root

#endif
