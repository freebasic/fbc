' TEST_MODE : COMPILE_ONLY_OK

'' This should mostly test assert()'s in fbc - for example in the -g STABS
'' emitter. Just to see whether the assumptions about var symbols are correct.

extern externarray() as integer
extern externstring as string
extern externinteger as integer

#if 0
dim externarray() as integer
dim externstring as string
dim externinteger as integer
#endif

extern publicarray() as integer
dim publicarray() as integer
extern publicstring as string
dim publicstring as string
extern publicinteger as integer
dim publicinteger as integer = 123

common commonarray() as integer
common commonstring as string
common commoninteger as integer

common shared commonsharedarray() as integer
common shared commonsharedstring as string
common shared commonsharedinteger as integer

dim shared dimsharedarray() as integer
dim shared dimsharedstring as string
dim shared dimsharedinteger as integer = 123

static shared staticsharedarray() as integer
static shared staticsharedstring as string
static shared staticsharedinteger as integer = 123

dim localarray() as integer
dim localstring as string
dim localinteger as integer = 123

static staticlocalarray() as integer
static staticlocalstring as string
static staticlocalinteger as integer = 123

print externarray(0), publicarray(0), commonarray(0), commonsharedarray(0), dimsharedarray(0), staticsharedarray(0), localarray(0), staticlocalarray(0)
print externstring  , publicstring  , commonstring  , commonsharedstring  , dimsharedstring  , staticsharedstring  , localstring  , staticlocalstring
print externinteger , publicinteger , commoninteger , commonsharedinteger , dimsharedinteger , staticsharedinteger , localinteger , staticlocalinteger
