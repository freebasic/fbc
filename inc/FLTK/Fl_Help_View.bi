#include once "Fl.bi"
#include once "Fl_Group.bi"
#include once "Fl_Scrollbar.bi"
#include once "fl_draw.bi"
#include once "Fl_Shared_Image.bi"
#include once "filename.bi"

extern "c++"
type Fl_Help_Func as function (as Fl_Widget ptr, as const zstring ptr) as const zstring ptr

type Fl_Help_Block 
	start as const zstring ptr
	end as const zstring ptr
	border as unsigned byte
	bgcolor as Fl_Color
	as long	x, y, w, h
	line(31) as long
end type

type Fl_Help_Link 
	filename as zstring*192
	name as zstring*32
	as long	x, y, w, h
end type

type Fl_Help_Font_Style
	f as Fl_Font
	s as Fl_Fontsize
	c as Fl_Color
	declare sub get(byref afont as Fl_Font, byref asize as Fl_Fontsize, byref acolor as Fl_Color)
	declare sub set(afont as Fl_Font, asize as Fl_Fontsize, acolor as Fl_Color)
	declare constructor(afont as Fl_Font, asize as Fl_Fontsize, acolor as Fl_Color)
	declare constructor()
end type

private sub Fl_Help_Font_Style.get(byref afont as Fl_Font, byref asize as Fl_Fontsize, byref acolor as Fl_Color)
	afont=f: asize=s: acolor=c
end sub

private sub Fl_Help_Font_Style.set(afont as Fl_Font, asize as Fl_Fontsize, acolor as Fl_Color)
	f=afont: s=asize: c=acolor
end sub

constructor Fl_Help_Font_Style(afont as Fl_Font, asize as Fl_Fontsize, acolor as Fl_Color)
	set(afont, asize, acolor)
end constructor

constructor Fl_Help_Font_Style()
end constructor

const MAX_FL_HELP_FS_ELTS = 100

type Fl_Help_Font_Stack
	declare constructor()
	declare sub init(f as Fl_Font, s as Fl_Fontsize, c as Fl_Color) 
	declare sub top(byref f as Fl_Font, byref s as Fl_Fontsize, byref c as Fl_Color) 
	declare sub push(f as Fl_Font, s as Fl_Fontsize, c as Fl_Color) 
	declare sub pop(byref f as Fl_Font, byref s as Fl_Fontsize, byref c as Fl_Color) 
	declare const function count() as unsigned integer
protected:
	nfonts_ as unsigned integer
	elts_(99) as Fl_Help_Font_Style

end type

constructor Fl_Help_Font_Stack()
	nfonts_=0
end constructor

private sub Fl_Help_Font_Stack.init(f as Fl_Font, s as Fl_Fontsize, c as Fl_Color) 
	nfonts_ = 0
	elts_(nfonts_).set(f, s, c)
	fl_font(f, s)
	fl_color(c)
end sub

private sub Fl_Help_Font_Stack.top(byref f as Fl_Font, byref s as Fl_Fontsize, byref c as Fl_Color) 
	elts_(nfonts_).get(f, s, c)
end sub

private sub Fl_Help_Font_Stack.push(f as Fl_Font, s as Fl_Fontsize, c as Fl_Color) 
	if nfonts_ <  (MAX_FL_HELP_FS_ELTS-1) then nfonts_ +=1
	elts_(nfonts_).set(f, s, c)
	fl_font(f, s): fl_color(c) 
end sub

private sub Fl_Help_Font_Stack.pop(byref f as Fl_Font, byref s as Fl_Fontsize, byref c as Fl_Color) 
	if nfonts_ > 0 then nfonts_ -=1
	top(f, s, c)
	fl_font(f, s): fl_color(c)
end sub

private function Fl_Help_Font_Stack.count as unsigned integer
	return nfonts_
end function

type Fl_Help_Target
	name as zstring*32
	y as long
end type

type Fl_Help_View extends Fl_Group
private:
  
	enum
		RIGHT_ = -1
		CENTER_
		LEFT_
	end enum

	title_ as zstring*1024
	defcolor_ as Fl_Color
	bgcolor_ as Fl_Color
	textcolor_ as Fl_Color
	linkcolor_ as Fl_Color

	textfont_ as Fl_Font
	textsize_ as Fl_Fontsize
	value_ as const zstring ptr
	fstack_ as Fl_Help_Font_Stack
	nblocks_ as long
	ablocks_ as long
	blocks_ as Fl_Help_Block ptr

	link_ as Fl_Help_Func ptr

	nlinks_ as long
	alinks_ as long
	links_ as Fl_Help_Link ptr

	ntargets_ as long
	atargets_ as long
	targets_ as Fl_Help_Target ptr

	directory_ as zstring*FL_PATH_MAX
	filename_ as zstring*FL_PATH_MAX
	topline_ as long
	leftline_ as long
	size_ as long
	hsize_ as long
	scrollbar_size_ as long
	scrollbar_ as Fl_Scrollbar = any
	hscrollbar_ as Fl_Scrollbar = any

	static selection_first as long
	static selection_last as long
	static selection_push_first as long
	static selection_push_last as long
	static selection_drag_first as long
	static selection_drag_last as long
	static selected as long
	static draw_mode as long
	static mouse_x as long
	static mouse_y as long
	static current_pos as long
	static current_view as Fl_Help_View ptr
	static hv_selection_color as Fl_Color
	static hv_selection_text_color as Fl_Color

	declare constructor (byref b as const Fl_Help_View)
	declare operator let (byref b as const Fl_Help_View)

	declare sub initfont(byref f as Fl_Font, byref s as Fl_Fontsize, byref c as Fl_Color)
	declare sub pushfont(f as Fl_Font, s as Fl_Fontsize)
	declare sub pushfont(f as Fl_Font, s as Fl_Fontsize, c as Fl_Color)
	declare sub popfont(byref f as Fl_Font, byref s as Fl_Fontsize, byref c as Fl_Color)

	declare function add_block(s as const zstring ptr, xx as long, yy as long, ww as long, hh as long, border as unsigned byte = 0) as Fl_Help_Block ptr
	declare sub add_link(n as const zstring ptr, xx as long, yy as long, ww as long, hh as long)
	declare sub add_target(n as const zstring ptr, yy as long)
	declare static function compare_targets(t0 as const Fl_Help_Target ptr, t1 as const Fl_Help_Target ptr) as long
	declare function do_align(block as Fl_Help_Block ptr, line_ as long, xx as long, a as long, byref l as long) as long
	declare sub draw()
	declare sub format()
	declare sub format_table(table_width as long ptr, columns as long ptr, table as const zstring ptr)
	declare sub free_data()
	declare function get_align(p as const zstring ptr, a as long) as long
	declare function get_attr(p as const zstring ptr, n as const zstring ptr, buf as zstring ptr, bufsize as long) as const zstring ptr
	declare function get_color(n as const zstring ptr, c as Fl_Color) as Fl_Color
	declare function get_image(name as const zstring ptr, W as long, H as long) as Fl_Shared_Image ptr
	declare function get_length(l as const zstring ptr) as long

	declare function handle(as long) as long

	declare sub hv_draw(t as const zstring ptr, x as long, y as long, entity_extra_length as long= 0)
	declare function begin_selection() as byte
	declare function extend_selection() as byte
	declare sub end_selection(c as long=0)
	declare sub clear_global_selection()
	declare function find_link(as long, as long) as Fl_Help_Link ptr
	declare sub follow_link(as Fl_Help_Link ptr)

public:

	declare constructor(xx as long, yy as long, ww as long, hh as long, l as const zstring ptr = 0)
	declare destructor()

	declare const function directory() as const zstring ptr
	declare const function filename() as const zstring ptr
	declare function find(s as const zstring ptr, p as long = 0) as long

	declare sub link(fn as Fl_Help_Func ptr)
	declare function load(f as const zstring ptr) as long
	declare sub resize(as long, as long, as long, as long)

	declare const function size() as long
	declare sub size(W as long, H as long) 
	declare sub textcolor(c as Fl_Color)
	declare const function textcolor() as Fl_Color
	declare sub textfont(f as Fl_Font)
	declare const function textfont() as Fl_Font
	declare sub textsize(s as Fl_Fontsize)
	declare const function textsize() as Fl_Fontsize
	declare function title() as const zstring ptr
	declare sub topline(n as const zstring ptr)
	declare sub topline(as long)
	declare const function topline() as long
	declare sub leftline(as long)
	declare const function leftline() as long
	declare sub value(val_ as const zstring ptr)
	declare const function value() as const zstring ptr
	declare sub clear_selection()
	declare sub select_all()

	declare const function scrollbar_size() as long
	declare sub scrollbar_size(newSize as long)

end type

private sub Fl_Help_View.initfont(byref f as Fl_Font, byref s as Fl_Fontsize, byref c as Fl_Color)
	f = textfont_: s = textsize_: c = textcolor_: fstack_.init(f, s, c)
end sub

private sub Fl_Help_View.pushfont(f as Fl_Font, s as Fl_Fontsize)
	fstack_.push(f, s, textcolor_)
end sub

private sub Fl_Help_View.pushfont(f as Fl_Font, s as Fl_Fontsize, c as Fl_Color)
	fstack_.push(f, s, c)
end sub

private sub Fl_Help_View.popfont(byref f as Fl_Font, byref s as Fl_Fontsize, byref c as Fl_Color)
	fstack_.pop(f, s, c)
end sub

private function Fl_Help_View.directory() as const zstring ptr
	if directory_[0] then
		return (@directory_)
	else
		return 0
	end if
end function

private function Fl_Help_View.filename() as const zstring ptr
	if filename_[0] then
		return (@filename_)
	else
		return 0
	end if
end function

private sub Fl_Help_View.link(fn as Fl_Help_Func ptr)
	link_ = fn
end sub

private function Fl_Help_View.size() as long
	return (size_)
end function

private sub Fl_Help_View.size(W as long, H as long)
	base.base.size(W, H)
end sub

private sub Fl_Help_View.textcolor(c as Fl_Color)
	if textcolor_ = defcolor_ then textcolor_ = c
	defcolor_ = c
end sub

private function Fl_Help_View.textcolor() as Fl_Color
	return (defcolor_)
end function

private sub Fl_Help_View.textfont(f as Fl_Font)
	textfont_ = f: format()
end sub

private function Fl_Help_View.textfont() as Fl_Font
	 return (textfont_)
end function

private sub Fl_Help_View.textsize(s as Fl_Fontsize)
	textsize_ = s: format()
end sub

private function Fl_Help_View.textsize() as Fl_Fontsize
	 return (textsize_)
end function

private function Fl_Help_View.title() as const zstring ptr
	 return (@title_)
end function

private function Fl_Help_View.topline() as long
	 return (topline_)
end function

private function Fl_Help_View.leftline() as long
	 return (leftline_)
end function

private function Fl_Help_View.value() as const zstring ptr
	 return (value_)
end function

private function Fl_Help_View.scrollbar_size() as long
	return (scrollbar_size_)
end function

private sub Fl_Help_View.scrollbar_size(newSize as long)
	scrollbar_size_= newSize
end sub

end extern
