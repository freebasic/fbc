DLLTOOL := dlltool
CC := gcc

mingwlibdir := $(dir $(shell $(CC) -print-file-name=libmingw32.a))

bydeflibs := $(wildcard *.def)
bydeflibs := $(patsubst %.def,lib%.dll.a,$(bydeflibs))

win32libs := aclui
win32libs += advapi32
win32libs += apcups
win32libs += avicap32
win32libs += avifil32
win32libs += bthprops
win32libs += cap
win32libs += cfgmgr32
win32libs += comctl32
win32libs += comdlg32
win32libs += crypt32
win32libs += ctl3d32
win32libs += d3d8
win32libs += d3d9
win32libs += d3dim
win32libs += d3drm
win32libs += d3dx10
win32libs += d3dx11
win32libs += d3dx8d
win32libs += d3dx9
win32libs += d3dx9d
win32libs += d3dxof
win32libs += ddraw
win32libs += dinput
win32libs += dinput8
win32libs += dmoguids
win32libs += dnsapi
win32libs += dplayx
win32libs += dpnaddr
win32libs += dpnet
win32libs += dpnlobby
win32libs += dpvoice
win32libs += dsetup
win32libs += dsound
win32libs += dwmapi
win32libs += dxapi
win32libs += dxerr8
win32libs += dxerr9
win32libs += esent
win32libs += faultrep
win32libs += gdi32
win32libs += gdiplus
win32libs += glaux
win32libs += glu32
win32libs += glut
win32libs += glut32
win32libs += hal
win32libs += icmui
win32libs += igmpagnt
win32libs += imagehlp
win32libs += imm32
win32libs += iphlpapi
win32libs += kernel32
win32libs += lz32
win32libs += mpr
win32libs += mqrt
win32libs += msacm32
win32libs += msi
win32libs += msimg32
win32libs += msvcrt
win32libs += msvfw32
win32libs += mswsock
win32libs += nddeapi
win32libs += normaliz
win32libs += ntdll
win32libs += ntdsapi
win32libs += ntoskrnl
win32libs += odbc32
win32libs += odbccp32
win32libs += ole32
win32libs += oleacc
win32libs += oleaut32
win32libs += olecli32
win32libs += oledlg
win32libs += olepro32
win32libs += olesvr32
win32libs += opengl32
win32libs += pdh
win32libs += psapi
win32libs += rasapi32
win32libs += rasdlg
win32libs += rpcdce4
win32libs += rpcns4
win32libs += secur32
win32libs += setupapi
win32libs += shell32
win32libs += shfolder
win32libs += shlwapi
win32libs += snmpapi
win32libs += spoolss
win32libs += svrapi
win32libs += url
win32libs += user32
win32libs += userenv
win32libs += usp10
win32libs += uuid
win32libs += uxtheme
win32libs += version
win32libs += vfw32
win32libs += win32k
win32libs += win32spl
win32libs += wininet
win32libs += winmm
win32libs += winspool
win32libs += wldap32
win32libs += wow32
win32libs += ws2_32
win32libs += wsnmp32
win32libs += wsock32
win32libs := $(patsubst %,lib%.dll.a,$(win32libs))

all: $(bydeflibs) $(win32libs)

# Some libraries need extra dlltool flags
libfmod.dll.a:         DTFLAGS := --add-stdcall-underscore
libjvm.dll.a:          DTFLAGS := --kill-at
libmySQL.dll.a:        DTFLAGS := --kill-at
libwx-c-0-9-0-2.dll.a: DTFLAGS := --add-stdcall-underscore

$(bydeflibs): lib%.dll.a: %.def
	$(DLLTOOL) -d $< -l $@ $(DTFLAGS)

$(win32libs): %.dll.a: $(mingwlibdir)/%.a
	cp $< $@

clean:
	rm -f $(bydeflibs) $(win32libs)
