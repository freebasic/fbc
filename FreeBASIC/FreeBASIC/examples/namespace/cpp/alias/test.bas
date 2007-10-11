
extern "c++" lib "cpplib"
	namespace str_ alias "str"
		declare function ucaseme ( byval inout_str as zstring ptr ) as zstring ptr
	end namespace
end extern

    print *str_.uCaSeMe( "Hello!" )
