'
' Small tool to start a shell with the path set to the FreeBASIC compiler
'

option explicit

dim sPath as string
sPath = exepath()

select case right$(sPath,1)
case "/","\"
case else
    sPath += "/"
end select

if len(dir$(sPath + "setvars.bat"))=0 then
	open "O",1,sPath + "setvars.bat"
	print #1,"@echo off"
	print #1,"set PATH="+exepath()+";%PATH%"
	print #1,"%COMSPEC%
	close #1
end if

shell sPath + "setvars.bat"

end
