' TEST_MODE : COMPILE_ONLY_OK

#include once "dir.bi"

dim as long l
dim as longint ll
dim as integer i
dim as string s

s = dir( "*" )
s = dir( "*", fbNormal )
s = dir( "*", , l )
s = dir( "*", , ll )
s = dir( "*", , @l )
s = dir( "*", , @ll )
s = dir( "*", fbNormal, l )
s = dir( "*", fbNormal, ll )
s = dir( "*", fbNormal, @l )
s = dir( "*", fbNormal, @ll )

s = dir( )
s = dir( l )
s = dir( ll )
s = dir( @l )
s = dir( @ll )
