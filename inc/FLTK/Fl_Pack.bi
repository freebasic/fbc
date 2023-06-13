#include once "Fl_Group.bi"

extern "c++"
type Fl_Pack extends Fl_Group
private:
	spacing_ as long

public:
	enum
		VERTICAL = 0
		HORIZONTAL_ = 1
	end enum

protected:
	declare constructor (byref b as const Fl_Pack)
	declare operator let (byref b as const Fl_Pack)

	declare sub draw()
public:
	declare constructor(x as long, y as long, w as long, h as long, l as const zstring ptr=0)
	declare const function spacing() as long 
	declare sub spacing(i as long)
	declare const function horizontal() as ubyte

end type
end extern

private function Fl_Pack.spacing() as long
	return spacing_
end function

private sub Fl_Pack.spacing(i as long)
	spacing_=i
end sub

private function Fl_Pack.horizontal() as ubyte
	return type_()
end function

