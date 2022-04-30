'' examples/manual/libraries/jni/mylib.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'JNI, The Java Native Interface'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibjni
'' --------

#include "jni.bi"
	
'' Note: The mangling must be "windows-ms" or the JRE won't find any function
Extern "windows-ms"
	Function Java_MyLib_add( env As JNIEnv Ptr, obj As jobject, l As jint, r As jint ) As jint Export
		Return l + r
	End Function
End Extern
