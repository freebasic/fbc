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
'' !!! FIXME !!! this should use cmd_opts.bas
scope
	dim as COptions ptr opts = new COptions( hardcoded.default_ini_file )
	if( opts <> NULL ) then
		manual_dir = opts->Get( "manual_dir", hardcoded.default_manual_dir )
		delete opts
	else
		manual_dir = hardcoded.default_manual_dir
	end if
end scope

FormatFbCodeLoadKeywords( manual_dir & "templates/default/keywords.lst" )

dim text as string = ReadFileAsText( command(1) )
if( text > "" ) then
	print FormatFbCode(text)
else
	print "Unable to read anything from '" & command(1) & "'"
end if
