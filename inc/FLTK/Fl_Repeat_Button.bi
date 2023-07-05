#include once "Fl.bi"
#include once "Fl_Button.bi"


extern "c++"
type Fl_Repeat_Button extends Fl_Button
private:
	declare static sub repeat_callback(as any ptr)
protected:
	declare constructor (byref b as const Fl_Repeat_Button)
	declare operator let (byref b as const Fl_Repeat_Button)
public:
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)
	declare sub deactivate()

end type

end extern

private sub Fl_Repeat_Button.deactivate()
	Fl.remove_timeout(@repeat_callback,@this)

	base.deactivate()
end sub
