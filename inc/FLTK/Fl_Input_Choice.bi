#include once "Fl.bi"
#include once "Fl_Group.bi"
#include once "Fl_Input.bi"
#include once "Fl_Repeat_Button.bi"
#include once "Fl_Menu_Button.bi"
#include once "fl_draw.bi"


extern "c++"

type Fl_Input_Choice extends Fl_Group 
private:
	declare constructor (byref w as const Fl_Input_Choice)
	declare operator let (byref w as const Fl_Input_Choice)

	type InputMenuButton extends Fl_Menu_Button
	protected:
		declare constructor (byref b as const InputMenuButton)
		declare operator let (byref b as const InputMenuButton)
	private:
		declare sub draw()
	public:
		declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
	end type

	inp_ as Fl_Input ptr
	menu_ as InputMenuButton ptr

	declare static sub menu_cb(as Fl_Widget ptr, data_ as any ptr)
	declare static sub inp_cb(as Fl_Widget ptr, data_ as any ptr)

	declare function inp_x() as long
	declare function inp_y() as long
	declare function inp_w() as long
	declare function inp_h() as long

	declare function menu_x() as long
	declare function menu_y() as long
	declare function menu_w() as long
	declare function menu_h() as long
public:
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)

	declare sub add(s as const zstring ptr)
	declare const function changed() as long
	declare sub clear_changed()
	declare sub set_changed()
	declare sub clear()

	declare const function down_box() as Fl_Boxtype
	declare sub down_box(b as Fl_Boxtype)
	declare function menu() as const Fl_Menu_Item ptr
	declare sub menu(m as const Fl_Menu_Item ptr)
	declare sub resize(X as long, Y as long, W as long, H as long)
	declare const function textcolor() as Fl_Color
	declare sub textcolor(c as Fl_Color)
	declare const function textfont() as Fl_Font
	declare sub textfont(f as Fl_Font)
	declare const function textsize() as Fl_Fontsize
	declare sub textsize(s as Fl_Fontsize)
	declare const function value() as const zstring ptr
	declare sub value(val_ as const zstring ptr)
	declare sub value(val_ as long)

	declare function menubutton() as Fl_Menu_Button ptr
	declare function input() as Fl_Input ptr
end type

/'private sub Fl_Input_Choice.menu_cb(a as Fl_Widget ptr, data_ as any ptr)
    dim o as Fl_Input_Choice ptr=cast(Fl_Input_Choice ptr, data_)
    Fl_Widget_Tracker wp(o)
    dim as const Fl_Menu_Item ptr item = o->menubutton()->mvalue()
    if (item && item->flags & (FL_SUBMENU|FL_SUBMENU_POINTER)) return;	// ignore submenus
    if (!strcmp(o->inp_->value(), o->menu_->text()))
    {
      o->Fl_Widget::clear_changed();
      if (o->when() & FL_WHEN_NOT_CHANGED)
	o->do_callback();
    }
    else
    {
      o->inp_->value(o->menu_->text());
      o->inp_->set_changed();
      o->Fl_Widget::set_changed();
      if (o->when() & (FL_WHEN_CHANGED|FL_WHEN_RELEASE))
	o->do_callback();
    }
    
    if (wp.deleted()) return;

    if (o->callback() != default_callback)
    {
      o->Fl_Widget::clear_changed();
      o->inp_->clear_changed();
    }
end sub

private sub Fl_Input_Choice.inp_cb(a as Fl_Widget ptr, data_ as any ptr)
    Fl_Input_Choice *o=(Fl_Input_Choice *)data;
    Fl_Widget_Tracker wp(o);
    if (o->inp_->changed()) {
      o->Fl_Widget::set_changed();
      if (o->when() & (FL_WHEN_CHANGED|FL_WHEN_RELEASE))
	o->do_callback();
    } else {
      o->Fl_Widget::clear_changed();
      if (o->when() & FL_WHEN_NOT_CHANGED)
	o->do_callback();
    }
    
    if (wp.deleted()) return;

    if (o->callback() != default_callback)
      o->Fl_Widget::clear_changed();
end sub'/

private sub Fl_Input_Choice.InputMenuButton.draw() 
	draw_box(FL_UP_BOX, color())
	fl_color(iif(active_r(), labelcolor() , fl_inactive(labelcolor())))
	dim as long xc = x()+w()/2, yc=y()+h()/2
	fl_polygon(xc-5,yc-3,xc+5,yc-3,xc,yc+3)
	if Fl.focus() = @this then draw_focus()
end sub

private function Fl_Input_Choice.inp_x() as long
	return(x() + Fl.box_dx(box()))
end function

private function Fl_Input_Choice.inp_y() as long
	return(y() + Fl.box_dy(box()))
end function

private function Fl_Input_Choice.inp_w() as long
	return(w() - Fl.box_dw(box()) - 20)
end function

private function Fl_Input_Choice.inp_h() as long
	return(h() - Fl.box_dh(box()))
end function

private function Fl_Input_Choice.menu_x() as long
	return(x() + w() - 20 - Fl.box_dx(box()))
end function

private function Fl_Input_Choice.menu_y() as long
	return(y() + Fl.box_dy(box()))
end function

private function Fl_Input_Choice.menu_w() as long
	return(20)
end function

private function Fl_Input_Choice.menu_h() as long
	return(h() - Fl.box_dh(box()))
end function

private sub Fl_Input_Choice.add(s as const zstring ptr)
	menu_->add(s)
end sub

private function Fl_Input_Choice.changed() as long
	return inp_->changed() or base.changed()
end function

private sub Fl_Input_Choice.clear_changed()
	inp_->clear_changed()
	base.clear_changed()
end sub

private sub Fl_Input_Choice.set_changed()
	inp_->set_changed()
end sub

private sub Fl_Input_Choice.clear()
	menu_->clear()
end sub

private function Fl_Input_Choice.down_box() as Fl_Boxtype
	return menu_->down_box()
end function

private sub Fl_Input_Choice.down_box(b as Fl_Boxtype)
	menu_->down_box(b)
end sub

private function Fl_Input_Choice.menu() as const Fl_Menu_Item ptr
	return menu_->menu()
end function

private sub Fl_Input_Choice.menu(m as const Fl_Menu_Item ptr)
	menu_->menu(m)
end sub

private sub Fl_Input_Choice.resize(X as long, Y as long, W as long, H as long)
	base.resize(X,Y,W,H)
	inp_->resize(inp_x(), inp_y(), inp_w(), inp_h())
	menu_->resize(menu_x(), menu_y(), menu_w(), menu_h())
end sub

private function Fl_Input_Choice.textcolor() as Fl_Color
	return (inp_->textcolor())
end function

private sub Fl_Input_Choice.textcolor(c as Fl_Color)
	inp_->textcolor(c)
end sub

private function Fl_Input_Choice.textfont() as Fl_Font
	return (inp_->textfont())
end function

private sub Fl_Input_Choice.textfont(f as Fl_Font)
	inp_->textfont(f)
end sub

private function Fl_Input_Choice.textsize() as Fl_Fontsize
	return (inp_->textsize())
end function

private sub Fl_Input_Choice.textsize(s as Fl_Fontsize)
	inp_->textsize(s)
end sub

private function Fl_Input_Choice.value() as const zstring ptr
	return (inp_->value())
end function

private sub Fl_Input_Choice.value(val_ as const zstring ptr)
	inp_->value(val_)
end sub

private sub Fl_Input_Choice.value(val_ as long)
	menu_->value(val_)
	inp_->value(menu_->text(val_))
end sub

private function Fl_Input_Choice.menubutton() as Fl_Menu_Button ptr
	return menu_
end function

private function Fl_Input_Choice.input() as Fl_Input ptr
	return inp_
end function

end extern

