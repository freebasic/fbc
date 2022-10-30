// implementation for call2-fbc.bas

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

	UDT();
	UDT( int rhs );
	UDT( UDT const& rhs );
	~UDT();

};

UDT::UDT()
{
	value = 0;
}

UDT::UDT( int rhs )
{
	value = rhs;
}

UDT::UDT( UDT const& rhs )
{
	this->value = rhs.value;
}

UDT::~UDT()
{
}

extern "C" {
void sub1_c_default( UDT const& a );
void sub1_c_cdecl( UDT const& a  ) __attribute__((cdecl));
void sub1_c_stdcall( UDT const& a ) __attribute__((stdcall));
UDT func1_c_default( UDT const& a );
UDT func1_c_cdecl( UDT const& a ) __attribute__((cdecl));
UDT func1_c_stdcall( UDT const& a ) __attribute__((stdcall));

void sub2_c_default( UDT const& a, UDT const& b );
void sub2_c_cdecl( UDT const& a, UDT const& b ) __attribute__((cdecl));
void sub2_c_stdcall( UDT const& a, UDT const& b ) __attribute__((stdcall));
UDT func2_c_default( UDT const& a, UDT const& b );
UDT func2_c_cdecl( UDT const& a, UDT const& b ) __attribute__((cdecl));
UDT func2_c_stdcall( UDT const& a, UDT const& b ) __attribute__((stdcall));

void sub3_c_default( UDT const& a, UDT const& b, UDT const& c );
void sub3_c_cdecl( UDT const& a, UDT const& b, UDT const& c ) __attribute__((cdecl));
void sub3_c_stdcall( UDT const& a, UDT const& b, UDT const& c ) __attribute__((stdcall));
UDT func3_c_default( UDT const& a, UDT const& b, UDT const& c );
UDT func3_c_cdecl( UDT const& a, UDT const& b, UDT const& c ) __attribute__((cdecl));
UDT func3_c_stdcall( UDT const& a, UDT const& b, UDT const& c ) __attribute__((stdcall));
}

void sub1_cpp_default( UDT const& a );
void sub1_cpp_cdecl( UDT const& a ) __attribute__((cdecl));
void sub1_cpp_stdcall( UDT const& a ) __attribute__((stdcall));
UDT func1_cpp_default( UDT const& a );
UDT func1_cpp_cdecl( UDT const& a ) __attribute__((cdecl));
UDT func1_cpp_stdcall( UDT const& a ) __attribute__((stdcall));

void sub2_cpp_default( UDT const& a, UDT const& b );
void sub2_cpp_cdecl( UDT const& a, UDT const& b ) __attribute__((cdecl));
void sub2_cpp_stdcall( UDT const& a, UDT const& b ) __attribute__((stdcall));
UDT func2_cpp_default( UDT const& a, UDT const& b );
UDT func2_cpp_cdecl( UDT const& a, UDT const& b ) __attribute__((cdecl));
UDT func2_cpp_stdcall( UDT const& a, UDT const& b ) __attribute__((stdcall));

void sub3_cpp_default( UDT const& a, UDT const& b, UDT const& c );
void sub3_cpp_cdecl( UDT const& a, UDT const& b, UDT const& c ) __attribute__((cdecl));
void sub3_cpp_stdcall( UDT const& a, UDT const& b, UDT const& c ) __attribute__((stdcall));
UDT func3_cpp_default( UDT const& a, UDT const& b, UDT const& c );
UDT func3_cpp_cdecl( UDT const& a, UDT const& b, UDT const& c ) __attribute__((cdecl));
UDT func3_cpp_stdcall( UDT const& a, UDT const& b, UDT const& c ) __attribute__((stdcall));

extern "C" {
void sub1_c_default( UDT const& a ) {
	ptr1 = &a;
	setMsg( "sub1_c_default" );
}

void sub1_c_cdecl( UDT const& a ) {
	ptr1 = &a;
	setMsg( "sub1_c_cdecl" );
}

void sub1_c_stdcall( UDT const& a ) {
	ptr1 = &a;
	setMsg( "sub1_c_stdcall" );
}

UDT func1_c_default( UDT const& a ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	setMsg( "func1_c_default" );
	return ret;
}

UDT func1_c_cdecl( UDT const& a ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	setMsg( "func1_c_cdecl" );
	return ret;
}

UDT func1_c_stdcall( UDT const& a ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	setMsg( "func1_c_stdcall" );
	return ret;
}

void sub2_c_default( UDT const& a, UDT const& b ) {
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "sub2_c_default" );
}

void sub2_c_cdecl( UDT const& a, UDT const& b ) {
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "sub2_c_cdecl" );
}

void sub2_c_stdcall( UDT const& a, UDT const& b ) {
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "sub2_c_stdcall" );
}

UDT func2_c_default( UDT const& a, UDT const& b ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "func2_c_default" );
	return ret;
}

UDT func2_c_cdecl( UDT const& a, UDT const& b ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "func2_c_cdecl" );
	return ret;
}

UDT func2_c_stdcall( UDT const& a, UDT const& b ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "func2_c_stdcall" );
	return ret;
}

void sub3_c_default( UDT const& a, UDT const& b, UDT const& c ) {
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "sub3_c_default" );
}

void sub3_c_cdecl( UDT const& a, UDT const& b, UDT const& c ) {
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "sub3_c_cdecl" );
}

void sub3_c_stdcall( UDT const& a, UDT const& b, UDT const& c ) {
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "sub3_c_stdcall" );
}

UDT func3_c_default( UDT const& a, UDT const& b, UDT const& c ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "func3_c_default" );
	return ret;
}

UDT func3_c_cdecl( UDT const& a, UDT const& b, UDT const& c ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "func3_c_cdecl" );
	return ret;
}

UDT func3_c_stdcall( UDT const& a, UDT const& b, UDT const& c ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "func3_c_stdcall" );
	return ret;
}
} // extern "C"

void sub1_cpp_default( UDT const& a ) {
	ptr1 = &a;
	setMsg( "sub1_cpp_default" );
}

void sub1_cpp_cdecl( UDT const& a ) {
	ptr1 = &a;
	setMsg( "sub1_cpp_cdecl" );
}

void sub1_cpp_stdcall( UDT const& a ) {
	ptr1 = &a;
	setMsg( "sub1_cpp_stdcall" );
}

UDT func1_cpp_default( UDT const& a ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	setMsg( "func1_cpp_default" );
	return ret;
}

UDT func1_cpp_cdecl( UDT const& a ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	setMsg( "func1_cpp_cdecl" );
	return ret;
}

UDT func1_cpp_stdcall( UDT const& a ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	setMsg( "func1_cpp_stdcall" );
	return ret;
}

void sub2_cpp_default( UDT const& a, UDT const& b ) {
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "sub2_cpp_default" );
}

void sub2_cpp_cdecl( UDT const& a, UDT const& b ) {
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "sub2_cpp_cdecl" );
}

void sub2_cpp_stdcall( UDT const& a, UDT const& b ) {
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "sub2_cpp_stdcall" );
}

UDT func2_cpp_default( UDT const& a, UDT const& b ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "func2_cpp_default" );
	return ret;
}

UDT func2_cpp_cdecl( UDT const& a, UDT const& b ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "func2_cpp_cdecl" );
	return ret;
}

UDT func2_cpp_stdcall( UDT const& a, UDT const& b ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	setMsg( "func2_cpp_stdcall" );
	return ret;
}

void sub3_cpp_default( UDT const& a, UDT const& b, UDT const& c ) {
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "sub3_cpp_default" );
}

void sub3_cpp_cdecl( UDT const& a, UDT const& b, UDT const& c ) {
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "sub3_cpp_cdecl" );
}

void sub3_cpp_stdcall( UDT const& a, UDT const& b, UDT const& c ) {
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "sub3_cpp_stdcall" );
}

UDT func3_cpp_default( UDT const& a, UDT const& b, UDT const& c ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "func3_cpp_default" );
	return ret;
}

UDT func3_cpp_cdecl( UDT const& a, UDT const& b, UDT const& c ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "func3_cpp_cdecl" );
	return ret;
}

UDT func3_cpp_stdcall( UDT const& a, UDT const& b, UDT const& c ) {
	UDT ret = UDT(1);
	ptr1 = &a;
	ptr2 = &b;
	ptr3 = &c;
	setMsg( "func3_cpp_stdcall" );
	return ret;
}
