#include once "Fl_Input.bi"

extern "c++"
type Fl_File_Input extends Fl_Input
private:
	errorcolor_  as Fl_Color
	ok_entry_ as byte
	down_box_ as ubyte
	buttons_(199) as short
	pressed_ as short

	declare sub draw_buttons()
	declare function handle_button(event as long) as long
	declare sub update_buttons()
public:
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)
	declare virtual function handle(event as long) as long

protected:
	declare constructor (byref b as const Fl_File_Input)
	declare operator let (byref b as const Fl_File_Input)
	declare sub draw()
public:
	declare const function down_box() as Fl_Boxtype
	declare sub down_box(b as Fl_Boxtype)

	declare const function errorcolor() as Fl_Color
	declare sub errorcolor(c as Fl_Color)

	declare function value(str_ as const zstring ptr) as long
	declare function value(str_ as const zstring ptr, len_ as long) as long
	declare function value() as const zstring ptr
end type
end extern

private function Fl_File_Input.down_box() as Fl_Boxtype
	return cast(Fl_Boxtype,down_box_)
end function

private sub Fl_File_Input.down_box(b as Fl_Boxtype)
	down_box_=b
end sub

private function Fl_File_Input.errorcolor() as Fl_Color
	return errorcolor_
end function

private sub Fl_File_Input.errorcolor(c as Fl_Color)
	errorcolor_ = c
end sub

private function Fl_File_Input.value() as const zstring ptr
	return base.value()
end function


