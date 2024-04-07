#ifndef __SAMPS_FILE_BI__
#define __SAMPS_FILE_BI__

declare function GetRefID( byref b as buffer ) as string
declare function GetPageID( byref b as buffer ) as string
declare sub SplitRefID( byref refid as string, byref pagename as string, byref codeid as integer )
declare sub RewriteFileEOL( byref path as string, byref filename as string, byref eol as string )
declare function ReadExampleFile( byref path as string, byref filename as string, byval skipheader as integer, byval bQuiet as integer = 0 ) as string
declare function WriteExampleFile _
	( _
		byref sPage as string, _
		byref path as string, _
		byref filename as string, _
		byref text as string, _
		byval CompareFirst as integer, _
		byref RefID as string, _
		byval force as boolean, _
		byref title as string _
	) as integer

declare function CompareBuffersEqual( byref b1 as buffer, byref b2 as buffer ) as integer

#endif
