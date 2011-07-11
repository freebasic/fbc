'' Small tool to open a console with the PATH set to include the directory that
'' includes fbc.exe.

'' Set the PATH
dim as string path = environ("PATH")
if (len(path) > 0) then
    path = ";" + path
end if
setenviron("PATH=" + exepath() + path)

'' Start shell
dim as string cmd = environ("COMSPEC")
if (len(cmd) = 0) then
    cmd = "command.com"
end if
shell(cmd)
