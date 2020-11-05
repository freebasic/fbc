' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	private:
		declare constructor()
		declare sub proc()
end type

constructor T()
end constructor

sub T.proc()
	redim as T x(0 to 0)
end sub

 
