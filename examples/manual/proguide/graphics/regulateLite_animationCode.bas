'' examples/manual/proguide/graphics/regulateLite_animationCode.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Lite regulation function to be integrated into user loop for FPS control'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgLiteRegulate
'' --------

'' Graphic animation from dodicat (https://www.freebasic.net/forum/viewtopic.php?p=184009#p184009)

#include "regulateLite.bi"

Type vector3d
	As Single x,y,z
End Type
'assignment macro
#define vct Type<vector3d>
 
 'macros
	#define map(a,b,x,c,d) ((d)-(c))*((x)-(a))/((b)-(a))+(c)
	#macro combsort(array,begin,finish,dot)
	Scope
		Var size=(finish),switch=0,j=0
		Dim As Single void=size
		Do
			void=void/1.3: If void<1 Then void=1
			switch=0
			For i As Integer =(begin) To size-void
				j=i+void
				If array(i)dot<array(j)dot Then 
					Swap array(i),array(j): switch=1
				End If
			Next
		Loop Until  switch =0 And void=1
	End Scope
	#endmacro
	
	Operator -(ByRef v1 As vector3d,ByRef v2 As vector3d) As vector3d
		Return Type<vector3d>(v1.x-v2.x,v1.y-v2.y,v1.z-v2.z)
	End Operator
	
	Operator + (ByRef v1 As vector3d,ByRef v2 As vector3d) As vector3d
	Return Type<vector3d>(v1.x+v2.x,v1.y+v2.y,v1.z+v2.z)
	End Operator
	
	Function length(ByRef v1 As vector3d) As Single
		Return Sqr(v1.x*v1.x+v1.y*v1.y+v1.z*v1.z)
	End Function 
	
	Function rotate3d(ByVal pivot As vector3d,ByVal pt As vector3d,ByVal Angle As vector3d, ByVal scale As vector3d=Type<vector3d>(1,1,1)) As vector3d
		#define cr 0.0174532925199433
		Angle=Type<vector3d>(Angle.x*cr,Angle.y*cr,Angle.z*cr)
		#macro Rotate(a1,a2,b1,b2,d)
		temp=Type<vector3d>((a1)*Cos(Angle.d)+(a2)*Sin(Angle.d),(b1)*Cos(Angle.d)+(b2)*Sin(Angle.d))
		#endmacro
		Dim As vector3d p=Type<vector3d>(pt.x-pivot.x,pt.y-pivot.y,pt.z-pivot.z)
		Dim As vector3d rot,temp
		Rotate(p.y,-p.z,p.z,p.y,x)'X
		rot.y=temp.x:rot.z=temp.y 
		p.y = rot.y:p.z = rot.z 
		Rotate(p.z,-p.x,p.x,p.z,y)'Y
		rot.z=temp.x:rot.x=temp.y
		p.x=rot.x
		Rotate(p.x,-p.y,p.y,p.x,z)'Z
		rot.x=temp.x:rot.y=temp.y
		Return Type<vector3d>((scale.x*rot.x+pivot.x),(scale.y*rot.y+pivot.y),(scale.z*rot.z+pivot.z))
	End Function
	
	Function apply_perspective(ByRef p As vector3d,ByRef eyepoint As vector3d) As vector3d
		Dim As Single   w=1+(p.z/eyepoint.z)
		If w=0 Then w=1e-20
		Return Type<vector3d>((p.x-eyepoint.x)/w+eyepoint.x,(p.y-eyepoint.y)/w+eyepoint.y,(p.z-eyepoint.z)/w+eyepoint.z)
	End Function
	'====================== End of rotator and perspective getter ======================================
	Dim Shared As Integer xres,yres
	ScreenRes 800, 640, 8
	Width 800 \ 8, 640 \ 16
	ScreenInfo xres,yres

	'two main arrays
	Dim Shared As vector3d rotated()
	ReDim Shared As vector3d array()
	'extra subs to regulate speed
	'four shapes
	Function create1(ByVal number As Integer) As Integer
		ReDim array(0)
		Dim As Integer count,stepper=10
		For x As Integer=xres/2-number To xres/2+number Step stepper
			For y As Integer=yres/2-number To yres/2+number Step stepper
				For z As Integer=-number To number Step stepper
					count=count+1
					ReDim Preserve array(1 To count)
					array(UBound(array))=vct(x,y,z)
				Next z
			Next y
		Next x
		ReDim rotated(LBound(array) To UBound(array))
		Return 0
	End Function
	
	'variables
	Dim As vector3d centre=vct(xres/2,yres/2,0)
	Dim As vector3d eyepoint=vct(xres/2,yres/2,600)
	Dim As vector3d angle
	Dim As Long fps=150,rfps
	Dim As Boolean skipping=False,remove=False,skipped
	Dim As Long ist,mist
	Dim As ULong averageFps
	Dim As Double sumFps
	Dim As Long N
	Dim As vector3d disp=vct(xres/2,yres/2,0)
	Dim As Integer k,flag=1,border=.2*xres
	Dim As Single sx=1,kx=2,ky=1.9,kz=1.5
	create1(90)
	Do
		angle=angle+vct(.2,2,.1)
		With angle
			If .x>=360 Then .x-=360
			If .y>=360 Then .y-=360
			If .x>=360 Then .z-=360
		End With
		disp=disp+vct(kx,ky,0)
		If disp.x<border Then kx=-kx
		If disp.x>xres-border Then kx=-kx
		If disp.y<border Then ky=-ky
		If disp.y>yres-border Then ky=-ky
		If (remove = False) Or (skipped = False) Then
			ScreenLock
			Cls
			
			For n As Integer=1 To UBound(rotated)
				rotated(n)=rotate3d(centre,(array(n)),angle,vct(sx,sx,sx))
			Next n
			
			combsort(rotated,1,UBound(rotated),.z)
			
			For n As Integer=1 To UBound(rotated)
				Var dist=length(rotated(n)-centre)
				rotated(n)=apply_perspective(rotated(n),eyepoint)
				rotated(n)=rotated(n)+(disp-centre)
				
				Var col=map(0,200,dist,1,15)
				Var radius=map(-400,400,rotated(n).z,10,1)
				Circle (rotated(n).x,rotated(n).y),radius,col,,,,f
			Next n
			
			Draw String (16,16),"Requested FPS = " & Right("  " & fps, 3)
			Draw String (16,32),"Applied FPS   = " & Right("  " & rfps, 3) & "   (average = " & Right("  " & averageFps, 3) & ")"
			Draw String (16,48),"Status : " & _
				IIf(skipping = True, "Image skipping activation = true, with " & _
				IIf(remove = True, "removing images skipped = " & IIf(mist > 0, Str(mist) & "/" & Str(mist + 1), "0"), _
				"scrolling images skipped = " & IIf(mist > 0, Str(mist) & "/" & Str(mist + 1), "0")), _
				"Image skipping activation = false")
			Draw String (16,80),"<+> : Increase FPS"
			Draw String (16,96),"<-> : Decrease FPS"
			Draw String (16,128),"<t> or <T> : True for image skipping activation"
			If Skipping = True Then
				Draw String (16,144),"   <s> or <S> : Scroll image skipped"
				Draw String (16,160),"   <r> or <R> : Remove image skipped"
				Draw String (16,176),"<f> or <F> : False for image skipping activation"
				Draw String (16,208),"<escape> : Quit"
			Else
				Draw String (16,144),"<f> or <F> : False for image skipping activation"
				Draw String (16,176),"<escape> : Quit"
			End If
			Draw String (544,608),"Graphic animation from dodicat"
			ScreenUnlock
		End If
		rfps = regulateLite(fps,skipping, ,skipped)
		If skipped = True Then
			ist += 1
		Else
			mist = ist
			ist = 0
		End If
		sumFps += rfps
		N += 1
		If N >= rfps / 2 Then
			averageFps = sumFps / N
			N = 0
			sumFps = 0
		End If
		Dim As String s = UCase(Inkey)
		Select Case s
		Case "+"
			If fps < 700 Then fps += 1
		Case "-"
			If fps > 10 Then fps -= 1
		Case "T"
			skipping = True
		Case "F"
			skipping = False
		Case "S"
			If skipping = True Then remove = False
		Case "R"
			If skipping = True Then remove = True
		Case Chr(27)
			Exit Do
		End Select
	Loop
