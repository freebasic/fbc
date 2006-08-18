sub test_esc
#define hello !"\u039a\u03b1\u03bb\u03b7\u03bc\u03ad\u03c1\u03b1 "
#define world !"\u03ba\u03cc\u03c3\u03bc\u03b5!"
#define helloworld hello + world

	dim as wstring * 128 hw1 = !"\u039a\u03b1\u03bb\u03b7\u03bc\u03ad\u03c1\u03b1 \u03ba\u03cc\u03c3\u03bc\u03b5!"
	dim as wstring * 128 hw2 = helloworld

	assert( hw1 = hw2 )

	assert( hw1 = helloworld )

	assert( helloworld = hw2 )
end sub

sub test_noesc
#define hello $"\u039a\u03b1\u03bb\u03b7\u03bc\u03ad\u03c1\u03b1 "
#define world $"\u03ba\u03cc\u03c3\u03bc\u03b5!"
#define helloworld hello + world

	dim as wstring * 128 hw1 = $"\u039a\u03b1\u03bb\u03b7\u03bc\u03ad\u03c1\u03b1 \u03ba\u03cc\u03c3\u03bc\u03b5!"
	dim as wstring * 128 hw2 = helloworld

	assert( hw1 = hw2 )

	assert( hw1 = helloworld )

	assert( helloworld = hw2 )
end sub

	test_esc
	test_noesc