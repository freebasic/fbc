'' dylibload()/dylibfree() call fb_hInitConsole()/fb_hExitConsole(), so we test them.

#include "testee-dylibload-only-examplelib.bas"

'' With explicit dylibfree(): The dynamic library's global dtors (including the FB runtime's one)
'' will run now, before those of the main program.
dylibfree(dylib)
