

dim as string s1, s2

s1 = "a"
s2 = "b"

ASSERT( s1<>s2 )
ASSERT( s1<s2 )

s1 = "b"
s2 = "a"

ASSERT( s1<>s2 )
ASSERT( s1>s2 )

s1 = "a"
s2 = "a"

ASSERT( s1=s2 )

s1 = "a"
s2 = "ab"

ASSERT( s1<s2 )

s1 = "ab"
s2 = "a"

ASSERT( s1>s2 )
