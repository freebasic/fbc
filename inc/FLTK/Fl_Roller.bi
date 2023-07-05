#include once "Fl_Valuator.bi"

extern "c++"
type Fl_Roller extends Fl_Valuator 
protected:
	declare sub draw()
	declare constructor (byref b as const Fl_Roller)
	declare operator let (byref b as const Fl_Roller)

public:
	declare function handle(as long) as long
	declare constructor(X as long, Y as long, W as long, H as long, L as const zstring ptr = 0)
end type

end extern
