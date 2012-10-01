''
''
'' gsl_block_uchar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_uchar_bi__
#define __gsl_block_uchar_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"

type gsl_block_uchar_struct
	size as integer
	data as ubyte ptr
end type

type gsl_block_uchar as gsl_block_uchar_struct

extern "c"
declare function gsl_block_uchar_alloc (byval n as integer) as gsl_block_uchar ptr
declare function gsl_block_uchar_calloc (byval n as integer) as gsl_block_uchar ptr
declare sub gsl_block_uchar_free (byval b as gsl_block_uchar ptr)
declare function gsl_block_uchar_fread (byval stream as FILE ptr, byval b as gsl_block_uchar ptr) as integer
declare function gsl_block_uchar_fwrite (byval stream as FILE ptr, byval b as gsl_block_uchar ptr) as integer
declare function gsl_block_uchar_fscanf (byval stream as FILE ptr, byval b as gsl_block_uchar ptr) as integer
declare function gsl_block_uchar_fprintf (byval stream as FILE ptr, byval b as gsl_block_uchar ptr, byval format as zstring ptr) as integer
declare function gsl_block_uchar_raw_fread (byval stream as FILE ptr, byval b as ubyte ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_uchar_raw_fwrite (byval stream as FILE ptr, byval b as ubyte ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_uchar_raw_fscanf (byval stream as FILE ptr, byval b as ubyte ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_uchar_raw_fprintf (byval stream as FILE ptr, byval b as ubyte ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_uchar_size (byval b as gsl_block_uchar ptr) as integer
declare function gsl_block_uchar_data (byval b as gsl_block_uchar ptr) as ubyte ptr
end extern

#endif
