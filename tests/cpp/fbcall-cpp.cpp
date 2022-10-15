// implementation for fbcall-fbc.bas

// each operation records call information
// in static variables, and we use getters
// to retrieve it back to fbc side

#define NULL 0
static const void * ptr1 = NULL;
static const void * ptr2 = NULL;
static const void * ptr3 = NULL;
static char msg1[100];  // check message

void setMsg( const char* msg ) {
	char *s = msg1;
	while( *msg )
		*s++ = *msg++;
	*s = *msg;
}

void resetChecks() {
	ptr1 = NULL;
	ptr2 = NULL;
	ptr3 = NULL;
	setMsg( "" );
}

const void* getPtr1() {
	return ptr1;
}

const void* getPtr2() {
	return ptr2;
}

const void* getPtr3() {
	return ptr3;
}

char* getMsg1() {
	return msg1;
}

class UDT
{
	public:
		int value;
};

/*
Default calling convention for rtlib is either
cdecl or stdcall depending on target platform
Assuming a gcc compiler, stdcall should be
default for windows 32 bit.  For windows 64 bit
it doesn't matter.
*/

#if defined( __CYGWIN__ ) || defined( _WIN32 )
	#define FBCALL __attribute__((stdcall))
#else
	#define FBCALL __attribute__((cdecl))
#endif

extern "C" {
void sub1_rtlib_default( UDT const& a ) FBCALL;
void sub1_rtlib_cdecl( UDT const& a  ) __attribute__((cdecl));
void sub1_rtlib_stdcall( UDT const& a ) __attribute__((stdcall));
UDT func1_rtlib_default( UDT const& a ) FBCALL;
UDT func1_rtlib_cdecl( UDT const& a ) __attribute__((cdecl));
UDT func1_rtlib_stdcall( UDT const& a ) __attribute__((stdcall));

void sub2_rtlib_default( UDT const& a, UDT const& b ) FBCALL;
void sub2_rtlib_cdecl( UDT const& a, UDT const& b ) __attribute__((cdecl));
void sub2_rtlib_stdcall( UDT const& a, UDT const& b ) __attribute__((stdcall));
UDT func2_rtlib_default( UDT const& a, UDT const& b ) FBCALL;
UDT func2_rtlib_cdecl( UDT const& a, UDT const& b ) __attribute__((cdecl));
UDT func2_rtlib_stdcall( UDT const& a, UDT const& b ) __attribute__((stdcall));

void sub3_rtlib_default( UDT const& a, UDT const& b, UDT const& c ) FBCALL;
void sub3_rtlib_cdecl( UDT const& a, UDT const& b, UDT const& c ) __attribute__((cdecl));
void sub3_rtlib_stdcall( UDT const& a, UDT const& b, UDT const& c ) __attribute__((stdcall));
UDT func3_rtlib_default( UDT const& a, UDT const& b, UDT const& c ) FBCALL;
UDT func3_rtlib_cdecl( UDT const& a, UDT const& b, UDT const& c ) __attribute__((cdecl));
UDT func3_rtlib_stdcall( UDT const& a, UDT const& b, UDT const& c ) __attribute__((stdcall));
}

extern "C" {
void sub1_rtlib_default( UDT const& a ) {
	ptr1 = &a;
	setMsg( "sub1_rtlib_default" );
}

void sub1_rtlib_cdecl( UDT const& a ) {
	ptr1 = &a;
	setMsg( "sub1_rtlib_cdecl" );
}

void sub1_rtlib_stdcall( UDT const& a ) {
	ptr1 = &a;
	setMsg( "sub1_rtlib_stdcall" );
}

UDT func1_rtlib_default( UDT const& a ) {
	UDT ret = {0};
	ptr1 = &a;
	setMsg( "func1_rtlib_default" );
	return ret;
}

UDT func1_rtlib_cdecl( UDT const& a ) {
	UDT ret = {0};
	ptr1 = &a;
	setMsg( "func1_rtlib_cdecl" );
	return ret;
}

UDT func1_rtlib_stdcall( UDT const& a ) {
	UDT ret = {0};
	ptr1 = &a;
	setMsg( "func1_rtlib_stdcall" );
	return ret;
}

void sub2_rtlib_default( UDT const& a, UDT const& b ) {
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "sub2_rtlib_default" );
}

void sub2_rtlib_cdecl( UDT const& a, UDT const& b ) {
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "sub2_rtlib_cdecl" );
}

void sub2_rtlib_stdcall( UDT const& a, UDT const& b ) {
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "sub2_rtlib_stdcall" );
}

UDT func2_rtlib_default( UDT const& a, UDT const& b ) {
	UDT ret = {0};
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "func2_rtlib_default" );
	return ret;
}

UDT func2_rtlib_cdecl( UDT const& a, UDT const& b ) {
	UDT ret = {0};
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "func2_rtlib_cdecl" );
	return ret;
}

UDT func2_rtlib_stdcall( UDT const& a, UDT const& b ) {
	UDT ret = {0};
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "func2_rtlib_stdcall" );
	return ret;
}

void sub3_rtlib_default( UDT const& a, UDT const& b, UDT const& c ) {
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "sub3_rtlib_default" );
}

void sub3_rtlib_cdecl( UDT const& a, UDT const& b, UDT const& c ) {
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "sub3_rtlib_cdecl" );
}

void sub3_rtlib_stdcall( UDT const& a, UDT const& b, UDT const& c ) {
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "sub3_rtlib_stdcall" );
}

UDT func3_rtlib_default( UDT const& a, UDT const& b, UDT const& c ) {
	UDT ret = {0};
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "func3_rtlib_default" );
	return ret;
}

UDT func3_rtlib_cdecl( UDT const& a, UDT const& b, UDT const& c ) {
	UDT ret = {0};
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "func3_rtlib_cdecl" );
	return ret;
}

UDT func3_rtlib_stdcall( UDT const& a, UDT const& b, UDT const& c ) {
	UDT ret = {0};
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "func3_rtlib_stdcall" );
	return ret;
}
} // extern "C"
