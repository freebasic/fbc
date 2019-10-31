/* What are we fixing?
// A lot of functions in the D2D interfaces
// are declared to return structures by value
// i.e.
// D2D1_SIZE_U ID2D1Bitmap::GetPixelSize();
// And
// D2D1_PIXEL_FORMAT ID2D1HwndRenderTarget::GetPixelFormat(ID2D1HwndRenderTarget*);
//
// While this is completely valid C/C++, how it is handled by
// compilers differs. As the Direct2D subsystem is 
// coded in C++, what happens is that Visual Studio's C++ compiler
// translates those prototypes to a function definition of
// D2D1_SIZE_U* ID2D1Bitmap::GetPixelSize(D2D1_SIZE_U* pStackObject);
// and 
// D2D1_PIXEL_FORMAT* ID2D1HwndRenderTarget::GetPixelFormat(ID2D1HwndRenderTarget*. D2D1_PIXEL_FORMAT*);
// i.e., it allocates the struct on the stack and sends a pointer to it
// as a hidden last parameter, and makes the return value a pointer too
//
// If you compile with Visual C++ in C++ mode, everything is fine,
// that's how it behaves and it's the same for Microsoft 
// as it is for you - things work fine
//
// If you compile with Visual C++ in C mode or use different compilers
// then that same 'magic' conversion doesn't happen and things go wrong.
// In 32-bit it'll probably crash your program quite quickly since
// the ret instruction of the D2D function will pop the wrong number of args
// from the stack and unbalance it
// In 64-bit, as args are passed in registers, it won't crash 
// in the same manner, but in both cases D2D1 will write through the 'invented' but
// non-existant pointer, so memory corruption is highly likely.
//
// See here for sample code and annotated assembly showing this is 
// indeed how it is
// https://blog.airesoft.co.uk/2014/12/direct2d-scene-of-the-accident/
// 
// This file thus reimplements the C macros as inline functions for those functions 
// to make this hidden pointer explicit so we can call the functions without issue
//
// NOTE: This only applies to functions whose prototypes directly return structs by value
// Lots of functions take structures by value, and they work fine
// Also, this isn't a complete list by any means
*/

/* Don't need these if we're not compiling in C */
#ifdef D2D_USE_C_DEFINITIONS

/* we undef and replace macros, which is useless
// if they haven't been included yet
// The first define is Mirosoft's name. the second MinGW
*/
#if !defined(_D2D1_H_) && !defined(_D2D1_H)
#error "d2d1.h must be included first, or unsupported toolchain"
#endif

#undef ID2D1Bitmap_GetPixelSize
static inline D2D1_SIZE_U* ID2D1Bitmap_GetPixelSize(ID2D1Bitmap* pBitmap, D2D1_SIZE_U* pSize) {
	typedef D2D1_SIZE_U* (STDMETHODCALLTYPE*pfnD2DF_BitmapGetPixelSize)(ID2D1Bitmap* pBm, D2D1_SIZE_U* pSize);
	pfnD2DF_BitmapGetPixelSize GetPixelSize = (pfnD2DF_BitmapGetPixelSize)(pBitmap->lpVtbl->GetPixelSize);
	return GetPixelSize(pBitmap, pSize);
}

#undef ID2D1Bitmap_GetSize
static inline D2D1_SIZE_F* ID2D1Bitmap_GetSize(ID2D1Bitmap* pBitmap, D2D1_SIZE_F* pSize) {
	typedef D2D1_SIZE_F* (STDMETHODCALLTYPE*pfnD2DF_BitmapGetSize)(ID2D1Bitmap* pBm, D2D1_SIZE_F* pSize);
	pfnD2DF_BitmapGetSize GetSize = (pfnD2DF_BitmapGetSize)(pBitmap->lpVtbl->GetSize);
	return GetSize(pBitmap, pSize);
}

#undef ID2D1RenderTarget_GetSize
static inline D2D1_SIZE_F* ID2D1RenderTarget_GetSize(ID2D1RenderTarget* pRT, D2D1_SIZE_F* pSize) {
	typedef D2D1_SIZE_F* (STDMETHODCALLTYPE*pfnD2DF_RenderTargetGetSize)(ID2D1RenderTarget* pRT, D2D1_SIZE_F* pSize);
	pfnD2DF_RenderTargetGetSize GetSize = (pfnD2DF_RenderTargetGetSize)(pRT->lpVtbl->GetSize);
	return GetSize(pRT, pSize);
}

#undef ID2D1RenderTarget_GetPixelSize
static inline D2D1_SIZE_U* ID2D1RenderTarget_GetPixelSize(ID2D1RenderTarget* pRT, D2D1_SIZE_U* pSize) {
	typedef D2D1_SIZE_U* (STDMETHODCALLTYPE*pfnD2DF_RenderTargetGetPixelSize)(ID2D1RenderTarget* pRT, D2D1_SIZE_U* pSize);
	pfnD2DF_RenderTargetGetPixelSize GetPixelSize = (pfnD2DF_RenderTargetGetPixelSize)(pRT->lpVtbl->GetPixelSize);
	return GetPixelSize(pRT, pSize);
}

#undef ID2D1RenderTarget_GetPixelFormat
static inline D2D1_PIXEL_FORMAT* ID2D1RenderTarget_GetPixelFormat(ID2D1RenderTarget* pRT, D2D1_PIXEL_FORMAT* pFormat) {
	typedef D2D1_PIXEL_FORMAT* (STDMETHODCALLTYPE*pfnD2DF_RenderTargetGetPixFmt)(ID2D1RenderTarget* pRT, D2D1_PIXEL_FORMAT* pSize);
	pfnD2DF_RenderTargetGetPixFmt GetPixFmt = (pfnD2DF_RenderTargetGetPixFmt)(pRT->lpVtbl->GetPixelFormat);
	return GetPixFmt(pRT, pFormat);
}

#undef ID2D1HwndRenderTarget_GetSize
static inline D2D1_SIZE_F* ID2D1HwndRenderTarget_GetSize(ID2D1HwndRenderTarget* pRT, D2D1_SIZE_F* pSize) {
	typedef D2D1_SIZE_F* (STDMETHODCALLTYPE*pfnD2DF_HwndRenderTargetGetSize)(ID2D1HwndRenderTarget* pRT, D2D1_SIZE_F* pSize);
	pfnD2DF_HwndRenderTargetGetSize GetSize = (pfnD2DF_HwndRenderTargetGetSize)(pRT->lpVtbl->Base.GetSize);
	return GetSize(pRT, pSize);
}

#undef ID2D1HwndRenderTarget_GetPixelSize
static inline D2D1_SIZE_U* ID2D1HwndRenderTarget_GetPixelSize(ID2D1HwndRenderTarget* pRT, D2D1_SIZE_U* pSize) {
	typedef D2D1_SIZE_U* (STDMETHODCALLTYPE*pfnD2DF_HwndRenderTargetGetPixelSize)(ID2D1HwndRenderTarget* pRT, D2D1_SIZE_U* pSize);
	pfnD2DF_HwndRenderTargetGetPixelSize GetPixelSize = (pfnD2DF_HwndRenderTargetGetPixelSize)(pRT->lpVtbl->Base.GetPixelSize);
	return GetPixelSize(pRT, pSize);
}

#undef ID2D1HwndRenderTarget_GetPixelFormat
static inline D2D1_PIXEL_FORMAT* ID2D1HwndRenderTarget_GetPixelFormat(ID2D1HwndRenderTarget* pRT, D2D1_PIXEL_FORMAT* pFormat) {
	typedef D2D1_PIXEL_FORMAT* (STDMETHODCALLTYPE*pfnD2DF_HwndRenderTargetGetPixFmt)(ID2D1HwndRenderTarget* pRT, D2D1_PIXEL_FORMAT* pSize);
	pfnD2DF_HwndRenderTargetGetPixFmt GetPixFmt = (pfnD2DF_HwndRenderTargetGetPixFmt)(pRT->lpVtbl->Base.GetPixelFormat);
	return GetPixFmt(pRT, pFormat);
}

/* D2D_USE_C_DEFINITIONS */
#endif
