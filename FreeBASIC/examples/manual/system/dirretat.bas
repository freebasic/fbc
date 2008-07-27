'' examples/manual/system/dirretat.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDir
'' --------

'' Example of using DIR function and retrieving attributes

#include "dir.bi" '' provides constants to match the attributes against

'' set input attribute mask to allow files that are normal, hidden, system or directory
Const attrib_mask = fbNormal Or fbHidden Or fbSystem Or fbDirectory ' = &h37

Dim As UInteger out_attr '' unsigned integer to hold retrieved attributes

Dim As String fname '' file/directory name returned with
Dim As Integer filecount, dircount

fname = Dir("*.*", attrib_mask, out_attr) '' Get first file name/attributes, according to supplied file spec and attribute mask

Print "File listing in " & CurDir & ":"

Do Until Len(fname) = 0 '' loop until Dir returns empty string

	If (fname <> ".") And (fname <> "..") Then '' ignore current and parent directory entries

	    Print fname,

	    If out_attr And fbDirectory Then
	        Print "- directory";
	        dircount += 1
	    Else
	        Print "- file";
	        filecount += 1
	    End If
	    If out_attr And fbReadOnly Then Print ", read-only";
	    If out_attr And fbHidden Then Print ", hidden";
	    If out_attr And fbSystem Then Print ", system";
	    If out_attr And fbArchive Then Print ", archived";
	    Print

	End If

	fname = Dir(out_attr) '' find next name/attributes

Loop

Print
Print "Found " & filecount & " files and " & dircount & " subdirs"
