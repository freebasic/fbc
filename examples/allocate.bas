'' dynamic memory allocation example

'' Allocate a chunk of memory of a certain size, measured in bytes
dim as integer buffersize = 1024 * 8
dim as byte ptr buffer = allocate( buffersize )

'' Do something with the buffer
for i as integer = 0 to buffersize - 1
	buffer[i] = 123
next

'' Free up the allocated chunk after we're done using it
deallocate( buffer )

'' ------------------

type MyType
	x as integer
	y as integer
end type

dim pmytype as MyType ptr

pmytype = allocate( sizeof( MyType ) )

pmytype->x = 1234
pmytype->y = 5678

print pmytype->x, pmytype->y

deallocate( pmytype )

sleep
