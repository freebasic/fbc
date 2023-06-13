#include once "Fl_Valuator.bi"

extern "c++"
type Fl_Adjuster extends Fl_Valuator
private:
	drag as long
	ix as long
	soft_ as long
protected:
	declare sub draw()
	declare function handle(as long) as long
	declare sub value_damage()

	declare constructor (byref b as const Fl_Adjuster)
	declare operator let (byref b as const Fl_Adjuster)
public:
	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)

	declare sub soft(s as long)
	declare const function soft() as long
end type
end extern

private sub Fl_Adjuster.soft(s as long)
	soft_=s
end sub

private function Fl_Adjuster.soft() as long
	return soft_
end function