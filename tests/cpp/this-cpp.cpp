// implementation for this-fbc.bas

// each operation records call information
// in static variables, and we use getters
// to retrieve it back to fbc side

static void * ptr1 = 0;
static void * ptr2 = 0;
static void * ptr3 = 0;

void resetChecks() {
	ptr1 = ptr2 = ptr3 = 0;
}

void* getPtr1() {
	return ptr1;
}

void* getPtr2() {
	return ptr2;
}

void* getPtr3() {
	return ptr3;
}

// Default calling convention in c++

class UDT_DEFAULT {
	public:
	int value;
	UDT_DEFAULT();
	~UDT_DEFAULT();
	void loadpointer1 ( void );
	void loadpointer2 ( void* arg );
	void loadpointer3 ( void* arg1, void* arg2 );
};

UDT_DEFAULT::UDT_DEFAULT() {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
	value = 0;
}

UDT_DEFAULT::~UDT_DEFAULT() {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
}

void UDT_DEFAULT::loadpointer1( void ) {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
}

void UDT_DEFAULT::loadpointer2( void* arg ) {
	ptr1 = this;
	ptr2 = arg;
	ptr3 = 0;
}

void UDT_DEFAULT::loadpointer3( void* arg1, void* arg2 ) {
	ptr1 = this;
	ptr2 = arg1;
	ptr3 = arg2;
}


// thiscall calling convention in c++
// Normally, __attribute__((thiscall)) will generate warnings on
// linux x86_64 so we should pass '-Wno-attributes' to gcc/g++
// or later disable emitting the attribute in gcc backend.

class UDT_THISCALL {
	public:
	int value;
	UDT_THISCALL() __attribute__((thiscall));
	~UDT_THISCALL() __attribute__((thiscall));
	void loadpointer1 ( void ) __attribute__((thiscall));
	void loadpointer2 ( void* arg ) __attribute__((thiscall));
	void loadpointer3 ( void* arg1, void* arg2 ) __attribute__((thiscall));
};

UDT_THISCALL::UDT_THISCALL() {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
	value = 0;
}

UDT_THISCALL::~UDT_THISCALL() {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
}

void UDT_THISCALL::loadpointer1( void ) {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
}

void UDT_THISCALL::loadpointer2( void* arg ) {
	ptr1 = this;
	ptr2 = arg;
	ptr3 = 0;
}

void UDT_THISCALL::loadpointer3( void* arg1, void* arg2 ) {
	ptr1 = this;
	ptr2 = arg1;
	ptr3 = arg2;
}

// cdecl calling convention in c++

class UDT_CDECL {
	public:
	int value;
	UDT_CDECL() __attribute__((cdecl));
	~UDT_CDECL() __attribute__((cdecl));
	void loadpointer1 ( void ) __attribute__((cdecl));
	void loadpointer2 ( void* arg ) __attribute__((cdecl));
	void loadpointer3 ( void* arg1, void* arg2 ) __attribute__((cdecl));
};

UDT_CDECL::UDT_CDECL() {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
	value = 0;
}

UDT_CDECL::~UDT_CDECL() {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
}

void UDT_CDECL::loadpointer1( void ) {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
}

void UDT_CDECL::loadpointer2( void* arg ) {
	ptr1 = this;
	ptr2 = arg;
	ptr3 = 0;
}

void UDT_CDECL::loadpointer3( void* arg1, void* arg2 ) {
	ptr1 = this;
	ptr2 = arg1;
	ptr3 = arg2;
}

// stdcall calling convention in c++

class UDT_STDCALL {
	public:
	int value;
	UDT_STDCALL() __attribute__((stdcall));

	// mingw/gcc appears to have a bug that generates wrong
	// mangling "__ZN11UDT_STDCALLD1Ev@8" so just use cdecl
	// here instead
	~UDT_STDCALL() __attribute__((cdecl));

	void loadpointer1 ( void ) __attribute__((stdcall));
	void loadpointer2 ( void* arg ) __attribute__((stdcall));
	void loadpointer3 ( void* arg1, void* arg2 ) __attribute__((stdcall));
};

UDT_STDCALL::UDT_STDCALL() {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
	value = 0;
}

UDT_STDCALL::~UDT_STDCALL() {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
}

void UDT_STDCALL::loadpointer1( void ) {
	ptr1 = this;
	ptr2 = 0;
	ptr3 = 0;
}

void UDT_STDCALL::loadpointer2( void* arg ) {
	ptr1 = this;
	ptr2 = arg;
	ptr3 = 0;
}

void UDT_STDCALL::loadpointer3( void* arg1, void* arg2 ) {
	ptr1 = this;
	ptr2 = arg1;
	ptr3 = arg2;
}
