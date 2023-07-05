#include once "Fl_Slider.bi"

extern "c++"
type Fl_Nice_Slider extends Fl_Slider
protected:
	declare constructor (byref b as const Fl_Nice_Slider)
	declare operator let (byref b as const Fl_Nice_Slider)
public:
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr=0)

end type
end extern
