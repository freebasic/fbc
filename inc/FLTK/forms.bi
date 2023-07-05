#include once "Fl.bi"
#include once "Fl_Group.bi"
#include once "Fl_Window.bi"
#include once "fl_draw.bi"

type FL_OBJECT as Fl_Widget
type FL_FORM as Fl_Window

#ifndef NULL
#define NULL 0
#endif
#ifndef FALSE
#define FALSE 0
#define TRUE 1
#endif

#define FL_ON		1
#define FL_OK_		1
#define FL_VALID	1
#define FL_PREEMPT	1
#define FL_AUTO		2
#define FL_WHEN_NEEDED	FL_AUTO
#define FL_OFF		0
#define FL_NONE		0
#define FL_CANCEL_	0
#define FL_INVALID	0
#define FL_IGNORE	-1

#define FL_LCOL		FL_BLACK
#define FL_COL1		FL_GRAY
#define FL_MCOL		FL_LIGHT1
#define FL_LEFT_BCOL	FL_LIGHT3 // 53 is better match
#define FL_TOP_BCOL	FL_LIGHT2 // 51
#define FL_BOTTOM_BCOL	FL_DARK2  // 40
#define FL_RIGHT_BCOL	FL_DARK3  // 36
#define FL_INACTIVE_	FL_INACTIVE_COLOR
#define FL_INACTIVE_COL	FL_INACTIVE_COLOR
#define FL_FREE_COL1	FL_FREE_COLOR
#define FL_FREE_COL2	(cast(Fl_Color, FL_FREE_COLOR+1))
#define FL_FREE_COL3	(cast(Fl_Color, FL_FREE_COLOR+2))
#define FL_FREE_COL4	(cast(Fl_Color, FL_FREE_COLOR+3))
#define FL_FREE_COL5	(cast(Fl_Color, FL_FREE_COLOR+4))
#define FL_FREE_COL6	(cast(Fl_Color, FL_FREE_COLOR+5))
#define FL_FREE_COL7	(cast(Fl_Color, FL_FREE_COLOR+6))
#define FL_FREE_COL8	(cast(Fl_Color, FL_FREE_COLOR+7))
#define FL_FREE_COL9	(cast(Fl_Color, FL_FREE_COLOR+8))
#define FL_FREE_COL10	(cast(Fl_Color, FL_FREE_COLOR+9))
#define FL_FREE_COL11	(cast(Fl_Color, FL_FREE_COLOR+10))
#define FL_FREE_COL12	(cast(Fl_Color, FL_FREE_COLOR+11))
#define FL_FREE_COL13	(cast(Fl_Color, FL_FREE_COLOR+12))
#define FL_FREE_COL14	(cast(Fl_Color, FL_FREE_COLOR+13))
#define FL_FREE_COL15	(cast(Fl_Color, FL_FREE_COLOR+14))
#define FL_FREE_COL16	(cast(Fl_Color, FL_FREE_COLOR+15))
#define FL_TOMATO	(cast(Fl_Color, 131))
#define FL_INDIANRED	(cast(Fl_Color, 164))
#define FL_SLATEBLUE	(cast(Fl_Color, 195))
#define FL_DARKGOLD	(cast(Fl_Color, 84))
#define FL_PALEGREEN	(cast(Fl_Color, 157))
#define FL_ORCHID	(cast(Fl_Color, 203))
#define FL_DARKCYAN	(cast(Fl_Color, 189))
#define FL_DARKTOMATO	(cast(Fl_Color, 113))
#define FL_WHEAT	(cast(Fl_Color, 174))

#define FL_ALIGN_BESIDE	FL_ALIGN_INSIDE

#define FL_PUP_TOGGLE	2
#define FL_PUP_INACTIVE 1
#define FL_NO_FRAME	FL_NO_BOX
#define FL_ROUNDED3D_UPBOX 	FL_ROUND_UP_BOX
#define FL_ROUNDED3D_DOWNBOX	FL_ROUND_DOWN_BOX
#define FL_OVAL3D_UPBOX		FL_ROUND_UP_BOX
#define FL_OVAL3D_DOWNBOX	FL_ROUND_DOWN_BOX

#define FL_MBUTTON1	1
#define FL_LEFTMOUSE	1
#define FL_MBUTTON2	2
#define FL_MIDDLEMOUSE	2
#define FL_MBUTTON3	3
#define FL_RIGHTMOUSE	3
#define FL_MBUTTON4	4
#define FL_MBUTTON5	5

#define FL_INVALID_STYLE 255
#define FL_NORMAL_STYLE	FL_HELVETICA
#define FL_BOLD_STYLE	FL_HELVETICA_BOLD
#define FL_ITALIC_STYLE	FL_HELVETICA_ITALIC
#define FL_BOLDITALIC_STYLE FL_HELVETICA_BOLD_ITALIC
#define FL_FIXED_STYLE	FL_COURIER
#define FL_FIXEDBOLD_STYLE FL_COURIER_BOLD
#define FL_FIXEDITALIC_STYLE FL_COURIER_ITALIC
#define FL_FIXEDBOLDITALIC_STYLE FL_COURIER_BOLD_ITALIC
#define FL_TIMES_STYLE	FL_TIMES
#define FL_TIMESBOLD_STYLE FL_TIMES_BOLD
#define FL_TIMESITALIC_STYLE FL_TIMES_ITALIC
#define FL_TIMESBOLDITALIC_STYLE FL_TIMES_BOLD_ITALIC

#define FL_SHADOW_STYLE		(FL_SHADOW_LABEL SHL 8)
#define FL_ENGRAVED_STYLE	(FL_ENGRAVED_LABEL SHL 8)
#define FL_EMBOSSED_STYLE	(FL_EMBOSSED_LABEL SHL 0)

#define FL_TINY_SIZE	8
#define FL_SMALL_SIZE	11 
#define FL_MEDIUM_SIZE	18 
#define FL_LARGE_SIZE	24 
#define FL_HUGE_SIZE	32 
#define FL_DEFAULT_SIZE	FL_SMALL_SIZE
#define FL_TINY_FONT	FL_TINY_SIZE
#define FL_SMALL_FONT	FL_SMALL_SIZE
#define FL_NORMAL_FONT	FL_NORMAL_SIZE
#define FL_MEDIUM_FONT	FL_MEDIUM_SIZE
#define FL_LARGE_FONT	FL_LARGE_SIZE
#define FL_HUGE_FONT	FL_HUGE_SIZE
#define FL_NORMAL_FONT1	FL_SMALL_FONT
#define FL_NORMAL_FONT2	FL_NORMAL_FONT
#define FL_DEFAULT_FONT	FL_SMALL_FONT

#define FL_RETURN_END_CHANGED	FL_WHEN_RELEASE
#define FL_RETURN_CHANGED	FL_WHEN_CHANGED
#define FL_RETURN_END		FL_WHEN_RELEASE_ALWAYS
#define FL_RETURN_ALWAYS	(FL_WHEN_CHANGED OR FL_WHEN_NOT_CHANGED)

#define FL_BOUND_WIDTH	3

type FL_Coord as long
type FL_COLOR_ as long

extern "c++"
#define FL_CMD_OPT any
declare sub fl_initialize(as long ptr, as zstring ptr ptr, as const zstring ptr, as FL_CMD_OPT ptr, as long)
private sub fl_finish()
end sub
type FL_IO_CALLBACK as sub (as FL_SOCKET, as any ptr)
private sub fl_add_io_callback(fd as long, w as short, cb as FL_IO_CALLBACK , v as any ptr) 
	Fl.add_fd(fd, w, cb, v)
end sub
private sub fl_remove_io_callback(fd as long, w as short, cb as FL_IO_CALLBACK) 
	Fl.remove_fd(fd)
end sub

private sub fl_add_timeout(msec as long, cb as sub(as any ptr),  v as any ptr) 
	Fl.add_timeout(msec*.001, cb, v)
end sub
private sub fl_remove_timeout(l as long)
end sub

private sub fl_set_idle_callback(cb as sub())
	Fl.set_idle(cb)
end sub

declare function fl_do_forms() as Fl_Widget ptr
declare function fl_check_forms() as Fl_Widget ptr
private function fl_do_only_forms() as Fl_Widget ptr
	return fl_do_forms()
end function
private function fl_check_only_forms() as Fl_Widget ptr
	return fl_check_forms()
end function

private sub fl_freeze_object(foo as Fl_Widget ptr)
end sub
private sub fl_unfreeze_object(foo as Fl_Widget ptr)
end sub
private sub fl_freeze_form(foo as Fl_Window ptr)
end sub
private sub fl_unfreeze_form(foo as Fl_Window ptr)
end sub
private sub fl_freeze_all_forms()
end sub
private sub fl_unfreeze_all_forms() 
end sub

private sub fl_set_focus_object(a as Fl_Window ptr, o as Fl_Widget ptr)
	Fl.focus(o)
end sub
private sub fl_reset_focus_object(o as Fl_Widget ptr)
	Fl.focus(o)
end sub
#define fl_set_object_focus fl_set_focus_object

private sub fl_set_object_boxtype(o as Fl_Widget ptr, a as Fl_Boxtype)
	o->box(a)
end sub
private sub fl_set_object_lsize(o as Fl_Widget ptr, s as long)
	o->labelsize(s)
end sub

private sub fl_set_object_lstyle(o as Fl_Widget ptr, a as long)
	o->labelfont(cast(Fl_Font, a and &hff)): o->labeltype(cast(Fl_Labeltype, a shr 8))
end sub

private sub fl_set_object_lcol(o as Fl_Widget ptr, a as Fl_Color)
	o->labelcolor(a)
end sub

#define fl_set_object_lcolor  fl_set_object_lcol
private sub fl_set_object_lalign(o as Fl_Widget ptr, a as Fl_Align)
	o->align(a)
end sub

#define fl_set_object_align fl_set_object_lalign
private sub fl_set_object_color(o as Fl_Widget ptr, a as Fl_Color, b as Fl_Color)
	o->color(a,b)
end sub
private sub fl_set_object_label(o as Fl_Widget ptr, a as const zstring ptr)
	o->label(a): o->redraw()
end sub
private sub fl_set_object_position(o as Fl_Widget ptr, x as long, y as long)
	o->position(x,y)
end sub
private sub fl_set_object_size(o as Fl_Widget ptr, w as long, h as long)
	o->size(w,h)
end sub
private sub fl_set_object_geometry(o as Fl_Widget ptr, x as long, y as long, w as long, h as long)
	o->resize(x,y,w,h)
end sub

private sub fl_get_object_geometry(o as Fl_Widget ptr,x as long ptr, y as long ptr, w as long ptr, h as long ptr)
	*x = o->x(): *y = o->y(): *w = o->w(): *h = o->h()
end sub
private sub fl_get_object_position(o as Fl_Widget ptr, x as long ptr, y as long ptr)
	*x = o->x(): *y = o->y()
end sub

type Forms_CB as sub(as Fl_Widget ptr, as integer)
private sub fl_set_object_callback(o as Fl_Widget ptr, c as Forms_CB, a as integer)
	o->callback(c,a)
end sub
#define fl_set_call_back  fl_set_object_callback
private sub fl_call_object_callback(o as Fl_Widget ptr)
	o->do_callback()
end sub
private sub fl_trigger_object(o as Fl_Widget ptr)
	o->do_callback()
end sub
private sub fl_set_object_return(o as Fl_Widget ptr, v as long)
	o->when(cast(Fl_When,v or FL_WHEN_RELEASE))
end sub

private sub fl_redraw_object(o as Fl_Widget ptr)
	o->redraw()
end sub
private sub fl_show_object(o as Fl_Widget ptr)
	o->show()
end sub
private sub fl_hide_object(o as Fl_Widget ptr)
	o->hide()
end sub
private sub fl_free_object(x as Fl_Widget ptr)
	delete x
end sub
private sub fl_delete_object(o as Fl_Widget ptr)
	o->parent()->remove(*o)
end sub
private sub fl_activate_object(o as Fl_Widget ptr)
	o->activate()
end sub
private sub fl_deactivate_object(o as Fl_Widget ptr)
	o->deactivate()
end sub

private sub fl_add_object(f as Fl_Window ptr, x as Fl_Widget ptr)
	f->add(x)
end sub
private sub fl_insert_object(o as Fl_Widget ptr, b as Fl_Widget ptr)
	b->parent()->insert(*o,b)
end sub

private function FL_ObjWin(o as Fl_Widget ptr) as Fl_Window ptr
	return o->window()
end function

private function fl_get_border_width() as long
	return 3
end function
private sub fl_set_border_width(x as long) 
end sub
private sub fl_set_object_dblbuffer(a as Fl_Widget ptr, b as long)
end sub
private sub fl_set_form_dblbuffer(a as Fl_Window ptr, b as long)
end sub


private sub fl_free_form(x as Fl_Window ptr)
	delete x
end sub
private sub fl_redraw_form(f as Fl_Window ptr)
	f->redraw()
end sub

private function fl_bgn_form(b as Fl_Boxtype, w as long, h as long) as Fl_Window ptr
  dim g as Fl_Window ptr = new Fl_Window(w,h,0)
  g->box(b)
  return g
end function
declare sub fl_end_form()
private sub fl_addto_form(f as Fl_Window ptr)
	f->begin()
end sub
private function fl_bgn_group() as Fl_Group ptr
	return new Fl_Group(0,0,0,0,0)
end function
private sub fl_end_group()
	Fl_Group.current()->forms_end()
end sub
private sub fl_addto_group(o as Fl_Widget ptr)
	cast(Fl_Group ptr, o)->begin()
end sub
#define resizebox _ddfdesign_kludge()

private sub fl_scale_form(f as Fl_Window ptr, x as double, y as double)
	f->resizable(f): f->size(cast(long, f->w()*x),cast(long, f->h()*y))
end sub
private sub fl_set_form_position(f as Fl_Window ptr, x as long, y as long)
	f->position(x,y)
end sub
private sub fl_set_form_size(f as Fl_Window ptr, w as long, h as long)
	f->size(w,h)
end sub
private sub fl_set_form_geometry(f as Fl_Window ptr, x as long, y as long, w as long, h as long)
	f->resize(x,y,w,h)
end sub
#define fl_set_initial_placement fl_set_form_geometry
private sub fl_adjust_form_size(a as Fl_Window ptr)
end sub

declare sub fl_show_form(f as Fl_Window ptr, p as long, b as long, n as const zstring ptr)

enum
	FL_PLACE_FREE = 0
	FL_PLACE_MOUSE = 1
	FL_PLACE_CENTER = 2
	FL_PLACE_POSITION = 4
	FL_PLACE_SIZE = 8
	FL_PLACE_GEOMETRY =16
	FL_PLACE_ASPECT = 32
	FL_PLACE_FULLSCREEN=64
	FL_PLACE_HOTSPOT = 128
	FL_PLACE_ICONIC = 256
	FL_FREE_SIZE=(1 shl 14)
	FL_FIX_SIZE =(1 shl 15)
end enum
#define FL_PLACE_FREE_CENTER (FL_PLACE_CENTER OR FL_FREE_SIZE)
#define FL_PLACE_CENTERFREE  (FL_PLACE_CENTER OR FL_FREE_SIZE)
enum
	FL_NOBORDER = 0
	FL_FULLBORDER
	FL_TRANSIENT
end enum

private sub fl_set_form_hotspot(w as Fl_Window ptr, x as long, y as long)
	w->hotspot(x,y)
end sub
private sub fl_set_form_hotobject(w as Fl_Window ptr, o as Fl_Widget ptr)
	w->hotspot(o)
end sub

extern "c"
extern fl_flip  as byte
end extern

private sub fl_flip_yorigin()
	fl_flip = 1
end sub

#define fl_prepare_form_window fl_show_form
private sub fl_show_form_window(a as Fl_Window ptr)
end sub

private sub fl_raise_form(f as Fl_Window ptr)
	f->show()
end sub

private sub fl_hide_form(f as Fl_Window ptr)
	f->hide()
end sub
private sub fl_pop_form(f as Fl_Window ptr)
	f->show()
end sub

extern "c"
extern fl_modal_next as byte
end extern
private sub fl_activate_all_forms()
end sub
private sub fl_deactivate_all_forms()
	fl_modal_next = 1
end sub
private sub fl_deactivate_form(w as Fl_Window ptr)
	w->deactivate()
end sub
private sub fl_activate_form(w as Fl_Window ptr)
	w->activate()
end sub

private sub fl_set_form_title(f as Fl_Window ptr, s as const zstring ptr)
	f->label(s)
end sub
private sub fl_title_form(f as Fl_Window ptr, s as const zstring ptr)
	f->label(s)
end sub

type Forms_FormCB as sub(as Fl_Widget ptr)
private sub fl_set_form_callback(f as Fl_Window ptr,c as Forms_FormCB)
	f->callback(c)
end sub

#define fl_set_form_call_back fl_set_form_callback

private sub fl_init()
end sub

declare sub fl_set_graphics_mode(as long, as long)

private function fl_form_is_visible(f as Fl_Window ptr) as long
	return f->visible()
end function

private function fl_mouse_button() as long
	return Fl.event_button()
end function

#define fl_mousebutton fl_mouse_button

#define fl_free       deallocate
#define fl_malloc     allocate
#define fl_calloc     callocate
#define fl_realloc    reallocate

private sub fl_drw_box(b as Fl_Boxtype, x as long, y as long, w as long, h as long, bgc as Fl_Color, z as long=3)
	fl_draw_box(b,x,y,w,h,bgc)
end sub
private sub fl_drw_frame(b as Fl_Boxtype, x as long, y as long, w as long, h as long, bgc as Fl_Color, z as long=3)
	fl_draw_box(b,x,y,w,h,bgc)
end sub

private sub fl_drw_text(align as Fl_Align, x as long, y as long, w as long, h as long, fgcolor as Fl_Color, size as long, style as Fl_Font, s as const zstring ptr)
	fl_font(style,size)
	fl_color(fgcolor)
	fl_draw(s,x,y,w,h,align)
end sub

private sub fl_drw_text_beside(align as Fl_Align, x as long, y as long, w as long, h as long, fgcolor as Fl_Color, size as long, style as Fl_Font, s as const zstring ptr)
	fl_font(style,size)
	fl_color(fgcolor)
	fl_draw(s,x,y,w,h,align)
end sub

private sub fl_set_font_name(n as Fl_Font, s as const zstring ptr)
	Fl.set_font(n,s)
end sub

private sub fl_mapcolor(c as Fl_Color, r as ubyte, g as ubyte, b as ubyte)
	Fl.set_color(c,r,g,b)
end sub

#define fl_set_clipping(x,y,w,h) fl_push_clip(x,y,w,h)
#define fl_unset_clipping() fl_pop_clip()

private function fl_add_new overload(p as Fl_Widget ptr) as Fl_Widget ptr
	return p
end function
private function fl_add_new overload(t as ubyte, p as Fl_Widget ptr) as Fl_Widget ptr
	p->type_(t): return p
end function

#macro forms_constructor(__type,name) _
private function name(t as ubyte, x as long, y as long, w as long, h as long,l as const zstring ptr) as __type ptr
	return cast(__type ptr, fl_add_new(t, new __type(x,y,w,h,l)))
end function
#endmacro
#macro forms_constructort(__type,name)
private function name(t as ubyte, x as long, y as long, w as long, h as long,l as const zstring ptr) as __type ptr
	return cast(__type ptr, fl_add_new(new __type(t,x,y,w,h,l)))
end function
#endmacro
#macro forms_constructorb(__type,name)
private function name(t as Fl_Boxtype, x as long, y as long, w as long, h as long,l as const zstring ptr) as __type ptr
	return cast(__type ptr, fl_add_new(new __type(t,x,y,w,h,l)))
end function
#endmacro

#include once "Fl_FormsBitmap.bi"
#define FL_NORMAL_BITMAP FL_NO_BOX
forms_constructorb(Fl_FormsBitmap, fl_add_bitmap)
private sub fl_set_bitmap_data(o as Fl_Widget ptr, w as long, h as long, b as const zstring ptr)
	cast(Fl_FormsBitmap ptr, o)->set(w,h,b)
end sub

#include once "Fl_FormsPixmap.bi"
#define FL_NORMAL_PIXMAP FL_NO_BOX
forms_constructorb(Fl_FormsPixmap, fl_add_pixmap)
private sub fl_set_pixmap_data(o as Fl_Widget ptr, b as byte ptr const ptr)
	cast(Fl_FormsPixmap ptr,o)->set(b)
end sub
private sub fl_set_pixmap_align(o as Fl_Widget ptr,a as Fl_Align, x as long, y as long)
	o->align(a)
end sub

#include once "Fl_Box.bi"
forms_constructorb(Fl_Box, fl_add_box)

#include once "Fl_Browser.bi"
forms_constructor(Fl_Browser, fl_add_browser)

private sub fl_clear_browser(o as Fl_Widget ptr)
	cast(Fl_Browser ptr,o)->clear()
end sub
private sub fl_add_browser_line(o as Fl_Widget ptr, s as const zstring ptr)
	cast(Fl_Browser ptr,o)->add(s)
end sub
private sub fl_addto_browser(o as Fl_Widget ptr, s as const zstring ptr)
	cast(Fl_Browser ptr,o)->add(s)
end sub
private sub fl_insert_browser_line(o as Fl_Widget ptr, n as long, s as const zstring ptr)
	cast(Fl_Browser ptr,o)->insert(n,s)
end sub
private sub fl_delete_browser_line(o as Fl_Widget ptr, n as long)
	cast(Fl_Browser ptr,o)->remove(n)
end sub
private sub fl_replace_browser_line(o as Fl_Widget ptr, n as long, s as const zstring ptr)
	cast(Fl_Browser ptr,o)->replace(n,s)
end sub
private function fl_get_browser_line(o as Fl_Widget ptr, n as long) as zstring ptr
	return cast(zstring ptr, cast(Fl_Browser ptr,o)->text(n))
end function
private function fl_load_browser(o as Fl_Widget ptr, f as const zstring ptr) as long
	return cast(Fl_Browser ptr,o)->load(f)
end function
private sub fl_select_browser_line(o as Fl_Widget ptr, n as long)
	cast(Fl_Browser ptr,o)->select_(n,1)
end sub
private sub fl_deselect_browser_line(o as Fl_Widget ptr, n as long)
	cast(Fl_Browser ptr,o)->select_(n,0)
end sub
private sub fl_deselect_browser(o as Fl_Widget ptr)
	cast(Fl_Browser ptr,o)->deselect()
end sub
private function fl_isselected_browser_line(o as Fl_Widget ptr, n as long) as long
	return cast(Fl_Browser ptr,o)->selected(n)
end function
private function fl_get_browser_topline(o as Fl_Widget ptr) as long
	return cast(Fl_Browser ptr,o)->topline()
end function
private function fl_get_browser(o as Fl_Widget ptr) as long
	return cast(Fl_Browser ptr,o)->value()
end function
private function fl_get_browser_maxline(o as Fl_Widget ptr) as long
	return cast(Fl_Browser ptr,o)->size()
end function
private sub fl_set_browser_topline(o as Fl_Widget ptr, n as long)
	cast(Fl_Browser ptr,o)->topline(n)
end sub
private sub fl_set_browser_fontsize(o as Fl_Widget ptr, s as long)
	cast(Fl_Browser ptr,o)->textsize(s)
end sub
private sub fl_set_browser_fontstyle(o as Fl_Widget ptr, s as Fl_Font)
	cast(Fl_Browser ptr,o)->textfont(s)
end sub
private sub fl_set_browser_specialkey(o as Fl_Widget ptr, c as byte)
	cast(Fl_Browser ptr,o)->format_char(c)
end sub
private sub fl_setdisplayed_browser_line(o as Fl_Widget ptr, n as long, i as long)
	cast(Fl_Browser ptr,o)->display(n,i)
end sub
private function fl_isdisplayed_browser_line(o as Fl_Widget ptr, n as long) as long
    return cast(Fl_Browser ptr,o)->displayed(n)
end function

#include once "Fl_Button.bi"

#define FL_NORMAL_BUTTON	0
#define FL_TOUCH_BUTTON		4
#define FL_INOUT_BUTTON		5
#define FL_RETURN_BUTTON_	6
#define FL_HIDDEN_RET_BUTTON	7
#define FL_PUSH_BUTTON		FL_TOGGLE_BUTTON
#define FL_MENU_BUTTON_		9

declare function fl_add_button(t as unsigned byte, x as long, y as long, w as long, h as long,l as const zstring ptr) as Fl_Button ptr
private function fl_get_button(b as Fl_Widget ptr) as long
	return cast(Fl_Button ptr,b)->value()
end function
private sub fl_set_button(b as Fl_Widget ptr, v as long)
	cast(Fl_Button ptr,b)->value(v)
end sub
private function fl_get_button_numb(x as Fl_Widget ptr) as long
	return Fl.event_button()
end function
private sub fl_set_button_shortcut(b as Fl_Widget ptr, s as zstring ptr, x as long=0)
	cast(Fl_Button ptr, b)->shortcut(s)
end sub

#include once "Fl_Light_Button.bi"
forms_constructor(Fl_Light_Button, fl_add_lightbutton)

#include once "Fl_Round_Button.bi"
forms_constructor(Fl_Round_Button, fl_add_roundbutton)
forms_constructor(Fl_Round_Button, fl_add_round3dbutton)

#include once "Fl_Check_Button.bi"
forms_constructor(Fl_Check_Button, fl_add_checkbutton)

private function fl_add_bitmapbutton(t as long, x as long, y as long, w as long, h as long, l as const zstring ptr) as Fl_Widget ptr
	dim o as Fl_Widget ptr = fl_add_button(t,x,y,w,h,l): return o
end function
private sub fl_set_bitmapbutton_data(o as Fl_Widget ptr, a as long, b as long, c as ubyte ptr)
	(new Fl_Bitmap(c,a,b))->label(o)
end sub

private function fl_add_pixmapbutton(t as long, x as long, y as long, w as long, h as long, l as const zstring ptr) as Fl_Widget ptr
	dim o as Fl_Widget ptr = fl_add_button(t,x,y,w,h,l) : return o
end function
private sub fl_set_pixmapbutton_data(o as Fl_Widget ptr, c as const byte ptr const ptr)
	(new Fl_Pixmap(c))->label(o)
end sub

#include once "Fl_Chart.bi"

forms_constructor(Fl_Chart, fl_add_chart)
private sub fl_clear_chart(o as Fl_Widget ptr)
	cast(Fl_Chart ptr,o)->clear()
end sub
private sub fl_add_chart_value(o as Fl_Widget ptr, v as double,s as const zstring ptr, c as ubyte)
	cast(Fl_Chart ptr,o)->add(v,s,c)
end sub
private sub fl_insert_chart_value(o as Fl_Widget ptr, i as long, v as double, s as const zstring ptr, c as ubyte)
	cast(Fl_Chart ptr,o)->insert(i,v,s,c)
end sub
private sub fl_replace_chart_value(o as Fl_Widget ptr, i as long, v as double, s as const zstring ptr, c as ubyte)
	cast(Fl_Chart ptr,o)->replace(i,v,s,c)
end sub
private sub fl_set_chart_bounds(o as Fl_Widget ptr, a as double, b as double)
	cast(Fl_Chart ptr,o)->bounds(a,b)
end sub
private sub fl_set_chart_maxnumb(o as Fl_Widget ptr, v as long)
	cast(Fl_Chart ptr,o)->maxsize(v)
end sub
private sub fl_set_chart_autosize(o as Fl_Widget ptr, v as long)
	cast(Fl_Chart ptr,o)->autosize(v)
end sub
private sub fl_set_chart_lstyle(o as Fl_Widget ptr, v as Fl_Font)
	cast(Fl_Chart ptr,o)->textfont(v)
end sub
private sub fl_set_chart_lsize(o as Fl_Widget ptr, v as long)
	cast(Fl_Chart ptr,o)->textsize(v)
end sub
private sub fl_set_chart_lcolor(o as Fl_Widget ptr, v as Fl_Color)
	cast(Fl_Chart ptr,o)->textcolor(v)
end sub
#define fl_set_chart_lcol   fl_set_chart_lcolor

#include once "Fl_Choice.bi"

#define FL_NORMAL_CHOICE	0
#define FL_NORMAL_CHOICE2	0
#define FL_DROPLIST_CHOICE	0

forms_constructor(Fl_Choice, fl_add_choice)
private sub fl_clear_choice(o as Fl_Widget ptr)
	cast(Fl_Choice ptr,o)->clear()
end sub
private sub fl_addto_choice(o as Fl_Widget ptr, s as const zstring ptr)
	cast(Fl_Choice ptr,o)->add(s)
end sub
private sub fl_replace_choice(o as Fl_Widget ptr, i as long, s as const zstring ptr)
	cast(Fl_Choice ptr,o)->replace(i-1,s)
end sub
private sub fl_delete_choice(o as Fl_Widget ptr, i as long)
	cast(Fl_Choice ptr,o)->remove(i-1)
end sub
private sub fl_set_choice(o as Fl_Widget ptr, i as long)
	cast(Fl_Choice ptr,o)->value(i-1)
end sub
private function fl_get_choice(o as Fl_Widget ptr) as long
	return cast(Fl_Choice ptr,o)->value()+1
end function
private function fl_get_choice_text(o as Fl_Widget ptr) as const zstring ptr
	return cast(Fl_Choice ptr,o)->text()
end function
private sub fl_set_choice_fontsize(o as Fl_Widget ptr, x as long)
	cast(Fl_Choice ptr,o)->textsize(x)
end sub
private sub fl_set_choice_fontstyle(o as Fl_Widget ptr, x as Fl_Font)
	cast(Fl_Choice ptr,o)->textfont(x)
end sub

#include once "Fl_Clock.bi"
forms_constructort(Fl_Clock, fl_add_clock)
private sub fl_get_clock(o as Fl_Widget ptr, h as long ptr, m as long ptr, s as long ptr)
	*h = cast(Fl_Clock ptr, o)->hour()
	*m = cast(Fl_Clock ptr, o)->minute()
	*s = cast(Fl_Clock ptr, o)->second()
end sub

#include once "Fl_Counter.bi"
forms_constructor(Fl_Counter, fl_add_counter)
private sub fl_set_counter_value(o as Fl_Widget ptr, v as double)
	cast(Fl_Counter ptr, o)->value(v)
end sub
private sub fl_set_counter_bounds(o as Fl_Widget ptr, a as double, b as double)
	cast(Fl_Counter ptr, o)->bounds(a,b)
end sub
private sub fl_set_counter_step(o as Fl_Widget ptr, a as double, b as double)
	cast(Fl_Counter ptr, o)->step_(a,b)
end sub
private sub fl_set_counter_precision(o as Fl_Widget ptr, v as long)
	cast(Fl_Counter ptr, o)->precision(v)
end sub
private sub fl_set_counter_return(o as Fl_Widget ptr, v as long)
	cast(Fl_Counter ptr, o)->when(cast(Fl_When,v or FL_WHEN_RELEASE))
end sub
private function fl_get_counter_value(o as Fl_Widget ptr) as double
	return cast(Fl_Counter ptr, o)->value()
end function
private sub fl_get_counter_bounds(o as Fl_Widget ptr, a as single ptr, b as single ptr)
	*a = cast(single, cast(Fl_Counter ptr, o)->minimum())
	*b = cast(single, cast(Fl_Counter ptr, o)->maximum())
end sub

private sub fl_set_cursor(w as Fl_Window ptr, c as Fl_Cursor)
	w->cursor(c)
end sub

#define FL_INVISIBLE_CURSOR FL_CURSOR_NONE
#define FL_DEFAULT_CURSOR FL_CURSOR_DEFAULT

#include once "Fl_Dial.bi"

#define FL_DIAL_COL1 FL_GRAY
#define FL_DIAL_COL2 37

forms_constructor(Fl_Dial, fl_add_dial)
private sub fl_set_dial_value(o as Fl_Widget ptr, v as double)
	cast(Fl_Dial ptr, o)->value(v)
end sub
private function fl_get_dial_value(o as Fl_Widget ptr) as double
	return cast(Fl_Dial ptr, o)->value()
end function
private sub fl_set_dial_bounds(o as Fl_Widget ptr, a as double, b as double)
	cast(Fl_Dial ptr, o)->bounds(a, b)
end sub
private sub fl_get_dial_bounds(o as Fl_Widget ptr, a as single ptr, b as single ptr)
	*a = cast(single, cast(Fl_Dial ptr, o)->minimum())
	*b = cast(single, cast(Fl_Dial ptr, o)->maximum())
end sub
private sub fl_set_dial_return(o as Fl_Widget ptr, i as long)
	cast(Fl_Dial ptr, o)->when(cast(Fl_When,i or FL_WHEN_RELEASE))
end sub
private sub fl_set_dial_angles(o as Fl_Widget ptr, a as long, b as long)
	cast(Fl_Dial ptr, o)->angles(cast(short,a), cast(short,b))
end sub
private sub fl_set_dial_step(o as Fl_Widget ptr, v as double)
	cast(Fl_Dial ptr, o)->step_(v)
end sub

private function fl_add_frame(i as Fl_Boxtype, x as long, y as long, w as long, h as long, l as const zstring ptr) as Fl_Widget ptr
	return fl_add_box(i,x-3,y-3,w+6,h+6,l)
end function

private function fl_add_labelframe(i as Fl_Boxtype, x as long, y as long, w as long, h as long, l as const zstring ptr) as Fl_Widget ptr
	dim o as Fl_Widget ptr = fl_add_box(i,x-3,y-3,w+6,h+6,l)
	o->align(FL_ALIGN_TOP_LEFT)
	return o
end function

#include once "Fl_Free.bi"
declare function fl_add_free(t as long, x as double, y as double, w as double, h as double, l as const zstring ptr, hdl as FL_HANDLEPTR) as Fl_Free ptr
	return cast(Fl_Free ptr, (fl_add_new(new Fl_Free(t,cast(long, x),cast(long, y), cast(long, w), cast(long, h),l,hdl)))
end function

#include once "fl_ask.bi"
#include once "fl_show_colormap.bi"

private function fl_show_question overload(c as const zstring ptr, x as long = 0) as long
	return fl_choice_("%s",fl_no,fl_yes,0L,c)
end function
declare sub fl_show_message(as const zstring ptr, as const zstring ptr, as const zstring ptr)
declare sub fl_show_alert(as const zstring ptr, as const  zstring ptr, as const zstring ptr, as long=0)
declare function fl_show_question overload(as const zstring ptr, as const zstring ptr, as const zstring ptr) as long
private function fl_show_input(l as const zstring ptr, d as const zstring ptr=0) as const zstring ptr
	return _fl_input("%s",d,l)
end function
declare function fl_show_simple_input(label as const zstring ptr, deflt as const zstring ptr = 0) as zstring ptr
declare function fl_show_choice(m1 as const zstring ptr, m2 as const zstring ptr, m3 as const zstring ptr, numb as long, b0 as const zstring ptr, b1 as const zstring ptr, b2 as const zstring ptr) as long

private sub fl_set_goodies_font(a as Fl_Font, b as Fl_Fontsize)
	fl_message_font(a,b)
end sub
#define fl_show_messages fl_message
private function fl_show_choices(c as const zstring ptr, n as long, b1 as const zstring ptr, b2 as const zstring ptr, b3 as const zstring ptr, xx as long) as long
	return fl_show_choice(0,c,0,n,b1,b2,b3)
end function

#include once "filename.bi"
#include once "Fl_File_Chooser.bi"
private function do_matching(a as zstring ptr, b as const zstring ptr) as long
	return fl_filename_match(a,b)
end function

declare function fl_show_file_selector(message as const zstring ptr, dir_ as const zstring ptr, pat as const zstring ptr, fname as const zstring ptr) as zstring ptr
declare function fl_get_directory() as zstring ptr
declare function fl_get_pattern() as zstring ptr
declare function fl_get_filename() as zstring ptr

#include once "Fl_Input.bi"
forms_constructor(Fl_Input, fl_add_input)
private sub fl_set_input(o as Fl_Widget ptr, v as const zstring ptr)
	cast(Fl_Input ptr,o)->value(v)
end sub
private sub fl_set_input_return(o as Fl_Widget ptr, x as long)
	cast(Fl_Input ptr,o)->when(cast(Fl_When,x or FL_WHEN_RELEASE))
end sub
private sub fl_set_input_color(o as Fl_Widget ptr, a as Fl_Color, b as Fl_Color)
	cast(Fl_Input ptr,o)->textcolor(a)
	cast(Fl_Input ptr,o)->cursor_color(b)
end sub

private sub fl_set_input_cursorpos(o as Fl_Widget ptr, x as long, y as long)
	cast(Fl_Input ptr,o)->position(x)
end sub
private function fl_get_input_cursorpos(o as Fl_Widget ptr, x as long ptr, y as long ptr) as long
	*x = cast(Fl_Input ptr,o)->position(): *y = 0: return *x
end function
private function fl_get_input(o as Fl_Widget ptr) as const zstring ptr
	return 	cast(Fl_Input ptr,o)->value()
end function

#include once "Fl_Menu_Button.bi"

#define FL_TOUCH_MENU		0
#define FL_PUSH_MENU		1
#define FL_PULLDOWN_MENU	2
forms_constructor(Fl_Menu_Button, fl_add_menu)

private sub fl_clear_menu(o as Fl_Widget ptr)
	cast(Fl_Menu_Button ptr,o)->clear()
end sub
private sub fl_set_menu(o as Fl_Widget ptr, s as const zstring ptr)
	cast(Fl_Menu_Button ptr,o)->clear(): cast(Fl_Menu_Button ptr,o)->add(s)
end sub
private sub fl_addto_menu(o as Fl_Widget ptr, s as const zstring ptr)
	cast(Fl_Menu_Button ptr,o)->add(s)
end sub
private sub fl_replace_menu_item(o as Fl_Widget ptr, i as long, s as const zstring ptr)
	cast(Fl_Menu_Button ptr,o)->replace(i-1,s)
end sub
private sub fl_delete_menu_item(o as Fl_Widget ptr, i as long)
	cast(Fl_Menu_Button ptr,o)->remove(i-1)
end sub
private sub fl_set_menu_item_shortcut(o as Fl_Widget ptr, i as long, s as const zstring ptr)
	cast(Fl_Menu_Button ptr,o)->shortcut(i-1,fl_old_shortcut(s))
end sub
private sub fl_set_menu_item_mode(o as Fl_Widget ptr, i as long, x as long)
	cast(Fl_Menu_Button ptr,o)->mode(i-1,x)
end sub
private sub fl_show_menu_symbol(o as Fl_Widget ptr, z as long) 
end sub
private function fl_get_menu(o as Fl_Widget ptr) as long
	return cast(Fl_Menu_Button ptr,o)->value()+1
end function
private function fl_get_menu_item_text(o as Fl_Widget ptr, i as long) as const zstring ptr
	return cast(Fl_Menu_Button ptr,o)->text(i)
end function
private function fl_get_menu_maxitems(o as Fl_Widget ptr) as long
	return cast(Fl_Menu_Button ptr,o)->size()
end function
private function fl_get_menu_item_mode(o as Fl_Widget ptr, i as long) as long
	return cast(Fl_Menu_Button ptr,o)->mode(i)
end function
private function fl_get_menu_text(o as Fl_Widget ptr)  as const zstring ptr
	return cast(Fl_Menu_Button ptr,o)->text()
end function

#include once "Fl_Positioner.bi"
#define FL_NORMAL_POSITIONER	0
forms_constructor(Fl_Positioner, fl_add_positioner)
private sub fl_set_positioner_xvalue(o as Fl_Widget ptr, v as double)
	cast(Fl_Positioner ptr,o)->xvalue(v)
end sub
private function fl_get_positioner_xvalue(o as Fl_Widget ptr) as double
	return cast(Fl_Positioner ptr,o)->xvalue()
end function
private sub fl_set_positioner_xbounds(o as Fl_Widget ptr, a as double, b as double)
	cast(Fl_Positioner ptr,o)->xbounds(a,b)
end sub
private sub fl_get_positioner_xbounds(o as Fl_Widget ptr, a as single ptr, b as single ptr)
	*a = cast(single,cast(Fl_Positioner ptr,o)->xminimum())
	*b = cast(single,cast(Fl_Positioner ptr,o)->xmaximum())
end sub
private sub fl_set_positioner_yvalue(o as Fl_Widget ptr, v as double)
	cast(Fl_Positioner ptr,o)->yvalue(v)
end sub
private function fl_get_positioner_yvalue(o as Fl_Widget ptr) as double
	return cast(Fl_Positioner ptr,o)->yvalue()
end function
private sub fl_set_positioner_ybounds(o as Fl_Widget ptr, a as double, b as double)
	cast(Fl_Positioner ptr,o)->ybounds(a,b)
end sub
private sub fl_get_positioner_ybounds(o as Fl_Widget ptr, a as single ptr, b as single ptr)
	*a = cast(single, cast(Fl_Positioner ptr,o)->yminimum())
	*b = cast(single, cast(Fl_Positioner ptr,o)->ymaximum())
end sub
private sub fl_set_positioner_xstep(o as Fl_Widget ptr, v as double)
	cast(Fl_Positioner ptr,o)->xstep(v)
end sub
private sub fl_set_positioner_ystep(o as Fl_Widget ptr, v as double)
	cast(Fl_Positioner ptr,o)->ystep(v)
end sub
private sub fl_set_positioner_return(o as Fl_Widget ptr, v as long)
	cast(Fl_Positioner ptr,o)->when(cast(Fl_When, v or FL_WHEN_RELEASE))
end sub

#include once "Fl_Slider.bi"

#define FL_HOR_BROWSER_SLIDER FL_HOR_SLIDER_
#define FL_VERT_BROWSER_SLIDER FL_VERT_SLIDER_

forms_constructort(Fl_Slider, fl_add_slider)
#define FL_SLIDER_COL1 FL_GRAY
private sub fl_set_slider_value(o as Fl_Widget ptr, v as double)
	cast(Fl_Slider ptr,o)->value(v)
end sub
private function fl_get_slider_value(o as Fl_Widget ptr) as double
    return cast(Fl_Slider ptr,o)->value()
end function
private sub fl_set_slider_bounds(o as Fl_Widget ptr, a as double, b as double)
	cast(Fl_Slider ptr,o)->bounds(a, b)
end sub
private sub fl_get_slider_bounds(o as Fl_Widget ptr, a as single ptr, b as single ptr)
	*a = cast(single, cast(Fl_Slider ptr,o)->minimum())
	*b = cast(single, cast(Fl_Slider ptr,o)->maximum())
end sub
private sub fl_set_slider_return(o as Fl_Widget ptr, i as long)
	cast(Fl_Slider ptr,o)->when(cast(Fl_When, i or FL_WHEN_RELEASE))
end sub
private sub fl_set_slider_step(o as Fl_Widget ptr, v as double)
	cast(Fl_Slider ptr,o)->step_(v)
end sub
private sub fl_set_slider_size(o as Fl_Widget ptr, v as double)
	cast(Fl_Slider ptr,o)->slider_size(v)
end sub

#include once "Fl_Value_Slider.bi"
forms_constructor(Fl_Value_Slider, fl_add_valslider)

private sub fl_set_slider_precision(o as Fl_Widget ptr, i as long)
	cast(Fl_Value_Slider ptr,o)->precision(i)
end sub

type Fl_FormsText extends Fl_Widget
protected:
	declare sub draw()
	declare constructor (byref b as const Fl_FormsText)
	declare operator let (byref b as const Fl_FormsText)
public:
	declare constructor (b as Fl_Boxtype, X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
end type

#define FL_NORMAL_TEXT FL_NO_BOX
forms_constructorb(Fl_FormsText, fl_add_text)

#include once "Fl_Timer.bi"
forms_constructort(Fl_Timer, fl_add_timer)
private sub fl_set_timer(o as Fl_Widget ptr, v as double)
	cast(Fl_Timer ptr,o)->value(v)
end sub
private function fl_get_timer(o as Fl_Widget ptr) as double
	return cast(Fl_Timer ptr,o)->value()
end function
private sub fl_suspend_timer(o as Fl_Widget ptr)
	cast(Fl_Timer ptr,o)->suspended(1)
end sub
private sub fl_resume_timer(o as Fl_Widget ptr)
	cast(Fl_Timer ptr,o)->suspended(0)
end sub
private sub fl_set_timer_countup(o as Fl_Widget ptr, d as byte)
	cast(Fl_Timer ptr,o)->direction(d)
end sub
declare sub fl_gettime(sec as integer ptr, usec as integer ptr)

private function fl_double_click() as long
	return Fl.event_clicks()
end function
private sub fl_draw()
	Fl.flush()
end sub
end extern

private constructor Fl_FormsText(b as Fl_Boxtype, X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
	base(X,Y,W,H,l)
	box(b): align(FL_ALIGN_LEFT)
end constructor