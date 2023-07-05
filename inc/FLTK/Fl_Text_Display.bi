#include once "Fl.bi"
#include once "Fl_Group.bi"
#include once "Fl_Widget.bi"
#include once "Fl_Scrollbar.bi"
#include once "Fl_Text_Buffer.bi"


extern "c++"

type Fl_Text_Display extends Fl_Group 
	enum 
		NORMAL_CURSOR
		CARET_CURSOR
		DIM_CURSOR
		BLOCK_CURSOR
		HEAVY_CURSOR
		SIMPLE_CURSOR
	end enum

	enum
		CURSOR_POS, 
		CHARACTER_POS
	end enum

	enum
		DRAG_NONE = -2
		DRAG_START_DND = -1
		DRAG_CHAR = 0 
		DRAG_WORD = 1 
		DRAG_LINE = 2
	end enum
	  
	enum
		WRAP_NONE
		WRAP_AT_COLUMN
		WRAP_AT_PIXEL
		WRAP_AT_BOUNDS
	end enum

	type Unfinished_Style_Cb as sub(as long, as any ptr)

	type Style_Table_Entry 
		color as Fl_Color
		font as Fl_Font
		size as Fl_Fontsize
		attr as unsigned long
	end type

	type text_area_
		x as long
		y as long
		w as long
		h as long
	end type

protected:
	declare constructor (byref b as const Fl_Text_Display)
	declare operator let (byref b as const Fl_Text_Display)

public:
	declare sub fl_text_drag_me(pos as long, d as Fl_Text_Display ptr)

	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)
	declare destructor()
	declare virtual function handle(as long) as long

	declare sub buffer(buf as Fl_Text_Buffer ptr)
	declare sub buffer(byref buf as Fl_Text_Buffer)
	declare const function buffer() as Fl_Text_Buffer ptr

	declare sub redisplay_range(start as long, end as long)
	declare sub scroll(topLineNum as long, horizOffset as long)
	declare sub insert(text as const zstring ptr)
	declare sub overstrike(text as const zstring ptr)
	declare sub insert_position(newPos as long)

	declare const function insert_position() as long
	declare const function position_to_xy(pos as long, x as long ptr, y as long ptr) as long

	declare const function in_selection(x as long, y as long) as long
	declare sub show_insert_position()

	declare function move_right() as long
	declare function move_left() as long
	declare function move_up() as long
	declare function move_down() as long
	declare const function count_lines(start as long, end as long, start_pos_is_line_start as boolean) as long
	declare const function line_start(pos as long) as long
	declare const function line_end(startPos as long, startPosIsLineStart as boolean) as long
	declare function skip_lines(startPos as long, nLines as long, startPosIsLineStart as boolean) as long
	declare function rewind_lines(startPos as long, nLines as long) as long
	declare sub next_word()
	declare sub previous_word()

	declare sub show_cursor(b as long = 1)
	declare sub hide_cursor()
	declare sub cursor_style(style as long)

	declare const function cursor_color() as Fl_Color
	declare sub cursor_color(n as Fl_Color)

	declare const function scrollbar_width() as long
	declare sub scrollbar_width(W as long)

	declare const function scrollbar_align() as Fl_Align
	declare sub scrollbar_align(a as Fl_Align)

	declare const function word_start(pos as long) as long
	declare const function word_end(pos as long) as long

	declare sub highlight_data(styleBuffer as Fl_Text_Buffer ptr, _
				styleTable as const Style_Table_Entry ptr, _
				nStyles as long, unfinishedStyle as byte alias "char", _
				unfinishedHighlightCB as Unfinished_Style_Cb, _
				cbArg as any ptr)

	declare const function position_style(lineStartPos as long, lineLen as long, lineIndex as long) as long
	declare const function shortcut() as long
	declare sub shortcut(s as long)
	declare const function textfont() as Fl_Font
	declare sub textfont(s as Fl_Font)
	declare const function textsize() as Fl_Fontsize
	declare sub textsize(s as Fl_Fontsize)
	declare const function textcolor() as Fl_Color
	declare sub textcolor(s as Fl_Color)
	declare const function wrapped_column(row as long, column as long) as long
	declare const function wrapped_row(row as long) as long
	declare sub wrap_mode(wrap as long, wrap_margin as long)
  
	declare virtual sub resize(X as long, Y as long, W as long, H as long)

	declare const function x_to_col(x as double) as double
	declare const function col_to_x(col as double) as double

	declare sub linenumber_width(width as long)
	declare const function linenumber_width() as long
	declare sub linenumber_font(val as Fl_Font)
	declare const function  linenumber_font() as Fl_Font
	declare sub linenumber_size(val as Fl_Fontsize)
	declare const function linenumber_size() as Fl_Fontsize
	declare sub linenumber_fgcolor(val as Fl_Color)
	declare const function linenumber_fgcolor() as Fl_Color
	declare sub linenumber_bgcolor(val as Fl_Color)
	declare const function linenumber_bgcolor() as Fl_Color
	declare sub linenumber_align(val as Fl_Align)
	declare const function linenumber_align() as Fl_Align
	declare sub linenumber_format(val as const zstring ptr)
	declare const function linenumber_format() as const zstring ptr
protected:
	declare virtual sub draw()

	declare sub draw_text(X as long, Y as long, W as long, H as long)
	declare sub draw_range(start as long, end as long)
	declare sub draw_cursor(as long, as long)
  
	declare const sub draw_string(style as long, x as long, y as long, toX as long, string_ as const zstring ptr, nChars as long)
  
	declare sub draw_vline(visLineNum as long, leftClip as long, rightClip as long, leftCharIndex as long, rightCharIndex as long)
  
	declare const function find_x(s as const zstring ptr, len as long, style as long, x as long) as long

	declare const function handle_vline(mode as long, lineStart as long, lineLen as long, leftChar as long, rightChar as long, topClip as long, bottomClip as long, leftClip as long, rightClip as long) as long
  
	declare sub draw_line_numbers(clearAll as boolean)
  
	declare const sub clear_rect(style as long, x as long, y as long, width as long, height as long) 
	declare sub display_insert()
  
	declare sub offset_line_starts(newTopLineNum as long)
  
	declare sub calc_line_starts(startLine as long, endLine as long)

	declare sub update_line_starts(pos as long, charsInserted as long, charsDeleted as long, linesInserted as long, linesDeleted as long, scrolled as long ptr)
  
	declare sub calc_last_char()
  
	declare const function position_to_line(pos as long, lineNum as long ptr) as long
	declare const function string_width(string as const zstring ptr, length as long, style as long) as double
  
	declare sub scroll_timer_cb(as any ptr)
  
	declare static sub buffer_predelete_cb(pos as long, nDeleted as long, cbArg as any ptr)
	declare static sub buffer_modified_cb(pos as long, nInserted as long, nDeleted as long, nRestyled as long, deletedText as const zstring ptr, cbArg as any ptr)
  
	declare static sub h_scrollbar_cb(w as Fl_Scrollbar ptr, d as Fl_Text_Display ptr)
	declare static sub v_scrollbar_cb(w as Fl_Scrollbar ptr, d as Fl_Text_Display ptr)
	declare sub update_v_scrollbar()
	declare sub update_h_scrollbar()
	declare const function measure_vline(visLineNum as long) as long
	declare const function longest_vline() as long
	declare const function empty_vlines() as long
	declare const function vline_length(visLineNum as long) as long
	declare const function xy_to_position(x as long, y as long, PosType as long = CHARACTER_POS) as long
  
	declare const sub xy_to_rowcol(x as long, y as long, row as long ptr, column as long ptr, PosType as long = CHARACTER_POS)
	declare sub maintain_absolute_top_line_number(state as long)
	declare const function get_absolute_top_line_number() as long
	declare sub absolute_top_line_number(oldFirstChar as long)
	declare const function maintaining_absolute_top_line_number() as long
	declare sub reset_absolute_top_line_number()
	declare const function  position_to_linecol(pos as long, lineNum as long ptr, column as long ptr) as long
	declare function scroll_(topLineNum as long, horizOffset as long) as long
  
	declare sub extend_range_for_styles(start as long ptr, end as long ptr)
  
	declare sub find_wrap_range(deletedText as const zstring ptr, pos as long, nInserted as long, nDeleted as long, modRangeStart as long ptr, modRangeEnd as long ptr,linesInserted as long ptr, linesDeleted as long ptr)
	declare sub measure_deleted_lines(pos as long, nDeleted as long)
	declare const sub wrapped_line_counter(buf as Fl_Text_Buffer ptr, startPos as long, maxPos as long,_
						 maxLines as long, startPosIsLineStart as boolean, styleBufOffset as long,_
						 retPos as long ptr, retLines as long ptr, retLineStart as long ptr, retLineEnd as long ptr,_
						 countLastLineMissingNewLine as boolean = true)
	declare const sub find_line_end(pos as long, start_pos_is_line_start as boolean, lineEnd as long ptr, nextLineStart as long ptr)
	declare const function measure_proportional_character(s as const zstring ptr, colNum as long, pos as long) as double
	declare const function wrap_uses_character(lineEndPos as long) as long


	as long damage_range1_start, damage_range1_end
	as long damage_range2_start, damage_range2_end
	mCursorPos as long
	mCursorOn as long
	mCursorOldY as long
	mCursorToHint as long

	mCursorStyle as long
	mCursorPreferredXPos as long
	mNVisibleLines as long
	mNBufferLines as long
	mBuffer as Fl_Text_Buffer ptr
	mStyleBuffer as Fl_Text_Buffer ptr

	as long mFirstChar, mLastChar

	mContinuousWrap as long
	mWrapMarginPix as long

	mLineStarts as long ptr
	mTopLineNum as long

	mAbsTopLineNum as long

	mNeedAbsTopLineNum as long

	mHorizOffset as long
	mTopLineNumHint as long

	mHorizOffsetHint as long
	mNStyles as long 
	mStyleTable as const Style_Table_Entry ptr

	mUnfinishedStyle as byte

	mUnfinishedHighlightCB as Unfinished_Style_Cb

	mHighlightCBArg as any ptr
  
	mMaxsize as long
  
	mSuppressResync as long
	mNLinesDeleted as long

	mModifyingTabDistance as long
  
	mColumnScale as double	'mutable?

  
	mCursor_color as Fl_Color
  
	mHScrollBar as Fl_Scrollbar ptr
	mVScrollBar as Fl_Scrollbar ptr
	scrollbar_width_ as long
	scrollbar_align_ as Fl_Align
	as long dragPos, dragType, dragging
	display_insert_position_hint as long
	text_area as text_area_
  
	shortcut_ as long
  
	textfont_ as Fl_Font
	textsize_ as Fl_Fontsize
	textcolor_ as Fl_Color
  
	as long mLineNumLeft, mLineNumWidth

'#if FLTK_ABI_VERSION >= 10303
	linenumber_font_ as Fl_Font
	linenumber_size_ as Fl_Fontsize
	linenumber_fgcolor_ as Fl_Color
	linenumber_bgcolor_ as Fl_Color
	linenumber_align_ as Fl_Align
	linenumber_format_ as const zstring ptr
'#endif
end type
end extern

private sub Fl_Text_Display.buffer(byref buf as Fl_Text_Buffer) 
	buffer(@buf)
end sub

private const function Fl_Text_Display.buffer() as Fl_Text_Buffer ptr
	return mBuffer
end function

private const function Fl_Text_Display.insert_position() as long
	return mCursorPos
end function

private sub Fl_Text_Display.hide_cursor() 
	show_cursor(0)
end sub

private const function Fl_Text_Display.cursor_color() as Fl_Color
	return mCursor_color
end function

private sub Fl_Text_Display.cursor_color(n as Fl_Color)
	mCursor_color=n
end sub

private const function Fl_Text_Display.scrollbar_width() as long
	return scrollbar_width_
end function

private sub Fl_Text_Display.scrollbar_width(W as long)
	scrollbar_width_=W
end sub

private const function Fl_Text_Display.scrollbar_align() as Fl_Align
	return scrollbar_align_
end function

private sub Fl_Text_Display.scrollbar_align(a as Fl_Align)
	scrollbar_align_=a
end sub

private const function Fl_Text_Display.word_start(pos as long) as long
	return buffer()->word_start(pos)
end function

private const function Fl_Text_Display.word_end(pos as long) as long
	return buffer()->word_end(pos)
end function

private const function Fl_Text_Display.shortcut() as long
	return shortcut_
end function

private sub Fl_Text_Display.shortcut(s as long)
	shortcut_=s
end sub

private const function Fl_Text_Display.textfont() as Fl_Font
	return textfont_
end function

private sub Fl_Text_Display.textfont(s as Fl_Font)
	textfont_=s:mColumnScale = 0
end sub

private const function Fl_Text_Display.textsize() as Fl_Fontsize
	return textsize_
end function

private sub Fl_Text_Display.textsize(s as Fl_Fontsize)
	textsize_=s:mColumnScale = 0
end sub

private const function Fl_Text_Display.textcolor() as Fl_Color
	return textcolor_
end function

private sub Fl_Text_Display.textcolor(n as Fl_Color)
	textcolor_=n
end sub


