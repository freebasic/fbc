''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' intrinsic macros (RGB, BIT, ASSERT, ...)
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"


'' name, debugonly?, args, arg[0] to arg[n] names, macro text
macrodata:

''#define RGB(r,g,b) ((cuint(r) shl 16) or (cuint(g) shl 8) or cuint(b))
data "RGB", _
	 FALSE, _
	 3, "R", "G", "B", _
	 FB_DEFTOK_TYPE_TEX, "((cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") shl 16) or (cuint(", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ") shl 8) or cuint(", _
	 FB_DEFTOK_TYPE_ARG, 2, _
	 FB_DEFTOK_TYPE_TEX, "))", _
	 -1
''#define RGBA(r,g,b,a) ((cuint(r) shl 16) or (cuint(g) shl 8) or cuint(b) or (cuint(a) shl 24))
data "RGBA", FALSE, _
	 4, "R", "G", "B", "A", _
	 FB_DEFTOK_TYPE_TEX, "((cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") shl 16) or (cuint(", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ") shl 8) or cuint(", _
	 FB_DEFTOK_TYPE_ARG, 2, _
	 FB_DEFTOK_TYPE_TEX, ") or (cuint(", _
	 FB_DEFTOK_TYPE_ARG, 3, _
	 FB_DEFTOK_TYPE_TEX, ") shl 24))", _
	 -1

''#define va_arg(a,t) peek( t, a )
data "VA_ARG", _
	 FALSE, _
	 2, "A", "T", _
	 FB_DEFTOK_TYPE_TEX, "peek(", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ",", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ")", _
	 -1
''#define va_next(a,t) (a + len( t ))
data "VA_NEXT", _
	 FALSE, _
	 2, "A", "T", _
	 FB_DEFTOK_TYPE_TEX, "(cptr(", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, " ptr,", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") + 1)", _
	 -1

''#define ASSERT(e) if not (e) then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)
data "ASSERT", _
	 TRUE, _
	 1, "E", _
	 FB_DEFTOK_TYPE_TEX, "if not (", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") then fb_Assert(__FILE__, __LINE__, __FUNCTION__, ", _
	 FB_DEFTOK_TYPE_ARGSTR, 0, _
	 FB_DEFTOK_TYPE_TEX, ")", _
	 -1
''#define ASSERTWARN(e) if not (e) then fb_AssertWarn(__FILE__, __LINE__, __FUNCTION__, #e)
data "ASSERTWARN", _
	 TRUE, _
	 1, "E", _
	 FB_DEFTOK_TYPE_TEX, "if not (", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") then fb_AssertWarn(__FILE__, __LINE__, __FUNCTION__, ", _
	 FB_DEFTOK_TYPE_ARGSTR, 0, _
	 FB_DEFTOK_TYPE_TEX, ")", _
	 -1

''#define OFFSETOF(type_,field_) cint( @cptr( type_ ptr, 0 )->field_ )
data "OFFSETOF", _
	 FALSE, _
	 2, "T", "F", _
	 FB_DEFTOK_TYPE_TEX, "cint( @cptr( ", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, " ptr, 0 )->", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, " )", _
	 -1

data "__FB_MIN_VERSION__", _
     FALSE, _
     3, "MAJOR", "MINOR", "PATCH_LEVEL", _
	 FB_DEFTOK_TYPE_TEX, "((__FB_VER_MAJOR__ > (", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ")) or ((__FB_VER_MAJOR__ = (", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ")) and ((__FB_VER_MINOR__ > (", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ")) or (__FB_VER_MINOR__ = (", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ") and __FB_VER_PATCH__ >= (", _
	 FB_DEFTOK_TYPE_ARG, 2, _
	 FB_DEFTOK_TYPE_TEX, ")))))", _
	 -1

'#ifndef FB__BIGENDIAN
''#define LOWORD(x) (cuint(x) and &h0000FFFF)
data "LOWORD", _
	 FALSE, _
	 1, "X", _
	 FB_DEFTOK_TYPE_TEX, "(cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") and &h0000FFFF)", _
	 -1
''#define HIWORD(x) (cyint(x) shr 16)
data "HIWORD", _
	 FALSE, _
	 1, "X", _
	 FB_DEFTOK_TYPE_TEX, "(cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") shr 16)", _
	 -1
''#define LOBYTE(x) (cuint(x) and &h000000FF)
data "LOBYTE", _
	 FALSE, _
	 1, "X", _
	 FB_DEFTOK_TYPE_TEX, "(cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") and &h000000FF)", _
	 -1
''#define HIBYTE(x) ((cuint(x) and &h0000FF00) shr 8)
data "HIBYTE", _
	 FALSE, _
	 1, "X", _
	 FB_DEFTOK_TYPE_TEX, "((cuint(", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") and &h0000FF00) shr 8)", _
	 -1
''#define BIT(x,y) (((x) and (1 shl (y))) > 0)
data "BIT", _
	 FALSE, _
	 2, "X", "Y", _
	 FB_DEFTOK_TYPE_TEX, "(((", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") and (1 shl (", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, "))) <> 0)", _
	 -1
''#define BITSET(x,y) ((x) or (1 shl (y)))
data "BITSET", _
	 FALSE, _
	 2, "X", "Y", _
	 FB_DEFTOK_TYPE_TEX, "((", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") or (1 shl (", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ")))", _
	 -1
''#define BITRESET(x,y) ((x) and not (y))
data "BITRESET", _
	 FALSE, _
	 2, "X", "Y", _
	 FB_DEFTOK_TYPE_TEX, "((", _
	 FB_DEFTOK_TYPE_ARG, 0, _
	 FB_DEFTOK_TYPE_TEX, ") and not (1 shl (", _
	 FB_DEFTOK_TYPE_ARG, 1, _
	 FB_DEFTOK_TYPE_TEX, ")))", _
	 -1
'#endif

'' EOL
data ""

'':::::
private sub hAddIntrinsicMacros( )
	dim as integer i, args, dbgonly, typ, argnum
	dim as FBDEFARG ptr arghead, lastarg, arg
	dim as FBDEFTOK ptr tok, tokhead
	dim as string mname, aname, text

	restore macrodata
	do
		read mname
		if( len( mname ) = 0 ) then
			exit do
		end if

		read dbgonly

		arghead = NULL
		lastarg = NULL

		'' for each argument, add it
		read args
		for i = 0 to args-1
			read aname

			lastarg = symbAddDefineArg( lastarg, strptr( aname ) )

			if( arghead = NULL ) then
				arghead = lastarg
			end if
		next

		tokhead = NULL
		tok = NULL

    	do
    		read typ
    		if( typ = -1 ) then
    			exit do
    		end if

			tok = symbAddDefineTok( tok, typ )

    		select case typ
    		case FB_DEFTOK_TYPE_ARG, FB_DEFTOK_TYPE_ARGSTR
    			read symbGetDefTokArgNum( tok )

    		case FB_DEFTOK_TYPE_TEX
    			read text
    			ZstrAssign( @symbGetDefTokText( tok ), text )
    		end select

			if( tokhead = NULL ) then
				tokhead = tok
			end if

    	loop

    	'' only if debugging?
    	if( dbgonly and not env.clopt.debug ) then
    		tokhead = NULL
    	end if

        symbAddDefineMacro( strptr( mname ), tokhead, args, arghead )

	loop

end sub

'':::::
sub rtlMacroModInit( )

	hAddIntrinsicMacros( )

end sub

'':::::
sub rtlMacroModEnd( )

	'' macros will be deleted when symbEnd is called

end sub

