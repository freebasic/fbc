''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008-2022 Jeffery R. Marshall (coder[at]execulink[dot]com)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.

'' samps_wiki.bas - manage wiki example source files

'' chng: written [jeffm]

'' fbdoc headers
#include once "CWiki.bi"

'' fbchkdoc headers
#include once "funcs.bi"
#include once "samps_wiki.bi"

using fb
using fbdoc

'' -------------------------

type WikiExampleCtx
	
	wiki as CWiki ptr

	filename_token as WikiToken ptr
	example_token as WikiToken ptr
	codeid as integer
	bInExamples as integer

	declare constructor	( byval init_wiki as CWiki ptr )
	declare destructor ()
	declare sub clear_state()

	declare function FindFirst() as integer
	declare function FindNext() as integer

	declare function Find( byval codeid as integer ) as integer
	declare function Find( byref filename as string ) as integer

	declare property FileName() as string
	declare property FileName( byref new_filename as string )
	declare property Text() as string
	declare property Text( byref new_text as string )
	declare property Lang() as string
	declare property Lang( byref new_Lang as string )
end type

sub WikiExampleCtx.clear_state()
	filename_token = NULL
	example_token = NULL
	codeid = 0
	bInExamples = FALSE
end sub

constructor WikiExampleCtx ( byval init_wiki as CWiki ptr )
	wiki = init_wiki
	clear_state()
end constructor

destructor WikiExampleCtx ()
	clear_state()
end destructor
	
function WikiExampleCtx.FindNext() as integer

	dim token as WikiToken ptr
	dim as string sItem, sValue
	function = FALSE

	if( example_token = NULL ) then
		token = wiki->GetTokenList()->GetHead()
	else
		token = example_token
		token = wiki->GetTokenList()->GetNext( token )
	end if

	filename_token = NULL
	example_token = NULL

	do while( token <> NULL )

		select case as const token->id
		case WIKI_TOKEN_CODE

			'' if( bInExamples ) then
				codeid += 1
			'' end if
			
			example_token = token

			exit do

		case WIKI_TOKEN_ACTION

			if lcase(token->action->name) = "fbdoc" then

				sItem = token->action->GetParam( "item")
				sValue = token->action->GetParam( "value")

				if lcase(sItem) = "ex" then
					bInExamples = TRUE

				elseif lcase(sItem) = "filename" then
					filename_token = token

				else
					bInExamples = FALSE
				end if

			else
				bInExamples = FALSE

			end if
			
		end select
		
		token = wiki->GetTokenList()->GetNext( token )
	loop

	if( token ) then
		function = TRUE
	else
		function = FALSE
	end if

end function

function WikiExampleCtx.FindFirst() as integer
	clear_state()
	function = FindNext()
end function

property WikiExampleCtx.FileName() as string
	if( filename_token ) then
		property = filename_token->action->GetParam( "value")
	else
		property = ""
	end if
end property

property WikiExampleCtx.FileName( byref new_filename as string )
	if( filename_token ) then
		filename_token->action->SetParam( "value", new_filename )
	else
		if( example_token ) then
			wiki->insert( "{{fbdoc item=""filename"" value=""" & new_filename & """}}", example_token )
			filename_token = wiki->GetTokenList()->GetPrev( example_token )
 		end if
	end if
end property

property WikiExampleCtx.Text() as string
	if( example_token ) then
		property = example_token->text
	else
		property = ""
	end if
end property

property WikiExampleCtx.Text( byref new_text as string )
	if( example_token ) then
		example_token->text = new_text		
	end if
end property

property WikiExampleCtx.Lang() as string
	if( example_token ) then
		property = example_token->code->Lang
	else
		property = ""
	end if
end property

property WikiExampleCtx.Lang( byref new_Lang as string )
	if( example_token ) then
		example_token->code->Lang = new_Lang		
	end if
end property

'' ------------------

constructor WikiExample ( byval init_wiki as CWiki ptr )
	ctx = new WikiExampleCtx( init_wiki )
end constructor

destructor WikiExample
	delete ctx
	ctx = NULL
end destructor

function WikiExample.FindNext() as integer
	function = ctx->FindNext
end function

function WikiExample.FindFirst() as integer
	function = ctx->FindFirst
end function

property WikiExample.FileName() as string
	property = ctx->filename
end property

property WikiExample.FileName( byref new_filename as string )
	ctx->filename = new_filename
end property

property WikiExample.Text() as string
	property = ctx->Text
end property

property WikiExample.Text( byref new_text as string )
	ctx->text = new_text
end property

property WikiExample.Lang() as string
	property = ctx->Lang
end property

property WikiExample.Lang( byref new_Lang as string )
	ctx->Lang = new_Lang
end property

property WikiExample.RefID() as string
	property = ctx->wiki->pagename & "_" & str(ctx->codeid)
end property

function WikiExample.Find( byval codeid as integer ) as integer
	function = FALSE

	if( ctx->FindFirst() ) then
		do
			if( ctx->codeid = codeid ) then
				function = TRUE
				exit do
			end if
		loop while( ctx->FindNext() )
	end if

end function

function WikiExample.Find( byref sfilename as string ) as integer
	
	function = FALSE

	if( ctx->FindFirst() ) then
		do
			if( lcase(ctx->filename) = lcase(sfilename) ) then
				function = TRUE
				exit do
			end if
		loop while( ctx->FindNext() )
	end if
		
end function
