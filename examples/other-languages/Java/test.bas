'' This program will use JNI to create a JVM and then call the method from
'' Hello.java (which needs to be compiled to Hello.class first, via
'' 'javac Hello.java').
#include once "jni.bi"
#define NULL 0

dim as JavaVMOption vm_options(0 to ...) = _
{ _
    (@"-Djava.class.path=.", NULL), _
    (@"-Djava.library.path=.", NULL) _ '', _
    _ ''(@"-verbose:class", NULL), _
    _ ''(@"-verbose:gc", NULL), _
    _ ''(@"-verbose:jni", NULL) _
}

dim as JavaVMInitArgs vm_args
vm_args.version = JNI_VERSION_1_4
vm_args.options = @vm_options(0)
vm_args.nOptions = ubound(vm_options) - lbound(vm_options) + 1
vm_args.ignoreUnrecognized = JNI_TRUE

dim as JavaVM ptr vm = NULL
dim as JNIEnv ptr env = NULL

if (JNI_CreateJavaVM(@vm, @env, @vm_args) < 0) then
    print "> JNI_CreateJavaVM failed"
    end 1
end if

dim as integer version = (*env)->GetVersion(env)
print "> Using JVM version " & (version shr 16) & "." & (version and &hFFFF)

'' Call Hello.hello() from Hello.java (needs to be compiled)
'' The following expects a 'static void (int)' method
const TEST_CLASS = "Hello"
const TEST_METHOD = "hello"
const TEST_SIGNATURE = "(I)V"    '' void (int)
const TEST_ARG = 123

print "> Calling " & TEST_CLASS & "." & TEST_METHOD & "(" & TEST_ARG & ")..."

'' Get the class...
dim as jclass testclass = (*env)->FindClass(env, TEST_CLASS)
if (testclass = NULL) then
    print "> '" & TEST_CLASS & "' class not found"
    end 1
end if

'' and the static method from it...
dim as jmethodID method = (*env)->GetStaticMethodID(env, testclass, TEST_METHOD, TEST_SIGNATURE)
if (method = NULL) then
    print "> '" & TEST_CLASS & "." & TEST_METHOD & "' method not found"
    end 1
end if

'' and call it, passing the argument.
(*env)->CallStaticVoidMethod(env, testclass, method, TEST_ARG)

dim as jthrowable exception = (*env)->ExceptionOccurred(env)
if (exception) then
    print "> The program threw an exception:"
    dim as jclass exceptionclass = (*env)->GetObjectClass(env, exception)
    dim as jmethodID tostring = (*env)->GetMethodID(env, exceptionclass, "toString", "()Ljava/lang/String;")
    dim as jstring message = (*env)->CallObjectMethod(env, exception, tostring)

    dim as zstring ptr text = (*env)->GetStringUTFChars(env, message, JNI_FALSE)
    print *text
    (*env)->ReleaseStringUTFChars(env, message, text)
    (*env)->ExceptionClear(env)
end if

print "> Finished"

(*vm)->DestroyJavaVM(vm)
