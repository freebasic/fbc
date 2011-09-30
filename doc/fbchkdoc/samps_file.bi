#ifndef __SAMPS_FILE_BI__
#define __SAMPS_FILE_BI__

declare function GetRefID( byref b as buffer ) as string
declare function GetPageID( byref b as buffer ) as string
declare sub SplitRefID( byref refid as string, byref pagename as string, byref codeid as integer )
declare sub RewriteFileEOL( byref path as string, byref filename as string, byref eol as string )
declare function ReadExampleFile( byref path as string, byref filename as string, byval skipheader as integer, byval bQuiet as integer = 0 ) as string
declare function WriteExampleFile( byref sPage as string, byref path as string, byref filename as string, byref text as string, byval CompareFirst as integer, byref RefID as string ) as integer

declare function CompareBuffersEqual( byref b1 as buffer, byref b2 as buffer ) as integer

#endif
