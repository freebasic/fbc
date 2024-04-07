// implementation for class-fbc.bas

// each operation records call information
// in static variables, and we use getters
// to retrieve it back to fbc side

#define NULL 0
static const void * ptr1 = NULL; // this/lhs address
static const void * ptr2 = NULL; // rhs address
static char msg1[100];  // check message
static int    val1 = 0; // current/lhs value
static int    val2 = 0; // rhs value
static int    val3 = 0; // result value
static int initial = 1; // 1 = enable ctor/copy-ctor/dtor/let

void setMsg( const char* msg ) {
	char *s = msg1;
	while( *msg )
		*s++ = *msg++;
	*s = *msg;
}

void setInitial( int flag ) {
	initial = flag;
}

void resetChecks() {
	ptr1 = NULL;
	ptr2 = NULL;
	setMsg( "" );
	val1 = 0;
	val2 = 0;
	val3 = 0;
}

const void* getPtr1() {
	return ptr1;
}

const void* getPtr2() {
	return ptr2;
}

char* getMsg1() {
	return msg1;
}

int getVal1() {
	return val1;
}

int getVal2() {
	return val2;
}

int getVal3() {
	return val3;
}

// BASE UDT class to test with and we declare same on fbc side
class UDT_BASE
{
	public:

	int value;

	UDT_BASE();
	UDT_BASE( UDT_BASE const& rhs );
	UDT_BASE( int const& rhs );
	virtual ~UDT_BASE();
	virtual void method( int const& rhs );

	// assignment
	UDT_BASE& operator=( UDT_BASE const& rhs );

	// !!! TODO !!! non-static member bops
	UDT_BASE& operator+( int const& rhs );
	UDT_BASE& operator-( int const& rhs );
};

class UDT_DERIVED : public UDT_BASE
{
	public:

	UDT_DERIVED();
	UDT_DERIVED( UDT_DERIVED const& rhs );
	UDT_DERIVED( int const& rhs );
	virtual ~UDT_DERIVED();
	virtual void method( int const& rhs );

	// assignment
	UDT_DERIVED& operator=( UDT_DERIVED const& rhs );

	// !!! TODO !!! non-static member bops
	UDT_DERIVED& operator+( int const& rhs );
	UDT_DERIVED& operator-( int const& rhs );
};

UDT_BASE operator+( UDT_BASE const& lhs, UDT_BASE const& rhs );
UDT_BASE operator-( UDT_BASE const& lhs, UDT_BASE const& rhs );

UDT_BASE operator+( int const& lhs, UDT_BASE const& rhs );
UDT_BASE operator-( int const& lhs, UDT_BASE const& rhs );

UDT_DERIVED operator+( UDT_DERIVED const& lhs, UDT_DERIVED const& rhs );
UDT_DERIVED operator-( UDT_DERIVED const& lhs, UDT_DERIVED const& rhs );

UDT_DERIVED operator+( int const& lhs, UDT_DERIVED const& rhs );
UDT_DERIVED operator-( int const& lhs, UDT_DERIVED const& rhs );

// constructor UDT_BASE()
UDT_BASE::UDT_BASE()
{
	if( initial ) {
		ptr1 = this;
		ptr2 = NULL;
		setMsg( "UDT_BASE::UDT_BASE()" );
		val1 = -1;
		val2 = -1;
		val3 = 0;
	}
	value = 0;
}

// constructor UDT_BASE( byref rhs as const UDT_BASE )
UDT_BASE::UDT_BASE( UDT_BASE const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "UDT_BASE::UDT_BASE( UDT_BASE const& rhs )" );
		val1 = -1;
		val2 = rhs.value;
		val3 = rhs.value;
	}
	value = rhs.value;
}

// constructor UDT_BASE( byref rhs as const long )
UDT_BASE::UDT_BASE( int const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "UDT_BASE::UDT_BASE( int const& rhs )" );
		val1 = -1;
		val2 = rhs;
		val3 = rhs;
	}
	value = rhs;
}

// destructor UDT_BASE()
UDT_BASE::~UDT_BASE()
{
	if( initial ) {
		ptr1 = this;
		ptr2 = NULL;
		setMsg( "UDT_BASE::~UDT_BASE()" );
		val1 = value;
		val2 = -1;
		val3 = -1;
	}
}

// sub UDT_BASE.mthod( byref rhs as const long )
void UDT_BASE::method( int const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "void UDT_BASE::method( int const& rhs )" );
		val1 = value;
		val2 = rhs;
		val3 = rhs;
	}
	value = rhs;
}

// operator UDT_BASE.let( byref rhs as const UDT_BASE )
UDT_BASE& UDT_BASE::operator=( UDT_BASE const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "UDT_BASE& UDT_BASE::operator=( UDT_BASE const& rhs )" );
		val1 = value;
		val2 = rhs.value;
		val3 = rhs.value;
	}
	value = rhs.value;
	return *this;
}

UDT_BASE& UDT_BASE::operator+( int const& rhs )
{
	ptr1 = this;
	ptr2 = &rhs;
	setMsg( "UDT_BASE& UDT_BASE::operator+( int const& rhs )" );
	val1 = value;
	val2 = rhs;
	val3 = value + rhs;

	value += rhs;
	return *this;
}

// !!! TODO !!!: operator UDT_BASE.+( byref rhs as const long )
UDT_BASE& UDT_BASE::operator-( int const& rhs )
{
	ptr1 = this;
	ptr2 = &rhs;
	setMsg( "UDT_BASE& UDT_BASE::operator-( int const& rhs )" );
	val1 = value;
	val2 = rhs;
	val3 = value - rhs;

	value -= rhs;
	return *this;
}

// operator +( byref lhs as const UDT_BASE, byref rhs as const UDT_BASE ) as UDT_BASE
UDT_BASE operator+( UDT_BASE const& lhs, UDT_BASE const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT_BASE operator+( UDT_BASE const& lhs, UDT_BASE const& rhs )" );
	val1 = lhs.value;
	val2 = rhs.value;
	val3 = lhs.value + rhs.value;

	return UDT_BASE(lhs.value + rhs.value);
}

// operator -( byref lhs as const UDT_BASE, byref rhs as const UDT_BASE ) as UDT_BASE
UDT_BASE operator-( UDT_BASE const& lhs, UDT_BASE const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT_BASE operator-( UDT_BASE const& lhs, UDT_BASE const& rhs )" );
	val1 = lhs.value;
	val2 = rhs.value;
	val3 = lhs.value - rhs.value;

	return UDT_BASE(lhs.value - rhs.value);
}

// operator +( byref lhs as const long, byref rhs as const UDT_BASE ) as UDT_BASE
UDT_BASE operator+( int const& lhs, UDT_BASE const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT_BASE operator+( int const& lhs, UDT_BASE const& rhs )" );
	val1 = lhs;
	val2 = rhs.value;
	val3 = lhs + rhs.value;

	return UDT_BASE(lhs + rhs.value);
}

// operator -( byref lhs as const long, byref rhs as const UDT_BASE ) as UDT_BASE
UDT_BASE operator-( int const& lhs, UDT_BASE const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT_BASE operator-( int const& lhs, UDT_BASE const& rhs )" );
	val1 = lhs;
	val2 = rhs.value;
	val3 = lhs - rhs.value;

	return UDT_BASE(lhs - rhs.value);
}

// constructor UDT_DERIVED()
UDT_DERIVED::UDT_DERIVED()
{
	if( initial ) {
		ptr1 = this;
		ptr2 = NULL;
		setMsg( "UDT_DERIVED::UDT_DERIVED()" );
		val1 = -1;
		val2 = -1;
		val3 = 0;
	}
	value = 0;
}

// constructor UDT_DERIVED( byref rhs as const UDT_DERIVED )
UDT_DERIVED::UDT_DERIVED( UDT_DERIVED const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "UDT_DERIVED::UDT_DERIVED( UDT_DERIVED const& rhs )" );
		val1 = -1;
		val2 = rhs.value;
		val3 = rhs.value;
	}
	value = rhs.value;
}

// constructor UDT_DERIVED( byref rhs as const long )
UDT_DERIVED::UDT_DERIVED( int const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "UDT_DERIVED::UDT_DERIVED( int const& rhs )" );
		val1 = -1;
		val2 = rhs;
		val3 = rhs;
	}
	value = rhs;
}

// destructor UDT_DERIVED()
UDT_DERIVED::~UDT_DERIVED()
{
	if( initial ) {
		ptr1 = this;
		ptr2 = NULL;
		setMsg( "UDT_DERIVED::~UDT_DERIVED()" );
		val1 = value;
		val2 = -1;
		val3 = -1;
	}
}

// sub UDT_DERIVED.mthod( byref rhs as const long )
void UDT_DERIVED::method( int const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "void UDT_DERIVED::method( int const& rhs )" );
		val1 = value;
		val2 = rhs;
		val3 = rhs;
	}
	value = rhs;
}

// operator UDT_DERIVED.let( byref rhs as const UDT_DERIVED )
UDT_DERIVED& UDT_DERIVED::operator=( UDT_DERIVED const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "UDT_DERIVED& UDT_DERIVED::operator=( UDT_DERIVED const& rhs )" );
		val1 = value;
		val2 = rhs.value;
		val3 = rhs.value;
	}
	value = rhs.value;
	return *this;
}

/*
// !!! TODO !!!: operator UDT_DERIVED.+( byref rhs as const long )
UDT_DERIVED& UDT_DERIVED::operator+( int const& rhs )
{
	ptr1 = this;
	ptr2 = &rhs;
	setMsg( "UDT_DERIVED& UDT_DERIVED::operator+( int const& rhs )" );
	val1 = value;
	val2 = rhs;
	val3 = value + rhs;

	value += rhs;
	return *this;
}

// !!! TODO !!!: operator UDT_DERIVED.+( byref rhs as const long )
UDT_DERIVED& UDT_DERIVED::operator-( int const& rhs )
{
	ptr1 = this;
	ptr2 = &rhs;
	setMsg( "UDT_DERIVED& UDT_DERIVED::operator-( int const& rhs )" );
	val1 = value;
	val2 = rhs;
	val3 = value - rhs;

	value -= rhs;
	return *this;
}
*/

// operator +( byref lhs as const UDT_DERIVED, byref rhs as const UDT_DERIVED ) as UDT_DERIVED
UDT_DERIVED operator+( UDT_DERIVED const& lhs, UDT_DERIVED const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT_DERIVED operator+( UDT_DERIVED const& lhs, UDT_DERIVED const& rhs )" );
	val1 = lhs.value;
	val2 = rhs.value;
	val3 = lhs.value + rhs.value;

	return UDT_DERIVED(lhs.value + rhs.value);
}

// operator -( byref lhs as const UDT_DERIVED, byref rhs as const UDT_DERIVED ) as UDT_DERIVED
UDT_DERIVED operator-( UDT_DERIVED const& lhs, UDT_DERIVED const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT_DERIVED operator-( UDT_DERIVED const& lhs, UDT_DERIVED const& rhs )" );
	val1 = lhs.value;
	val2 = rhs.value;
	val3 = lhs.value - rhs.value;

	return UDT_DERIVED(lhs.value - rhs.value);
}

// operator +( byref lhs as const long, byref rhs as const UDT_DERIVED ) as UDT_DERIVED
UDT_DERIVED operator+( int const& lhs, UDT_DERIVED const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT_DERIVED operator+( int const& lhs, UDT_DERIVED const& rhs )" );
	val1 = lhs;
	val2 = rhs.value;
	val3 = lhs + rhs.value;

	return UDT_DERIVED(lhs + rhs.value);
}

// operator -( byref lhs as const long, byref rhs as const UDT_DERIVED ) as UDT_DERIVED
UDT_DERIVED operator-( int const& lhs, UDT_DERIVED const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT_DERIVED operator-( int const& lhs, UDT_DERIVED const& rhs )" );
	val1 = lhs;
	val2 = rhs.value;
	val3 = lhs - rhs.value;

	return UDT_DERIVED(lhs - rhs.value);
}
