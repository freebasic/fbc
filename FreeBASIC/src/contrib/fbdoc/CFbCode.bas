''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006 Jeffery R. Marshall (coder[at]execulink.com) and
''  the FreeBASIC development team.
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


'' CFbCode - fb syntax parser for document conversion
''
'' chng: jun/2006 written [coderJeff]
''

#include once "common.bi"
#include once "CFbCode.bi"
#include once "fbdoc_keywords.bi"

#include "list.bi"
#include "CFbCode.bi"

type CFbCode_
	as TLIST          tokenlist
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
function CFbCode_New _
	( _
		byval _this as CFbCode ptr _
	) as CFbCode ptr

	dim as integer isstatic = TRUE
	
	if( _this = NULL ) then
		isstatic = FALSE
		_this = callocate( len( CFbCode ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

	listNew( @_this->tokenlist, 16, len( FbToken ), TRUE )

	function = _this

end function

'':::::
private sub CFbCode_FreeTokenList _
	( _
		byval _this as CFbCode ptr _
	)
	
	dim as FbToken ptr itm, nxt

	itm = cast( FbToken ptr, listGetHead( @_this->tokenlist ) )
	do while( itm <> NULL )
		nxt = cast( FbToken ptr, listGetNext( itm ) )
		
		itm->text = ""

		listDelNode( @_this->tokenlist, cast( any ptr, itm ) )
		
		itm = nxt
	loop
	
end sub

'':::::
sub CFbCode_Delete _
	( _
		byval _this as CFbCode ptr, _
		byval isstatic as integer _
	)
	
	if( _this = NULL ) then
		exit sub
	end if

	CFbCode_FreeTokenList _this

	if( isstatic = FALSE ) then
		deallocate( _this )
	end if

end sub

'':::::
function CFbCode_NextEnum _
	( _
		byval _iter as any ptr ptr _
	) as FbToken ptr

	if( _iter = NULL ) then
		return NULL
	end if

	if( *_iter = NULL ) then
		return NULL
	end if

	dim as FbToken ptr itm

	itm = cast( FbToken ptr, *_iter )
	itm = listGetNext( itm )

	*_iter = itm

	if( *_iter = NULL ) then
		return NULL
	end if

	function = itm
	
end function

'':::::
function CFbCode_NewEnum _
	( _
		byval _this as CFbCode ptr, _
		byval _iter as any ptr ptr _
	) as FbToken ptr

	if( _this = NULL ) then
		return NULL
	end if

	if( _iter = NULL ) then
		return NULL
	end if

	dim as FbToken ptr itm = listGetHead( @_this->tokenlist )

	if( itm = NULL ) then
		return NULL
	end if

	*_iter = itm

	function = itm

end function

'':::::
private function PeekChar _
	( _
		byval _this as CFbCode ptr, _
		byval x as integer = 0 _
	) as integer

	if( _this->i + x < _this->n ) then
		return cast( ubyte ptr, _this->text )[_this->i + x]
	end if

	return 0
	
end function 

private function ReadChar _
	( _
		byval _this as CFbCode ptr _
	) as integer

	if( _this->i < _this->n ) then
		_this->i += 1
		return cast( ubyte ptr, _this->text )[_this->i - 1]
	end if

	return 0
	
end function 

'':::::
private function _AddToken _
	( _
		byval _this as CFbCode ptr, _
		byval id as FB_TOKEN, _
		byval text as zstring ptr = NULL _
	) as integer
	
	dim as string k
	
	dim as FbToken ptr token = listNewNode( @_this->tokenlist )

	token->id = id
	
	if( text = NULL ) then
		token->text = mid( *_this->text, _this->s + 1, _this->i - _this->s)
	else
		token->text = *text
	end if
	
	token->flags = FBTOKEN_FLAGS_NONE
	if( _this->inprepro ) then
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
		_this->startofline = TRUE
		_this->inprepro = FALSE
	
	elseif( id <> FB_TOKEN_SPACE ) then
		_this->startofline = FALSE

	end if

	return TRUE
	
end function

'':::::
private function _ReadSuffix _
	( _
		byval _this as CFbCode ptr, _
		byval additional as integer = FALSE _
	) as integer

	dim as integer c

	c = PeekChar( _this )

	if( ( c = asc("$") ) or _
		 ( c = asc("!") ) or _
		 ( c = asc("#") ) or _
		 ( c = asc("%") ) or _
		 ( c = asc("&") ) _
	) then

		c = ReadChar( _this )
	end if

	if( additional ) then
		c = PeekChar( _this )
		if( ( c = asc("U") ) or _
			 ( c = asc("u") ) _
		) then
			c = ReadChar( _this )
		end if
	end if

	return TRUE

end function

'':::::
private function _ReadQuoted _
	( _
		byval _this as CFbCode ptr, _
		byval escapedonce as integer = 0 _
	) as integer

	dim as integer c

	c = PeekChar( _this )
	if( c <> 34 ) then
		return FALSE
	end if
	
	'' Expects Opening Quote
	c = ReadChar( _this )

	if( (escapedonce = TRUE) or (_this->escaped = TRUE) ) then

		while( _this->i < _this->n )
			c = ReadChar( _this )
			if( c = asc("""") ) then
				c = PeekChar( _this )
				if( c = asc("""") ) then
					c = ReadChar( _this )
				else
					exit while
				end if
			elseif( c = asc("\") ) then
				c = PeekChar( _this )
				if( c = 10 or c = 13 ) then
					exit while
				else
					c = ReadChar( _this )
				end if
			end if
		wend 

	else
		
		while( _this->i < _this->n )
			c = ReadChar( _this )
			if( c = asc("""") ) then
				if( PeekChar( _this ) = asc("""") ) then
					c = ReadChar( _this )
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
		byval _this as CFbCode ptr _
	) as integer

	dim as integer c

	c = PeekChar( _this )
	while( c )
		c = PeekChar( _this )
		if( c = 10 or c = 13 ) then
			exit while
		elseif( c = asc("'") ) then
			c = ReadChar( _this )
			if( _this->incomment = TRUE ) then
				if( PeekChar( _this ) = asc("/") ) then
					c = ReadChar( _this )
					_this->incomment = FALSE
					exit while
				end if
			end if
		else
			c = ReadChar( _this )
		end if
	wend

	return TRUE

end function

'':::::
private function _ReadInteger _
	( _
		byval _this as CFbCode ptr, _
		byval nskip as integer, _
		byval filterset as zstring ptr _
	) as integer

	dim as integer c

	while( nskip > 0 )
		c = ReadChar( _this )
		nskip -= 1
	wend

	c = PeekChar( _this )
	while( instr( *filterset, chr(c) ) > 0 )
		c = ReadChar( _this )
		c = PeekChar( _this )
	wend 

	return TRUE

end function

'':::::
private function _ReadNumber _
	( _
		byval _this as CFbCode ptr _
	) as integer

	dim as integer c, i=0, d = 0, f = 0

	c = PeekChar( _this )
	if( c = asc(".") ) then
		c = ReadChar( _this )
	  d += 1

	else
		c = PeekChar( _this )
		while( c >= asc("0") and c <= asc("9") )
			i += 1
			c = ReadChar( _this )
			c = PeekChar( _this )
		wend
		if( c = asc(".") ) then
			d += 1
		end if
	end if

	if( d = 0 and i = 0 ) then
		return FALSE
	end if

	c = PeekChar( _this )
	while( c >= asc("0") and c <= asc("9") )
		f += 1
		c = ReadChar( _this )
		c = PeekChar( _this )
	wend

	if( i = 0 and f = 0 ) then
		return FALSE
	end if

	c = PeekChar( _this )
	if( c = asc("D") or c = asc("d") or c = asc("E") or c = asc("e") ) then
		c = PeekChar( _this, 1 )
		if( c = asc("+") or c = asc("-") or ( c >= asc("0") and c <= asc("9") ) ) then
			c = ReadChar( _this )
			c = PeekChar( _this )
			if( c = asc("+") or c = asc("-") ) then
				c = ReadChar(_this)
			end if
			while (c)
				c = PeekChar( _this )
				if( c >= asc("0") and c <= asc("9") ) then
					c = ReadChar( _this )
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
		byval _this as CFbCode ptr _
	) as integer

	dim as integer c

	'' newline ?
	c = PeekChar( _this )
	if( c = 13 or c = 10 ) then
		c = ReadChar( _this )
		if( c = 13 ) then
			c = PeekChar( _this )
			if( c = 10 ) then
				c = ReadChar( _this )
			end if
		end if
		return _AddToken( _this, FB_TOKEN_NEWLINE )
	end if

	if( _this->incomment = TRUE ) then
		_ReadToEOL( _this )
		return _AddToken( _this, FB_TOKEN_COMMENT )
	end if

	'' tab | space ?
	c = PeekChar( _this )
	if( c = 9 or c = 32 ) then
		c = ReadChar( _this )
		while ( c )
			c = PeekChar( _this )
			if( c = 9 or c = 32 )then
				c = ReadChar( _this )
			else
				exit while
			end if
		wend
		return _AddToken( _this, FB_TOKEN_SPACE )
	end if

	'' '
	c = PeekChar( _this )
	if( c = asc("'") ) then
		c = ReadChar( _this )
		_ReadToEOL( _this )
		return _AddToken( _this, FB_TOKEN_COMMENT )
	end if

	'' #
	c = PeekChar( _this )
	if( c = asc("#") and _this->startofline = TRUE ) then
		c = ReadChar( _this )
		while( c )
			c = PeekChar( _this )
			if( ( c = asc("_") ) or _
				 ( c >= asc("A") and c <= asc("Z") ) or _
				 ( c >= asc("a") and c <= asc("z") ) _
			) then
				c = ReadChar( _this )
			else
				exit while
			end if
			'' _ReadToEOL( _this )
		wend 
		_this->inprepro = TRUE
		return _AddToken( _this, FB_TOKEN_DEFINE )
	end if

	'' $"..." 
	c = PeekChar( _this )
	if( c = asc("$") ) then
		if( PeekChar( _this, 1 ) = asc("""") ) then
			c = ReadChar( _this ) '' $
			if( _ReadQuoted( _this, TRUE ) ) then
				return _AddToken( _this, FB_TOKEN_QUOTED )
			end if
		end if
	end if

	'' /'
	c = PeekChar( _this )
	if( c = asc("/") ) then
		if( PeekChar( _this, 1 ) = asc("'") ) then
			c = ReadChar( _this )
			c = ReadChar( _this )
			_this->incomment = TRUE
			_ReadToEOL( _this )
			return _AddToken( _this, FB_TOKEN_COMMENT )
		end if
	end if

	'' "
	c = PeekChar( _this )
	if( c = asc("""") ) then
		if( _ReadQuoted( _this, FALSE ) ) then
			return _AddToken( _this, FB_TOKEN_QUOTED )
		end if
	end if

	'' Name | keyword
	c = PeekChar( _this )
	if( c = asc("_") or _
	   ( c >= asc("A") and c <= asc("Z") ) or _
		 ( c >= asc("a") and c <= asc("z") ) _
		) then

		c = ReadChar( _this )
		while( c )
			c = PeekChar( _this )
			if( ( c = asc("_") ) or _
				 ( c >= asc("A") and c <= asc("Z") ) or _
				 ( c >= asc("a") and c <= asc("z") ) or _
				 ( c >= asc("0") and c <= asc("9") ) or _
				 ( c = asc(".") ) _
				) then

				c = ReadChar( _this )

			else
				_ReadSuffix( _this )
				exit while

			end if

		wend

		return _AddToken( _this, FB_TOKEN_NAME )

	end if

	'' &01234 &b1234 &o1234 &h1234
	c = PeekChar( _this )
	if( c = asc("&") ) then
		c = PeekChar( _this, 1 )
		if( c >= asc("0") and c <= asc("7") ) then
			if( _ReadInteger( _this, 1, "01234567" ) ) then
				_ReadSuffix( _this, TRUE )
				return _AddToken( _this, FB_TOKEN_NUMBER )
			end if

		elseif( c = asc("B") or c = asc("b") ) then
			if( _ReadInteger( _this, 2, "01" ) ) then
				_ReadSuffix( _this, TRUE )
				return _AddToken( _this, FB_TOKEN_NUMBER )
			end if

		elseif( c = asc("O") or c = asc("o") ) then
			if( _ReadInteger( _this, 2, "01234567" ) ) then
				_ReadSuffix( _this, TRUE )
				return _AddToken( _this, FB_TOKEN_NUMBER )
			end if

		elseif( c = asc("H") or c = asc("h") ) then
			if( _ReadInteger( _this, 2, "0123456789ABCDEFabcdef" ) ) then
				_ReadSuffix( _this, TRUE )
				return _AddToken( _this, FB_TOKEN_NUMBER )
			end if

		end if
	end if

	'' .number
	c = PeekChar( _this )
	if( c = asc(".") ) then
		c = PeekChar( _this, 1 )
	  if( c >= asc("0") and c <= asc("9") ) then
			if( _ReadNumber( _this ) ) then
				_ReadSuffix( _this, TRUE )
				return _AddToken( _this, FB_TOKEN_NUMBER )
			end if
		end if
	end if

	'' Number
	c = PeekChar( _this )
  if( c >= asc("0") and c <= asc("9") ) then
		if( _ReadNumber( _this ) ) then
			_ReadSuffix( _this, TRUE )
			return _AddToken( _this, FB_TOKEN_NUMBER )
		end if
	end if

	c = ReadChar( _this )
	return _AddToken( _this, FB_TOKEN_OTHER )

end function

'':::::
function CFbCode_Parse _
	( _
		byval _this as CFbCode ptr, _
		byval text as zstring ptr _
	) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	CFbCode_FreeTokenList( _this )
	_this->escaped = FALSE
	_this->incomment = FALSE
	_this->startofline = TRUE

	if( text = NULL ) then
		return FALSE
	end if

	_this->text = text
	_this->s = 0
	_this->i = 0
	_this->n = len(*text)

	while ( _this->s < _this->n )
		if( _ParseToken( _this ) = FALSE ) then
			exit while
		end if
		_this->s = _this->i
	
	wend		

	'' Closer
	_AddToken( _this, FB_TOKEN_NULL )

	_this->text = NULL

	return TRUE

end function

'':::::
private function _ParseLine _
	( _
		byval _this as CFbCode ptr _
	) as integer

	dim as integer c

	'' newline ?
	c = PeekChar( _this )
	if( c = 13 or c = 10 ) then
		c = ReadChar( _this )
		if( c = 13 ) then
			c = PeekChar( _this )
			if( c = 10 ) then
				c = ReadChar( _this )
			end if
		end if
		return _AddToken( _this, FB_TOKEN_NEWLINE )
	end if

	_ReadToEOL( _this )
	return _AddToken( _this, FB_TOKEN_OTHER )

end function

'':::::
function CFbCode_ParseLines _
	( _
		byval _this as CFbCode ptr, _
		byval text as zstring ptr _
	) as integer

	if( _this = NULL ) then
		return FALSE
	end if

	CFbCode_FreeTokenList( _this )
	_this->escaped = FALSE
	_this->incomment = FALSE
	_this->startofline = TRUE

	if( text = NULL ) then
		return FALSE
	end if

	_this->text = text
	_this->s = 0
	_this->i = 0
	_this->n = len(*text)

	while ( _this->s < _this->n )
		if( _ParseToken( _this ) = FALSE ) then
			exit while
		end if
		_this->s = _this->i
	
	wend		

	'' Closer
	_AddToken( _this, FB_TOKEN_NULL )

	_this->text = NULL

	return TRUE

end function
