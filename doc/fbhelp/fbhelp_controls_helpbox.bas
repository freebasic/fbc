''  fbhelp - FreeBASIC help viewer
''  Copyright (C) 2006-2021 Jeffery R. Marshall (coder[at]execulink.com)

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

'' chng: jul/2006 written [coderJeff]

#include once "common.bi"
#include once "fbhelp_screen.bi"
#include once "fbhelp_controls.bi"
#include once "fbhelp_textbuffer.bi"
#include once "fbhelp_file.bi"
#include once "fbhelp_form_msgbox.bi"

#include once "crt/ctype.bi"

'' NB: Only one instance of HelpBox allowed per application

enum Attribs_Enum
	ATTRIB_DEFAULT = 0
	ATTRIB_BOLD
	ATTRIB_LINK
	ATTRIB_3
	ATTRIB_4
	ATTRIB_5
	ATTRIB_6
	ATTRIB_7
	ATTRIB_WHITE_SPACE
	ATTRIB_COMMENT
	ATTRIB_QUOTED
	ATTRIB_NUMBER
	ATTRIB_KEYWORD
	ATTRIB_DEFINE
	ATTRIB_NAME
	ATTRIB_OTHER
end enum

	type page_history_t
		isfile as integer
		pagename as string
		pagetitle as string
		leftindex as integer
		topindex as integer
		col as integer
		row as integer
	end type

	const hist_max as integer = 256

	const SCROLL_DELAY = 0.05

	dim shared hist_pages(0 to hist_max - 1) as page_history_t
	dim shared hist_head as integer
	dim shared hist_curr as integer
	dim shared hist_tail as integer


''::::: 
public function HelpBox_GetLengthOfLine _
	( _
		byval ctl as helpbox_t ptr, _
		byval row as integer _
	) as integer

	if( ctl = NULL ) then
		return 0
	end if

	if( row < 0 ) then
		return 0
	end if

	if( row >= ctl->buffer.rowcount ) then
		return 0
	end if

	dim as integer i = 0
	dim as integer j = 0
	dim as integer hide = FALSE
	dim as ubyte ptr text = ctl->buffer.rowindex[row].text
	dim as integer size = ctl->buffer.rowindex[row].size

	while( i < size )
		if( text[i] = 27 ) then
			i += 1
			if( (text[i] and &h80) <> 0 ) then
			elseif( hide = FALSE ) then
				j += 1
			end if
		elseif( text[i] = 16 ) then
			hide = TRUE
		elseif( text[i] = 29 ) then
		elseif( text[i] = 2 ) then
			hide = FALSE
		elseif( text[i] = 23 ) then
			hide = FALSE
		elseif( hide = FALSE ) then
			if( text[i] = 9 ) then
				j += 3
			else
				j += 1
			end if
		end if
		i += 1
	wend 

	return j

end function


'':::::
public function HelpBox_GenerateLinkIndex _
	( _
		byval ctl as helpbox_t ptr _
	) as integer

	dim t as textbuffer_t ptr
	dim as integer i, n = 0, row, col, size
	dim as zstring ptr text

	for row = 0 to ctl->buffer.rowcount - 1
		text = ctl->buffer.rowindex[row].text
		size = ctl->buffer.rowindex[row].size

		n = 0
		for i = 0 to size - 1
			if( text[i] = 16 ) then
				n += 1
			end if
		next i

		if( n = 0 ) then
			ctl->buffer.rowindex[row].usercount = 0
			ctl->buffer.rowindex[row].userdata = NULL
		else

			dim as integer link_start_col = -1
			dim as integer link_end_col = -1
			dim as integer link_start_index = -1
			dim as integer link_url_index = -1
			dim as integer link_anchor_index = -1
			dim as integer link_end_index = -1

			dim as helplink_t ptr links

			dim as integer hide = FALSE, escaped = FALSE

			links = reallocate( ctl->buffer.rowindex[row].userdata, sizeof( helplink_t ) * n )
			if( links = NULL ) then
				return FALSE
			end if

			ctl->buffer.rowindex[row].usercount = n
			ctl->buffer.rowindex[row].userdata = links
			
			col = 0
			n = 0

			for i = 0 to size - 1

				if( text[i] = 16 ) then

					hide = TRUE

					link_start_col = col
					link_start_index = i

					link_end_col = -1
					link_anchor_index = -1
					link_end_index = -1

				elseif( text[i] = 29 ) then

					hide = TRUE

					link_anchor_index = i

				elseif( text[i] = 2 ) then

					hide = FALSE

					link_url_index = i

				elseif( text[i] = 23 ) then

					link_end_col = col
					link_end_index = i

					if( link_start_col >= 0 ) then
						if( link_end_col >= 0 ) then
							if( link_start_index >= 0 ) then
								if( link_end_index >= 0 ) then

									if( link_anchor_index >= 0 ) then
										with links[n]
											.row = row
											.col = link_start_col
											.text = NULL
											.length = link_end_col - link_start_col
											.url = NULL
											.url_size = 0
											.anchor = text + link_anchor_index + 1
											.anchor_size = link_end_index - link_anchor_index - 1
										end with

										n += 1

									elseif( link_url_index >= 0 ) then

										with links[n]
											.row = row
											.col = link_start_col
											.text = text + link_url_index + 1
											.length = link_end_col - link_start_col
											.url = text + link_start_index + 1
											.url_size = link_url_index - link_start_index - 1
											.anchor = NULL
											.anchor_size = 0
										end with

										n += 1

									end if

								end if
							end if
						end if
					end if


					hide = FALSE

					if( n >= ctl->buffer.rowindex[row].usercount ) then
						exit for
					end if

				elseif( hide = FALSE ) then
					
					if( text[i] = 9 ) then
						col += 3

					elseif( text[i] = 27 ) then
						i += 1

						if( text[i] and &h80 = 0) then
							col += 1
						end if

					else
						col += 1

					end if

				end if

			next i

		end if

	next row

	return TRUE

end function


'':::::
private function HelpBox_FormatRaw _
	( _
		byval ctl as helpbox_t ptr, _
		byval text as zstring ptr, _
		byval size as integer, _
		byval x as integer, _
		byval w as integer _
	) as zstring ptr

	dim as integer i, j, n, ww

	static ch(0 to MAX_LINE_WIDTH) as ubyte

	ww = size - x

	if( ww < 0 ) then
		ww = 0
	end if

	if( ww > w ) then
		ww = w 
	end if

	for i = 0 to ww - 1
		ch(i) = text[x + i]
	next i

	for i = ww to w - 1
		ch(i) = 32 '' 0
	next i

	ch(w) = 0
		
	return @ch(0)

end function

'':::::
private function HelpBox_FormatText _
	( _
		byval ctl as helpbox_t ptr, _
		byval text as zstring ptr, _
		byval size as integer, _
		byval x as integer, _
		byval w as integer _
	) as zstring ptr

	dim as integer i, j, n, ww

	static ch(0 to MAX_LINE_WIDTH) as ubyte

	'' TODO: expand tabs

	ww = size - x

	if( ww < 0 ) then
		ww = 0
	end if

	if( ww > w ) then
		ww = w 
	end if

	for i = 0 to ww - 1
		ch(i) = text[x + i]
	next i

	for i = ww to w - 1
		ch(i) = 32 '' 0
	next i

	ch(w) = 0
		
	return @ch(0)

end function

'':::::
private function _LookUpAttrib( byval attrib as integer ) as integer

	static attribs(0 to 15) as integer = _
		{ _
			 7, _ '' ATTRIB_DEFAULT
			15, _ '' ATTRIB_BOLD
			10, _ '' ATTRIB_LINK
			 5, _ '' ATTRIB_3
			 5, _ '' ATTRIB_4
			 5, _ '' ATTRIB_5
			 5, _ '' ATTRIB_6
			 5, _ '' ATTRIB_7
			 7, _ '' ATTRIB_WHITE_SPACE
			 7, _ '' ATTRIB_COMMENT
			10, _ '' ATTRIB_QUOTED
			12, _ '' ATTRIB_NUMBER
			14, _ '' ATTRIB_KEYWORD
			10, _ '' ATTRIB_DEFINE
			 7, _ '' ATTRIB_NAME
			 7  _ '' ATTRIB_OTHER 
		} 

	if( screen_colormode ) then	
		return( attribs( attrib and &hf ) or (screen_bc shl 4 ))
	end if

	return screen_fc

end function

'':::::
private function HelpBox_FormatHelp _
	( _
		byval ctl as helpbox_t ptr, _
		byval text as zstring ptr, _
		byval size as integer, _
		byval x as integer, _
		byval w as integer _
	) as char_attrib_t ptr

	dim as integer i, j, attrib, prevattrib, hide, tabbed

	static ch(0 to MAX_LINE_WIDTH) as char_attrib_t

	j = 0
	i = 0
	attrib = _LookupAttrib( ATTRIB_DEFAULT )
	prevattrib = attrib
	hide = FALSE
	tabbed = 0

	while( i < size )
		if( text[i] = 27 ) then
			i += 1
			if( (text[i] and &h80) <> 0 ) then
				attrib = _LookupAttrib( text[i] and &h7f )

			elseif( hide = FALSE ) then

				if( j >= x ) then
					ch(j - x).char = text[i]
					ch(j - x).attrib = attrib
				end if
				j += 1

			end if

		elseif( text[i] = 16 ) then
			prevattrib = attrib
			hide = TRUE

		elseif( text[i] = 29 ) then

		elseif( text[i] = 2 ) then
			attrib = _LookupAttrib( ATTRIB_LINK )
			hide = FALSE

		elseif( text[i] = 23 ) then
			attrib = prevattrib
			hide = FALSE

		elseif( hide = FALSE ) then

			if( text[i] = 9 ) then
				
				tabbed = 3
				while(( j < x + w ) and (tabbed > 0))
					if( j >= x ) then
						ch(j - x).char = 32
						ch(j - x).attrib = attrib
					end if
					j += 1
					tabbed -= 1
				wend

			else

				if( j >= x ) then
					ch(j - x).char = text[i]
					ch(j - x).attrib = attrib
				end if
				j += 1

			end if

		end if

		if( j >= x + w ) then
			exit while
		end if

		i += 1
	wend 

	if( j < x ) then
		j = x
	end if

	for i = j - x to w - 1
		ch(i).char = 32
		ch(i).attrib = _LookUpAttrib( ATTRIB_DEFAULT )
	next i

	ch(w).char = 0
	ch(w).attrib = 0
		
	return @ch(0)

end function

'':::::
public sub HelpBox_Draw _
	( _
			byval ctl as helpbox_t ptr _
	)

	static as integer i, xx, yy, r

	if( ctl->style = HELPBOX_STYLE_RAW ) then

		dim as zstring ptr s

		for i = 0 to ctl->ctl.rect.h - 1

			r = ctl->topindex + i		

			if r < 0 or r >= ctl->buffer.rowcount then
				s = HelpBox_FormatRaw( ctl, NULL, 0, 0, ctl->ctl.rect.w )
			else
				s = HelpBox_FormatRaw( ctl, _
					ctl->buffer.rowindex[r].text, _
					ctl->buffer.rowindex[r].size, _
					ctl->leftindex, _
					ctl->ctl.rect.w )
			end if

			Screen_SetColor ctl->ctl.fc, ctl->ctl.bc
			Screen_DrawText ctl->ctl.rect.x, ctl->ctl.rect.y + i, s

		next i

	elseif( ctl->style = HELPBOX_STYLE_TEXT ) then

	elseif( ctl->style = HELPBOX_STYLE_HELP ) then

		dim as char_attrib_t ptr s

		for i = 0 to ctl->ctl.rect.h - 1

			r = ctl->topindex + i		

			if r < 0 or r >= ctl->buffer.rowcount then
				s = HelpBox_FormatHelp( ctl, NULL, 0, 0, ctl->ctl.rect.w )
			else
				s = HelpBox_FormatHelp( ctl, _
					ctl->buffer.rowindex[r].text, _
					ctl->buffer.rowindex[r].size, _
					ctl->leftindex, _
					ctl->ctl.rect.w )
			end if

			Screen_SetColor ctl->ctl.fc, ctl->ctl.bc
			Screen_DrawTextAttrib ctl->ctl.rect.x, ctl->ctl.rect.y + i, s, ctl->ctl.rect.w

		next i

	end if

	CtlClrRedraw( ctl )

end sub

public sub HelpBox_Update _
	( _
			byval ctl as helpbox_t ptr _
	)
		
	dim as integer bVisible = TRUE

	if( ctl->col < ctl->leftindex ) then
		bVisible = FALSE
	elseif( ctl->col >= ctl->leftindex + ctl->ctl.rect.w ) then
		bVisible = FALSE
	elseif( ctl->row < ctl->topindex ) then
		bVisible = FALSE
	elseif( ctl->row >= ctl->topindex + ctl->ctl.rect.h ) then
		bVisible = FALSE
	end if

	if( bVisible ) then
		Screen_SetCursorPos _
			( _
				ctl->ctl.rect.x + ctl->col - ctl->leftindex, _
				ctl->ctl.rect.y + ctl->row - ctl->topindex _
			)

		Screen_ShowCursor( )
	else

		Screen_HideCursor( )
	end if

	CtlClrUpdate( ctl )

end sub

#define DIRFLAG_NONE  &h0
#define DIRFLAG_LEFT  &h1
#define DIRFLAG_RIGHT &h2
#define DIRFLAG_UP	  &h4
#define DIRFLAG_DOWN  &h8
#define DIRFLAG_ALL   &hf
#define DIRFLAG_INDEX &h80

#define ADJUST_FUNC_STORE  1
#define ADJUST_FUNC_ADJUST 2

'':::::
private sub HelpBox_AdjustPosition _
	( _
		byval ctl as helpbox_t ptr, _
		byval func as integer, _
		byval dirflag as integer _
	)

	static as integer old_topindex, old_leftindex, old_row, old_col

	select case func
	case ADJUST_FUNC_STORE '' save position

		old_topindex   = ctl->topindex
		old_leftindex  = ctl->leftindex
		old_row		   = ctl->row
		old_col		   = ctl->col

	case ADJUST_FUNC_ADJUST '' Adjustments

		if( dirflag and DIRFLAG_LEFT ) then '' moving left
			if ctl->col < 0 then
				ctl->col = 0
			end if
			if ctl->leftindex < 0 then
				ctl->leftindex = 0
			end if
			if(( dirflag and DIRFLAG_INDEX ) = 0 ) then
				if ctl->leftindex > ctl->col then
					ctl->leftindex = ctl->col
				end if
			end if
		end if

		if( dirflag and DIRFLAG_RIGHT ) then '' moving right
			if ctl->col > HELPBOX_MAX_WIDTH then
				ctl->col = HELPBOX_MAX_WIDTH
			end if
			if(( dirflag and DIRFLAG_INDEX ) = 0 ) then
				if ctl->leftindex + ctl->ctl.rect.w - 1 < ctl->col then
					ctl->leftindex = ctl->col - ctl->ctl.rect.w + 1
				end if
			else
				if( ctl->leftindex + ctl->ctl.rect.w > HELPBOX_MAX_WIDTH ) then
					ctl->leftindex = HELPBOX_MAX_WIDTH - ctl->ctl.rect.w
					if( ctl->leftindex < 0 ) then
						ctl->leftindex = 0
					end if
				end if
			end if
		end if

		if( dirflag and DIRFLAG_UP ) then '' moving up
			if ctl->row < 0 then
				ctl->row = 0
			end if
			if ctl->topindex < 0 then
				ctl->topindex = 0
			end if
			if(( dirflag and DIRFLAG_INDEX ) = 0 ) then
				if ctl->topindex > ctl->row then
					ctl->topindex = ctl->row
				end if
			end if
		end if

		if( dirflag and DIRFLAG_DOWN ) then '' moving down
			if ctl->row > ctl->buffer.rowcount then
				ctl->row = ctl->buffer.rowcount
			end if
			if(( dirflag and DIRFLAG_INDEX ) = 0 ) then
				if ctl->topindex < ctl->row - ctl->ctl.rect.h + 1 then
					ctl->topindex = ctl->row - ctl->ctl.rect.h + 1
				end if
			else
				if( ctl->topindex > ctl->buffer.rowcount - ctl->ctl.rect.h + 1) then
					ctl->topindex = ctl->buffer.rowcount - ctl->ctl.rect.h + 1
					if( ctl->topindex < 0 ) then
						ctl->topindex = 0
					end if
				end if
			end if
		end if
		
		if( old_topindex <> ctl->topindex ) then
			ScrollBar_SetValue( ctl->vscroll, ctl->topindex )
			CtlSetRedraw( ctl )
		elseif( old_leftindex <> ctl->leftindex ) then
			CtlSetRedraw( ctl )
		end if

		if( old_row <> ctl->row ) then
			CtlSetUpdate( ctl )
		elseif( old_col <> ctl->col ) then
			CtlSetUpdate( ctl )
		end if

	end select


end sub

'':::::
public sub HelpBox_SetPosition _
	( _
		byval ctl as helpbox_t ptr, _
		byval col as integer, _
		byval row as integer _
	)

	HelpBox_AdjustPosition ctl, ADJUST_FUNC_STORE, DIRFLAG_NONE
	ctl->col = col
	ctl->row = row
	HelpBox_AdjustPosition ctl, ADJUST_FUNC_ADJUST, DIRFLAG_ALL

end sub

'':::::
public sub HelpBox_SetScrollIndex _
	( _
		byval ctl as helpbox_t ptr, _
		byval leftindex as integer, _
		byval topindex as integer _
	)

	HelpBox_AdjustPosition ctl, ADJUST_FUNC_STORE, DIRFLAG_NONE
	ctl->leftindex = leftindex
	ctl->topindex = topindex
	HelpBox_AdjustPosition ctl, ADJUST_FUNC_ADJUST, DIRFLAG_ALL or DIRFLAG_INDEX

end sub

'':::::
public function HelpBox_KeyInput _
	( _
		byval ctl as helpbox_t ptr, _
		byval key as zstring ptr _
	) as integer
	
	static as integer dirflag

	if( key = NULL ) then
		return FALSE
	end if

	if( len( *key ) = 0 ) then
		return FALSE
	end if

	dirflag = 0

	HelpBox_AdjustPosition ctl, ADJUST_FUNC_STORE, dirflag

	select case *key
	case chr(255, 75) '' left
		ctl->col -= 1
		dirflag = DIRFLAG_LEFT

	case chr(255, 77) '' right
		ctl->col += 1
		dirflag = DIRFLAG_RIGHT

	case chr(255, 72) '' up
		ctl->row -= 1
		dirflag = DIRFLAG_UP

	case chr(255, 80) '' down
		ctl->row += 1
		dirflag = DIRFLAG_DOWN

	case chr(255, 73) '' pageup 
		ctl->row -= ctl->ctl.rect.h
		ctl->topindex -= ctl->ctl.rect.h
		dirflag = DIRFLAG_UP

	case chr(255, 81) '' pagedn
		ctl->row += ctl->ctl.rect.h
		if( ctl->topindex + ctl->ctl.rect.h < ctl->buffer.rowcount ) then
			ctl->topindex += ctl->ctl.rect.h
		end if
		dirflag = DIRFLAG_DOWN

	case chr(255, 71) '' home
		ctl->col = 0
		dirflag = DIRFLAG_LEFT

	case chr(255, 79) '' end
		ctl->col = HelpBox_GetLengthOfLine( ctl, ctl->row )
		dirflag = DIRFLAG_RIGHT

	case chr(255, 132) '' ctrl + pageup
		ctl->col -= ctl->ctl.rect.w
		ctl->leftindex -= ctl->ctl.rect.w
		dirflag = DIRFLAG_LEFT

	case chr(255, 118) '' ctrl + pagedn
		ctl->col += ctl->ctl.rect.w
		ctl->leftindex += ctl->ctl.rect.w
		dirflag = DIRFLAG_RIGHT

	case chr(255, 119) '' ctrl + home
		ctl->col = 0
		ctl->row = 0
		dirflag = DIRFLAG_LEFT or DIRFLAG_UP

	case chr(255, 117) '' ctrl + end
		ctl->col = 0
		ctl->row = ctl->buffer.rowcount
		dirflag = DIRFLAG_LEFT or DIRFLAG_DOWN

	case chr(6), chr(255,116)		'' ctrl+f
		HelpBox_NavigateForward( ctl )

	case chr(8), chr(255,115), chr(255, 83)	'' backspace & ctrl + h / ctrl+left / del
		HelpBox_NavigateBack( ctl )

	case chr(13)		'' enter
		HelpBox_NavigateLink( ctl )

	case chr(9)			'' tab
		HelpBox_NavigateNextLink( ctl, 0 )

	case chr(255, 15)   '' shift + tab
		HelpBox_NavigatePrevLink( ctl, 0 )

	case chr(33) to chr(126)
		HelpBox_NavigateNextLink( ctl, asc(*key) )

	case else
		return FALSE

	end select

	HelpBox_AdjustPosition ctl, ADJUST_FUNC_ADJUST, dirflag

	return TRUE

end function


'':::::
public function HelpBox_GetUrlFromPosition _
	( _
		byval ctl as helpbox_t ptr, _
		byval col as integer, _
		byval row as integer _
	) as string

	if( ctl = NULL ) then
		return ""
	end if

	'if( ctl->buffer = NULL ) then
	'	return ""
	'end if

	if( ctl->buffer.rowindex = NULL ) then
		return ""
	end if

	if( row < 0 ) then 
		return ""
	end if

	if( row >= ctl->buffer.rowcount ) then
		return ""
	end if

	if( col < 0 ) then
		return ""
	end if

	if( ctl->buffer.rowindex[row].usercount <= 0 ) then
		return ""
	end if

	dim as integer i
	dim as helplink_t ptr link

	for i = 0 to ctl->buffer.rowindex[row].usercount - 1

		link = cast(helplink_t ptr, ctl->buffer.rowindex[row].userdata)

		if( link ) then
			link += i
			if( link->url ) then
				if( link->url_size > 0 ) then
					if( col >= link->col ) then
						if( col < link->col + link->length ) then
							return left( *link->url, link->url_size )
						end if					
					end if
				end if
			end if
		end if
	next i

	return ""

end function

'':::::
public function HelpBox_SetNextUrlPosition _
	( _
		byval ctl as helpbox_t ptr, _
		byval char as integer, _
		byval target as zstring ptr _
	) as integer

	if( ctl = NULL ) then
		return FALSE
	end if

	if( ctl->buffer.rowindex = NULL ) then
		return FALSE
	end if

	dim as integer row, col, i, j, ch
	dim as helplink_t ptr link

	col = ctl->col
	for row = ctl->row to ctl->buffer.rowcount - 1
		if( ctl->buffer.rowindex[row].usercount > 0 ) then
			for i = 0 to ctl->buffer.rowindex[row].usercount - 1
				link = cast(helplink_t ptr, ctl->buffer.rowindex[row].userdata)
				if( link ) then
					link += i
					if( target <> NULL ) then
						if( link->anchor ) then
							if( link->anchor_size > 0 ) then
								if( lcase( left( *link->anchor, link->anchor_size )) = lcase(*target) ) then
									HelpBox_SetPosition( ctl, link->col, row )
									HelpBox_SetScrollIndex( ctl, ctl->leftindex, row )
									return TRUE
								end if
							end if
						end if
					else
						if( link->url ) then
							if( link->url_size > 0 ) then
								if( link->col > col ) then
									ch = link->text[0]
									if( (char = 0) or ( toupper(char) = toupper(ch)) ) then
										HelpBox_SetPosition( ctl, link->col, row )
										return TRUE
									end if
								end if
							end if
						end if
					end if
				end if
			next i
		end if

		col = -1

	next row

	for row = 0 to ctl->row - 1
		if( ctl->buffer.rowindex[row].usercount > 0 ) then
			for i = 0 to ctl->buffer.rowindex[row].usercount - 1
				link = cast(helplink_t ptr, ctl->buffer.rowindex[row].userdata)
				if( link ) then
					link += i
					if( target <> NULL ) then
						if( link->anchor ) then
							if( link->anchor_size > 0 ) then
								if( lcase( left( *link->anchor, link->anchor_size )) = lcase(*target) ) then
									HelpBox_SetPosition( ctl, link->col, row )
									return TRUE
								end if
							end if
						end if
					else
						if( link->url ) then
							if( link->url_size > 0 ) then
								ch = link->text[0]
								if( (char = 0) or ( toupper(char) = toupper(ch)) ) then
									HelpBox_SetPosition( ctl, link->col, row )
									return TRUE
								end if
							end if
						end if
					end if
				end if
			next i
		end if
	next row


	return FALSE

end function

'':::::
public function HelpBox_SetPrevUrlPosition _
	( _
		byval ctl as helpbox_t ptr, _
		byval char as integer _
	) as integer

	if( ctl = NULL ) then
		return FALSE
	end if

	if( ctl->buffer.rowindex = NULL ) then
		return FALSE
	end if

	dim as integer row, col, i, j, ch
	dim as helplink_t ptr link

	col = ctl->col
	for row = ctl->row to 0 step - 1
		if( ctl->buffer.rowindex[row].usercount > 0 ) then
			for i = ctl->buffer.rowindex[row].usercount - 1 to 0 step - 1
				link = cast(helplink_t ptr, ctl->buffer.rowindex[row].userdata)
				if( link ) then
					link += i
					if( link->url ) then
						if( link->url_size > 0 ) then
							if( link->col < col ) then
								ch = link->text[0]
								if( (char = 0) or ( toupper(char) = toupper(ch)) ) then
									HelpBox_SetPosition( ctl, link->col, row )
									return TRUE
								end if
							end if
						end if
					end if
				end if
			next i
		end if
		col = HELPBOX_MAX_WIDTH
	next row

	for row = ctl->buffer.rowcount - 1 to ctl->row step - 1
		if( ctl->buffer.rowindex[row].usercount > 0 ) then
			for i = ctl->buffer.rowindex[row].usercount - 1 to 0 step - 1
				link = cast(helplink_t ptr, ctl->buffer.rowindex[row].userdata) 
				if( link ) then
					link += i
					if( link->url ) then
						if( link->url_size > 0 ) then
							ch = link->text[0]
							if( (char = 0) or ( toupper(char) = toupper(ch)) ) then
								HelpBox_SetPosition( ctl, link->col, row )
								return TRUE
							end if
						end if
					end if
				end if
			next i
		end if
	next row

	return FALSE

end function



'':::::
private function _LoadHelpPage _
	( _
		byval ctl as helpbox_t ptr, _
		byval pagename as zstring ptr, _
		byval isfile as integer, _
		byval hist as page_history_t ptr _
	) as integer

	dim as integer size, bOK = FALSE

	if( pagename <> NULL ) then
		if( isfile <> 0 ) then
			if( TextBuffer_LoadTextFile(  @ctl->buffer, *pagename) ) then
				bOK = TRUE
			end if
		else
			size = HelpFile_SeekPage( pagename )
			if( size >= 0 ) then
				if( TextBuffer_Resize(  @ctl->buffer, size ) ) then
					if( HelpFile_Read( ctl->buffer.text, size ) <> 0 ) then
						bOK = TRUE
					end if
				end if
			end if
		end if
		if( bOK ) then
			ctl->style = HELPBOX_STYLE_HELP
			TextBuffer_GenerateRowIndex @ctl->buffer, 0, TRUE
			HelpBox_GenerateLinkIndex ctl
			ctl->isFile = isFile
			ctl->pagename = *pagename
			ctl->pagetitle = *pagename '' TODO : Get title from loaded file
			ctl->topindex = 0
			ctl->leftindex = 0
			ctl->row = 0
			ctl->col = 0

			ScrollBar_SetLimits( ctl->vscroll, 0, ctl->buffer.rowcount - ctl->ctl.rect.h + 1 )
			ScrollBar_SetValue(  ctl->vscroll, ctl->topindex )

			return TRUE
		end if
	end if

	if( hist <> NULL ) then
		if( hist->isfile <> 0 ) then
			if( TextBuffer_LoadTextFile(  @ctl->buffer, hist->pagename ) ) then
				bOK = TRUE
			end if
		else
			size = HelpFile_SeekPage( hist->pagename )
			if( size >= 0 ) then
				if( TextBuffer_Resize(  @ctl->buffer, size ) ) then
					if( HelpFile_Read( ctl->buffer.text, size ) <> 0 ) then
						bOK = TRUE
					end if
				end if
			end if
		end if
		if( bOK ) then
			ctl->style = HELPBOX_STYLE_HELP
			TextBuffer_GenerateRowIndex @ctl->buffer, 0, TRUE
			HelpBox_GenerateLinkIndex ctl
			ctl->isFile = hist->isFile
			ctl->pagename = hist->pagename
			ctl->pagetitle = hist->pagetitle
			ctl->topindex = hist->topindex
			ctl->leftindex = hist->leftindex
			ctl->row = hist->row
			ctl->col = hist->col

			ScrollBar_SetLimits( ctl->vscroll, 0, ctl->buffer.rowcount - ctl->ctl.rect.h + 1 )
			ScrollBar_SetValue(  ctl->vscroll, ctl->topindex )


			return TRUE
		end if
	end if

	return FALSE
	
end function

'':::::
private sub _SavePageProps ( byval ctl as helpbox_t ptr )

	with hist_pages( hist_curr )
		.isFile = ctl->isFile
		.pagename = ctl->pagename
		.pagetitle = ctl->pagetitle
		.leftindex = ctl->leftindex
		.topindex = ctl->topindex
		.col = ctl->col
		.row = ctl->row
	end with

end sub

'':::::
public function HelpBox_NavigateBack ( byval ctl as helpbox_t ptr ) as integer
	
	if( hist_curr <> hist_head ) then
		
		_SavePageProps ( ctl )

		hist_curr -= 1
		hist_curr += hist_max
		hist_curr mod = hist_max

		_LoadHelpPage( ctl, NULL, 0, @hist_pages( hist_curr ) )

		CtlSetRedraw( ctl )

		return TRUE
		
	end if

	return FALSE

end function

'':::::
public sub HelpBox_NavigateForward ( byval ctl as helpbox_t ptr )
	
	if( hist_curr <> hist_tail ) then
		
		_SavePageProps ( ctl )
		
		hist_curr += 1
		hist_curr mod = hist_max

		_LoadHelpPage( ctl, NULL, 0, @hist_pages( hist_curr ) )

		CtlSetRedraw( ctl )

	end if

end sub

'':::::
public sub HelpBox_NavigateToPage _
	( _
		byval ctl as helpbox_t ptr, _
		byval pagename as zstring ptr, _
		byval isFile as integer _
	)

	_SavePageProps ( ctl )
	
	
	if( instr( *pagename, "://" ) > 0 ) then
		msgbox_show( "Internet Link:" + chr(10) + chr(10) + *pagename, NULL, 1, "OK" )

	elseif( _LoadHelpPage( ctl, pagename, isFile, NULL )) then

		hist_tail = hist_curr
		
		hist_tail += 1
		hist_tail mod= hist_max

		if( hist_tail = hist_head ) then
			hist_head += 1
			hist_head mod= hist_max
		end if

		hist_curr = hist_tail

		_SavePageProps ( ctl )

	else
		msgbox_show( "Page not found:" + chr(10) + chr(10) + *pagename, NULL, 1, "OK" )

	end if

	CtlSetRedraw( ctl )

end sub

'':::::
public sub HelpBox_NavigateLink ( byval ctl as helpbox_t ptr )
	dim tmp as string
	tmp = HelpBox_GetUrlFromPosition( ctl, ctl->col, ctl->row )
	if( tmp > "" ) then
		if(left(tmp, 1) = "#") then
			HelpBox_SetNextUrlPosition( ctl, 0, mid(tmp,2) )		
		elseif(left(tmp, 1) = "*") then
			HelpBox_NavigateToPage ctl, FixPath( exePath ) + mid(tmp,2), TRUE
		else
			HelpBox_NavigateToPage ctl, tmp, FALSE
		end if
	end if

end sub

'':::::
public sub HelpBox_NavigateNextLink( byval ctl as helpbox_t ptr, byval char as integer )
	HelpBox_SetNextUrlPosition( ctl, char, NULL )
end sub

'':::::
public sub HelpBox_NavigatePrevLink( byval ctl as helpbox_t ptr, byval char as integer )
	HelpBox_SetPrevUrlPosition( ctl, char )
end sub


'':::::
public sub HelpBox_ClearHistory( byval ctl as helpbox_t ptr )

	hist_head = 0
	hist_tail = 0
	hist_curr = 0

	with hist_pages( hist_curr )
		.isfile = FALSE
		.pagename = ""
		.pagetitle = ""
		.leftindex = 0
		.topindex = 0
		.col = 0
		.row = 0
	end with

end sub


'':::::
public function HelpBox_Default_Handler _
	( _
		byval ctl_in as control_t ptr, _
		byval msg as message_t ptr _
	) as integer

	dim ctl as helpbox_t ptr = cast( helpbox_t ptr, ctl_in )

	static as integer cap_col, cap_row, col, row
	static as double currscrolltime, lastscrolltime
	static as integer bScroll

	if( ctl = NULL ) then
		return FALSE
	end if

	if( msg = NULL ) then
		return FALSE
	end if

	select case msg->id
	case MSG_PAINT
		HelpBox_Draw( ctl )

	case MSG_UPDATE
		HelpBox_Update( ctl )

	case MSG_KEY_PRESS
		if(Controls_GetCapture() = ctl ) then
			return( HelpBox_KeyInput( ctl, msg->ky ) )
		end if

	case MSG_MOUSE_WHEEL
		HelpBox_SetScrollIndex ctl, _
			ctl->leftindex, _
			ctl->topindex + msg->mz

	case MSG_SCROLL
		currscrolltime = timer
		if( currscrolltime - lastscrolltime ) > SCROLL_DELAY then
			HelpBox_SetScrollIndex ctl, _
				ctl->leftindex, _
				ctl->topindex + msg->mz
			lastscrolltime = currscrolltime
		end if

	case MSG_SET_SCROLL
		HelpBox_SetScrollIndex ctl, _
			ctl->leftindex, _
			msg->mz


	case MSG_MOUSE_DOWN, MSG_MOUSE_UP, MSG_MOUSE_MOVE, MSG_MOUSE_UPDATE
		
		if( Controls_IsPointInRect( @ctl->ctl.rect, msg->mx, msg->my ) ) then
			bScroll = TRUE
		else
			currscrolltime = timer
			if( currscrolltime - lastscrolltime ) > SCROLL_DELAY then
				bScroll = TRUE
				lastscrolltime = currscrolltime
			else
				bScroll = FALSE
			end if
		end if

		if( bScroll ) then
		
			col = msg->mx - ctl->ctl.rect.x + ctl->leftindex
			row = msg->my - ctl->ctl.rect.y + ctl->topindex

			HelpBox_SetPosition ctl, _
				col, _
				row

			select case msg->id
			case MSG_MOUSE_DOWN
				cap_col = col
				cap_row = row

			case MSG_MOUSE_UP
				if( (cap_col = col) and (cap_row = row) ) then
					HelpBox_NavigateLink( ctl )
				end if

			end select

		end if

	end select

end function
