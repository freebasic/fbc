#ifndef NULL
#define NULL 0
#endif
#include once "COptions.bi"
#include once "fbchkdoc.bi"
#include once "funcs.bi"

using fb
using fbdoc

'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

dim as string manual_dir, def_manual_dir

if( command(1) = "" ) then
	print "usage: " & command(0) & " {filename}"
	print
	print "reads basic source or include and rewrites pretty printed to stdout"
	end 0
end if

dim filename as string = command(1)

'' read defaults from the configuration file (if it exists)
scope
	dim as COptions ptr opts = new COptions( default_optFile )
	if( opts <> NULL ) then
		manual_dir = opts->Get( "manual_dir", default_ManualDir )
		delete opts
	else
		def_manual_dir = default_ManualDir
	end if
end scope

if( manual_dir = "" ) then
	manual_dir = default_ManualDir
end if

FormatFbCodeLoadKeywords( manual_dir & "templates/default/keywords.lst" )

dim text as string = ReadFileAsText( command(1) )
if( text > "" ) then
	print FormatFbCode(text)
else
	print "Unable to read anything from '" & command(1) & "'"
end if
