#include once "gdsl/gdsl.bi"
#ifndef NULL
	const NULL = 0
#endif

dim shared keywords(0 to ...) as zstring ptr = _
{ _
	@"dim", @"as", @"integer", @"print", @"sleep", @"end" _
}

dim inputdata(0 to ...) as string = _
{ _
	"dim", "i", "as", "integer", _
	"print", "i", _
	"sleep", ":", "end" _
}

dim hash as gdsl_hash_t = gdsl_hash_alloc( "myhashtable", NULL, NULL, NULL, NULL, 32 )
for i as integer = lbound( keywords ) to ubound( keywords )
	gdsl_hash_insert( hash, keywords(i) )
next

for i as integer = lbound( inputdata ) to ubound( inputdata )
	print "input: " & inputdata(i);
	if( gdsl_hash_search( hash, inputdata(i) ) <> 0 ) then
		print , "(keyword)"
	else
		print , "(not a keyword)"
	end if
next

gdsl_hash_free( hash )
