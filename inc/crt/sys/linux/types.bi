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
#include once "crt/long.bi"

type __u_char as ubyte
type __u_short as ushort
type __u_int as ulong
type __u_long as culong
type __int8_t as byte
type __uint8_t as ubyte
type __int16_t as short
type __uint16_t as ushort
type __int32_t as long
type __uint32_t as ulong
type __int64_t as longint
type __uint64_t as ulongint

type __quad_t as longint
type __u_quad_t as ulongint

type __dev_t as __u_quad_t
type __uid_t as ulong
type __gid_t as ulong
type __ino_t as culong
type __ino64_t as __u_quad_t
type __mode_t as ulong
type __nlink_t as culong
type __off_t as clong
type __off64_t as __quad_t
type __pid_t as long

type __fsid_t
	__val(0 to 2-1) as long
end type

type __clock_t as clong
type __rlim_t as culong
type __rlim64_t as __u_quad_t
type __id_t as ulong
type __time_t as clong
type __useconds_t as ulong
type __suseconds_t as clong
type __daddr_t as long
type __key_t as long
type __clockid_t as long
type __timer_t as any ptr
type __blksize_t as clong
type __blkcnt_t as clong
type __blkcnt64_t as __quad_t
type __fsblkcnt_t as culong
type __fsblkcnt64_t as __u_quad_t
type __fsfilcnt_t as culong
type __fsfilcnt64_t as __u_quad_t
type __ssize_t as integer
type __loff_t as __off64_t
type __qaddr_t as __quad_t ptr
type __caddr_t as byte ptr
type __intptr_t as integer
type __socklen_t as ulong

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
#ifndef ssize_t
type ssize_t as __ssize_t
#endif

#include once "crt/time.bi"
#include once "crt/stddef.bi"

type int8_t as byte
type int16_t as short
type int32_t as long
type int64_t as longint
type u_int8_t as ubyte
type u_int16_t as ushort
type u_int32_t as ulong
type u_int64_t as ulongint
type register_t as long

type blkcnt_t as __blkcnt_t
type fsblkcnt_t as __fsblkcnt_t
type fsfilcnt_t as __fsfilcnt_t

#endif
