#include once "Fl_Button.bi"


extern "c++"
type Fl_Light_Button extends Fl_Button
protected:
	declare constructor (byref b as const Fl_Light_Button)
	declare operator let (byref b as const Fl_Light_Button)

	declare virtual sub draw()
public:
	declare virtual function handle(h as long) as long
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)

end type

end extern

