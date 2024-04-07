''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2022 The FreeBASIC development team.
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


'' CFbCode - fb syntax parser for document conversion
''
'' chng: jun/2006 written [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "fbdoc_defs.bi"
#include once "CFbCode.bi"
#include once "fbdoc_keywords.bi"

#include "list.bi"
#include "CFbCode.bi"

namespace fb.fbdoc

	type CFbCodeCtx_
		as CList ptr      tokenlist
		as integer        incomment
		as integer        escaped
		as integer        startofline
		as zstring ptr    text
		as integer        n
		as integer        s
		as integer        i
		as integer        inprepro
	end type

	'':::::
	constructor CFbCode _
		( _
		)

		ctx = new CFbCodeCtx
		ctx->tokenlist = new CList( 16, len( FbToken ) )
		ctx->incomment = FALSE
		ctx->escaped = FALSE
		ctx->startofline = FALSE
		ctx->text = NULL
		ctx->n = 0
		ctx->s = 0
		ctx->i = 0
		ctx->inprepro = FALSE

	end constructor

	'':::::
	private sub _FreeTokenList _
		( _
			byval ctx as CFbCodeCtx ptr _
		)
		
		dim as FbToken ptr itm, nxt

		itm = ctx->tokenlist->GetHead()
		do while( itm <> NULL )
			nxt = ctx->tokenlist->GetNext( itm )
			
			itm->text = ""

			ctx->tokenlist->Remove( itm )
			
			itm = nxt
		loop
		
	end sub

	'':::::
	destructor CFbCode _
		( _
		)
		
		if( ctx = NULL ) then
			exit destructor
		end if

		_FreeTokenList( ctx )
		delete ctx
		
	end destructor

	'':::::
	function CFbCode.NextEnum _
		( _
			byval _iter as any ptr ptr _
		) as FbToken ptr

		if( ctx = NULL ) then
			return NULL
		end if

		if( ctx->tokenlist = NULL ) then
			return NULL
		end if

		if( _iter = NULL ) then
			return NULL
		end if

		*_iter = ctx->tokenlist->GetNext(*_iter)

		if( *_iter ) then
			return cast(FbToken ptr, *_iter)
		end if

		return NULL

	end function

	'':::::
	function CFbCode.NewEnum _
		( _
			byval _iter as any ptr ptr _
		) as FbToken ptr

		if( ctx = NULL ) then
			return NULL
		end if

		if( _iter = NULL ) then
			return NULL
		end if

		if( ctx->tokenlist = NULL ) then
			return NULL
		end if

		*_iter = ctx->tokenlist->GetHead()

		if( *_iter ) then
			return cast(FbToken ptr, *_iter)
		end if

		return NULL

	end function

	'':::::
	private function PeekChar _
		( _
			byval ctx as CFbCodeCtx ptr, _
			byval x as integer = 0 _
		) as integer

		if( ctx->i + x < ctx->n ) then
			return cast( ubyte ptr, ctx->text )[ctx->i + x]
		end if

		return 0
		
	end function 

	private function ReadChar _
		( _
			byval ctx as CFbCodeCtx ptr _
		) as integer

		if( ctx->i < ctx->n ) then
			ctx->i += 1
			return cast( ubyte ptr, ctx->text )[ctx->i - 1]
		end if

		return 0
		
	end function 

	'':::::
	private function _AddToken _
		( _
			byval ctx as CFbCodeCtx ptr, _
			byval id as FB_TOKEN, _
			byval text as zstring ptr = NULL _
		) as integer
		
		dim as string k
		
		dim as FbToken ptr token = ctx->tokenlist->Insert()

		token->id = id
		
		if( text = NULL ) then
			token->text = mid( *ctx->text, ctx->s + 1, ctx->i - ctx->s)
		else
			token->text = *text
		end if
		
		token->flags = FBTOKEN_FLAGS_NONE
		if( ctx->inprepro ) then
			token->flags or= FBTOKEN_FLAGS_DEFINE
		end if

		select case id
		case FB_TOKEN_NAME, FB_TOKEN_DEFINE, FB_TOKEN_KEYWORD
			k = fbdoc_FindKeyword( token->text )
			if( len(k) > 0 ) then
				token->id = FB_TOKEN_KEYWORD
				token->text = k
			end if
		end select

		if( id = FB_TOKEN_NEWLINE ) then
			ctx->startofline = TRUE
			ctx->inprepro = FALSE
		
		elseif( id <> FB_TOKEN_SPACE ) then
			ctx->startofline = FALSE

		end if

		return TRUE
		
	end function

	'':::::
	private function _ReadSuffix _
		( _
			byval ctx as CFbCodeCtx ptr, _
			byval additional as integer = FALSE _
		) as integer

		dim as integer c

		c = PeekChar( ctx )

		if( ( c = asc("$") ) or _
			 ( c = asc("!") ) or _
			 ( c = asc("#") ) or _
			 ( c = asc("%") ) or _
			 ( c = asc("&") ) _
		) then

			c = ReadChar( ctx )
		end if

		if( additional ) then
			c = PeekChar( ctx )
			if( ( c = asc("U") ) or _
				 ( c = asc("u") ) _
			) then
				c = ReadChar( ctx )
			end if
		end if

		return TRUE

	end function

	'':::::
	private function _ReadQuoted _
		( _
			byval ctx as CFbCodeCtx ptr, _
			byval escapedonce as integer = FALSE _
		) as integer

		dim as integer c

		c = PeekChar( ctx )
		if( c <> 34 ) then
			return FALSE
		end if
		
		'' Expects Opening Quote
		c = ReadChar( ctx )

		if( escapedonce or ctx->escaped ) then

			while( ctx->i < ctx->n )
				c = ReadChar( ctx )
				if( c = asc("""") ) then
					c = PeekChar( ctx )
					if( c = asc("""") ) then
						c = ReadChar( ctx )
					else
						exit while
					end if
				elseif( c = asc("\") ) then
					c = PeekChar( ctx )
					if( c = 10 or c = 13 ) then
						exit while
					else
						c = ReadChar( ctx )
					end if
				end if
			wend 

		else
			
			while( ctx->i < ctx->n )
				c = ReadChar( ctx )
				if( c = asc("""") ) then
					if( PeekChar( ctx ) = asc("""") ) then
						c = ReadChar( ctx )
					else
						exit while
					end if
				endif
			wend

		end if

		return TRUE

	end function

	'':::::
	private function _ReadToEOL _
		( _
			byval ctx as CFbCodeCtx ptr _
		) as integer

		dim as integer c

		c = PeekChar( ctx )
		while( c )
			c = PeekChar( ctx )
			if( c = 10 or c = 13 ) then
				exit while
			elseif( c = asc("'") ) then
				c = ReadChar( ctx )
				if( ctx->incomment ) then
					if( PeekChar( ctx ) = asc("/") ) then
						c = ReadChar( ctx )
						ctx->incomment = FALSE
						exit while
					end if
				end if
			else
				c = ReadChar( ctx )
			end if
		wend

		return TRUE

	end function

	'':::::
	private function _ReadInteger _
		( _
			byval ctx as CFbCodeCtx ptr, _
			byval nskip as integer, _
			byval filterset as zstring ptr _
		) as integer

		dim as integer c

		while( nskip > 0 )
			c = ReadChar( ctx )
			nskip -= 1
		wend

		c = PeekChar( ctx )
		while( instr( *filterset, chr(c) ) > 0 )
			c = ReadChar( ctx )
			c = PeekChar( ctx )
		wend 

		return TRUE

	end function

	'':::::
	private function _ReadNumber _
		( _
			byval ctx as CFbCodeCtx ptr _
		) as integer

		dim as integer c, i=0, d = 0, f = 0

		c = PeekChar( ctx )
		if( c = asc(".") ) then
			c = ReadChar( ctx )
		  d += 1

		else
			c = PeekChar( ctx )
			while( c >= asc("0") and c <= asc("9") )
				i += 1
				c = ReadChar( ctx )
				c = PeekChar( ctx )
			wend
			if( c = asc(".") ) then
				d += 1
			end if
		end if

		if( d = 0 and i = 0 ) then
			return FALSE
		end if

		c = PeekChar( ctx )
		while( c >= asc("0") and c <= asc("9") )
			f += 1
			c = ReadChar( ctx )
			c = PeekChar( ctx )
		wend

		if( i = 0 and f = 0 ) then
			return FALSE
		end if

		c = PeekChar( ctx )
		if( c = asc("D") or c = asc("d") or c = asc("E") or c = asc("e") ) then
			c = PeekChar( ctx, 1 )
			if( c = asc("+") or c = asc("-") or ( c >= asc("0") and c <= asc("9") ) ) then
				c = ReadChar( ctx )
				c = PeekChar( ctx )
				if( c = asc("+") or c = asc("-") ) then
					c = ReadChar(ctx)
				end if
				while (c)
					c = PeekChar( ctx )
					if( c >= asc("0") and c <= asc("9") ) then
						c = ReadChar( ctx )
					else
						exit while
					end if
				wend
			end if
		end if

		return TRUE

	end function

	'':::::
	private function _ParseToken _
		( _
			byval ctx as CFbCodeCtx ptr _
		) as integer

		dim as integer c

		'' newline ?
		c = PeekChar( ctx )
		if( c = 13 or c = 10 ) then
			c = ReadChar( ctx )
			if( c = 13 ) then
				c = PeekChar( ctx )
				if( c = 10 ) then
					c = ReadChar( ctx )
				end if
			end if
			return _AddToken( ctx, FB_TOKEN_NEWLINE )
		end if

		if( ctx->incomment ) then
			_ReadToEOL( ctx )
			return _AddToken( ctx, FB_TOKEN_COMMENT )
		end if

		'' tab | space ?
		c = PeekChar( ctx )
		if( c = 9 or c = 32 ) then
			c = ReadChar( ctx )
			while ( c )
				c = PeekChar( ctx )
				if( c = 9 or c = 32 )then
					c = ReadChar( ctx )
				else
					exit while
				end if
			wend
			return _AddToken( ctx, FB_TOKEN_SPACE )
		end if

		'' '
		c = PeekChar( ctx )
		if( c = asc("'") ) then
			c = ReadChar( ctx )
			_ReadToEOL( ctx )
			return _AddToken( ctx, FB_TOKEN_COMMENT )
		end if

		'' #
		c = PeekChar( ctx )
		if( c = asc("#") and ctx->startofline ) then
			c = ReadChar( ctx )
			while( c )
				c = PeekChar( ctx )
				if( ( c = asc("_") ) or _
					 ( c >= asc("A") and c <= asc("Z") ) or _
					 ( c >= asc("a") and c <= asc("z") ) _
				) then
					c = ReadChar( ctx )
				else
					exit while
				end if
				'' _ReadToEOL( ctx )
			wend 
			ctx->inprepro = TRUE
			return _AddToken( ctx, FB_TOKEN_DEFINE )
		end if

		'' $"..." 
		c = PeekChar( ctx )
		if( c = asc("$") ) then
			if( PeekChar( ctx, 1 ) = asc("""") ) then
				c = ReadChar( ctx ) '' $
				if( _ReadQuoted( ctx, TRUE ) ) then
					return _AddToken( ctx, FB_TOKEN_QUOTED )
				end if
			end if
		end if

		'' /'
		c = PeekChar( ctx )
		if( c = asc("/") ) then
			if( PeekChar( ctx, 1 ) = asc("'") ) then
				c = ReadChar( ctx )
				c = ReadChar( ctx )
				ctx->incomment = TRUE
				_ReadToEOL( ctx )
				return _AddToken( ctx, FB_TOKEN_COMMENT )
			end if
		end if

		'' "
		c = PeekChar( ctx )
		if( c = asc("""") ) then
			if( _ReadQuoted( ctx, FALSE ) ) then
				return _AddToken( ctx, FB_TOKEN_QUOTED )
			end if
		end if

		'' Name | keyword
		c = PeekChar( ctx )
		if( c = asc("_") or _
		   ( c >= asc("A") and c <= asc("Z") ) or _
			 ( c >= asc("a") and c <= asc("z") ) _
			) then

			c = ReadChar( ctx )
			while( c )
				c = PeekChar( ctx )
				if( ( c = asc("_") ) or _
					 ( c >= asc("A") and c <= asc("Z") ) or _
					 ( c >= asc("a") and c <= asc("z") ) or _
					 ( c >= asc("0") and c <= asc("9") ) or _
					 ( c = asc(".") ) _
					) then

					c = ReadChar( ctx )

				else
					_ReadSuffix( ctx )
					exit while

				end if

			wend

			return _AddToken( ctx, FB_TOKEN_NAME )

		end if

		'' &01234 &b1234 &o1234 &h1234
		c = PeekChar( ctx )
		if( c = asc("&") ) then
			c = PeekChar( ctx, 1 )
			if( c >= asc("0") and c <= asc("7") ) then
				if( _ReadInteger( ctx, 1, "01234567" ) ) then
					_ReadSuffix( ctx, TRUE )
					return _AddToken( ctx, FB_TOKEN_NUMBER )
				end if

			elseif( c = asc("B") or c = asc("b") ) then
				if( _ReadInteger( ctx, 2, "01" ) ) then
					_ReadSuffix( ctx, TRUE )
					return _AddToken( ctx, FB_TOKEN_NUMBER )
				end if

			elseif( c = asc("O") or c = asc("o") ) then
				if( _ReadInteger( ctx, 2, "01234567" ) ) then
					_ReadSuffix( ctx, TRUE )
					return _AddToken( ctx, FB_TOKEN_NUMBER )
				end if

			elseif( c = asc("H") or c = asc("h") ) then
				if( _ReadInteger( ctx, 2, "0123456789ABCDEFabcdef" ) ) then
					_ReadSuffix( ctx, TRUE )
					return _AddToken( ctx, FB_TOKEN_NUMBER )
				end if

			end if
		end if

		'' .number
		c = PeekChar( ctx )
		if( c = asc(".") ) then
			c = PeekChar( ctx, 1 )
		  if( c >= asc("0") and c <= asc("9") ) then
				if( _ReadNumber( ctx ) ) then
					_ReadSuffix( ctx, TRUE )
					return _AddToken( ctx, FB_TOKEN_NUMBER )
				end if
			end if
		end if

		'' Number
		c = PeekChar( ctx )
	  if( c >= asc("0") and c <= asc("9") ) then
			if( _ReadNumber( ctx ) ) then
				_ReadSuffix( ctx, TRUE )
				return _AddToken( ctx, FB_TOKEN_NUMBER )
			end if
		end if

		c = ReadChar( ctx )
		return _AddToken( ctx, FB_TOKEN_OTHER )

	end function

	'':::::
	function CFbCode.Parse _
		( _
			byval text as zstring ptr _
		) as integer

		if( ctx = NULL ) then
			return FALSE
		end if

		_FreeTokenList( ctx )
		ctx->escaped = FALSE
		ctx->incomment = FALSE
		ctx->startofline = TRUE

		if( text = NULL ) then
			return FALSE
		end if

		ctx->text = text
		ctx->s = 0
		ctx->i = 0
		ctx->n = len(*text)

		while ( ctx->s < ctx->n )
			if( _ParseToken( ctx ) = FALSE ) then
				exit while
			end if
			ctx->s = ctx->i
		
		wend		

		'' Closer
		_AddToken( ctx, FB_TOKEN_NULL )

		ctx->text = NULL

		return TRUE

	end function

	'':::::
	private function _ParseLine _
		( _
			byval ctx as CFbCodeCtx ptr _
		) as integer

		dim as integer c

		'' newline ?
		c = PeekChar( ctx )
		if( c = 13 or c = 10 ) then
			c = ReadChar( ctx )
			if( c = 13 ) then
				c = PeekChar( ctx )
				if( c = 10 ) then
					c = ReadChar( ctx )
				end if
			end if
			return _AddToken( ctx, FB_TOKEN_NEWLINE )
		end if

		_ReadToEOL( ctx )
		return _AddToken( ctx, FB_TOKEN_OTHER )

	end function

	'':::::
	function CFbCode.ParseLines _
		( _
			byval text as zstring ptr _
		) as integer

		if( ctx = NULL ) then
			return FALSE
		end if

		_FreeTokenList( ctx )
		ctx->escaped = FALSE
		ctx->incomment = FALSE
		ctx->startofline = TRUE

		if( text = NULL ) then
			return FALSE
		end if

		ctx->text = text
		ctx->s = 0
		ctx->i = 0
		ctx->n = len(*text)

		while ( ctx->s < ctx->n )
			if( _ParseToken( ctx ) = FALSE ) then
				exit while
			end if
			ctx->s = ctx->i
		
		wend		

		'' Closer
		_AddToken( ctx, FB_TOKEN_NULL )

		ctx->text = NULL

		return TRUE

	end function

end namespace
