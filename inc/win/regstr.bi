'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "winapifamily.bi"

#define _INC_REGSTR
#define REGSTR_KEY_CLASS __TEXT("Class")
#define REGSTR_KEY_CONFIG __TEXT("Config")
#define REGSTR_KEY_ENUM __TEXT("Enum")
#define REGSTR_KEY_ROOTENUM __TEXT("Root")
#define REGSTR_KEY_BIOSENUM __TEXT("BIOS")
#define REGSTR_KEY_ACPIENUM __TEXT("ACPI")
#define REGSTR_KEY_PCMCIAENUM __TEXT("PCMCIA")
#define REGSTR_KEY_PCIENUM __TEXT("PCI")
#define REGSTR_KEY_VPOWERDENUM __TEXT("VPOWERD")
#define REGSTR_KEY_ISAENUM __TEXT("ISAPnP")
#define REGSTR_KEY_EISAENUM __TEXT("EISA")
#define REGSTR_KEY_LOGCONFIG __TEXT("LogConfig")
#define REGSTR_KEY_SYSTEMBOARD __TEXT("*PNP0C01")
#define REGSTR_KEY_APM __TEXT("*PNP0C05")
#define REGSTR_KEY_INIUPDATE __TEXT("IniUpdate")
#define REG_KEY_INSTDEV __TEXT("Installed")
#define REGSTR_KEY_DOSOPTCDROM __TEXT("CD-ROM")
#define REGSTR_KEY_DOSOPTMOUSE __TEXT("MOUSE")
#define REGSTR_KEY_KNOWNDOCKINGSTATES __TEXT("Hardware Profiles")
#define REGSTR_KEY_DEVICEPARAMETERS __TEXT("Device Parameters")
#define REGSTR_DEFAULT_INSTANCE __TEXT("0000")
#define REGSTR_PATH_MOTHERBOARD (REGSTR_KEY_SYSTEMBOARD + __TEXT(!"\\") + REGSTR_DEFAULT_INSTANCE)
#define REGSTR_PATH_SETUP __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion")
#define REGSTR_PATH_DRIVERSIGN __TEXT(!"Software\\Microsoft\\Driver Signing")
#define REGSTR_PATH_NONDRIVERSIGN __TEXT(!"Software\\Microsoft\\Non-Driver Signing")
#define REGSTR_PATH_DRIVERSIGN_POLICY __TEXT(!"Software\\Policies\\Microsoft\\Windows NT\\Driver Signing")
#define REGSTR_PATH_NONDRIVERSIGN_POLICY __TEXT(!"Software\\Policies\\Microsoft\\Windows NT\\Non-Driver Signing")
#define REGSTR_PATH_PIFCONVERT __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\PIFConvert")
#define REGSTR_PATH_MSDOSOPTS __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\MS-DOSOptions")
#define REGSTR_PATH_NOSUGGMSDOS __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\NoMSDOSWarn")
#define REGSTR_PATH_NEWDOSBOX __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\MS-DOSSpecialConfig")
#define REGSTR_PATH_RUNONCE __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\RunOnce")
#define REGSTR_PATH_RUNONCEEX __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\RunOnceEx")
#define REGSTR_PATH_RUN __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Run")
#define REGSTR_PATH_RUNSERVICESONCE __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\RunServicesOnce")
#define REGSTR_PATH_RUNSERVICES __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\RunServices")
#define REGSTR_PATH_EXPLORER __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Explorer")
#define REGSTR_PATH_PROPERTYSYSTEM __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\PropertySystem")
#define REGSTR_PATH_DETECT __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Detect")
#define REGSTR_PATH_APPPATHS __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\App Paths")
#define REGSTR_PATH_UNINSTALL __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall")
#define REGSTR_PATH_REALMODENET __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Network\\Real Mode Net")
#define REGSTR_PATH_NETEQUIV __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Network\\Equivalent")
#define REGSTR_PATH_CVNETWORK __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Network")
#define REGSTR_PATH_WMI_SECURITY __TEXT(!"System\\CurrentControlSet\\Control\\Wmi\\Security")
#define REGSTR_PATH_RELIABILITY __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Reliability")
#define REGSTR_PATH_RELIABILITY_POLICY __TEXT(!"Software\\Policies\\Microsoft\\Windows NT\\Reliability")
#define REGSTR_PATH_RELIABILITY_POLICY_SHUTDOWNREASONUI __TEXT("ShutdownReasonUI")
#define REGSTR_PATH_RELIABILITY_POLICY_SNAPSHOT __TEXT("Snapshot")
#define REGSTR_PATH_RELIABILITY_POLICY_REPORTSNAPSHOT __TEXT("ReportSnapshot")
#define REGSTR_PATH_REINSTALL __TEXT(!"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Reinstall")
#define REGSTR_PATH_NT_CURRENTVERSION __TEXT(!"Software\\Microsoft\\Windows NT\\CurrentVersion")
#define REGSTR_PATH_VOLUMECACHE __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VolumeCaches")
#define REGSTR_VAL_DISPLAY __TEXT("display")
#define REGSTR_PATH_IDCONFIGDB __TEXT(!"System\\CurrentControlSet\\Control\\IDConfigDB")
#define REGSTR_PATH_CRITICALDEVICEDATABASE __TEXT(!"System\\CurrentControlSet\\Control\\CriticalDeviceDatabase")
#define REGSTR_PATH_CLASS __TEXT(!"System\\CurrentControlSet\\Services\\Class")
#define REGSTR_PATH_DISPLAYSETTINGS __TEXT(!"Display\\Settings")
#define REGSTR_PATH_FONTS __TEXT(!"Display\\Fonts")
#define REGSTR_PATH_ENUM __TEXT("Enum")
#define REGSTR_PATH_ROOT __TEXT(!"Enum\\Root")
#define REGSTR_PATH_CURRENTCONTROLSET __TEXT(!"System\\CurrentControlSet")
#define REGSTR_PATH_SYSTEMENUM __TEXT(!"System\\CurrentControlSet\\Enum")
#define REGSTR_PATH_HWPROFILES __TEXT(!"System\\CurrentControlSet\\Hardware Profiles")
#define REGSTR_PATH_HWPROFILESCURRENT __TEXT(!"System\\CurrentControlSet\\Hardware Profiles\\Current")
#define REGSTR_PATH_CLASS_NT __TEXT(!"System\\CurrentControlSet\\Control\\Class")
#define REGSTR_PATH_PER_HW_ID_STORAGE __TEXT(!"Software\\Microsoft\\Windows NT\\CurrentVersion\\PerHwIdStorage")
#define REGSTR_PATH_DEVICE_CLASSES __TEXT(!"System\\CurrentControlSet\\Control\\DeviceClasses")
#define REGSTR_PATH_CODEVICEINSTALLERS __TEXT(!"System\\CurrentControlSet\\Control\\CoDeviceInstallers")
#define REGSTR_PATH_BUSINFORMATION __TEXT(!"System\\CurrentControlSet\\Control\\PnP\\BusInformation")
#define REGSTR_PATH_SERVICES __TEXT(!"System\\CurrentControlSet\\Services")
#define REGSTR_PATH_VXD __TEXT(!"System\\CurrentControlSet\\Services\\VxD")
#define REGSTR_PATH_IOS __TEXT(!"System\\CurrentControlSet\\Services\\VxD\\IOS")
#define REGSTR_PATH_VMM __TEXT(!"System\\CurrentControlSet\\Services\\VxD\\VMM")
#define REGSTR_PATH_VPOWERD __TEXT(!"System\\CurrentControlSet\\Services\\VxD\\VPOWERD")
#define REGSTR_PATH_VNETSUP __TEXT(!"System\\CurrentControlSet\\Services\\VxD\\VNETSUP")
#define REGSTR_PATH_NWREDIR __TEXT(!"System\\CurrentControlSet\\Services\\VxD\\NWREDIR")
#define REGSTR_PATH_NCPSERVER __TEXT(!"System\\CurrentControlSet\\Services\\NcpServer\\Parameters")
#define REGSTR_PATH_VCOMM __TEXT(!"System\\CurrentControlSet\\Services\\VxD\\VCOMM")
#define REGSTR_PATH_IOARB __TEXT(!"System\\CurrentControlSet\\Services\\Arbitrators\\IOArb")
#define REGSTR_PATH_ADDRARB __TEXT(!"System\\CurrentControlSet\\Services\\Arbitrators\\AddrArb")
#define REGSTR_PATH_DMAARB __TEXT(!"System\\CurrentControlSet\\Services\\Arbitrators\\DMAArb")
#define REGSTR_PATH_IRQARB __TEXT(!"System\\CurrentControlSet\\Services\\Arbitrators\\IRQArb")
#define REGSTR_PATH_CODEPAGE __TEXT(!"System\\CurrentControlSet\\Control\\Nls\\Codepage")
#define REGSTR_PATH_FILESYSTEM __TEXT(!"System\\CurrentControlSet\\Control\\FileSystem")
#define REGSTR_PATH_FILESYSTEM_NOVOLTRACK __TEXT(!"System\\CurrentControlSet\\Control\\FileSystem\\NoVolTrack")
#define REGSTR_PATH_CDFS __TEXT(!"System\\CurrentControlSet\\Control\\FileSystem\\CDFS")
#define REGSTR_PATH_WINBOOT __TEXT(!"System\\CurrentControlSet\\Control\\WinBoot")
#define REGSTR_PATH_INSTALLEDFILES __TEXT(!"System\\CurrentControlSet\\Control\\InstalledFiles")
#define REGSTR_PATH_VMM32FILES __TEXT(!"System\\CurrentControlSet\\Control\\VMM32Files")
const REGSTR_MAX_VALUE_LENGTH = 256
#define REGSTR_KEY_DEVICE_PROPERTIES __TEXT("Properties")
#define REGSTR_VAL_SLOTNUMBER __TEXT("SlotNumber")
#define REGSTR_VAL_ATTACHEDCOMPONENTS __TEXT("AttachedComponents")
#define REGSTR_VAL_BASEDEVICEPATH __TEXT("BaseDevicePath")
#define REGSTR_VAL_SYSTEMBUSNUMBER __TEXT("SystemBusNumber")
#define REGSTR_VAL_BUSDATATYPE __TEXT("BusDataType")
#define REGSTR_VAL_INTERFACETYPE __TEXT("InterfaceType")
#define REGSTR_VAL_SERVICE __TEXT("Service")
#define REGSTR_VAL_DETECTSIGNATURE __TEXT("DetectSignature")
#define REGSTR_VAL_CLASSGUID __TEXT("ClassGUID")
#define REGSTR_VAL_INSTANCEIDENTIFIER __TEXT("InstanceIdentifier")
#define REGSTR_VAL_DUPLICATEOF __TEXT("DuplicateOf")
#define REGSTR_VAL_STATUSFLAGS __TEXT("StatusFlags")
#define REGSTR_VAL_DISABLECOUNT __TEXT("DisableCount")
#define REGSTR_VAL_UNKNOWNPROBLEMS __TEXT("UnknownProblem")
#define REGSTR_VAL_DOCKSTATE __TEXT("DockState")
#define REGSTR_VAL_PREFERENCEORDER __TEXT("PreferenceOrder")
#define REGSTR_VAL_USERWAITINTERVAL __TEXT("UserWaitInterval")
#define REGSTR_VAL_DEVICE_INSTANCE __TEXT("DeviceInstance")
#define REGSTR_VAL_SYMBOLIC_LINK __TEXT("SymbolicLink")
#define REGSTR_VAL_DEFAULT __TEXT("Default")
#define REGSTR_VAL_LOWERFILTERS __TEXT("LowerFilters")
#define REGSTR_VAL_UPPERFILTERS __TEXT("UpperFilters")
#define REGSTR_VAL_LOCATION_INFORMATION __TEXT("LocationInformation")
#define REGSTR_VAL_UI_NUMBER __TEXT("UINumber")
#define REGSTR_VAL_UI_NUMBER_DESC_FORMAT __TEXT("UINumberDescFormat")
#define REGSTR_VAL_CAPABILITIES __TEXT("Capabilities")
#define REGSTR_VAL_DEVICE_TYPE __TEXT("DeviceType")
#define REGSTR_VAL_DEVICE_CHARACTERISTICS __TEXT("DeviceCharacteristics")
#define REGSTR_VAL_DEVICE_SECURITY_DESCRIPTOR __TEXT("Security")
#define REGSTR_VAL_DEVICE_EXCLUSIVE __TEXT("Exclusive")
#define REGSTR_VAL_RESOURCE_PICKER_TAGS __TEXT("ResourcePickerTags")
#define REGSTR_VAL_RESOURCE_PICKER_EXCEPTIONS __TEXT("ResourcePickerExceptions")
#define REGSTR_VAL_CUSTOM_PROPERTY_CACHE_DATE __TEXT("CustomPropertyCacheDate")
#define REGSTR_VAL_CUSTOM_PROPERTY_HW_ID_KEY __TEXT("CustomPropertyHwIdKey")
#define REGSTR_VAL_LAST_UPDATE_TIME __TEXT("LastUpdateTime")
#define REGSTR_VAL_CONTAINERID __TEXT("ContainerID")
#define REGSTR_VAL_EJECT_PRIORITY __TEXT("EjectPriority")
#define REGSTR_KEY_CONTROL __TEXT("Control")
#define REGSTR_VAL_ACTIVESERVICE __TEXT("ActiveService")
#define REGSTR_VAL_LINKED __TEXT("Linked")
#define REGSTR_VAL_PHYSICALDEVICEOBJECT __TEXT("PhysicalDeviceObject")
#define REGSTR_VAL_REMOVAL_POLICY __TEXT("RemovalPolicy")
#define REGSTR_VAL_CURRENT_VERSION __TEXT("CurrentVersion")
#define REGSTR_VAL_CURRENT_BUILD __TEXT("CurrentBuildNumber")
#define REGSTR_VAL_CURRENT_CSDVERSION __TEXT("CSDVersion")
#define REGSTR_VAL_CURRENT_TYPE __TEXT("CurrentType")
#define REGSTR_VAL_BITSPERPIXEL __TEXT("BitsPerPixel")
#define REGSTR_VAL_RESOLUTION __TEXT("Resolution")
#define REGSTR_VAL_DPILOGICALX __TEXT("DPILogicalX")
#define REGSTR_VAL_DPILOGICALY __TEXT("DPILogicalY")
#define REGSTR_VAL_DPIPHYSICALX __TEXT("DPIPhysicalX")
#define REGSTR_VAL_DPIPHYSICALY __TEXT("DPIPhysicalY")
#define REGSTR_VAL_REFRESHRATE __TEXT("RefreshRate")
#define REGSTR_VAL_DISPLAYFLAGS __TEXT("DisplayFlags")
#define REGSTR_PATH_CONTROLPANEL __TEXT("Control Panel")
#define REGSTR_PATH_CONTROLSFOLDER __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Controls Folder")
#define REGSTR_VAL_DOSCP __TEXT("OEMCP")
#define REGSTR_VAL_WINCP __TEXT("ACP")
#define REGSTR_PATH_DYNA_ENUM __TEXT(!"Config Manager\\Enum")
#define REGSTR_VAL_HARDWARE_KEY __TEXT("HardWareKey")
#define REGSTR_VAL_ALLOCATION __TEXT("Allocation")
#define REGSTR_VAL_PROBLEM __TEXT("Problem")
#define REGSTR_VAL_STATUS __TEXT("Status")
#define REGSTR_VAL_DONTUSEMEM __TEXT("DontAllocLastMem")
#define REGSTR_VAL_SYSTEMROOT __TEXT("SystemRoot")
#define REGSTR_VAL_BOOTCOUNT __TEXT("BootCount")
#define REGSTR_VAL_REALNETSTART __TEXT("RealNetStart")
#define REGSTR_VAL_MEDIA __TEXT("MediaPath")
#define REGSTR_VAL_CONFIG __TEXT("ConfigPath")
#define REGSTR_VAL_DEVICEPATH __TEXT("DevicePath")
#define REGSTR_VAL_SRCPATH __TEXT("SourcePath")
#define REGSTR_VAL_SVCPAKSRCPATH __TEXT("ServicePackSourcePath")
#define REGSTR_VAL_DRIVERCACHEPATH __TEXT("DriverCachePath")
#define REGSTR_VAL_OLDWINDIR __TEXT("OldWinDir")
#define REGSTR_VAL_SETUPFLAGS __TEXT("SetupFlags")
#define REGSTR_VAL_REGOWNER __TEXT("RegisteredOwner")
#define REGSTR_VAL_REGORGANIZATION __TEXT("RegisteredOrganization")
#define REGSTR_VAL_LICENSINGINFO __TEXT("LicensingInfo")
#define REGSTR_VAL_OLDMSDOSVER __TEXT("OldMSDOSVer")
#define REGSTR_VAL_FIRSTINSTALLDATETIME __TEXT("FirstInstallDateTime")
#define REGSTR_VAL_INSTALLTYPE __TEXT("InstallType")
const IT_COMPACT = &h0000
const IT_TYPICAL = &h0001
const IT_PORTABLE = &h0002
const IT_CUSTOM = &h0003
#define REGSTR_VAL_WRAPPER __TEXT("Wrapper")
#define REGSTR_KEY_RUNHISTORY __TEXT("RunHistory")
#define REGSTR_VAL_LASTALIVEINTERVAL __TEXT("TimeStampInterval")
#define REGSTR_VAL_DIRTYSHUTDOWN __TEXT("DirtyShutdown")
#define REGSTR_VAL_DIRTYSHUTDOWNTIME __TEXT("DirtyShutdownTime")
#define REGSTR_VAL_BT __TEXT("6005BT")
#define REGSTR_VAL_LASTCOMPUTERNAME __TEXT("LastComputerName")
#define REGSTR_VAL_LASTALIVEBT __TEXT("LastAliveBT")
#define REGSTR_VAL_LASTALIVESTAMP __TEXT("LastAliveStamp")
#define REGSTR_VAL_LASTALIVESTAMPFORCED __TEXT("LastAliveStampForced")
#define REGSTR_VAL_LASTALIVESTAMPINTERVAL __TEXT("LastAliveStampInterval")
#define REGSTR_VAL_LASTALIVESTAMPPOLICYINTERVAL __TEXT("LastAliveStampPolicyInterval")
#define REGSTR_VAL_LASTALIVEUPTIME __TEXT("LastAliveUptime")
#define REGSTR_VAL_LASTALIVEPMPOLICY __TEXT("LastAlivePMPolicy")
#define REGSTR_VAL_REASONCODE __TEXT("ReasonCode")
#define REGSTR_VAL_COMMENT __TEXT("Comment")
#define REGSTR_VAL_SHUTDOWNREASON __TEXT("ShutdownReason")
#define REGSTR_VAL_SHUTDOWNREASON_CODE __TEXT("ShutdownReasonCode")
#define REGSTR_VAL_SHUTDOWNREASON_COMMENT __TEXT("ShutdownReasonComment")
#define REGSTR_VAL_SHUTDOWNREASON_PROCESS __TEXT("ShutdownReasonProcess")
#define REGSTR_VAL_SHUTDOWNREASON_USERNAME __TEXT("ShutdownReasonUserName")
#define REGSTR_VAL_SHOWREASONUI __TEXT("ShutdownReasonUI")
#define REGSTR_VAL_SHUTDOWN_IGNORE_PREDEFINED __TEXT("ShutdownIgnorePredefinedReasons")
#define REGSTR_VAL_SHUTDOWN_STATE_SNAPSHOT __TEXT("ShutdownStateSnapshot")
#define REGSTR_KEY_SETUP __TEXT(!"\\Setup")
#define REGSTR_VAL_BOOTDIR __TEXT("BootDir")
#define REGSTR_VAL_WINBOOTDIR __TEXT("WinbootDir")
#define REGSTR_VAL_WINDIR __TEXT("WinDir")
#define REGSTR_VAL_APPINSTPATH __TEXT("AppInstallPath")
#define REGSTR_PATH_EBD (REGSTR_PATH_SETUP + REGSTR_KEY_SETUP + __TEXT(!"\\EBD"))
#define REGSTR_KEY_EBDFILESLOCAL __TEXT("EBDFilesLocale")
#define REGSTR_KEY_EBDFILESKEYBOARD __TEXT("EBDFilesKeyboard")
#define REGSTR_KEY_EBDAUTOEXECBATLOCAL __TEXT("EBDAutoexecBatLocale")
#define REGSTR_KEY_EBDAUTOEXECBATKEYBOARD __TEXT("EBDAutoexecBatKeyboard")
#define REGSTR_KEY_EBDCONFIGSYSLOCAL __TEXT("EBDConfigSysLocale")
#define REGSTR_KEY_EBDCONFIGSYSKEYBOARD __TEXT("EBDConfigSysKeyboard")
#define REGSTR_VAL_POLICY __TEXT("Policy")
#define REGSTR_VAL_BEHAVIOR_ON_FAILED_VERIFY __TEXT("BehaviorOnFailedVerify")
const DRIVERSIGN_NONE = &h00000000
const DRIVERSIGN_WARNING = &h00000001
const DRIVERSIGN_BLOCKING = &h00000002
#define REGSTR_VAL_MSDOSMODE __TEXT("MSDOSMode")
#define REGSTR_VAL_MSDOSMODEDISCARD __TEXT("Discard")
#define REGSTR_VAL_DOSOPTGLOBALFLAGS __TEXT("GlobalFlags")
const DOSOPTGF_DEFCLEAN = &h00000001
#define REGSTR_VAL_DOSOPTFLAGS __TEXT("Flags")
#define REGSTR_VAL_OPTORDER __TEXT("Order")
#define REGSTR_VAL_CONFIGSYS __TEXT("Config.Sys")
#define REGSTR_VAL_AUTOEXEC __TEXT("Autoexec.Bat")
#define REGSTR_VAL_STDDOSOPTION __TEXT("StdOption")
#define REGSTR_VAL_DOSOPTTIP __TEXT("TipText")
const DOSOPTF_DEFAULT = &h00000001
const DOSOPTF_SUPPORTED = &h00000002
const DOSOPTF_ALWAYSUSE = &h00000004
const DOSOPTF_USESPMODE = &h00000008
const DOSOPTF_PROVIDESUMB = &h00000010
const DOSOPTF_NEEDSETUP = &h00000020
const DOSOPTF_INDOSSTART = &h00000040
const DOSOPTF_MULTIPLE = &h00000080
const SUF_FIRSTTIME = &h00000001
const SUF_EXPRESS = &h00000002
const SUF_BATCHINF = &h00000004
const SUF_CLEAN = &h00000008
const SUF_INSETUP = &h00000010
const SUF_NETSETUP = &h00000020
const SUF_NETHDBOOT = &h00000040
const SUF_NETRPLBOOT = &h00000080
const SUF_SBSCOPYOK = &h00000100
#define REGSTR_VAL_DOSPAGER __TEXT("DOSPager")
#define REGSTR_VAL_VXDGROUPS __TEXT("VXDGroups")
#define REGSTR_VAL_VPOWERDFLAGS __TEXT("Flags")
const VPDF_DISABLEPWRMGMT = &h00000001
const VPDF_FORCEAPM10MODE = &h00000002
const VPDF_SKIPINTELSLCHECK = &h00000004
const VPDF_DISABLEPWRSTATUSPOLL = &h00000008
const VPDF_DISABLERINGRESUME = &h00000010
const VPDF_SHOWMULTIBATT = &h00000020
const BIF_SHOWSIMILARDRIVERS = &h00000001
const BIF_RAWDEVICENEEDSDRIVER = &h00000002
#define REGSTR_VAL_WORKGROUP __TEXT("Workgroup")
#define REGSTR_VAL_DIRECTHOST __TEXT("DirectHost")
#define REGSTR_VAL_FILESHARING __TEXT("FileSharing")
#define REGSTR_VAL_PRINTSHARING __TEXT("PrintSharing")
#define REGSTR_VAL_FIRSTNETDRIVE __TEXT("FirstNetworkDrive")
#define REGSTR_VAL_MAXCONNECTIONS __TEXT("MaxConnections")
#define REGSTR_VAL_APISUPPORT __TEXT("APISupport")
#define REGSTR_VAL_MAXRETRY __TEXT("MaxRetry")
#define REGSTR_VAL_MINRETRY __TEXT("MinRetry")
#define REGSTR_VAL_SUPPORTLFN __TEXT("SupportLFN")
#define REGSTR_VAL_SUPPORTBURST __TEXT("SupportBurst")
#define REGSTR_VAL_SUPPORTTUNNELLING __TEXT("SupportTunnelling")
#define REGSTR_VAL_FULLTRACE __TEXT("FullTrace")
#define REGSTR_VAL_READCACHING __TEXT("ReadCaching")
#define REGSTR_VAL_SHOWDOTS __TEXT("ShowDots")
#define REGSTR_VAL_GAPTIME __TEXT("GapTime")
#define REGSTR_VAL_SEARCHMODE __TEXT("SearchMode")
#define REGSTR_VAL_SHELLVERSION __TEXT("ShellVersion")
#define REGSTR_VAL_MAXLIP __TEXT("MaxLIP")
#define REGSTR_VAL_PRESERVECASE __TEXT("PreserveCase")
#define REGSTR_VAL_OPTIMIZESFN __TEXT("OptimizeSFN")
#define REGSTR_VAL_NCP_BROWSEMASTER __TEXT("BrowseMaster")
#define REGSTR_VAL_NCP_USEPEERBROWSING __TEXT("Use_PeerBrowsing")
#define REGSTR_VAL_NCP_USESAP __TEXT("Use_Sap")
#define REGSTR_VAL_PCCARD_POWER __TEXT("EnablePowerManagement")
#define REGSTR_VAL_WIN31FILESYSTEM __TEXT("Win31FileSystem")
#define REGSTR_VAL_PRESERVELONGNAMES __TEXT("PreserveLongNames")
#define REGSTR_VAL_DRIVEWRITEBEHIND __TEXT("DriveWriteBehind")
#define REGSTR_VAL_ASYNCFILECOMMIT __TEXT("AsyncFileCommit")
#define REGSTR_VAL_PATHCACHECOUNT __TEXT("PathCache")
#define REGSTR_VAL_NAMECACHECOUNT __TEXT("NameCache")
#define REGSTR_VAL_CONTIGFILEALLOC __TEXT("ContigFileAllocSize")
#define REGSTR_VAL_FREESPACERATIO __TEXT("FreeSpaceRatio")
#define REGSTR_VAL_VOLIDLETIMEOUT __TEXT("VolumeIdleTimeout")
#define REGSTR_VAL_BUFFIDLETIMEOUT __TEXT("BufferIdleTimeout")
#define REGSTR_VAL_BUFFAGETIMEOUT __TEXT("BufferAgeTimeout")
#define REGSTR_VAL_NAMENUMERICTAIL __TEXT("NameNumericTail")
#define REGSTR_VAL_READAHEADTHRESHOLD __TEXT("ReadAheadThreshold")
#define REGSTR_VAL_DOUBLEBUFFER __TEXT("DoubleBuffer")
#define REGSTR_VAL_SOFTCOMPATMODE __TEXT("SoftCompatMode")
#define REGSTR_VAL_DRIVESPINDOWN __TEXT("DriveSpinDown")
#define REGSTR_VAL_FORCEPMIO __TEXT("ForcePMIO")
#define REGSTR_VAL_FORCERMIO __TEXT("ForceRMIO")
#define REGSTR_VAL_LASTBOOTPMDRVS __TEXT("LastBootPMDrvs")
#define REGSTR_VAL_ACSPINDOWNPREVIOUS __TEXT("ACSpinDownPrevious")
#define REGSTR_VAL_BATSPINDOWNPREVIOUS __TEXT("BatSpinDownPrevious")
#define REGSTR_VAL_VIRTUALHDIRQ __TEXT("VirtualHDIRQ")
#define REGSTR_VAL_SRVNAMECACHECOUNT __TEXT("ServerNameCacheMax")
#define REGSTR_VAL_SRVNAMECACHE __TEXT("ServerNameCache")
#define REGSTR_VAL_SRVNAMECACHENETPROV __TEXT("ServerNameCacheNumNets")
#define REGSTR_VAL_AUTOMOUNT __TEXT("AutoMountDrives")
#define REGSTR_VAL_COMPRESSIONMETHOD __TEXT("CompressionAlgorithm")
#define REGSTR_VAL_COMPRESSIONTHRESHOLD __TEXT("CompressionThreshold")
#define REGSTR_VAL_ACDRIVESPINDOWN __TEXT("ACDriveSpinDown")
#define REGSTR_VAL_BATDRIVESPINDOWN __TEXT("BatDriveSpinDown")
#define REGSTR_VAL_CDCACHESIZE __TEXT("CacheSize")
#define REGSTR_VAL_CDPREFETCH __TEXT("Prefetch")
#define REGSTR_VAL_CDPREFETCHTAIL __TEXT("PrefetchTail")
#define REGSTR_VAL_CDRAWCACHE __TEXT("RawCache")
#define REGSTR_VAL_CDEXTERRORS __TEXT("ExtendedErrors")
#define REGSTR_VAL_CDSVDSENSE __TEXT("SVDSense")
#define REGSTR_VAL_CDSHOWVERSIONS __TEXT("ShowVersions")
#define REGSTR_VAL_CDCOMPATNAMES __TEXT("MSCDEXCompatNames")
#define REGSTR_VAL_CDNOREADAHEAD __TEXT("NoReadAhead")
#define REGSTR_VAL_SCSI __TEXT(!"SCSI\\")
#define REGSTR_VAL_ESDI __TEXT(!"ESDI\\")
#define REGSTR_VAL_FLOP __TEXT(!"FLOP\\")
#define REGSTR_VAL_DISK __TEXT("GenDisk")
#define REGSTR_VAL_CDROM __TEXT("GenCD")
#define REGSTR_VAL_TAPE __TEXT("TAPE")
#define REGSTR_VAL_SCANNER __TEXT("SCANNER")
#define REGSTR_VAL_FLOPPY __TEXT("FLOPPY")
#define REGSTR_VAL_SCSITID __TEXT("SCSITargetID")
#define REGSTR_VAL_SCSILUN __TEXT("SCSILUN")
#define REGSTR_VAL_REVLEVEL __TEXT("RevisionLevel")
#define REGSTR_VAL_PRODUCTID __TEXT("ProductId")
#define REGSTR_VAL_PRODUCTTYPE __TEXT("ProductType")
#define REGSTR_VAL_DEVTYPE __TEXT("DeviceType")
#define REGSTR_VAL_REMOVABLE __TEXT("Removable")
#define REGSTR_VAL_CURDRVLET __TEXT("CurrentDriveLetterAssignment")
#define REGSTR_VAL_USRDRVLET __TEXT("UserDriveLetterAssignment")
#define REGSTR_VAL_SYNCDATAXFER __TEXT("SyncDataXfer")
#define REGSTR_VAL_AUTOINSNOTE __TEXT("AutoInsertNotification")
#define REGSTR_VAL_DISCONNECT __TEXT("Disconnect")
#define REGSTR_VAL_INT13 __TEXT("Int13")
#define REGSTR_VAL_PMODE_INT13 __TEXT("PModeInt13")
#define REGSTR_VAL_USERSETTINGS __TEXT("AdapterSettings")
#define REGSTR_VAL_NOIDE __TEXT("NoIDE")
#define REGSTR_VAL_DISKCLASSNAME __TEXT("DiskDrive")
#define REGSTR_VAL_CDROMCLASSNAME __TEXT("CDROM")
#define REGSTR_VAL_FORCELOAD __TEXT("ForceLoadPD")
#define REGSTR_VAL_FORCEFIFO __TEXT("ForceFIFO")
#define REGSTR_VAL_FORCECL __TEXT("ForceChangeLine")
#define REGSTR_VAL_NOUSECLASS __TEXT("NoUseClass")
#define REGSTR_VAL_NOINSTALLCLASS __TEXT("NoInstallClass")
#define REGSTR_VAL_NODISPLAYCLASS __TEXT("NoDisplayClass")
#define REGSTR_VAL_SILENTINSTALL __TEXT("SilentInstall")
#define REGSTR_KEY_PCMCIA_CLASS __TEXT("PCMCIA")
#define REGSTR_KEY_SCSI_CLASS __TEXT("SCSIAdapter")
#define REGSTR_KEY_PORTS_CLASS __TEXT("ports")
#define REGSTR_KEY_MEDIA_CLASS __TEXT("MEDIA")
#define REGSTR_KEY_DISPLAY_CLASS __TEXT("Display")
#define REGSTR_KEY_KEYBOARD_CLASS __TEXT("Keyboard")
#define REGSTR_KEY_MOUSE_CLASS __TEXT("Mouse")
#define REGSTR_KEY_MONITOR_CLASS __TEXT("Monitor")
#define REGSTR_KEY_MODEM_CLASS __TEXT("Modem")
#define REGSTR_VAL_PCMCIA_OPT __TEXT("Options")
const PCMCIA_OPT_HAVE_SOCKET = &h00000001
const PCMCIA_OPT_AUTOMEM = &h00000004
const PCMCIA_OPT_NO_SOUND = &h00000008
const PCMCIA_OPT_NO_AUDIO = &h00000010
const PCMCIA_OPT_NO_APMREMOVE = &h00000020
#define REGSTR_VAL_PCMCIA_MEM __TEXT("Memory")
const PCMCIA_DEF_MEMBEGIN = &h000c0000
const PCMCIA_DEF_MEMEND = &h00ffffff
const PCMCIA_DEF_MEMLEN = &h00001000
#define REGSTR_VAL_PCMCIA_ALLOC __TEXT("AllocMemWin")
#define REGSTR_VAL_PCMCIA_ATAD __TEXT("ATADelay")
#define REGSTR_VAL_PCMCIA_SIZ __TEXT("MinRegionSize")
const PCMCIA_DEF_MIN_REGION = &h00010000
#define REGSTR_VAL_P1284MDL __TEXT("Model")
#define REGSTR_VAL_P1284MFG __TEXT("Manufacturer")
#define REGSTR_VAL_ISAPNP __TEXT("ISAPNP")
#define REGSTR_VAL_ISAPNP_RDP_OVERRIDE __TEXT("RDPOverRide")
#define REGSTR_VAL_PCI __TEXT("PCI")
#define REGSTR_PCI_OPTIONS __TEXT("Options")
#define REGSTR_PCI_DUAL_IDE __TEXT("PCIDualIDE")
const PCI_OPTIONS_USE_BIOS = &h00000001
const PCI_OPTIONS_USE_IRQ_STEERING = &h00000002
const AGP_FLAG_NO_1X_RATE = &h00000001
const AGP_FLAG_NO_2X_RATE = &h00000002
const AGP_FLAG_NO_4X_RATE = &h00000004
const AGP_FLAG_NO_8X_RATE = &h00000008
const AGP_FLAG_REVERSE_INITIALIZATION = &h00000080
const AGP_FLAG_NO_SBA_ENABLE = &h00000100
const AGP_FLAG_NO_FW_ENABLE = &h00000200
const AGP_FLAG_SPECIAL_TARGET = &h000fffff
const AGP_FLAG_SPECIAL_RESERVE = &h000f8000
#define REGSTR_KEY_CRASHES __TEXT("Crashes")
#define REGSTR_KEY_DANGERS __TEXT("Dangers")
#define REGSTR_KEY_DETMODVARS __TEXT("DetModVars")
#define REGSTR_KEY_NDISINFO __TEXT("NDISInfo")
#define REGSTR_VAL_PROTINIPATH __TEXT("ProtIniPath")
#define REGSTR_VAL_RESOURCES __TEXT("Resources")
#define REGSTR_VAL_CRASHFUNCS __TEXT("CrashFuncs")
#define REGSTR_VAL_CLASS __TEXT("Class")
#define REGSTR_VAL_CLASSDESC __TEXT("ClassDesc")
#define REGSTR_VAL_DEVDESC __TEXT("DeviceDesc")
#define REGSTR_VAL_BOOTCONFIG __TEXT("BootConfig")
#define REGSTR_VAL_DETFUNC __TEXT("DetFunc")
#define REGSTR_VAL_DETFLAGS __TEXT("DetFlags")
#define REGSTR_VAL_COMPATIBLEIDS __TEXT("CompatibleIDs")
#define REGSTR_VAL_DETCONFIG __TEXT("DetConfig")
#define REGSTR_VAL_VERIFYKEY __TEXT("VerifyKey")
#define REGSTR_VAL_COMINFO __TEXT("ComInfo")
#define REGSTR_VAL_INFNAME __TEXT("InfName")
#define REGSTR_VAL_CARDSPECIFIC __TEXT("CardSpecific")
#define REGSTR_VAL_NETOSTYPE __TEXT("NetOSType")
#define REGSTR_DATA_NETOS_NDIS __TEXT("NDIS")
#define REGSTR_DATA_NETOS_ODI __TEXT("ODI")
#define REGSTR_DATA_NETOS_IPX __TEXT("IPX")
#define REGSTR_VAL_MFG __TEXT("Mfg")
#define REGSTR_VAL_SCAN_ONLY_FIRST __TEXT("ScanOnlyFirstDrive")
#define REGSTR_VAL_SHARE_IRQ __TEXT("ForceIRQSharing")
#define REGSTR_VAL_NONSTANDARD_ATAPI __TEXT("NonStandardATAPI")
#define REGSTR_VAL_IDE_FORCE_SERIALIZE __TEXT("ForceSerialization")
const REGSTR_VAL_MAX_HCID_LEN = 1024
#define REGSTR_VAL_HWREV __TEXT("HWRevision")
#define REGSTR_VAL_ENABLEINTS __TEXT("EnableInts")
const REGDF_NOTDETIO = &h00000001
const REGDF_NOTDETMEM = &h00000002
const REGDF_NOTDETIRQ = &h00000004
const REGDF_NOTDETDMA = &h00000008
const REGDF_NOTDETALL = ((REGDF_NOTDETIO or REGDF_NOTDETMEM) or REGDF_NOTDETIRQ) or REGDF_NOTDETDMA
const REGDF_NEEDFULLCONFIG = &h00000010
const REGDF_GENFORCEDCONFIG = &h00000020
const REGDF_NODETCONFIG = &h00008000
const REGDF_CONFLICTIO = &h00010000
const REGDF_CONFLICTMEM = &h00020000
const REGDF_CONFLICTIRQ = &h00040000
const REGDF_CONFLICTDMA = &h00080000
const REGDF_CONFLICTALL = ((REGDF_CONFLICTIO or REGDF_CONFLICTMEM) or REGDF_CONFLICTIRQ) or REGDF_CONFLICTDMA
const REGDF_MAPIRQ2TO9 = &h00100000
const REGDF_NOTVERIFIED = &h80000000
#define REGSTR_VAL_APMBIOSVER __TEXT("APMBiosVer")
#define REGSTR_VAL_APMFLAGS __TEXT("APMFlags")
#define REGSTR_VAL_SLSUPPORT __TEXT("SLSupport")
#define REGSTR_VAL_MACHINETYPE __TEXT("MachineType")
#define REGSTR_VAL_SETUPMACHINETYPE __TEXT("SetupMachineType")
#define REGSTR_MACHTYPE_UNKNOWN __TEXT("Unknown")
#define REGSTR_MACHTYPE_IBMPC __TEXT("IBM PC")
#define REGSTR_MACHTYPE_IBMPCJR __TEXT("IBM PCjr")
#define REGSTR_MACHTYPE_IBMPCCONV __TEXT("IBM PC Convertible")
#define REGSTR_MACHTYPE_IBMPCXT __TEXT("IBM PC/XT")
#define REGSTR_MACHTYPE_IBMPCXT_286 __TEXT("IBM PC/XT 286")
#define REGSTR_MACHTYPE_IBMPCAT __TEXT("IBM PC/AT")
#define REGSTR_MACHTYPE_IBMPS2_25 __TEXT("IBM PS/2-25")
#define REGSTR_MACHTYPE_IBMPS2_30_286 __TEXT("IBM PS/2-30 286")
#define REGSTR_MACHTYPE_IBMPS2_30 __TEXT("IBM PS/2-30")
#define REGSTR_MACHTYPE_IBMPS2_50 __TEXT("IBM PS/2-50")
#define REGSTR_MACHTYPE_IBMPS2_50Z __TEXT("IBM PS/2-50Z")
#define REGSTR_MACHTYPE_IBMPS2_55SX __TEXT("IBM PS/2-55SX")
#define REGSTR_MACHTYPE_IBMPS2_60 __TEXT("IBM PS/2-60")
#define REGSTR_MACHTYPE_IBMPS2_65SX __TEXT("IBM PS/2-65SX")
#define REGSTR_MACHTYPE_IBMPS2_70 __TEXT("IBM PS/2-70")
#define REGSTR_MACHTYPE_IBMPS2_P70 __TEXT("IBM PS/2-P70")
#define REGSTR_MACHTYPE_IBMPS2_70_80 __TEXT("IBM PS/2-70/80")
#define REGSTR_MACHTYPE_IBMPS2_80 __TEXT("IBM PS/2-80")
#define REGSTR_MACHTYPE_IBMPS2_90 __TEXT("IBM PS/2-90")
#define REGSTR_MACHTYPE_IBMPS1 __TEXT("IBM PS/1")
#define REGSTR_MACHTYPE_PHOENIX_PCAT __TEXT("Phoenix PC/AT Compatible")
#define REGSTR_MACHTYPE_HP_VECTRA __TEXT("HP Vectra")
#define REGSTR_MACHTYPE_ATT_PC __TEXT("AT&T PC")
#define REGSTR_MACHTYPE_ZENITH_PC __TEXT("Zenith PC")
#define REGSTR_VAL_APMMENUSUSPEND __TEXT("APMMenuSuspend")
const APMMENUSUSPEND_DISABLED = 0
const APMMENUSUSPEND_ENABLED = 1
const APMMENUSUSPEND_UNDOCKED = 2
const APMMENUSUSPEND_NOCHANGE = &h80
#define REGSTR_VAL_APMACTIMEOUT __TEXT("APMACTimeout")
#define REGSTR_VAL_APMBATTIMEOUT __TEXT("APMBatTimeout")
const APMTIMEOUT_DISABLED = 0
#define REGSTR_VAL_APMSHUTDOWNPOWER __TEXT("APMShutDownPower")
#define REGSTR_VAL_BUSTYPE __TEXT("BusType")
#define REGSTR_VAL_CPU __TEXT("CPU")
#define REGSTR_VAL_NDP __TEXT("NDP")
#define REGSTR_VAL_PNPBIOSVER __TEXT("PnPBIOSVer")
#define REGSTR_VAL_PNPSTRUCOFFSET __TEXT("PnPStrucOffset")
#define REGSTR_VAL_PCIBIOSVER __TEXT("PCIBIOSVer")
#define REGSTR_VAL_HWMECHANISM __TEXT("HWMechanism")
#define REGSTR_VAL_LASTPCIBUSNUM __TEXT("LastPCIBusNum")
#define REGSTR_VAL_CONVMEM __TEXT("ConvMem")
#define REGSTR_VAL_EXTMEM __TEXT("ExtMem")
#define REGSTR_VAL_COMPUTERNAME __TEXT("ComputerName")
#define REGSTR_VAL_BIOSNAME __TEXT("BIOSName")
#define REGSTR_VAL_BIOSVERSION __TEXT("BIOSVersion")
#define REGSTR_VAL_BIOSDATE __TEXT("BIOSDate")
#define REGSTR_VAL_MODEL __TEXT("Model")
#define REGSTR_VAL_SUBMODEL __TEXT("Submodel")
#define REGSTR_VAL_REVISION __TEXT("Revision")
#define REGSTR_VAL_FIFODEPTH __TEXT("FIFODepth")
#define REGSTR_VAL_RDINTTHRESHOLD __TEXT("RDIntThreshold")
#define REGSTR_VAL_WRINTTHRESHOLD __TEXT("WRIntThreshold")
#define REGSTR_VAL_PRIORITY __TEXT("Priority")
#define REGSTR_VAL_DRIVER __TEXT("Driver")
#define REGSTR_VAL_FUNCDESC __TEXT("FunctionDesc")
#define REGSTR_VAL_FORCEDCONFIG __TEXT("ForcedConfig")
#define REGSTR_VAL_CONFIGFLAGS __TEXT("ConfigFlags")
#define REGSTR_VAL_CSCONFIGFLAGS __TEXT("CSConfigFlags")
const CONFIGFLAG_DISABLED = &h00000001
const CONFIGFLAG_REMOVED = &h00000002
const CONFIGFLAG_MANUAL_INSTALL = &h00000004
const CONFIGFLAG_IGNORE_BOOT_LC = &h00000008
const CONFIGFLAG_NET_BOOT = &h00000010
const CONFIGFLAG_REINSTALL = &h00000020
const CONFIGFLAG_FAILEDINSTALL = &h00000040
const CONFIGFLAG_CANTSTOPACHILD = &h00000080
const CONFIGFLAG_OKREMOVEROM = &h00000100
const CONFIGFLAG_NOREMOVEEXIT = &h00000200
const CONFIGFLAG_FINISH_INSTALL = &h00000400
const CONFIGFLAG_NEEDS_FORCED_CONFIG = &h00000800
const CONFIGFLAG_PARTIAL_LOG_CONF = &h00002000
const CONFIGFLAG_SUPPRESS_SURPRISE = &h00004000
const CONFIGFLAG_VERIFY_HARDWARE = &h00008000
const CONFIGFLAG_FINISHINSTALL_UI = &h00010000
const CONFIGFLAG_FINISHINSTALL_ACTION = &h00020000
const CONFIGFLAG_BOOT_DEVICE = &h00040000
const CSCONFIGFLAG_BITS = &h00000007
const CSCONFIGFLAG_DISABLED = &h00000001
const CSCONFIGFLAG_DO_NOT_CREATE = &h00000002
const CSCONFIGFLAG_DO_NOT_START = &h00000004
const DMSTATEFLAG_APPLYTOALL = &h00000001
#define REGSTR_VAL_ROOT_DEVNODE __TEXT(!"HTREE\\ROOT\\0")
#define REGSTR_VAL_RESERVED_DEVNODE __TEXT(!"HTREE\\RESERVED\\0")
#define REGSTR_PATH_READDATAPORT (REGSTR_KEY_ISAENUM + __TEXT(!"\\ReadDataPort\\0"))
#define REGSTR_PATH_MULTI_FUNCTION __TEXT("MF")
#define REGSTR_VAL_RESOURCE_MAP __TEXT("ResourceMap")
#define REGSTR_PATH_CHILD_PREFIX __TEXT("Child")
const NUM_RESOURCE_MAP = 256
#define REGSTR_VAL_MF_FLAGS __TEXT("MFFlags")
const MF_FLAGS_EVEN_IF_NO_RESOURCE = &h00000001
const MF_FLAGS_NO_CREATE_IF_NO_RESOURCE = &h00000002
const MF_FLAGS_FILL_IN_UNKNOWN_RESOURCE = &h00000004
const MF_FLAGS_CREATE_BUT_NO_SHOW_DISABLED = &h00000008
#define REGSTR_VAL_EISA_RANGES __TEXT("EISARanges")
#define REGSTR_VAL_EISA_FUNCTIONS __TEXT("EISAFunctions")
#define REGSTR_VAL_EISA_FUNCTIONS_MASK __TEXT("EISAFunctionsMask")
#define REGSTR_VAL_EISA_FLAGS __TEXT("EISAFlags")
#define REGSTR_VAL_EISA_SIMULATE_INT15 __TEXT("EISASimulateInt15")
const EISAFLAG_NO_IO_MERGE = &h00000001
const EISAFLAG_SLOT_IO_FIRST = &h00000002
const EISA_NO_MAX_FUNCTION = &hff
const NUM_EISA_RANGES = 4
#define REGSTR_VAL_DRVDESC __TEXT("DriverDesc")
#define REGSTR_VAL_DEVLOADER __TEXT("DevLoader")
#define REGSTR_VAL_STATICVXD __TEXT("StaticVxD")
#define REGSTR_VAL_PROPERTIES __TEXT("Properties")
#define REGSTR_VAL_MANUFACTURER __TEXT("Manufacturer")
#define REGSTR_VAL_EXISTS __TEXT("Exists")
#define REGSTR_VAL_CMENUMFLAGS __TEXT("CMEnumFlags")
#define REGSTR_VAL_CMDRIVFLAGS __TEXT("CMDrivFlags")
#define REGSTR_VAL_ENUMERATOR __TEXT("Enumerator")
#define REGSTR_VAL_DEVICEDRIVER __TEXT("DeviceDriver")
#define REGSTR_VAL_PORTNAME __TEXT("PortName")
#define REGSTR_VAL_INFPATH __TEXT("InfPath")
#define REGSTR_VAL_INFSECTION __TEXT("InfSection")
#define REGSTR_VAL_INFSECTIONEXT __TEXT("InfSectionExt")
#define REGSTR_VAL_POLLING __TEXT("Polling")
#define REGSTR_VAL_DONTLOADIFCONFLICT __TEXT("DontLoadIfConflict")
#define REGSTR_VAL_PORTSUBCLASS __TEXT("PortSubClass")
#define REGSTR_VAL_NETCLEAN __TEXT("NetClean")
#define REGSTR_VAL_IDE_NO_SERIALIZE __TEXT("IDENoSerialize")
#define REGSTR_VAL_NOCMOSORFDPT __TEXT("NoCMOSorFDPT")
#define REGSTR_VAL_COMVERIFYBASE __TEXT("COMVerifyBase")
#define REGSTR_VAL_MATCHINGDEVID __TEXT("MatchingDeviceId")
#define REGSTR_VAL_DRIVERDATE __TEXT("DriverDate")
#define REGSTR_VAL_DRIVERDATEDATA __TEXT("DriverDateData")
#define REGSTR_VAL_DRIVERVERSION __TEXT("DriverVersion")
#define REGSTR_VAL_LOCATION_INFORMATION_OVERRIDE __TEXT("LocationInformationOverride")
#define REGSTR_KEY_OVERRIDE __TEXT("Override")
#define REGSTR_VAL_CONFIGMG __TEXT("CONFIGMG")
#define REGSTR_VAL_SYSDM __TEXT("SysDM")
#define REGSTR_VAL_SYSDMFUNC __TEXT("SysDMFunc")
#define REGSTR_VAL_PRIVATE __TEXT("Private")
#define REGSTR_VAL_PRIVATEFUNC __TEXT("PrivateFunc")
#define REGSTR_VAL_DETECT __TEXT("Detect")
#define REGSTR_VAL_DETECTFUNC __TEXT("DetectFunc")
#define REGSTR_VAL_ASKFORCONFIG __TEXT("AskForConfig")
#define REGSTR_VAL_ASKFORCONFIGFUNC __TEXT("AskForConfigFunc")
#define REGSTR_VAL_WAITFORUNDOCK __TEXT("WaitForUndock")
#define REGSTR_VAL_WAITFORUNDOCKFUNC __TEXT("WaitForUndockFunc")
#define REGSTR_VAL_REMOVEROMOKAY __TEXT("RemoveRomOkay")
#define REGSTR_VAL_REMOVEROMOKAYFUNC __TEXT("RemoveRomOkayFunc")
#define REGSTR_VAL_CURCONFIG __TEXT("CurrentConfig")
#define REGSTR_VAL_FRIENDLYNAME __TEXT("FriendlyName")
#define REGSTR_VAL_CURRENTCONFIG __TEXT("CurrentConfig")
#define REGSTR_VAL_MAP __TEXT("Map")
#define REGSTR_VAL_ID __TEXT("CurrentID")
#define REGSTR_VAL_DOCKED __TEXT("CurrentDockedState")
#define REGSTR_VAL_CHECKSUM __TEXT("CurrentChecksum")
#define REGSTR_VAL_HWDETECT __TEXT("HardwareDetect")
#define REGSTR_VAL_INHIBITRESULTS __TEXT("InhibitResults")
#define REGSTR_VAL_PROFILEFLAGS __TEXT("ProfileFlags")
#define REGSTR_KEY_PCMCIA __TEXT(!"PCMCIA\\")
#define REGSTR_KEY_PCUNKNOWN __TEXT("UNKNOWN_MANUFACTURER")
#define REGSTR_VAL_PCSSDRIVER __TEXT("Driver")
#define REGSTR_KEY_PCMTD __TEXT("MTD-")
#define REGSTR_VAL_PCMTDRIVER __TEXT("MTD")
#define REGSTR_VAL_HARDWAREID __TEXT("HardwareID")
#define REGSTR_VAL_INSTALLER __TEXT("Installer")
#define REGSTR_VAL_INSTALLER_32 __TEXT("Installer32")
#define REGSTR_VAL_INSICON __TEXT("Icon")
#define REGSTR_VAL_ENUMPROPPAGES __TEXT("EnumPropPages")
#define REGSTR_VAL_ENUMPROPPAGES_32 __TEXT("EnumPropPages32")
#define REGSTR_VAL_BASICPROPERTIES __TEXT("BasicProperties")
#define REGSTR_VAL_BASICPROPERTIES_32 __TEXT("BasicProperties32")
#define REGSTR_VAL_COINSTALLERS_32 __TEXT("CoInstallers32")
#define REGSTR_VAL_PRIVATEPROBLEM __TEXT("PrivateProblem")
#define REGSTR_KEY_CURRENT __TEXT("Current")
#define REGSTR_KEY_DEFAULT __TEXT("Default")
#define REGSTR_KEY_MODES __TEXT("Modes")
#define REGSTR_VAL_MODE __TEXT("Mode")
#define REGSTR_VAL_BPP __TEXT("BPP")
#define REGSTR_VAL_HRES __TEXT("HRes")
#define REGSTR_VAL_VRES __TEXT("VRes")
#define REGSTR_VAL_FONTSIZE __TEXT("FontSize")
#define REGSTR_VAL_DRV __TEXT("drv")
#define REGSTR_VAL_GRB __TEXT("grb")
#define REGSTR_VAL_VDD __TEXT("vdd")
#define REGSTR_VAL_VER __TEXT("Ver")
#define REGSTR_VAL_MAXRES __TEXT("MaxResolution")
#define REGSTR_VAL_DPMS __TEXT("DPMS")
#define REGSTR_VAL_RESUMERESET __TEXT("ResumeReset")
#define REGSTR_VAL_DESCRIPTION __TEXT("Description")
#define REGSTR_KEY_SYSTEM __TEXT("System")
#define REGSTR_KEY_USER __TEXT("User")
#define REGSTR_VAL_DPI __TEXT("dpi")
#define REGSTR_VAL_PCICOPTIONS __TEXT("PCICOptions")
const PCIC_DEFAULT_IRQMASK = &h4eb8
const PCIC_DEFAULT_NUMSOCKETS = 0
#define REGSTR_VAL_PCICIRQMAP __TEXT("PCICIRQMap")
#define REGSTR_PATH_APPEARANCE __TEXT(!"Control Panel\\Appearance")
#define REGSTR_PATH_LOOKSCHEMES __TEXT(!"Control Panel\\Appearance\\Schemes")
#define REGSTR_VAL_CUSTOMCOLORS __TEXT("CustomColors")
#define REGSTR_PATH_SCREENSAVE __TEXT(!"Control Panel\\Desktop")
#define REGSTR_VALUE_USESCRPASSWORD __TEXT("ScreenSaveUsePassword")
#define REGSTR_VALUE_SCRPASSWORD __TEXT("ScreenSave_Data")
#define REGSTR_VALUE_LOWPOWERTIMEOUT __TEXT("ScreenSaveLowPowerTimeout")
#define REGSTR_VALUE_POWEROFFTIMEOUT __TEXT("ScreenSavePowerOffTimeout")
#define REGSTR_VALUE_LOWPOWERACTIVE __TEXT("ScreenSaveLowPowerActive")
#define REGSTR_VALUE_POWEROFFACTIVE __TEXT("ScreenSavePowerOffActive")
#define REGSTR_PATH_WINDOWSAPPLETS __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Applets")
#define REGSTR_PATH_SYSTRAY __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Applets\\SysTray")
#define REGSTR_VAL_SYSTRAYSVCS __TEXT("Services")
#define REGSTR_VAL_SYSTRAYBATFLAGS __TEXT("PowerFlags")
#define REGSTR_VAL_SYSTRAYPCCARDFLAGS __TEXT("PCMCIAFlags")
#define REGSTR_PATH_NETWORK_USERSETTINGS __TEXT("Network")
#define REGSTR_KEY_NETWORK_PERSISTENT __TEXT(!"\\Persistent")
#define REGSTR_KEY_NETWORK_RECENT __TEXT(!"\\Recent")
#define REGSTR_VAL_REMOTE_PATH __TEXT("RemotePath")
#define REGSTR_VAL_USER_NAME __TEXT("UserName")
#define REGSTR_VAL_PROVIDER_NAME __TEXT("ProviderName")
#define REGSTR_VAL_CONNECTION_TYPE __TEXT("ConnectionType")
#define REGSTR_VAL_UPGRADE __TEXT("Upgrade")
#define REGSTR_KEY_LOGON __TEXT(!"\\Logon")
#define REGSTR_VAL_MUSTBEVALIDATED __TEXT("MustBeValidated")
#define REGSTR_VAL_RUNLOGINSCRIPT __TEXT("ProcessLoginScript")
#define REGSTR_KEY_NETWORKPROVIDER __TEXT(!"\\NetworkProvider")
#define REGSTR_PATH_NW32NETPROVIDER (REGSTR_PATH_SERVICES + __TEXT(!"\\NWNP32") + REGSTR_KEY_NETWORKPROVIDER)
#define REGSTR_PATH_MS32NETPROVIDER (REGSTR_PATH_SERVICES + __TEXT(!"\\MSNP32") + REGSTR_KEY_NETWORKPROVIDER)
#define REGSTR_VAL_AUTHENT_AGENT __TEXT("AuthenticatingAgent")
#define REGSTR_VAL_PREFREDIR __TEXT("PreferredRedir")
#define REGSTR_VAL_AUTOSTART __TEXT("AutoStart")
#define REGSTR_VAL_AUTOLOGON __TEXT("AutoLogon")
#define REGSTR_VAL_NETCARD __TEXT("Netcard")
#define REGSTR_VAL_TRANSPORT __TEXT("Transport")
#define REGSTR_VAL_DYNAMIC __TEXT("Dynamic")
#define REGSTR_VAL_TRANSITION __TEXT("Transition")
#define REGSTR_VAL_STATICDRIVE __TEXT("StaticDrive")
#define REGSTR_VAL_LOADHI __TEXT("LoadHi")
#define REGSTR_VAL_LOADRMDRIVERS __TEXT("LoadRMDrivers")
#define REGSTR_VAL_SETUPN __TEXT("SetupN")
#define REGSTR_VAL_SETUPNPATH __TEXT("SetupNPath")
#define REGSTR_VAL_WRKGRP_FORCEMAPPING __TEXT("WrkgrpForceMapping")
#define REGSTR_VAL_WRKGRP_REQUIRED __TEXT("WrkgrpRequired")
#define REGSTR_PATH_CURRENT_CONTROL_SET __TEXT(!"System\\CurrentControlSet\\Control")
#define REGSTR_VAL_CURRENT_USER __TEXT("Current User")
#define REGSTR_PATH_PWDPROVIDER __TEXT(!"System\\CurrentControlSet\\Control\\PwdProvider")
#define REGSTR_VAL_PWDPROVIDER_PATH __TEXT("ProviderPath")
#define REGSTR_VAL_PWDPROVIDER_DESC __TEXT("Description")
#define REGSTR_VAL_PWDPROVIDER_CHANGEPWD __TEXT("ChangePassword")
#define REGSTR_VAL_PWDPROVIDER_CHANGEPWDHWND __TEXT("ChangePasswordHwnd")
#define REGSTR_VAL_PWDPROVIDER_GETPWDSTATUS __TEXT("GetPasswordStatus")
#define REGSTR_VAL_PWDPROVIDER_ISNP __TEXT("NetworkProvider")
#define REGSTR_VAL_PWDPROVIDER_CHANGEORDER __TEXT("ChangeOrder")
#define REGSTR_PATH_POLICIES __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Policies")
#define REGSTR_PATH_UPDATE __TEXT(!"System\\CurrentControlSet\\Control\\Update")
#define REGSTR_VALUE_ENABLE __TEXT("Enable")
#define REGSTR_VALUE_VERBOSE __TEXT("Verbose")
#define REGSTR_VALUE_NETPATH __TEXT("NetworkPath")
#define REGSTR_VALUE_DEFAULTLOC __TEXT("UseDefaultNetLocation")
#define REGSTR_KEY_NETWORK __TEXT("Network")
#define REGSTR_KEY_SYSTEM __TEXT("System")
#define REGSTR_KEY_PRINTERS __TEXT("Printers")
#define REGSTR_KEY_WINOLDAPP __TEXT("WinOldApp")
#define REGSTR_KEY_EXPLORER __TEXT("Explorer")
#define REGSTR_PATH_RUN_POLICY (REGSTR_PATH_POLICIES + __TEXT(!"\\Explorer\\Run"))
#define REGSTR_VAL_NOFILESHARING __TEXT("NoFileSharing")
#define REGSTR_VAL_NOPRINTSHARING __TEXT("NoPrintSharing")
#define REGSTR_VAL_NOFILESHARINGCTRL __TEXT("NoFileSharingControl")
#define REGSTR_VAL_NOPRINTSHARINGCTRL __TEXT("NoPrintSharingControl")
#define REGSTR_VAL_HIDESHAREPWDS __TEXT("HideSharePwds")
#define REGSTR_VAL_DISABLEPWDCACHING __TEXT("DisablePwdCaching")
#define REGSTR_VAL_ALPHANUMPWDS __TEXT("AlphanumPwds")
#define REGSTR_VAL_NETSETUP_DISABLE __TEXT("NoNetSetup")
#define REGSTR_VAL_NETSETUP_NOCONFIGPAGE __TEXT("NoNetSetupConfigPage")
#define REGSTR_VAL_NETSETUP_NOIDPAGE __TEXT("NoNetSetupIDPage")
#define REGSTR_VAL_NETSETUP_NOSECURITYPAGE __TEXT("NoNetSetupSecurityPage")
#define REGSTR_VAL_SYSTEMCPL_NOVIRTMEMPAGE __TEXT("NoVirtMemPage")
#define REGSTR_VAL_SYSTEMCPL_NODEVMGRPAGE __TEXT("NoDevMgrPage")
#define REGSTR_VAL_SYSTEMCPL_NOCONFIGPAGE __TEXT("NoConfigPage")
#define REGSTR_VAL_SYSTEMCPL_NOFILESYSPAGE __TEXT("NoFileSysPage")
#define REGSTR_VAL_DISPCPL_NODISPCPL __TEXT("NoDispCPL")
#define REGSTR_VAL_DISPCPL_NOBACKGROUNDPAGE __TEXT("NoDispBackgroundPage")
#define REGSTR_VAL_DISPCPL_NOSCRSAVPAGE __TEXT("NoDispScrSavPage")
#define REGSTR_VAL_DISPCPL_NOAPPEARANCEPAGE __TEXT("NoDispAppearancePage")
#define REGSTR_VAL_DISPCPL_NOSETTINGSPAGE __TEXT("NoDispSettingsPage")
#define REGSTR_VAL_SECCPL_NOSECCPL __TEXT("NoSecCPL")
#define REGSTR_VAL_SECCPL_NOPWDPAGE __TEXT("NoPwdPage")
#define REGSTR_VAL_SECCPL_NOADMINPAGE __TEXT("NoAdminPage")
#define REGSTR_VAL_SECCPL_NOPROFILEPAGE __TEXT("NoProfilePage")
#define REGSTR_VAL_PRINTERS_HIDETABS __TEXT("NoPrinterTabs")
#define REGSTR_VAL_PRINTERS_NODELETE __TEXT("NoDeletePrinter")
#define REGSTR_VAL_PRINTERS_NOADD __TEXT("NoAddPrinter")
#define REGSTR_VAL_WINOLDAPP_DISABLED __TEXT("Disabled")
#define REGSTR_VAL_WINOLDAPP_NOREALMODE __TEXT("NoRealMode")
#define REGSTR_VAL_NOENTIRENETWORK __TEXT("NoEntireNetwork")
#define REGSTR_VAL_NOWORKGROUPCONTENTS __TEXT("NoWorkgroupContents")
#define REGSTR_VAL_UNDOCK_WITHOUT_LOGON __TEXT("UndockWithoutLogon")
#define REGSTR_VAL_MINPWDLEN __TEXT("MinPwdLen")
#define REGSTR_VAL_PWDEXPIRATION __TEXT("PwdExpiration")
#define REGSTR_VAL_WIN31PROVIDER __TEXT("Win31Provider")
#define REGSTR_VAL_DISABLEREGTOOLS __TEXT("DisableRegistryTools")
#define REGSTR_PATH_WINLOGON __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Winlogon")
#define REGSTR_VAL_LEGALNOTICECAPTION __TEXT("LegalNoticeCaption")
#define REGSTR_VAL_LEGALNOTICETEXT __TEXT("LegalNoticeText")
#define REGSTR_VAL_DRIVE_SPINDOWN __TEXT("NoDispSpinDown")
#define REGSTR_VAL_SHUTDOWN_FLAGS __TEXT("ShutdownFlags")
#define REGSTR_VAL_RESTRICTRUN __TEXT("RestrictRun")
#define REGSTR_KEY_POL_USERS __TEXT("Users")
#define REGSTR_KEY_POL_COMPUTERS __TEXT("Computers")
#define REGSTR_KEY_POL_USERGROUPS __TEXT("UserGroups")
#define REGSTR_KEY_POL_DEFAULT __TEXT(".default")
#define REGSTR_KEY_POL_USERGROUPDATA __TEXT(!"GroupData\\UserGroups\\Priority")
#define REGSTR_PATH_TIMEZONE __TEXT(!"System\\CurrentControlSet\\Control\\TimeZoneInformation")
#define REGSTR_VAL_TZBIAS __TEXT("Bias")
#define REGSTR_VAL_TZDLTBIAS __TEXT("DaylightBias")
#define REGSTR_VAL_TZSTDBIAS __TEXT("StandardBias")
#define REGSTR_VAL_TZACTBIAS __TEXT("ActiveTimeBias")
#define REGSTR_VAL_TZDLTFLAG __TEXT("DaylightFlag")
#define REGSTR_VAL_TZSTDSTART __TEXT("StandardStart")
#define REGSTR_VAL_TZDLTSTART __TEXT("DaylightStart")
#define REGSTR_VAL_TZDLTNAME __TEXT("DaylightName")
#define REGSTR_VAL_TZSTDNAME __TEXT("StandardName")
#define REGSTR_VAL_TZNOCHANGESTART __TEXT("NoChangeStart")
#define REGSTR_VAL_TZNOCHANGEEND __TEXT("NoChangeEnd")
#define REGSTR_VAL_TZNOAUTOTIME __TEXT("DisableAutoDaylightTimeSet")
#define REGSTR_PATH_FLOATINGPOINTPROCESSOR __TEXT(!"HARDWARE\\DESCRIPTION\\System\\FloatingPointProcessor")
#define REGSTR_PATH_FLOATINGPOINTPROCESSOR0 __TEXT(!"HARDWARE\\DESCRIPTION\\System\\FloatingPointProcessor\\0")
#define REGSTR_PATH_COMPUTRNAME __TEXT(!"System\\CurrentControlSet\\Control\\ComputerName\\ComputerName")
#define REGSTR_VAL_COMPUTRNAME __TEXT("ComputerName")
#define REGSTR_PATH_SHUTDOWN __TEXT(!"System\\CurrentControlSet\\Control\\Shutdown")
#define REGSTR_VAL_FORCEREBOOT __TEXT("ForceReboot")
#define REGSTR_VAL_SETUPPROGRAMRAN __TEXT("SetupProgramRan")
#define REGSTR_VAL_DOES_POLLING __TEXT("PollingSupportNeeded")
#define REGSTR_PATH_KNOWNDLLS __TEXT(!"System\\CurrentControlSet\\Control\\SessionManager\\KnownDLLs")
#define REGSTR_PATH_KNOWN16DLLS __TEXT(!"System\\CurrentControlSet\\Control\\SessionManager\\Known16DLLs")
#define REGSTR_PATH_CHECKVERDLLS __TEXT(!"System\\CurrentControlSet\\Control\\SessionManager\\CheckVerDLLs")
#define REGSTR_PATH_WARNVERDLLS __TEXT(!"System\\CurrentControlSet\\Control\\SessionManager\\WarnVerDLLs")
#define REGSTR_PATH_HACKINIFILE __TEXT(!"System\\CurrentControlSet\\Control\\SessionManager\\HackIniFiles")
#define REGSTR_PATH_CHECKBADAPPS __TEXT(!"System\\CurrentControlSet\\Control\\SessionManager\\CheckBadApps")
#define REGSTR_PATH_APPPATCH __TEXT(!"System\\CurrentControlSet\\Control\\SessionManager\\AppPatches")
#define REGSTR_PATH_CHECKBADAPPS400 __TEXT(!"System\\CurrentControlSet\\Control\\SessionManager\\CheckBadApps400")
#define REGSTR_PATH_SHELLSERVICEOBJECT __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\ShellServiceObject")
#define REGSTR_PATH_SHELLSERVICEOBJECTDELAYED __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\ShellServiceObjectDelayLoad")
#define REGSTR_PATH_KNOWNVXDS __TEXT(!"System\\CurrentControlSet\\Control\\SessionManager\\KnownVxDs")
#define REGSTR_VAL_UNINSTALLER_DISPLAYNAME __TEXT("DisplayName")
#define REGSTR_VAL_UNINSTALLER_COMMANDLINE __TEXT("UninstallString")
#define REGSTR_VAL_REINSTALL_DISPLAYNAME __TEXT("DisplayName")
#define REGSTR_VAL_REINSTALL_STRING __TEXT("ReinstallString")
#define REGSTR_VAL_REINSTALL_DEVICEINSTANCEIDS __TEXT("DeviceInstanceIds")
#define REGSTR_PATH_DESKTOP REGSTR_PATH_SCREENSAVE
#define REGSTR_PATH_MOUSE __TEXT(!"Control Panel\\Mouse")
#define REGSTR_PATH_KEYBOARD __TEXT(!"Control Panel\\Keyboard")
#define REGSTR_PATH_COLORS __TEXT(!"Control Panel\\Colors")
#define REGSTR_PATH_SOUND __TEXT(!"Control Panel\\Sound")
#define REGSTR_PATH_METRICS __TEXT(!"Control Panel\\Desktop\\WindowMetrics")
#define REGSTR_PATH_ICONS __TEXT(!"Control Panel\\Icons")
#define REGSTR_PATH_CURSORS __TEXT(!"Control Panel\\Cursors")
#define REGSTR_PATH_CHECKDISK __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Applets\\Check Drive")
#define REGSTR_PATH_CHECKDISKSET __TEXT("Settings")
#define REGSTR_PATH_CHECKDISKUDRVS __TEXT("NoUnknownDDErrDrvs")
#define REGSTR_PATH_FAULT __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Fault")
#define REGSTR_VAL_FAULT_LOGFILE __TEXT("LogFile")
#define REGSTR_PATH_AEDEBUG __TEXT(!"Software\\Microsoft\\Windows NT\\CurrentVersion\\AeDebug")
#define REGSTR_VAL_AEDEBUG_DEBUGGER __TEXT("Debugger")
#define REGSTR_VAL_AEDEBUG_AUTO __TEXT("Auto")
#define REGSTR_PATH_GRPCONV __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\GrpConv")
#define REGSTR_VAL_REGITEMDELETEMESSAGE __TEXT("Removal Message")
#define REGSTR_PATH_LASTCHECK __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\LastCheck")
#define REGSTR_PATH_LASTOPTIMIZE __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\LastOptimize")
#define REGSTR_PATH_LASTBACKUP __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\LastBackup")
#define REGSTR_PATH_CHKLASTCHECK __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Applets\\Check Drive\\LastCheck")
#define REGSTR_PATH_CHKLASTSURFAN __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Applets\\Check Drive\\LastSurfaceAnalysis")

type _DSKTLSYSTEMTIME
	wYear as WORD
	wMonth as WORD
	wDayOfWeek as WORD
	wDay as WORD
	wHour as WORD
	wMinute as WORD
	wSecond as WORD
	wMilliseconds as WORD
	wResult as WORD
end type

type DSKTLSYSTEMTIME as _DSKTLSYSTEMTIME
type PDSKTLSYSTEMTIME as _DSKTLSYSTEMTIME ptr
type LPDSKTLSYSTEMTIME as _DSKTLSYSTEMTIME ptr

const DTRESULTOK = 0
const DTRESULTFIX = 1
const DTRESULTPROB = 2
const DTRESULTPART = 3
#define REGSTR_KEY_SHARES __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Network\\LanMan")
#define REGSTR_VAL_SHARES_FLAGS __TEXT("Flags")
#define REGSTR_VAL_SHARES_TYPE __TEXT("Type")
#define REGSTR_VAL_SHARES_PATH __TEXT("Path")
#define REGSTR_VAL_SHARES_REMARK __TEXT("Remark")
#define REGSTR_VAL_SHARES_RW_PASS __TEXT("Parm1")
#define REGSTR_VAL_SHARES_RO_PASS __TEXT("Parm2")
#define REGSTR_PATH_PRINT __TEXT(!"System\\CurrentControlSet\\Control\\Print")
#define REGSTR_PATH_PRINTERS __TEXT(!"System\\CurrentControlSet\\Control\\Print\\Printers")
#define REGSTR_PATH_PROVIDERS __TEXT(!"System\\CurrentControlSet\\Control\\Print\\Providers")
#define REGSTR_PATH_MONITORS __TEXT(!"System\\CurrentControlSet\\Control\\Print\\Monitors")
#define REGSTR_PATH_ENVIRONMENTS __TEXT(!"System\\CurrentControlSet\\Control\\Print\\Environments")
#define REGSTR_VAL_START_ON_BOOT __TEXT("StartOnBoot")
#define REGSTR_VAL_PRINTERS_MASK __TEXT("PrintersMask")
#define REGSTR_VAL_DOS_SPOOL_MASK __TEXT("DOSSpoolMask")
#define REGSTR_KEY_CURRENT_ENV __TEXT(!"\\Windows 4.0")
#define REGSTR_KEY_DRIVERS __TEXT(!"\\Drivers")
#define REGSTR_KEY_PRINT_PROC __TEXT(!"\\Print Processors")
#define REGSTR_PATH_EVENTLABELS __TEXT(!"AppEvents\\EventLabels")
#define REGSTR_PATH_SCHEMES __TEXT(!"AppEvents\\Schemes")
#define REGSTR_PATH_APPS (REGSTR_PATH_SCHEMES + __TEXT(!"\\Apps"))
#define REGSTR_PATH_APPS_DEFAULT (REGSTR_PATH_SCHEMES + __TEXT(!"\\Apps\\.Default"))
#define REGSTR_PATH_NAMES (REGSTR_PATH_SCHEMES + __TEXT(!"\\Names"))
#define REGSTR_PATH_MULTIMEDIA (REGSTR_PATH_SETUP + __TEXT(!"\\Multimedia"))
#define REGSTR_PATH_MULTIMEDIA_AUDIO __TEXT(!"Software\\Microsoft\\Multimedia\\Audio")
#define REGSTR_PATH_MULTIMEDIA_AUDIO_IMAGES (REGSTR_PATH_MULTIMEDIA_AUDIO + __TEXT(!"\\Images"))
#define REGSTR_PATH_MEDIARESOURCES (REGSTR_PATH_CURRENT_CONTROL_SET + __TEXT(!"\\MediaResources"))
#define REGSTR_PATH_MEDIAPROPERTIES (REGSTR_PATH_CURRENT_CONTROL_SET + __TEXT(!"\\MediaProperties"))
#define REGSTR_PATH_PRIVATEPROPERTIES (REGSTR_PATH_MEDIAPROPERTIES + __TEXT(!"\\PrivateProperties"))
#define REGSTR_PATH_PUBLICPROPERTIES (REGSTR_PATH_MEDIAPROPERTIES + __TEXT(!"\\PublicProperties"))
#define REGSTR_PATH_JOYOEM (REGSTR_PATH_PRIVATEPROPERTIES + __TEXT(!"\\Joystick\\OEM"))
#define REGSTR_PATH_JOYCONFIG (REGSTR_PATH_MEDIARESOURCES + __TEXT(!"\\Joystick"))
#define REGSTR_KEY_JOYCURR __TEXT("CurrentJoystickSettings")
#define REGSTR_KEY_JOYSETTINGS __TEXT("JoystickSettings")
#define REGSTR_VAL_JOYUSERVALUES __TEXT("JoystickUserValues")
#define REGSTR_VAL_JOYCALLOUT __TEXT("JoystickCallout")
#define REGSTR_VAL_JOYNCONFIG __TEXT("Joystick%dConfiguration")
#define REGSTR_VAL_JOYNOEMNAME __TEXT("Joystick%dOEMName")
#define REGSTR_VAL_JOYNOEMCALLOUT __TEXT("Joystick%dOEMCallout")
#define REGSTR_VAL_JOYOEMCALLOUT __TEXT("OEMCallout")
#define REGSTR_VAL_JOYOEMNAME __TEXT("OEMName")
#define REGSTR_VAL_JOYOEMDATA __TEXT("OEMData")
#define REGSTR_VAL_JOYOEMXYLABEL __TEXT("OEMXYLabel")
#define REGSTR_VAL_JOYOEMZLABEL __TEXT("OEMZLabel")
#define REGSTR_VAL_JOYOEMRLABEL __TEXT("OEMRLabel")
#define REGSTR_VAL_JOYOEMPOVLABEL __TEXT("OEMPOVLabel")
#define REGSTR_VAL_JOYOEMULABEL __TEXT("OEMULabel")
#define REGSTR_VAL_JOYOEMVLABEL __TEXT("OEMVLabel")
#define REGSTR_VAL_JOYOEMTESTMOVEDESC __TEXT("OEMTestMoveDesc")
#define REGSTR_VAL_JOYOEMTESTBUTTONDESC __TEXT("OEMTestButtonDesc")
#define REGSTR_VAL_JOYOEMTESTMOVECAP __TEXT("OEMTestMoveCap")
#define REGSTR_VAL_JOYOEMTESTBUTTONCAP __TEXT("OEMTestButtonCap")
#define REGSTR_VAL_JOYOEMTESTWINCAP __TEXT("OEMTestWinCap")
#define REGSTR_VAL_JOYOEMCALCAP __TEXT("OEMCalCap")
#define REGSTR_VAL_JOYOEMCALWINCAP __TEXT("OEMCalWinCap")
#define REGSTR_VAL_JOYOEMCAL1 __TEXT("OEMCal1")
#define REGSTR_VAL_JOYOEMCAL2 __TEXT("OEMCal2")
#define REGSTR_VAL_JOYOEMCAL3 __TEXT("OEMCal3")
#define REGSTR_VAL_JOYOEMCAL4 __TEXT("OEMCal4")
#define REGSTR_VAL_JOYOEMCAL5 __TEXT("OEMCal5")
#define REGSTR_VAL_JOYOEMCAL6 __TEXT("OEMCal6")
#define REGSTR_VAL_JOYOEMCAL7 __TEXT("OEMCal7")
#define REGSTR_VAL_JOYOEMCAL8 __TEXT("OEMCal8")
#define REGSTR_VAL_JOYOEMCAL9 __TEXT("OEMCal9")
#define REGSTR_VAL_JOYOEMCAL10 __TEXT("OEMCal10")
#define REGSTR_VAL_JOYOEMCAL11 __TEXT("OEMCal11")
#define REGSTR_VAL_JOYOEMCAL12 __TEXT("OEMCal12")
#define REGSTR_VAL_AUDIO_BITMAP __TEXT("bitmap")
#define REGSTR_VAL_AUDIO_ICON __TEXT("icon")
#define REGSTR_PATH_DEVICEINSTALLER __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\Device Installer")
#define REGSTR_PATH_DIFX __TEXT(!"Software\\Microsoft\\Windows\\CurrentVersion\\DIFX")
#define REGSTR_VAL_SEARCHOPTIONS __TEXT("SearchOptions")
#define REGSTR_PATH_BIOSINFO __TEXT(!"System\\CurrentControlSet\\Control\\BiosInfo")
#define REGSTR_PATH_PCIIR __TEXT(!"System\\CurrentControlSet\\Control\\Pnp\\PciIrqRouting")
#define REGSTR_VAL_OPTIONS __TEXT("Options")
#define REGSTR_VAL_STAT __TEXT("Status")
#define REGSTR_VAL_TABLE_STAT __TEXT("TableStatus")
#define REGSTR_VAL_MINIPORT_STAT __TEXT("MiniportStatus")
const PIR_OPTION_ENABLED = &h00000001
const PIR_OPTION_REGISTRY = &h00000002
const PIR_OPTION_MSSPEC = &h00000004
const PIR_OPTION_REALMODE = &h00000008
const PIR_OPTION_DEFAULT = &h0000000f
const PIR_STATUS_ERROR = &h00000000
const PIR_STATUS_ENABLED = &h00000001
const PIR_STATUS_DISABLED = &h00000002
const PIR_STATUS_MAX = &h00000003
const PIR_STATUS_TABLE_REGISTRY = &h00000000
const PIR_STATUS_TABLE_MSSPEC = &h00000001
const PIR_STATUS_TABLE_REALMODE = &h00000002
const PIR_STATUS_TABLE_NONE = &h00000003
const PIR_STATUS_TABLE_ERROR = &h00000004
const PIR_STATUS_TABLE_BAD = &h00000005
const PIR_STATUS_TABLE_SUCCESS = &h00000006
const PIR_STATUS_TABLE_MAX = &h00000007
const PIR_STATUS_MINIPORT_NORMAL = &h00000000
const PIR_STATUS_MINIPORT_COMPATIBLE = &h00000001
const PIR_STATUS_MINIPORT_OVERRIDE = &h00000002
const PIR_STATUS_MINIPORT_NONE = &h00000003
const PIR_STATUS_MINIPORT_ERROR = &h00000004
const PIR_STATUS_MINIPORT_NOKEY = &h00000005
const PIR_STATUS_MINIPORT_SUCCESS = &h00000006
const PIR_STATUS_MINIPORT_INVALID = &h00000007
const PIR_STATUS_MINIPORT_MAX = &h00000008
#define REGSTR_PATH_LASTGOOD __TEXT(!"System\\LastKnownGoodRecovery\\LastGood")
#define REGSTR_PATH_LASTGOODTMP __TEXT(!"System\\LastKnownGoodRecovery\\LastGood.Tmp")
const LASTGOOD_OPERATION = &h000000ff
const LASTGOOD_OPERATION_NOPOSTPROC = &h00000000
const LASTGOOD_OPERATION_DELETE = &h00000001
