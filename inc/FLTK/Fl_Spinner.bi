#include once "Enumerations.bi"
#include once "Fl_Group.bi"
#include once "Fl_Input.bi"
#include once "Fl_Repeat_Button.bi"

#include once "crt/stdio.bi"

extern "c++"
type Fl_Spinner extends Fl_Group
	value_ as double
	minimum_ as double
	maximum_ as double
	step__ as double
	format_ as const zstring ptr

	input_ as Fl_Input = any
	up_button_ as Fl_Repeat_Button = any
	down_button_ as Fl_Repeat_Button = any

	declare static sub sb_cb(w as Fl_Widget ptr, sb as Fl_Spinner ptr)
	declare sub update()
protected:
	declare constructor (byref b as const Fl_Spinner)
	declare operator let (byref b as const Fl_Spinner)

public:
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr = 0)

	declare function format() as const zstring ptr
	declare sub format(f as const zstring ptr)
	declare function handle(event as long) as long

	declare const function maximum() as double
	declare sub maximum(m as double)
	declare const function minimum() as double
	declare sub minimum(m as double)
	declare sub range(a as double, b as double)
	declare sub resize(X as long, Y as long, W as long, H as long)
	declare const function step_() as double
	declare sub step_(s as double)
	declare const function textcolor() as Fl_Color
	declare sub textcolor(c as Fl_Color)
	declare const function textfont() as Fl_Font
	declare sub textfont(f as Fl_Font)
	declare const function textsize() as Fl_Fontsize
	declare sub textsize(s as Fl_Fontsize)
	declare const function type_() as ubyte
	declare sub type_(v as ubyte)
	declare const function value() as double
	declare sub value(v as double)
	declare sub color(v as Fl_Color)
	declare const function color() as Fl_Color
	declare sub selection_color(val_ as Fl_Color)
	declare const function selection_color() as Fl_Color
end type
end extern

private sub Fl_Spinner.sb_cb(w as Fl_Widget ptr, sb as Fl_Spinner ptr)

	dim v as double

	if w = @sb->input_ then
		v = val(*sb->input_.value())

		if v < sb->minimum_ then
			sb->value_ = sb->minimum_
			sb->update()
		elseif v > sb->maximum_ then
			sb->value_ = sb->maximum_
			sb->update()
		else
			sb->value_ = v
		end if
	elseif w = @sb->up_button_ then
		v = sb->value_ + sb->step__

		if v > sb->maximum_ then
			sb->value_ = sb->minimum_
		else
			sb->value_ = v
		end if

		sb->update()
	elseif w = @sb->down_button_ then
		v = sb->value_ - sb->step__

		if v < sb->minimum_ then 
			sb->value_ = sb->maximum_
		else
			sb->value_ = v
		end if

		sb->update()
	end if

	sb->set_changed()
	sb->do_callback()

end sub

private sub Fl_Spinner.update()
	dim s as zstring * 255

	if left(*format_,3)="%.*" then
		dim c as integer = 0
		dim temp as zstring * 64
		dim sp as zstring ptr=@temp
		sprintf(temp, "%.12f", step_)
		do while *sp: sp+=1: loop
		sp-=1
		do while sp>@temp andalso *sp=asc("0"): sp-=1:loop
		do while sp>@temp andalso (*sp>=asc("0") andalso *sp<=asc("9") ):  sp-=1: c+=1: loop
		sprintf(s, format_, c, value_)
	else 
		sprintf(s, format_, value_)
	end if
	input_.value(s)
end sub



private function Fl_Spinner.format() as const zstring ptr
	return format_
end function

private sub Fl_Spinner.format(f as const zstring ptr)
	format_=f
	update()
end sub


private function Fl_Spinner.handle(event as long) as long
	select case (event) 
	case FL_KEYDOWN,  FL_SHORTCUT 
		if Fl.event_key() = _FL_Up then
			up_button_.do_callback()
			return 1
		elseif Fl.event_key() = _FL_Down then
			down_button_.do_callback()
			return 1
		else
			return 0
		end if

	case FL_FOCUS
		if input_.take_focus() then return 1 else return 0
	end select
	return base.handle(event)

end function


private function Fl_Spinner.maximum() as double
	return maximum_
end function

private sub Fl_Spinner.maximum(m as double)
	maximum_=m
end sub

private function Fl_Spinner.minimum() as double
	return minimum_
end function

private sub Fl_Spinner.minimum(m as double)
	minimum_=m
end sub

private sub Fl_Spinner.range(a as double, b as double)
	minimum_=a: maximum_=b
end sub

private sub Fl_Spinner.resize(X as long, Y as long, W as long, H as long)
	base.resize(X,Y,W,H)

	input_.resize(X, Y, W - H / 2 - 2, H)
	up_button_.resize(X + W - H / 2 - 2, Y, H / 2 + 2, H / 2)
	down_button_.resize(X + W - H / 2 - 2, Y + H - H / 2, H / 2 + 2, H / 2)
end sub

private function Fl_Spinner.step_() as double
	return step__
end function

private sub Fl_Spinner.step_(s as double)
	step__ = s
	if step__ <>cast(long, step__) then 
			input_.type_(FL_FLOAT_INPUT_)
	else
		 input_.type_(FL_INT_INPUT_)
	end if
	update()

end sub

private function Fl_Spinner.textcolor() as Fl_Color
	return input_.textcolor()
end function

private sub Fl_Spinner.textcolor(c as Fl_Color)
	input_.textcolor(c)
end sub

private function Fl_Spinner.textfont() as Fl_Font
	return input_.textfont()
end function

private sub Fl_Spinner.textfont(f as Fl_Font)
	input_.textfont(f)
end sub

private function Fl_Spinner.textsize() as Fl_Fontsize
	return input_.textsize()
end function

private sub Fl_Spinner.textsize(s as Fl_Fontsize)
	input_.textsize(s)
end sub

private function Fl_Spinner.type_() as ubyte
	return input_.type_()
end function

private sub Fl_Spinner.type_(v as ubyte)
	if v=FL_FLOAT_INPUT_ then
		format("%.*f")
	else
		format("%.0f")
	end if

	input_.type_(v)
end sub

private function Fl_Spinner.value() as double
	return value_
end function

private sub Fl_Spinner.value(v as double)
	value_ = v: update()
end sub

private sub Fl_Spinner.color(v as Fl_Color)
	input_.color(v)
end sub

private function Fl_Spinner.color() as Fl_Color
	return input_.color()
end function

private sub Fl_Spinner.selection_color(val_ as Fl_Color)
	input_.selection_color(val_)
end sub

private function Fl_Spinner.selection_color() as Fl_Color
	return input_.selection_color()
end function


