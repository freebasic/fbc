' TEST_MODE : COMPILE_AND_RUN_OK

'' (no EOL at end of file)

dim shared as integer ctors = 0, dtors = 0

type T
	as integer a
	declare constructor()
	declare destructor()
end type

constructor T()
	ctors += 1
end constructor

destructor T()
	dtors += 1
end destructor

sub check () destructor
	print ctors, dtors
	if( ctors <> 1 ) then end 1
	if( dtors <> 1 ) then end 2
end sub

dim as T obj

do
	exit do
loop