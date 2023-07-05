#include once "Fl_Light_Button.bi"


extern "c++"
type Fl_Check_Button extends Fl_Light_Button
protected:
	declare constructor (byref b as const Fl_Check_Button)
	declare operator let (byref b as const Fl_Check_Button)
public:
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)

end type

end extern

