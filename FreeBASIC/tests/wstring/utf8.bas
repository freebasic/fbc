#define hello "Καλημέρα "
#define world "κόσμε!"
#define helloworld hello + world

	dim as wstring * 32 hw1 = "Καλημέρα κόσμε!"
	dim as wstring * 32 hw2 = helloworld

	assert( hw1 = hw2 )

	assert( hw1 = helloworld )

	assert( helloworld = hw2 )
