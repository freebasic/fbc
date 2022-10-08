'' ------------------------------------
#print "---"
#print "2 errors for field members as parent type"

namespace n1
	type T1
		__ as integer
		type T2
			member1 as T1
			as T1 member2
		end type
	end type
end namespace
