''
''
'' sys\types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_linux_types_bi__
#define __crt_sys_linux_types_bi__

'' begin_include "bits/types.bi"

#include once "crt/stddef.bi"

type __u_char as ubyte
type __u_short as ushort
type __u_int as uinteger
type __u_long as uinteger
type __int8_t as byte
type __uint8_t as ubyte
type __int16_t as short
type __uint16_t as ushort
type __int32_t as integer
type __uint32_t as uinteger

type __quad_t
	__val(0 to 2-1) as integer
end type

type __u_quad_t
	__val(0 to 2-1) as __u_long
end type

type __dev_t as __u_quad_t
type __uid_t as uinteger
type __gid_t as uinteger
type __ino_t as uinteger
type __ino64_t as __u_quad_t
type __mode_t as uinteger
type __nlink_t as uinteger
type __off_t as integer
type __off64_t as __quad_t
type __pid_t as integer

type __fsid_t
	__val(0 to 2-1) as integer
end type

type __clock_t as integer
type __rlim_t as uinteger
type __rlim64_t as __u_quad_t
type __id_t as uinteger
type __time_t as integer
type __useconds_t as uinteger
type __suseconds_t as integer
type __daddr_t as integer
type __swblk_t as integer
type __key_t as integer
type __clockid_t as integer
type __timer_t as integer
type __blksize_t as integer
type __blkcnt_t as integer
type __blkcnt64_t as __quad_t
type __fsblkcnt_t as uinteger
type __fsblkcnt64_t as __u_quad_t
type __fsfilcnt_t as uinteger
type __fsfilcnt64_t as __u_quad_t
type __ssize_t as integer
type __loff_t as __off64_t
type __qaddr_t as __quad_t ptr
type __caddr_t as byte ptr
type __intptr_t as integer
type __socklen_t as uinteger

'' end_include "bits/types.bi"

type loff_t as __loff_t
type ino_t as __ino_t
type dev_t as __dev_t
type gid_t as __gid_t
type mode_t as __mode_t
type nlink_t as __nlink_t
type uid_t as __uid_t
type off_t as __off_t
type pid_t as __pid_t
type ssize_t as __ssize_t

#include once "crt/time.bi"
#include once "crt/stddef.bi"

type uint as uinteger
type int8_t as integer
type int16_t as integer
type int32_t as integer
type int64_t as integer
type u_int8_t as uinteger
type u_int16_t as uinteger
type u_int32_t as uinteger
type u_int64_t as uinteger
type register_t as integer

type blkcnt_t as __blkcnt_t
type fsblkcnt_t as __fsblkcnt_t
type fsfilcnt_t as __fsfilcnt_t

#endif
