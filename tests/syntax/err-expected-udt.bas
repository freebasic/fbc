'' FB_ERRMSG_EXPECTEDUDT

namespace n1
	type T extends object
		declare operator []( byval index as integer) as any ptr
	end type

	sub proc
		dim as T x
#print "-- 1 error expected"
		print x[0].invalid
	end sub
end namespace

namespace n2
	type T
		i as T ptr
	end type

	sub proc
		dim x as T
#print "-- 1 error expected"
		print x.i.i
	end sub
end namespace

namespace n3
	sub proc
		dim x as integer
#print "-- 1 error expected"
		print x.invalid
	end sub
end namespace

namespace n4
	type T
		i as integer
	end type

	sub proc
		dim x as T
#print "-- 1 error expected"
		print peek(@x).invalid
	end sub
end namespace

namespace n5
	function f() as any ptr
		function = 0
	end function

	sub proc
#print "-- 1 error expected"
		print f().invalid
	end sub
end namespace

namespace n6
	type T
		i as any ptr
	end type

	sub proc
		dim x as T
		dim px as T ptr = @x
#print "-- 1 error expected"
		print px->i.i
	end sub
end namespace
