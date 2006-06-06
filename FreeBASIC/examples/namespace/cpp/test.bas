
extern "c++" lib "cpplib"
	namespace cpp
		declare function sum cdecl( byval a as integer, byval b as integer ) as integer        
	end namespace
end extern

	print "1 + 2 ="; cpp.sum( 1, 2 )
