#ifndef __FBC_INT_PROFILE_BI__
#define __FBC_INT_PROFILE_BI__

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

'' DISCLAIMER!!!
''
''   1) this header documents runtime library internals
''      and is subject to change without notice
''
'' declarations must follow ./src/rtlib/profile.c
''

namespace FBC

enum PROFGEN_ID
	PROFGEN_ID_NONE                  = 0
	PROFGEN_ID_GMON                  = 1
	PROFGEN_ID_CALLS                 = 2
	PROFGEN_ID_CYCLES                = 3
end enum

enum PROFILE_OPTIONS
	PROFILE_OPTION_REPORT_DEFAULT    = &h0000
	PROFILE_OPTION_REPORT_CALLS      = &h0001
	PROFILE_OPTION_REPORT_CALLTREE   = &h0002
	PROFILE_OPTION_REPORT_RAWLIST    = &h0004 
	PROFILE_OPTION_REPORT_RAWDATA    = &h0008
	PROFILE_OPTION_REPORT_RAWSTRINGS = &h0010

	PROFILE_OPTION_REPORT_MASK       = &h00FF

	PROFILE_OPTION_HIDE_HEADER       = &h0100
	PROFILE_OPTION_HIDE_TITLES       = &h0200
	PROFILE_OPTION_HIDE_COUNTS       = &h0400
	PROFILE_OPTION_HIDE_TIMES        = &h0800
	PROFILE_OPTION_SHOW_DEBUGGING    = &h1000
	PROFILE_OPTION_GRAPHICS_CHARS    = &h2000
end enum

extern "rtlib"
	declare sub ProfileInit alias "fb_InitProfile" ()
	declare function ProfileEnd alias "fb_EndProfile" ( byval errorcode as long ) as long
	declare function ProfileBeginCall alias "fb_ProfileBeginCall" ( byval procedurename as const zstring ptr ) as any ptr
	declare sub ProfileEndCall alias "fb_ProfileEndCall" ( byval procctx as any ptr )

	declare function ProfileSetFileName alias "fb_ProfileSetFileName" ( byval filename as const zstring ptr ) as long
	declare function ProfileGetOptions alias "fb_ProfileSetOptions" ( ) as PROFILE_OPTIONS
	declare function ProfileSetOptions alias "fb_ProfileSetOptions" ( byval options as PROFILE_OPTIONS ) as PROFILE_OPTIONS
	declare sub ProfileIgnore alias "fb_ProfileIgnore" ( byval procedurename as zstring ptr ) 
end extern

#if __FB_MT__
extern "rtlib"
	declare sub fbProfileLock alias "fb_ProfileLock" ()
	declare sub fbProfileUnlock alias "fb_ProfileUnlock" ()
end extern
#else
extern "rtlib"
	private sub fbProfileLock alias "fb_ProfileLock" ()
	end sub
	private sub fbProfileUnlock alias "fb_ProfileUnlock" ()
	end sub
end extern
#endif


'' ------------------------------------
'' PROFILER INTERNALS
'' ------------------------------------
''
'' Please Note: this may change

namespace Profiler
	const PROFILER_MAX_PATH      = 1024
	const STRING_BLOCK_TB_SIZE   = 10240
	const STRING_HASH_TB_SIZE    = 997
	const PROC_MAX_CHILDREN      = 257
	const PROC_BLOCK_SIZE        = 1024
	const PROC_HASH_TB_SIZE      = 257
	const PROFILE_MAX_PATH       = 1024

	'' information about a single string
	type STRING_INFO
		as long  size
		as long  length
		as ulong full_hash
	end type

	'' block of memory to store strings
	type STRING_BLOCK_TB
		as ubyte data(0 to STRING_BLOCK_TB_SIZE-1)
		as long bytes_used
		as long string_block_id
		as STRING_BLOCK_TB ptr next
	end type

	'' hash table for strings
	type STRING_HASH_TB
		as STRING_INFO ptr items(0 to STRING_HASH_TB_SIZE-1)
		as STRING_HASH_TB ptr next
	end type

	'' procedure call information, and hash table for child procedures
	type FB_PROCINFO
		as const zstring ptr name
		as FB_PROCINFO ptr parent
		as double time
		as double total_time
		as longint call_count
		as FB_PROCINFO ptr child(0 to PROC_MAX_CHILDREN-1)
		as FB_PROCINFO ptr next
		as ulong children
		as ulong full_hash
		as long proc_id
		as long visited
	end type

	'' block of memory to store procedure call information records
	type PROC_BLOCK_TB
		as FB_PROCINFO fbproc(0 to PROC_BLOCK_SIZE-1)
		as long next_free
		as long proc_block_id
		as PROC_BLOCK_TB ptr next
	end type

	'' hash table for procedures (by procedure name)
	type PROC_HASH_TB
		as FB_PROCINFO ptr proc(0 to PROC_HASH_TB_SIZE-1)
		as PROC_HASH_TB ptr next
	end type

	'' array of pointers to procedure call information records
	type FB_PROCARRAY
		as FB_PROCINFO ptr ptr array
		as STRING_HASH_TB ptr hash
		as long length
		as long size
	end type

	'' information about the profiler internals
	type PROFILER_METRICS
		as long inited
	
		as long string_bytes_allocated
		as long string_bytes_used
		as long string_bytes_free
		as long string_count_blocks
		as long string_count_strings
		as long string_max_len
	
		as long hash_bytes_allocated
		as long hash_count_blocks
		as long hash_count_items
		as long hash_count_slots
	
		as long procs_bytes_allocated
		as long procs_count_blocks
		as long procs_count_items
		as long procs_count_slots
	end type

	'' global profiler state
	type FB_PROFILER_STATE
		as zstring * PROFILER_MAX_PATH filename
		as zstring * 32 launch_time
		as ulong proc_id
		as PROFILE_OPTIONS options
		as STRING_BLOCK_TB ptr strings
		as STRING_HASH_TB ptr string_hash
		as STRING_HASH_TB ptr ignore_hash
		as PROC_BLOCK_TB ptr procs
		as PROFILER_METRICS ptr metrics
		as string calltree_leader
	end type

	'' thread local storage profiler state
	type FB_PROFILECTX
		as FB_PROCINFO ptr main_proc
		as FB_PROCINFO ptr cur_proc
	end type

end namespace

extern "rtlib"
	declare function ProfileGetProfiler alias "fb_ProfileGetProfiler" _
		() as Profiler.FB_PROFILER_STATE ptr

	'' TODO: this should have a profiler object ptr as first parameter
	declare function ProfileGetMetrics alias "fb_ProfileGetMetrics" _
		 ( byval refresh as long ) as Profiler.PROFILER_METRICS ptr
end extern

end namespace

#endif
