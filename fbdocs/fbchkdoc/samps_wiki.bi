#ifndef __SAMPS_WIKI_BI__
#define __SAMPS_WIKI_BI__

type WikiExampleCtx_ as WikiExampleCtx

type WikiExample
	
	declare constructor( byval init_wiki as fb.fbdoc.CWiki ptr )
	declare destructor()

	declare function FindFirst() as integer
	declare function FindNext() as integer

	declare function Find( byval codeid as integer ) as integer
	declare function Find( byref filename as string ) as integer

	declare property FileName() as string
	declare property FileName( byref new_filename as string )
	declare property Text() as string
	declare property Text( byref new_text as string )
	declare property Lang() as string
	declare property Lang( byref new_text as string )
	declare property RefID() as string

private:
	ctx as WikiExampleCtx_ ptr

end type

#endif
