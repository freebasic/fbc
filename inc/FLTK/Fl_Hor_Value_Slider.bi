#include once "Fl_Value_Slider.bi"

extern "c++"
type Fl_Hor_Value_Slider extends Fl_Value_Slider
protected:
	declare constructor (byref b as const Fl_Hor_Value_Slider)
	declare operator let (byref b as const Fl_Hor_Value_Slider)
public:
	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
end type
end extern

