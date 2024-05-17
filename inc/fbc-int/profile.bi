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
	PROFILE_OPTION_REPORT_DEFAULT    = &h00000000
	PROFILE_OPTION_REPORT_CALLS      = &h00000001
	PROFILE_OPTION_REPORT_CALLTREE   = &h00000002
	PROFILE_OPTION_REPORT_RAWLIST    = &h00000004
	PROFILE_OPTION_REPORT_RAWDATA    = &h00000008
	PROFILE_OPTION_REPORT_RAWSTRINGS = &h00000010

	PROFILE_OPTION_REPORT_MASK       = &h000000FF

	PROFILE_OPTION_HIDE_HEADER       = &h00000100
	PROFILE_OPTION_HIDE_TITLES       = &h00000200
	PROFILE_OPTION_HIDE_COUNTS       = &h00000400
	PROFILE_OPTION_HIDE_TIMES        = &h00000800
	PROFILE_OPTION_HIDE_FUNCTIONS    = &h00001000
	PROFILE_OPTION_HIDE_GLOBALS      = &h00002000

	PROFILE_OPTION_SHOW_DEBUGGING    = &h01000000
	PROFILE_OPTION_GRAPHICS_CHARS    = &h02000000
end enum

extern "rtlib"
	'' -profgen fb
	declare sub ProfileInit alias "fb_InitProfile" ()
	declare function ProfileEnd alias "fb_EndProfile" ( byval errorcode as long ) as long

	declare function ProfileBeginProc alias "fb_ProfileBeginProc" ( byval procedurename as const zstring ptr ) as any ptr
	declare sub ProfileEndProc alias "fb_ProfileEndProc" ( byval procctx as any ptr )
	declare function ProfileBeginCall alias "fb_ProfileBeginCall" ( byval procedurename as const zstring ptr ) as any ptr
	declare sub ProfileEndCall alias "fb_ProfileEndCall" ( byval procctx as any ptr )

	'' -profgen cycles
	declare sub ProfileCyclesInit alias "fb_InitProfileCycles" ()
	declare function ProfileCyclesEnd alias "fb_EndProfileCycles" ( byval errorcode as long ) as long

	'' options common to all profilers
	declare function ProfileSetFileName alias "fb_ProfileSetFileName" ( byval filename as const zstring ptr ) as long
	declare function ProfileGetFileName alias "fb_ProfileGetFileName" ( byval filename as zstring ptr, byval length as long ) as long
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

#pragma push(profile, false)

namespace Profiler
	const PROFILER_MAX_PATH      = 1024
	const STRING_INFO_TB_SIZE    = 10240
	const STRING_HASH_TB_SIZE    = 997
	const PROC_MAX_CHILDREN      = 257
	const PROC_INFO_TB_SIZE      = 1024
	const PROC_HASH_TB_SIZE      = 257

	'' information about a single string
	type STRING_INFO
		as long  size
		as long  length
		as ulong hashkey
	end type

	'' block of memory to store strings
	type STRING_INFO_TB
		as ubyte data(0 to STRING_INFO_TB_SIZE-1)
		as STRING_INFO_TB ptr next
		as long bytes_used
		as long string_tb_id
	end type

	'' first block in a list of string storage blocks
	type STRING_TABLE
		as STRING_INFO_TB ptr tb
	end type

	'' block of memory for hashes
	type STRING_HASH_TB
		as STRING_INFO ptr items(0 to STRING_HASH_TB_SIZE-1)
		as STRING_HASH_TB ptr next
	end type

	'' first block of memory for hashes and associated string table
	type STRING_HASH_TABLE
		as STRING_TABLE ptr strings
		as STRING_HASH_TB ptr tb
	end type

	'' hash table for strings
	type STRING_HASH
		as STRING_HASH_TABLE ptr strings
		as STRING_HASH_TABLE ptr hash
	end type

	'' profiler global context
	'' use FB_PROFILE_LOCK()/FB_PROFILE_UNLOCK when accessing
	type FB_PROFILER_GLOBAL
		as any ptr profiler_ctx
		as STRING_TABLE strings
		as STRING_HASH_TABLE strings_hash
		as STRING_HASH_TABLE ignores_hash
		as zstring * PROFILER_MAX_PATH filename
		as zstring * 32 launch_time
		as PROFILE_OPTIONS options
	end type

	'' information about the profiler internals
	type FB_PROFILER_METRICS
		as long count_threads

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

	'' extra information about procinfo entry
	enum PROCINFO_FLAGS
		PROCINFO_FLAGS_NONE     = 0
		PROCINFO_FLAGS_MAIN     = 1
		PROCINFO_FLAGS_THREAD   = 2
		PROCINFO_FLAGS_CALLPTR  = 4
		PROCINFO_FLAGS_FOREIGN  = 8
	end enum

	'' '-profgen fb' data structure

	'' procedure call information, and hash table for child procedures
	type FB_PROCINFO
		as const zstring ptr name
		as FB_PROCINFO ptr parent
		as double start_time
		as double local_time
		as longint local_count
		as ulong hashkey
		as long proc_id
		as FB_PROCINFO ptr child(0 to PROC_MAX_CHILDREN-1)
		as FB_PROCINFO ptr next
	end type

	'' block of memory to store procedure call information records
	type FB_PROCINFO_TB
		as FB_PROCINFO procinfo(0 to PROC_INFO_TB_SIZE-1)
		as FB_PROCINFO_TB ptr next
		as long next_free
		as long proc_tb_id
	end type

	'' hash table block for procedures
	type PROC_HASH_TB
		as FB_PROCINFO ptr proc(0 to PROC_HASH_TB_SIZE-1)
		as PROC_HASH_TB ptr next
	end type

	'' array of procinfo entries and associated hash tables
	type FB_PROCARRAY
		as FB_PROCINFO ptr ptr array
		as STRING_HASH hash
		as STRING_HASH_TABLE ptr ignores
		as long length
		as long size
	end type

	'' thread profiler state
	type FB_PROFILER_THREAD
		as FB_PROCINFO ptr thread_entry
		as FB_PROCINFO ptr thread_proc
		as STRING_TABLE strings
		as STRING_HASH strings_hash
		as FB_PROCINFO_TB ptr proc_tb
		as FB_PROFILER_THREAD ptr next
		as long last_proc_id
	end type

	'' thread local storage
	type FB_PROFILECTX
		as FB_PROFILER_THREAD ptr ctx
	end type

	'' calls profiler
	'' use FB_PROFILE_LOCK()/FB_PROFILE_UNLOCK when accessing
	type FB_PROFILER_CALLS
		as FB_PROFILER_GLOBAL ptr global
		as FB_PROFILER_THREAD ptr main_thread
		as FB_PROFILER_THREAD ptr threads
		as string calltree_leader
	end type

	'' '-profgen cycles' data structure

	'' cycles profiler
	'' use FB_PROFILE_LOCK()/FB_PROFILE_UNLOCK when accessing
	type FB_PROFILER_CYCLES
		as FB_PROFILER_GLOBAL ptr global
		as double start_time
	end type

end namespace

#pragma pop(profile)

extern "rtlib"
	declare function ProfileGetGlobalProfiler alias "fb_ProfileGetGlobalProfiler" _
		() as Profiler.FB_PROFILER_GLOBAL ptr

	declare function ProfileGetCallsProfiler alias "fb_ProfileGetCallsProfiler" _
		() as Profiler.FB_PROFILER_CALLS ptr

	declare function ProfileGetCyclesProfiler alias "fb_ProfileGetCyclesProfiler" _
		() as Profiler.FB_PROFILER_CYCLES ptr

	declare sub ProfileGetCallsMetrics alias "fb_ProfileGetCallsMetrics" _
		 ( byval metrics as Profiler.FB_PROFILER_METRICS ptr )

end extern

end namespace

#endif
