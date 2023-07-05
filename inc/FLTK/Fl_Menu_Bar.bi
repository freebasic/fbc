#include once "Fl_Menu_.bi"

extern "c++"
type Fl_Menu_Bar extends Fl_Menu_
protected:
	declare constructor (byref b as const Fl_Menu_Bar)
	declare operator let (byref b as const Fl_Menu_Bar)

	declare virtual sub draw()
public:
	declare virtual function handle(h as long) as long
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)

end type

end extern

