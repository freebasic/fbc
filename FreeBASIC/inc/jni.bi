''
''
'' jni -- Java(tm) Native Interface
''		  header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jni_bi__
#define __jni_bi__

#inclib "jvm"

#include once "crt/stdio.bi"
#include once "crt/stdarg.bi"

'' begin include "jni_md.bi"
type jint as integer
type jlong as longint
type jbyte as byte
'' end include "jni_md.bi"

type jboolean as ubyte
type jchar as ushort
type jshort as short
type jfloat as single
type jdouble as double
type jsize as jint
type jobject as _jobject ptr
type jclass as jobject
type jthrowable as jobject
type jstring as jobject
type jarray as jobject
type jbooleanArray as jarray
type jbyteArray as jarray
type jcharArray as jarray
type jshortArray as jarray
type jintArray as jarray
type jlongArray as jarray
type jfloatArray as jarray
type jdoubleArray as jarray
type jobjectArray as jarray
type jweak as jobject

union jvalue
	z as jboolean
	b as jbyte
	c as jchar
	s as jshort
	i as jint
	j as jlong
	f as jfloat
	d as jdouble
	l as jobject
end union

type jfieldID as _jfieldID ptr
type jmethodID as _jmethodID ptr

#define JNI_FALSE 0
#define JNI_TRUE 1
#define JNI_OK 0
#define JNI_ERR (-1)
#define JNI_EDETACHED (-2)
#define JNI_EVERSION (-3)
#define JNI_ENOMEM (-4)
#define JNI_EEXIST (-5)
#define JNI_EINVAL (-6)
#define JNI_COMMIT 1
#define JNI_ABORT 2

type JNINativeMethod
	name as zstring ptr
	signature as zstring ptr
	fnPtr as any ptr
end type

type JNIEnv as JNINativeInterface_ ptr
type JavaVM as JNIInvokeInterface_ ptr

type JNINativeInterface_
	reserved0 as any ptr
	reserved1 as any ptr
	reserved2 as any ptr
	reserved3 as any ptr
	GetVersion as function (byval as JNIEnv ptr) as jint
	DefineClass as function (byval as JNIEnv ptr, byval as zstring ptr, byval as jobject, byval as jbyte ptr, byval as jsize) as jclass
	FindClass as function (byval as JNIEnv ptr, byval as zstring ptr) as jclass
	FromReflectedMethod as function (byval as JNIEnv ptr, byval as jobject) as jmethodID
	FromReflectedField as function (byval as JNIEnv ptr, byval as jobject) as jfieldID
	ToReflectedMethod as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jboolean) as jobject
	GetSuperclass as function (byval as JNIEnv ptr, byval as jclass) as jclass
	IsAssignableFrom as function (byval as JNIEnv ptr, byval as jclass, byval as jclass) as jboolean
	ToReflectedField as function (byval as JNIEnv ptr, byval as jclass, byval as jfieldID, byval as jboolean) as jobject
	Throw as function (byval as JNIEnv ptr, byval as jthrowable) as jint
	ThrowNew as function (byval as JNIEnv ptr, byval as jclass, byval as zstring ptr) as jint
	ExceptionOccurred as function (byval as JNIEnv ptr) as jthrowable
	ExceptionDescribe as sub (byval as JNIEnv ptr)
	ExceptionClear as sub (byval as JNIEnv ptr)
	FatalError as sub (byval as JNIEnv ptr, byval as zstring ptr)
	PushLocalFrame as function (byval as JNIEnv ptr, byval as jint) as jint
	PopLocalFrame as function (byval as JNIEnv ptr, byval as jobject) as jobject
	NewGlobalRef as function (byval as JNIEnv ptr, byval as jobject) as jobject
	DeleteGlobalRef as sub (byval as JNIEnv ptr, byval as jobject)
	DeleteLocalRef as sub (byval as JNIEnv ptr, byval as jobject)
	IsSameObject as function (byval as JNIEnv ptr, byval as jobject, byval as jobject) as jboolean
	NewLocalRef as function (byval as JNIEnv ptr, byval as jobject) as jobject
	EnsureLocalCapacity as function (byval as JNIEnv ptr, byval as jint) as jint
	AllocObject as function (byval as JNIEnv ptr, byval as jclass) as jobject
	NewObject as function cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...) as jobject
	NewObjectV as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list) as jobject
	NewObjectA as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jobject
	GetObjectClass as function (byval as JNIEnv ptr, byval as jobject) as jclass
	IsInstanceOf as function (byval as JNIEnv ptr, byval as jobject, byval as jclass) as jboolean
	GetMethodID as function (byval as JNIEnv ptr, byval as jclass, byval as zstring ptr, byval as zstring ptr) as jmethodID
	CallObjectMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, ...) as jobject
	CallObjectMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as va_list) as jobject
	CallObjectMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as jvalue ptr) as jobject
	CallBooleanMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, ...) as jboolean
	CallBooleanMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as va_list) as jboolean
	CallBooleanMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as jvalue ptr) as jboolean
	CallByteMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, ...) as jbyte
	CallByteMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as va_list) as jbyte
	CallByteMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as jvalue ptr) as jbyte
	CallCharMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, ...) as jchar
	CallCharMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as va_list) as jchar
	CallCharMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as jvalue ptr) as jchar
	CallShortMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, ...) as jshort
	CallShortMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as va_list) as jshort
	CallShortMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as jvalue ptr) as jshort
	CallIntMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, ...) as jint
	CallIntMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as va_list) as jint
	CallIntMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as jvalue ptr) as jint
	CallLongMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, ...) as jlong
	CallLongMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as va_list) as jlong
	CallLongMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as jvalue ptr) as jlong
	CallFloatMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, ...) as jfloat
	CallFloatMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as va_list) as jfloat
	CallFloatMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as jvalue ptr) as jfloat
	CallDoubleMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, ...) as jdouble
	CallDoubleMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as va_list) as jdouble
	CallDoubleMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as jvalue ptr) as jdouble
	CallVoidMethod as sub cdecl (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, ...)
	CallVoidMethodV as sub (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as va_list)
	CallVoidMethodA as sub (byval as JNIEnv ptr, byval as jobject, byval as jmethodID, byval as jvalue ptr)
	CallNonvirtualObjectMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, ...) as jobject
	CallNonvirtualObjectMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as va_list) as jobject
	CallNonvirtualObjectMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jobject
	CallNonvirtualBooleanMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, ...) as jboolean
	CallNonvirtualBooleanMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as va_list) as jboolean
	CallNonvirtualBooleanMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jboolean
	CallNonvirtualByteMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, ...) as jbyte
	CallNonvirtualByteMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as va_list) as jbyte
	CallNonvirtualByteMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jbyte
	CallNonvirtualCharMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, ...) as jchar
	CallNonvirtualCharMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as va_list) as jchar
	CallNonvirtualCharMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jchar
	CallNonvirtualShortMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, ...) as jshort
	CallNonvirtualShortMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as va_list) as jshort
	CallNonvirtualShortMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jshort
	CallNonvirtualIntMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, ...) as jint
	CallNonvirtualIntMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as va_list) as jint
	CallNonvirtualIntMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jint
	CallNonvirtualLongMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, ...) as jlong
	CallNonvirtualLongMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as va_list) as jlong
	CallNonvirtualLongMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jlong
	CallNonvirtualFloatMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, ...) as jfloat
	CallNonvirtualFloatMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as va_list) as jfloat
	CallNonvirtualFloatMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jfloat
	CallNonvirtualDoubleMethod as function cdecl (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, ...) as jdouble
	CallNonvirtualDoubleMethodV as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as va_list) as jdouble
	CallNonvirtualDoubleMethodA as function (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jdouble
	CallNonvirtualVoidMethod as sub cdecl (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, ...)
	CallNonvirtualVoidMethodV as sub (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as va_list)
	CallNonvirtualVoidMethodA as sub (byval as JNIEnv ptr, byval as jobject, byval as jclass, byval as jmethodID, byval as jvalue ptr)
	GetFieldID as function (byval as JNIEnv ptr, byval as jclass, byval as zstring ptr, byval as zstring ptr) as jfieldID
	GetObjectField as function (byval as JNIEnv ptr, byval as jobject, byval as jfieldID) as jobject
	GetBooleanField as function (byval as JNIEnv ptr, byval as jobject, byval as jfieldID) as jboolean
	GetByteField as function (byval as JNIEnv ptr, byval as jobject, byval as jfieldID) as jbyte
	GetCharField as function (byval as JNIEnv ptr, byval as jobject, byval as jfieldID) as jchar
	GetShortField as function (byval as JNIEnv ptr, byval as jobject, byval as jfieldID) as jshort
	GetIntField as function (byval as JNIEnv ptr, byval as jobject, byval as jfieldID) as jint
	GetLongField as function (byval as JNIEnv ptr, byval as jobject, byval as jfieldID) as jlong
	GetFloatField as function (byval as JNIEnv ptr, byval as jobject, byval as jfieldID) as jfloat
	GetDoubleField as function (byval as JNIEnv ptr, byval as jobject, byval as jfieldID) as jdouble
	SetObjectField as sub (byval as JNIEnv ptr, byval as jobject, byval as jfieldID, byval as jobject)
	SetBooleanField as sub (byval as JNIEnv ptr, byval as jobject, byval as jfieldID, byval as jboolean)
	SetByteField as sub (byval as JNIEnv ptr, byval as jobject, byval as jfieldID, byval as jbyte)
	SetCharField as sub (byval as JNIEnv ptr, byval as jobject, byval as jfieldID, byval as jchar)
	SetShortField as sub (byval as JNIEnv ptr, byval as jobject, byval as jfieldID, byval as jshort)
	SetIntField as sub (byval as JNIEnv ptr, byval as jobject, byval as jfieldID, byval as jint)
	SetLongField as sub (byval as JNIEnv ptr, byval as jobject, byval as jfieldID, byval as jlong)
	SetFloatField as sub (byval as JNIEnv ptr, byval as jobject, byval as jfieldID, byval as jfloat)
	SetDoubleField as sub (byval as JNIEnv ptr, byval as jobject, byval as jfieldID, byval as jdouble)
	GetStaticMethodID as function (byval as JNIEnv ptr, byval as jclass, byval as zstring ptr, byval as zstring ptr) as jmethodID
	CallStaticObjectMethod as function cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...) as jobject
	CallStaticObjectMethodV as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list) as jobject
	CallStaticObjectMethodA as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jobject
	CallStaticBooleanMethod as function cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...) as jboolean
	CallStaticBooleanMethodV as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list) as jboolean
	CallStaticBooleanMethodA as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jboolean
	CallStaticByteMethod as function cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...) as jbyte
	CallStaticByteMethodV as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list) as jbyte
	CallStaticByteMethodA as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jbyte
	CallStaticCharMethod as function cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...) as jchar
	CallStaticCharMethodV as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list) as jchar
	CallStaticCharMethodA as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jchar
	CallStaticShortMethod as function cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...) as jshort
	CallStaticShortMethodV as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list) as jshort
	CallStaticShortMethodA as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jshort
	CallStaticIntMethod as function cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...) as jint
	CallStaticIntMethodV as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list) as jint
	CallStaticIntMethodA as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jint
	CallStaticLongMethod as function cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...) as jlong
	CallStaticLongMethodV as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list) as jlong
	CallStaticLongMethodA as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jlong
	CallStaticFloatMethod as function cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...) as jfloat
	CallStaticFloatMethodV as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list) as jfloat
	CallStaticFloatMethodA as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jfloat
	CallStaticDoubleMethod as function cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...) as jdouble
	CallStaticDoubleMethodV as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list) as jdouble
	CallStaticDoubleMethodA as function (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr) as jdouble
	CallStaticVoidMethod as sub cdecl (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, ...)
	CallStaticVoidMethodV as sub (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as va_list)
	CallStaticVoidMethodA as sub (byval as JNIEnv ptr, byval as jclass, byval as jmethodID, byval as jvalue ptr)
	GetStaticFieldID as function (byval as JNIEnv ptr, byval as jclass, byval as zstring ptr, byval as zstring ptr) as jfieldID
	GetStaticObjectField as function (byval as JNIEnv ptr, byval as jclass, byval as jfieldID) as jobject
	GetStaticBooleanField as function (byval as JNIEnv ptr, byval as jclass, byval as jfieldID) as jboolean
	GetStaticByteField as function (byval as JNIEnv ptr, byval as jclass, byval as jfieldID) as jbyte
	GetStaticCharField as function (byval as JNIEnv ptr, byval as jclass, byval as jfieldID) as jchar
	GetStaticShortField as function (byval as JNIEnv ptr, byval as jclass, byval as jfieldID) as jshort
	GetStaticIntField as function (byval as JNIEnv ptr, byval as jclass, byval as jfieldID) as jint
	GetStaticLongField as function (byval as JNIEnv ptr, byval as jclass, byval as jfieldID) as jlong
	GetStaticFloatField as function (byval as JNIEnv ptr, byval as jclass, byval as jfieldID) as jfloat
	GetStaticDoubleField as function (byval as JNIEnv ptr, byval as jclass, byval as jfieldID) as jdouble
	SetStaticObjectField as sub (byval as JNIEnv ptr, byval as jclass, byval as jfieldID, byval as jobject)
	SetStaticBooleanField as sub (byval as JNIEnv ptr, byval as jclass, byval as jfieldID, byval as jboolean)
	SetStaticByteField as sub (byval as JNIEnv ptr, byval as jclass, byval as jfieldID, byval as jbyte)
	SetStaticCharField as sub (byval as JNIEnv ptr, byval as jclass, byval as jfieldID, byval as jchar)
	SetStaticShortField as sub (byval as JNIEnv ptr, byval as jclass, byval as jfieldID, byval as jshort)
	SetStaticIntField as sub (byval as JNIEnv ptr, byval as jclass, byval as jfieldID, byval as jint)
	SetStaticLongField as sub (byval as JNIEnv ptr, byval as jclass, byval as jfieldID, byval as jlong)
	SetStaticFloatField as sub (byval as JNIEnv ptr, byval as jclass, byval as jfieldID, byval as jfloat)
	SetStaticDoubleField as sub (byval as JNIEnv ptr, byval as jclass, byval as jfieldID, byval as jdouble)
	NewString as function (byval as JNIEnv ptr, byval as jchar ptr, byval as jsize) as jstring
	GetStringLength as function (byval as JNIEnv ptr, byval as jstring) as jsize
	GetStringChars as function (byval as JNIEnv ptr, byval as jstring, byval as jboolean ptr) as jchar ptr
	ReleaseStringChars as sub (byval as JNIEnv ptr, byval as jstring, byval as jchar ptr)
	NewStringUTF as function (byval as JNIEnv ptr, byval as zstring ptr) as jstring
	GetStringUTFLength as function (byval as JNIEnv ptr, byval as jstring) as jsize
	GetStringUTFChars as function (byval as JNIEnv ptr, byval as jstring, byval as jboolean ptr) as byte ptr
	ReleaseStringUTFChars as sub (byval as JNIEnv ptr, byval as jstring, byval as zstring ptr)
	GetArrayLength as function (byval as JNIEnv ptr, byval as jarray) as jsize
	NewObjectArray as function (byval as JNIEnv ptr, byval as jsize, byval as jclass, byval as jobject) as jobjectArray
	GetObjectArrayElement as function (byval as JNIEnv ptr, byval as jobjectArray, byval as jsize) as jobject
	SetObjectArrayElement as sub (byval as JNIEnv ptr, byval as jobjectArray, byval as jsize, byval as jobject)
	NewBooleanArray as function (byval as JNIEnv ptr, byval as jsize) as jbooleanArray
	NewByteArray as function (byval as JNIEnv ptr, byval as jsize) as jbyteArray
	NewCharArray as function (byval as JNIEnv ptr, byval as jsize) as jcharArray
	NewShortArray as function (byval as JNIEnv ptr, byval as jsize) as jshortArray
	NewIntArray as function (byval as JNIEnv ptr, byval as jsize) as jintArray
	NewLongArray as function (byval as JNIEnv ptr, byval as jsize) as jlongArray
	NewFloatArray as function (byval as JNIEnv ptr, byval as jsize) as jfloatArray
	NewDoubleArray as function (byval as JNIEnv ptr, byval as jsize) as jdoubleArray
	GetBooleanArrayElements as function (byval as JNIEnv ptr, byval as jbooleanArray, byval as jboolean ptr) as jboolean ptr
	GetByteArrayElements as function (byval as JNIEnv ptr, byval as jbyteArray, byval as jboolean ptr) as jbyte ptr
	GetCharArrayElements as function (byval as JNIEnv ptr, byval as jcharArray, byval as jboolean ptr) as jchar ptr
	GetShortArrayElements as function (byval as JNIEnv ptr, byval as jshortArray, byval as jboolean ptr) as jshort ptr
	GetIntArrayElements as function (byval as JNIEnv ptr, byval as jintArray, byval as jboolean ptr) as jint ptr
	GetLongArrayElements as function (byval as JNIEnv ptr, byval as jlongArray, byval as jboolean ptr) as jlong ptr
	GetFloatArrayElements as function (byval as JNIEnv ptr, byval as jfloatArray, byval as jboolean ptr) as jfloat ptr
	GetDoubleArrayElements as function (byval as JNIEnv ptr, byval as jdoubleArray, byval as jboolean ptr) as jdouble ptr
	ReleaseBooleanArrayElements as sub (byval as JNIEnv ptr, byval as jbooleanArray, byval as jboolean ptr, byval as jint)
	ReleaseByteArrayElements as sub (byval as JNIEnv ptr, byval as jbyteArray, byval as jbyte ptr, byval as jint)
	ReleaseCharArrayElements as sub (byval as JNIEnv ptr, byval as jcharArray, byval as jchar ptr, byval as jint)
	ReleaseShortArrayElements as sub (byval as JNIEnv ptr, byval as jshortArray, byval as jshort ptr, byval as jint)
	ReleaseIntArrayElements as sub (byval as JNIEnv ptr, byval as jintArray, byval as jint ptr, byval as jint)
	ReleaseLongArrayElements as sub (byval as JNIEnv ptr, byval as jlongArray, byval as jlong ptr, byval as jint)
	ReleaseFloatArrayElements as sub (byval as JNIEnv ptr, byval as jfloatArray, byval as jfloat ptr, byval as jint)
	ReleaseDoubleArrayElements as sub (byval as JNIEnv ptr, byval as jdoubleArray, byval as jdouble ptr, byval as jint)
	GetBooleanArrayRegion as sub (byval as JNIEnv ptr, byval as jbooleanArray, byval as jsize, byval as jsize, byval as jboolean ptr)
	GetByteArrayRegion as sub (byval as JNIEnv ptr, byval as jbyteArray, byval as jsize, byval as jsize, byval as jbyte ptr)
	GetCharArrayRegion as sub (byval as JNIEnv ptr, byval as jcharArray, byval as jsize, byval as jsize, byval as jchar ptr)
	GetShortArrayRegion as sub (byval as JNIEnv ptr, byval as jshortArray, byval as jsize, byval as jsize, byval as jshort ptr)
	GetIntArrayRegion as sub (byval as JNIEnv ptr, byval as jintArray, byval as jsize, byval as jsize, byval as jint ptr)
	GetLongArrayRegion as sub (byval as JNIEnv ptr, byval as jlongArray, byval as jsize, byval as jsize, byval as jlong ptr)
	GetFloatArrayRegion as sub (byval as JNIEnv ptr, byval as jfloatArray, byval as jsize, byval as jsize, byval as jfloat ptr)
	GetDoubleArrayRegion as sub (byval as JNIEnv ptr, byval as jdoubleArray, byval as jsize, byval as jsize, byval as jdouble ptr)
	SetBooleanArrayRegion as sub (byval as JNIEnv ptr, byval as jbooleanArray, byval as jsize, byval as jsize, byval as jboolean ptr)
	SetByteArrayRegion as sub (byval as JNIEnv ptr, byval as jbyteArray, byval as jsize, byval as jsize, byval as jbyte ptr)
	SetCharArrayRegion as sub (byval as JNIEnv ptr, byval as jcharArray, byval as jsize, byval as jsize, byval as jchar ptr)
	SetShortArrayRegion as sub (byval as JNIEnv ptr, byval as jshortArray, byval as jsize, byval as jsize, byval as jshort ptr)
	SetIntArrayRegion as sub (byval as JNIEnv ptr, byval as jintArray, byval as jsize, byval as jsize, byval as jint ptr)
	SetLongArrayRegion as sub (byval as JNIEnv ptr, byval as jlongArray, byval as jsize, byval as jsize, byval as jlong ptr)
	SetFloatArrayRegion as sub (byval as JNIEnv ptr, byval as jfloatArray, byval as jsize, byval as jsize, byval as jfloat ptr)
	SetDoubleArrayRegion as sub (byval as JNIEnv ptr, byval as jdoubleArray, byval as jsize, byval as jsize, byval as jdouble ptr)
	RegisterNatives as function (byval as JNIEnv ptr, byval as jclass, byval as JNINativeMethod ptr, byval as jint) as jint
	UnregisterNatives as function (byval as JNIEnv ptr, byval as jclass) as jint
	MonitorEnter as function (byval as JNIEnv ptr, byval as jobject) as jint
	MonitorExit as function (byval as JNIEnv ptr, byval as jobject) as jint
	GetJavaVM as function (byval as JNIEnv ptr, byval as JavaVM ptr ptr) as jint
	GetStringRegion as sub (byval as JNIEnv ptr, byval as jstring, byval as jsize, byval as jsize, byval as jchar ptr)
	GetStringUTFRegion as sub (byval as JNIEnv ptr, byval as jstring, byval as jsize, byval as jsize, byval as zstring ptr)
	GetPrimitiveArrayCritical as sub (byval as JNIEnv ptr, byval as jarray, byval as jboolean ptr)
	ReleasePrimitiveArrayCritical as sub (byval as JNIEnv ptr, byval as jarray, byval as any ptr, byval as jint)
	GetStringCritical as function (byval as JNIEnv ptr, byval as jstring, byval as jboolean ptr) as jchar ptr
	ReleaseStringCritical as sub (byval as JNIEnv ptr, byval as jstring, byval as jchar ptr)
	NewWeakGlobalRef as function (byval as JNIEnv ptr, byval as jobject) as jweak
	DeleteWeakGlobalRef as sub (byval as JNIEnv ptr, byval as jweak)
	ExceptionCheck as function (byval as JNIEnv ptr) as jboolean
	NewDirectByteBuffer as function (byval as JNIEnv ptr, byval as any ptr, byval as jlong) as jobject
	GetDirectBufferAddress as sub (byval as JNIEnv ptr, byval as jobject)
	GetDirectBufferCapacity as function (byval as JNIEnv ptr, byval as jobject) as jlong
end type

type JNIEnv_
	functions as JNINativeInterface_ ptr
end type

type JavaVMOption
	optionString as zstring ptr
	extraInfo as any ptr
end type

type JavaVMInitArgs
	version as jint
	nOptions as jint
	options as JavaVMOption ptr
	ignoreUnrecognized as jboolean
end type

type JavaVMAttachArgs
	version as jint
	name as zstring ptr
	group as jobject
end type

type JDK1_1InitArgs
	version as jint
	properties as byte ptr ptr
	checkSource as jint
	nativeStackSize as jint
	javaStackSize as jint
	minHeapSize as jint
	maxHeapSize as jint
	verifyMode as jint
	classpath as zstring ptr
	vfprintf as function (byval as FILE ptr, byval as zstring ptr, byval as va_list) as jint
	exit as sub (byval as jint)
	abort as sub ()
	enableClassGC as jint
	enableVerboseGC as jint
	disableAsyncGC as jint
	verbose as jint
	debugging as jboolean
	debugPort as jint
end type

type JDK1_1AttachArgs
	__padding as any ptr
end type

type JNIInvokeInterface_
	reserved0 as any ptr
	reserved1 as any ptr
	reserved2 as any ptr
	DestroyJavaVM as function (byval as JavaVM ptr) as jint
	AttachCurrentThread as function (byval as JavaVM ptr, byval as any ptr ptr, byval as any ptr) as jint
	DetachCurrentThread as function (byval as JavaVM ptr) as jint
	GetEnv as function (byval as JavaVM ptr, byval as any ptr ptr, byval as jint) as jint
	AttachCurrentThreadAsDaemon as function (byval as JavaVM ptr, byval as any ptr ptr, byval as any ptr) as jint
end type

type JavaVM_
	functions as JNIInvokeInterface_ ptr
end type

declare function JNI_GetDefaultJavaVMInitArgs  alias "JNI_GetDefaultJavaVMInitArgs" (byval args as any ptr) as jint
declare function JNI_CreateJavaVM  alias "JNI_CreateJavaVM" (byval pvm as JavaVM ptr ptr, byval penv as any ptr ptr, byval args as any ptr) as jint
declare function JNI_GetCreatedJavaVMs  alias "JNI_GetCreatedJavaVMs" (byval as JavaVM ptr ptr, byval as jsize, byval as jsize ptr) as jint
declare function JNI_OnLoad  alias "JNI_OnLoad" (byval vm as JavaVM ptr, byval reserved as any ptr) as jint
declare sub JNI_OnUnload  alias "JNI_OnUnload" (byval vm as JavaVM ptr, byval reserved as any ptr)

#define JNI_VERSION_1_1 &h00010001
#define JNI_VERSION_1_2 &h00010002
#define JNI_VERSION_1_4 &h00010004

#endif
