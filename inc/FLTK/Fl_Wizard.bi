#include once "Fl.bi"
#include once "Fl_Group.bi"

#inclib "fltk_forms"

extern "c++"

type Fl_Wizard  extends Fl_Group 
private:
	value_ as Fl_Widget ptr
	declare operator let (byref w as const Fl_Wizard)
	declare constructor (byref w as const Fl_Wizard)
	declare virtual sub draw()

public:
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)
	declare sub next_ alias "next"()
	declare sub prev()
	declare function value() as Fl_Widget ptr
	declare sub value(v as Fl_Widget ptr)

end type
end extern
