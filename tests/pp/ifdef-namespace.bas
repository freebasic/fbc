' TEST_MODE : COMPILE_ONLY_OK

'' Regression test for namespaces being used in #ifdef/#undef etc.

namespace A
end namespace

#if defined(A)
#endif

#ifdef A
#endif

#ifndef A
#endif

#undef A
print "hi"
