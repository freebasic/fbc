' TEST_MODE : COMPILE_AND_RUN_OK

#define ASSERT(e) if (e) = FALSE then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

dim i as long, l as long
dim si as string, sl as string
dim s as string

'' constant:
i = cvi("ABCD")
l = cvl("ABCD")

si = mki$(&h44434241)
sl = mkl$(&h44434241)


assert(i = &h4241)
assert(l = &h44434241)

assert(si = "AB")
assert(sl = "ABCD")



'' variable:
sl = "ABCD"
i = cvi(sl)
l = cvl(sl)

l = &h44434241
si = mki$(l)
sl = mkl$(l)


assert(i = &h4241)
assert(l = &h44434241)

assert(si = "AB")
assert(sl = "ABCD")
