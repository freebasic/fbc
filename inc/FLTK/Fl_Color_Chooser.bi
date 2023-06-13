#include once "Fl_Group.bi"
#include once "Fl_Box.bi"
#include once "Fl_Return_Button.bi"
#include once "Fl_Choice.bi"
#include once "Fl_Value_Input.bi"

extern "c++"
type Flcc_HueBox extends Fl_Widget
private:
	as long px, py
protected:
	declare constructor (byref b as const Flcc_HueBox)
	declare operator let (byref b as const Flcc_HueBox)
	declare sub draw()
	declare function handle_key(as long) as long
public:
	declare function handle(as long) as long
	declare constructor(X as long, Y as long, W as long, H as long)
end type

type Flcc_ValueBox extends Fl_Widget
private:
	as long py
protected:
	declare constructor (byref b as const Flcc_ValueBox)
	declare operator let (byref b as const Flcc_ValueBox)
	declare sub draw()
	declare function handle_key(as long) as long
public:
	declare function handle(as long) as long
	declare constructor(X as long, Y as long, W as long, H as long)
end type

type Flcc_Value_Input extends Fl_Value_Input
protected:
	declare constructor (byref b as const Flcc_Value_Input)
	declare operator let (byref b as const Flcc_Value_Input)
public:
	declare function format(as zstring ptr) as long
	declare constructor(X as long, Y as long, W as long, H as long)
end type

type Fl_Color_Chooser extends Fl_Group
private:
	huebox as Flcc_HueBox = any
	valuebox as Flcc_ValueBox = any
	choice as Fl_Choice = any
	rvalue as Flcc_Value_Input = any
	gvalue as Flcc_Value_Input = any
	bvalue as Flcc_Value_Input = any
	resize_box as Fl_Box = any
	as double hue_, saturation_, value_
	as double r_, g_, b_
	declare sub set_valuators()
	declare static sub rgb_cb(as Fl_Widget ptr, as any ptr)
	declare static sub mode_cb(as Fl_Widget ptr, as any ptr)

protected:
	declare constructor (byref b as const Fl_Color_Chooser)
	declare operator let (byref b as const Fl_Color_Chooser)
public:
	declare function mode() as long
	declare sub mode(newMode as long)
	declare const function hue() as double
	declare const function saturation() as double
	declare const function value() as double
	declare const function r() as double
	declare const function g() as double
	declare const function b() as double
	declare function hsv(H as double, S as double, V as double) as long
	declare function rgb_ alias "rgb"(R as double, G as double, B as double) as long
	declare static sub hsv2rgb(H as double, S as double, V as double, byref R as double, byref G as double, byref B as double)
	declare static sub rgb2hsv(R as double, G as double, B as double, byref H as double, byref S as double, byref V as double)

	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
end type

'declare function fl_color_chooser (name as const zstring ptr, byval r as double, byval g as double, byval b as double,m as long=-1) as long
'declare function fl_color_chooser (name as const zstring ptr, byval r as ubyte, byval g as ubyte, byval b as ubyte,m as long=-1) as long
end extern

private function Fl_Color_Chooser.mode() as long
	return choice.value()
end function

private function Fl_Color_Chooser.hue() as double
	return hue_
end function

private function Fl_Color_Chooser.saturation() as double
	return saturation_
end function

private function Fl_Color_Chooser.value() as double
	return value_
end function

private function Fl_Color_Chooser.r() as double
	return r_
end function

private function Fl_Color_Chooser.g() as double
	return g_
end function

private function Fl_Color_Chooser.b() as double
	return b_
end function
