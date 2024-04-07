#include once "Fl_Widget.bi"

extern "c++"
type Fl_Box extends Fl_Widget
protected:
	declare constructor (byref b as const Fl_Box)
	declare operator let (byref b as const Fl_Box)

	declare virtual sub draw()
public:
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)
	declare constructor(b as Fl_Boxtype, x as long, y as long, w as long, h as long, title as const zstring ptr)
	declare virtual function handle(h as long) as long

end type

end extern

