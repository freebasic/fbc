' TEST_MODE : COMPILE_AND_RUN_OK

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

dim i as integer, l as long, i32 as integer<32>
dim si as string, sl as string, si32 as string
dim s as string


'' constant:
i = cvi("ABCD")
l = cvl("ABCD")
i32 = cvi<32>("ABCD")

si = mki$(&h44434241)
sl = mkl$(&h44434241)
si32 = mki$<32>(&h44434241)

assert(i = &h4241)
assert(l = &h44434241)
assert(i32 = &h44434241)

assert(si = "AB")
assert(sl = "ABCD")
assert(si32 = "ABCD")


'' variable:
si = "AB"
sl = "ABCD"
si32 = "ABCD"

i = cvi(si)
l = cvl(sl)
i32 = cvi<32>(si32)

assert(i = &h4241)
assert(l = &h44434241)
assert(i32 = &h44434241)

si = mki$(i)
sl = mkl$(l)
sl = mki$<32>(i32)

assert(si = "AB")
assert(sl = "ABCD")
assert(si32 = "ABCD")
