#ifndef _CMovie_bi_
#define _CMovie_bi_ 1

type CMovieCtx_ as CMovieCtx

type CMovie
	declare constructor( byval hwnd as HWND )
	
	declare destructor()
	
	declare function insert(  ) as BOOL
	
	declare function remove(  ) as BOOL
	
	declare function resize( byval width_ as DWORD, _
							 byval height as DWORD ) as BOOL
	
	declare function load( byval filename as wstring ptr ) as BOOL
	
	declare function play(  ) as BOOL
	
	declare function pause(  ) as BOOL
	
	declare function stop(  ) as BOOL

private:
	ctx as CMovieCtx_ ptr
end type

#endif