#include once "Fl_Slider.bi"

extern "c++"
type Fl_Hor_Fill_Slider extends Fl_Slider
protected:
	declare constructor (byref b as const Fl_Hor_Fill_Slider)
	declare operator let (byref b as const Fl_Hor_Fill_Slider)
public:
	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
end type
end extern

