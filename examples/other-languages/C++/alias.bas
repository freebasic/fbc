'' An example showing that FB namespaces can use aliases,
'' in this case it's used as a work-around: the C++ namespace is named "str",
'' but that's an FB keyword, so on the FB side this example uses "str_".

extern "c++" lib "alias"
	namespace str_ alias "str"
		declare sub ucaseme( byval inout_str as zstring ptr )
	end namespace
end extern

dim as zstring * 7 s
s = "Hello!"

print s
str_.ucaseme( s )
print s
