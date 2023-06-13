#include once "Fl_Round_Button.bi"


extern "c++"
type Fl_Radio_Round_Button extends Fl_Round_Button
protected:
	declare constructor (byref b as const Fl_Radio_Round_Button)
	declare operator let (byref b as const Fl_Radio_Round_Button)
public:
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)

end type

end extern

