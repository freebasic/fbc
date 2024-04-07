#include once "Fl_Widget.bi"

#define FL_NORMAL_INPUT_	0
#define FL_FLOAT_INPUT_		1
#define FL_INT_INPUT_		2
#define FL_HIDDEN_INPUT_	3
#define FL_MULTILINE_INPUT_	4
#define FL_SECRET_INPUT_	5
#define FL_INPUT_TYPE_		7
#define FL_INPUT_READONLY_	8
#define FL_NORMAL_OUTPUT_	(FL_NORMAL_INPUT_ or FL_INPUT_READONLY_)
#define FL_MULTILINE_OUTPUT_	(FL_MULTILINE_INPUT_ or FL_INPUT_READONLY_)
#define FL_INPUT_WRAP_		16
#define FL_MULTILINE_INPUT_WRAP_	(FL_MULTILINE_INPUT_ or FL_INPUT_WRAP_)
#define FL_MULTILINE_OUTPUT_WRAP_ 	(FL_MULTILINE_INPUT_ or FL_INPUT_READONLY_ or FL_INPUT_WRAP_)


extern "c++"
type Fl_Char as unsigned long

type Fl_Input_ extends Fl_Widget
private:
	value_ as const zstring ptr
	buffer as zstring ptr
	size_ as long
	bufsize as long
	position_ as long
	mark_ as long
	tab_nav_ as long
	as long xscroll_, yscroll_
	mu_p as long
	maximum_size_ as long
	shortcut_ as long
	erase_cursor_only as ubyte
	textfont_ as Fl_Font
	textsize_ as Fl_Fontsize
	textcolor_ as Fl_Color
	cursor_color_ as Fl_Color

	static up_down_pos as double
	static was_up_down as long

	declare const function expand(as const zstring ptr, as zstring ptr) as const zstring ptr
	declare const function expandpos(as const zstring ptr, as const zstring ptr, as const zstring ptr, as long ptr) as double
	declare sub minimal_update(as long, as long)
	declare sub minimal_update(p as long)
	declare sub put_in_buffer(newsize as long)
	declare const sub setfont()
protected:
	declare constructor (byref b as const Fl_Input_)
	declare operator let (byref b as const Fl_Input_)

	declare const function word_start(i as long) as long
	declare const function word_end(i as long) as long
	declare const function  line_start(i as long) as long
	declare const function line_end(i as long) as long
	declare sub drawtext(as long, as long, as long, as long)
	declare function up_down_position(as long, keepmark as long=0) as long
	declare sub handle_mouse(as long, as long, as long, as long, keepmark as long=0)
	declare function handletext(e as long, as long, as long, as long, as long) as long
	declare sub maybe_do_callback()
	declare const function xscroll() as long
	declare const function yscroll() as long
	declare sub yscroll(yOffset as long)
	declare function linesPerPage() as long
public:
	declare sub resize(as long, as long, as long, as long)
	declare constructor(as long, as long, as long, as long, const as zstring ptr = 0)
	declare destructor()

	declare function value(as const zstring ptr) as long
	declare function value(as const zstring ptr, as long) as long
	declare function static_value(as const zstring ptr) as long
	declare function static_value(as const zstring ptr, as long) as long
	declare const function value() as const zstring ptr

	declare const function index(i as long) as Fl_Char
	declare const function size() as long
	declare sub size(W as long, H as long)
	declare const function maximum_size() as long
	declare sub maximum_size(m as long)
	declare const function position() as long
	declare const function mark() as long
	declare function position(p as long, m as long) as long
	declare function position(p as long) as long
	declare function mark(m as long) as long
	declare function replace(b as long, e as long, text as const zstring ptr, ilen as long=0) as long
	declare function cut() as long
	declare function cut(n as long) as long
	declare function cut(a as long, b as long) as long
	declare function insert(t as const zstring ptr, l as long=0) as long
	declare function copy(clipboard as long) as long
	declare function undo() as long
	declare function copy_cuts() as long
	declare const function shortcut() as long
	declare sub shortcut(s as long)
	declare const function textfont() as Fl_Font
	declare sub textfont(s as Fl_Font)
	declare const function textsize() as Fl_Fontsize
	declare sub textsize(s as Fl_Fontsize)
	declare const function textcolor() as Fl_Color
	declare sub textcolor(n as Fl_Color)
	declare const function cursor_color() as Fl_Color 
	declare sub cursor_color(n as Fl_Color)
	declare const function input_type() as long
	declare sub input_type(t as long)
	declare const function readonly() as long
	declare sub readonly(b as long)
	declare const function wrap() as long
	declare sub wrap(b as long)
	declare sub tab_nav(val_ as long)
	declare const function tab_nav() as long

end type
end extern

private function Fl_Input_.xscroll() as long
	return xscroll_
end function

private function Fl_Input_.yscroll() as long
	return yscroll_
end function

private sub Fl_Input_.yscroll(yOffset as long)
	yscroll_ = yOffset
	damage(FL_DAMAGE_EXPOSE)
end sub

private function Fl_Input_.value() as const zstring ptr
	return value_
end function

private function Fl_Input_.size() as long
	return size_
end function

private sub Fl_Input_.size(W as long, H as long)
	Base.size(W, H)
end sub

private function Fl_Input_.maximum_size() as long
	return maximum_size_
end function

private sub Fl_Input_.maximum_size(m as long)
	maximum_size_=m
end sub

private function Fl_Input_.position() as long
	return position_
end function

private function Fl_Input_.mark() as long
	return mark_
end function

private function Fl_Input_.position(p as long) as long
	return position(p, p)
end function

private function Fl_Input_.mark(m as long) as long
	return position(position(), m)
end function

private function Fl_Input_.cut() as long
	return replace(position(), mark(), 0)
end function

private function Fl_Input_.cut(n as long) as long
	return replace(position(), position()+n, 0)
end function

private function Fl_Input_.cut(a as long, b as long) as long
	return replace(a, b, 0)
end function

private function Fl_Input_.insert(t as const zstring ptr, l as long) as long
	return replace(position_, mark_, t, l)
end function

private function Fl_Input_.shortcut() as long
	return shortcut_
end function

private sub Fl_Input_.shortcut(s as long)
	shortcut_=s
end sub

private function Fl_Input_.textfont() as Fl_Font
	return textfont_
end function

private sub Fl_Input_.textfont(s as Fl_Font)
	textfont_=s
end sub

private function Fl_Input_.textsize() as Fl_Fontsize
	return textsize_
end function

private sub Fl_Input_.textsize(s as Fl_Fontsize)
	textsize_=s
end sub

private function Fl_Input_.textcolor() as Fl_Color
	return textcolor_
end function

private sub Fl_Input_.textcolor(n as Fl_Color)
	textcolor_=n
end sub

private function Fl_Input_.cursor_color() as Fl_Color
	return cursor_color_
end function

private sub Fl_Input_.cursor_color(n as Fl_Color)
	cursor_color_=n
end sub

private function Fl_Input_.input_type() as long
	return type_() and FL_INPUT_TYPE_
end function

private sub Fl_Input_.input_type(t as long)
	type_(cast(unsigned byte,t or readonly()))
end sub

private function Fl_Input_.readonly() as long
	return type_() and FL_INPUT_READONLY_
end function

private sub Fl_Input_.readonly(b as long)
	if b then
		type_(cast(unsigned byte, type_() or FL_INPUT_READONLY_))
	else
		type_(cast(unsigned byte, type_() and not FL_INPUT_READONLY_))
	end if
end sub

private function Fl_Input_.wrap() as long
	return type_() and FL_INPUT_WRAP_
end function

private sub Fl_Input_.wrap(b as long)
	if b then
		type_(cast(unsigned byte, type_() or FL_INPUT_WRAP_))
	else
		type_(cast(unsigned byte, type_() and not FL_INPUT_WRAP_))
	end if
end sub

private sub Fl_Input_.tab_nav(val_ as long)
	tab_nav_ = val_
end sub

private function Fl_Input_.tab_nav() as long
	return tab_nav_
end function

