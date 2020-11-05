#include once "trycatch.bi"

#define	SIGINT		2	'' Interactive attention
#define	SIGILL		4	'' Illegal instruction
#define	SIGFPE		8	'' Floating point error
#define	SIGSEGV		11	'' Segmentation violation
#define	SIGTERM		15	'' Termination request
#define SIGBREAK	21	'' Control-break
#define	SIGABRT		22	'' Abnormal termination (abort)

extern "C"
	type __p_sig_fn_t as sub(byval as integer)
	declare function signal(byval as integer, byval as __p_sig_fn_t) as __p_sig_fn_t
end extern

type TryCatchCtx
	cur 		as TryCatch ptr
	oldsigabrt  as __p_sig_fn_t
	oldsigsegv  as __p_sig_fn_t
	oldsigfpe	as __p_sig_fn_t
	oldsigill	as __p_sig_fn_t
	oldsigterm	as __p_sig_fn_t
	oldsigint	as __p_sig_fn_t
end type

	dim shared ctx as TryCatchCtx
	dim shared messages(0 to 31) as zstring * 32
	
private sub handler cdecl(byval sig as integer)
	if ctx.cur = 0 then
		error sig
	end if
	
	signal(sig, @handler)
	
	ctx.cur->ex = new Exception(messages(sig))
	
	var buf = @ctx.cur->buf
	
	ctx.cur = ctx.cur->prev
	
	crt.longjmp(buf, sig)
end sub

private sub __construc() constructor
	messages(SIGINT)	= "Interactive attention"
	messages(SIGILL) 	= "Illegal instruction"
	messages(SIGFPE) 	= "Floating point error"
	messages(SIGSEGV)	= "Segmentation violation"
	messages(SIGTERM)	= "Termination request"
	messages(SIGBREAK)	= "Control-break"
	messages(SIGABRT)	= "Abnormal termination"
	
	ctx.oldsigabrt = signal(SIGABRT, @handler)
	ctx.oldsigsegv = signal(SIGSEGV, @handler)
	ctx.oldsigfpe = signal(SIGFPE, @handler)
	ctx.oldsigill = signal(SIGILL, @handler)
	ctx.oldsigterm = signal(SIGTERM, @handler)
	ctx.oldsigint = signal(SIGINT, @handler)
end sub

private sub __destruc() destructor
	signal(SIGABRT, ctx.oldsigabrt)
	signal(SIGSEGV, ctx.oldsigsegv)
	signal(SIGFPE, ctx.oldsigfpe)
	signal(SIGILL, ctx.oldsigill)
	signal(SIGTERM, ctx.oldsigterm)
	signal(SIGINT, ctx.oldsigint)
end sub
		
''
'' TryCatch
''
constructor TryCatch()
	this.prev = ctx.cur
	ctx.cur = @this
end constructor

destructor TryCatch()
	if( ctx.cur = @this ) then
		ctx.cur = this.prev
	end if
	if this.ex <> 0 then
		delete this.ex
	end if
end destructor

sub TryCatch.throw_(file as zstring ptr, func as zstring ptr, line_ as integer)
	if ctx.cur = 0 then
		error 1
	end if
	
	this.ex->file = file
	this.ex->func = func
	this.ex->line = line_
	var buf = @ctx.cur->buf
	ctx.cur = ctx.cur->prev
	crt.longjmp(buf, 1)
end sub

sub TryCatch.throw_(ex as Exception ptr, file as zstring ptr, func as zstring ptr, line_ as integer)
	this.ex = ex
	throw_(file, func, line_)
end sub

sub TryCatch.throw_(msg as zstring ptr, file as zstring ptr, func as zstring ptr, line_ as integer)
	this.ex = new Exception(msg)
	throw_(file, func, line_)
end sub

''
'' Exception
''
constructor Exception()
end constructor

constructor Exception(msg as zstring ptr)
	this.msg = allocate(len(*msg) + 1)
	*this.msg = *msg
end constructor

destructor Exception()
	if this.msg <> 0 then
		deallocate(this.msg)
	end if
	if this.file_ <> 0 then
		deallocate(this.file_)
	end if
	if this.func_ <> 0 then
		deallocate(this.func_)
	end if
end destructor

property Exception.message() as string
	return *this.msg
end property

property Exception.file() as string
	return iif(this.file_ <> 0, *this.file_, "")
end property

property Exception.file(file_ as zstring ptr)
	this.file_ = allocate(len(*file_) + 1)
	*this.file_ = *file_
end property

property Exception.func() as string
	return iif(this.func_ <> 0, *this.func_, "")
end property

property Exception.func(func_ as zstring ptr)
	this.func_ = allocate(len(*func_) + 1)
	*this.func_ = *func_
end property

property Exception.line() as integer
	return this.line_
end property

property Exception.line(line_ as integer)
	this.line_ = line_
end property

operator Exception.cast() as string
	operator = this.toString()
end operator

function Exception.toString() as string
	function = this.message & " exception threw at " & this.file & "(" & this.line & "):" & this.func & "()"
end function
