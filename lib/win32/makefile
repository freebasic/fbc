DLLTOOL := dlltool
CC := gcc

mingwlibdir := $(patsubst %/,%,$(dir $(shell $(CC) -print-file-name=libmingw32.a)))

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
# MinGW-w64 only
win32libs += d3dx10
# MinGW-w64 only
win32libs += d3dx11
win32libs += d3dx8d
# MinGW-w64 only
win32libs += d3dx9
win32libs += d3dx9d
win32libs += d3dxof
win32libs += ddraw
win32libs += dhcpcsvc
win32libs += dinput
win32libs += dinput8
win32libs += dlcapi
win32libs += dmoguids
win32libs += dnsapi
win32libs += dplayx
win32libs += dpnaddr
win32libs += dpnet
win32libs += dpnlobby
win32libs += dpvoice
win32libs += dsetup
win32libs += dsound
# MinGW-w64 only
win32libs += dwmapi
win32libs += dxapi
win32libs += dxerr8
win32libs += dxerr9
# MinGW-w64 only
win32libs += esent
win32libs += dxguid
win32libs += faultrep
win32libs += gdi32
win32libs += gdiplus
win32libs += glaux
win32libs += glu32
# MinGW-w64 only
win32libs += glut
# MinGW-w64 only
win32libs += glut32
win32libs += hal
win32libs += hid
win32libs += hidparse
win32libs += icmui
win32libs += igmpagnt
win32libs += imagehlp
win32libs += imm32
win32libs += iphlpapi
win32libs += kernel32
win32libs += ksproxy
win32libs += ksuser
win32libs += largeint
win32libs += lz32
win32libs += mapi32
win32libs += mcd
win32libs += mfcuia32
win32libs += mgmtapi
win32libs += mpr
win32libs += mprapi
win32libs += mqrt
win32libs += msacm32
# MinGW-w64 only
win32libs += msi
win32libs += mscms
win32libs += msdmo
win32libs += msimg32
win32libs += msvcrt
win32libs += msvcp60
win32libs += msvfw32
win32libs += mswsock
win32libs += nddeapi
# MinGW-w64 only
win32libs += normaliz
win32libs += ndis
win32libs += netapi32
win32libs += newdev
win32libs += ntdll
# MinGW-w64 only
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
# MinGW-w64 only
win32libs += pdh
win32libs += penwin32
win32libs += pkpd32
win32libs += powrprof
win32libs += psapi
win32libs += quartz
win32libs += rapi
win32libs += rasapi32
win32libs += rasdlg
win32libs += rpcdce4
win32libs += rpcns4
win32libs += rpcrt4
win32libs += rtm
win32libs += rtutils
win32libs += scrnsave
win32libs += scrnsavw
win32libs += scsiport
win32libs += secur32
win32libs += setupapi
win32libs += shell32
win32libs += shfolder
win32libs += shlwapi
win32libs += snmpapi
# MinGW-w64 only
win32libs += spoolss
win32libs += strmiids
win32libs += svrapi
win32libs += tapi32
win32libs += tdi
# MinGW.org only
#win32libs += thunk32
win32libs += url
win32libs += usbcamd2
win32libs += usbcamd
win32libs += user32
win32libs += userenv
win32libs += usp10
win32libs += uuid
win32libs += uxtheme
win32libs += vdmdbg
win32libs += version
win32libs += vfw32
win32libs += videoprt
win32libs += win32k
win32libs += win32spl
win32libs += wininet
win32libs += winmm
win32libs += winspool
win32libs += winstrm
win32libs += wldap32
win32libs += wow32
win32libs += ws2_32
win32libs += wsnmp32
win32libs += wsock32
win32libs += wst
win32libs += wtsapi32
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
