''
''
'' ddk\winddk -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ddk_winddk_bi__
#define __ddk_winddk_bi__

#include once "windows.bi"
#include once "win/windef.bi"
#include once "win/winnt.bi"
#include once "win/ntdef.bi"
#include once "win/basetyps.bi"
#include once "ddk_ntstatus.bi"

#define DDKAPI stdcall
#undef Absolute

type PCSZ as zstring ptr
type _CSHORT as short
type PADAPTER_OBJECT as _ADAPTER_OBJECT ptr
type PDMA_ADAPTER as _DMA_ADAPTER ptr
type PIO_STATUS_BLOCK as _IO_STATUS_BLOCK ptr
type PSECTION_OBJECT as _SECTION_OBJECT ptr
type WAIT_TYPE as ULONG
type TRACEHANDLE as HANDLE
type PWMILIB_CONTEXT as PVOID
type PSYSCTL_IRP_DISPOSITION as PVOID
type LOGICAL as ULONG
type KPRIORITY as LONG
type KIRQL as UCHAR
type PKIRQL as UCHAR ptr
type KSPIN_LOCK as ULONG_PTR
type PKSPIN_LOCK as ULONG_PTR ptr
type KAFFINITY as ULONG
type PKAFFINITY as ULONG ptr
type KPROCESSOR_MODE as CCHAR
type DEVICE_OBJECT as _DEVICE_OBJECT
type PDEVICE_OBJECT as DEVICE_OBJECT ptr
type IRP as _IRP
type PIRP as IRP ptr
type SCATTER_GATHER_ELEMENT as _SCATTER_GATHER_ELEMENT
type PSCATTER_GATHER_ELEMENT as SCATTER_GATHER_ELEMENT ptr
type SCATTER_GATHER_LIST as _SCATTER_GATHER_LIST
type PSCATTER_GATHER_LIST as SCATTER_GATHER_LIST ptr
type DRIVER_OBJECT as _DRIVER_OBJECT
type PDRIVER_OBJECT as DRIVER_OBJECT ptr
type KDPC as _KDPC
type PKDPC as KDPC ptr
type PRKDPC as PKDPC
type DEVICE_DESCRIPTION as _DEVICE_DESCRIPTION
type PDEVICE_DESCRIPTION as DEVICE_DESCRIPTION ptr
type FILE_OBJECT as _FILE_OBJECT
type PFILE_OBJECT as FILE_OBJECT ptr
type KAPC as _KAPC
type PKAPC as KAPC ptr
type PRKAPC as PKAPC
type MDL as _MDL
type PMDL as MDL ptr
type IO_STACK_LOCATION as _IO_STACK_LOCATION
type PIO_STACK_LOCATION as IO_STACK_LOCATION ptr
type EISA_MEMORY_CONFIGURATION as _EISA_MEMORY_CONFIGURATION
type PEISA_MEMORY_CONFIGURATION as _EISA_MEMORY_CONFIGURATION ptr
type EISA_PORT_DESCRIPTOR as _EISA_PORT_DESCRIPTOR
type PEISA_PORT_DESCRIPTOR as _EISA_PORT_DESCRIPTOR ptr
type EISA_PORT_CONFIGURATION as _EISA_PORT_CONFIGURATION
type PEISA_PORT_CONFIGURATION as _EISA_PORT_CONFIGURATION ptr
type PDEVOBJ_EXTENSION as any ptr
type IO_CSQ_IRP_CONTEXT as _IO_CSQ_IRP_CONTEXT
type PIO_CSQ_IRP_CONTEXT as _IO_CSQ_IRP_CONTEXT ptr
type IO_CSQ as _IO_CSQ
type PIO_CSQ as IO_CSQ ptr
type PSCSI_REQUEST_BLOCK as any ptr
type PKPRCB as any ptr
type PKTSS as any ptr
type PSET_PARTITION_INFORMATION_EX as any ptr
type TARGET_DEVICE_REMOVAL_NOTIFICATION as _TARGET_DEVICE_REMOVAL_NOTIFICATION
type PTARGET_DEVICE_REMOVAL_NOTIFICATION as _TARGET_DEVICE_REMOVAL_NOTIFICATION ptr
type BUS_QUERY_ID_TYPE as _BUS_QUERY_ID_TYPE
type PBUS_QUERY_ID_TYPE as _BUS_QUERY_ID_TYPE
type DEVICE_TEXT_TYPE as _DEVICE_TEXT_TYPE
type PDEVICE_TEXT_TYPE as _DEVICE_TEXT_TYPE
type DEVICE_USAGE_NOTIFICATION_TYPE as _DEVICE_USAGE_NOTIFICATION_TYPE
type POWER_SEQUENCE as _POWER_SEQUENCE
type PPOWER_SEQUENCE as _POWER_SEQUENCE ptr
type IO_NOTIFICATION_EVENT_CATEGORY as _IO_NOTIFICATION_EVENT_CATEGORY
type OBJECT_NAME_INFORMATION as _OBJECT_NAME_INFORMATION
type POBJECT_NAME_INFORMATION as _OBJECT_NAME_INFORMATION ptr
type MODE as _MODE
type PIO_TIMER as _IO_TIMER ptr
type PEPROCESS as _EPROCESS ptr
type PETHREAD as _ETHREAD ptr
type PKINTERRUPT as _KINTERRUPT ptr
type POBJECT_TYPE as _OBJECT_TYPE ptr
type PKTHREAD as _KTHREAD ptr
type PRKTHREAD as _KTHREAD ptr
type PCOMPRESSED_DATA_INFO as _COMPRESSED_DATA_INFO ptr
type PHAL_DISPATCH_TABLE as _HAL_DISPATCH_TABLE ptr
type PHAL_PRIVATE_DISPATCH_TABLE as _HAL_PRIVATE_DISPATCH_TABLE ptr
type PDRIVE_LAYOUT_INFORMATION as _DRIVE_LAYOUT_INFORMATION ptr
type PDRIVE_LAYOUT_INFORMATION_EX as _DRIVE_LAYOUT_INFORMATION_EX ptr
type POWER_STATE as _POWER_STATE
type PPOWER_STATE as _POWER_STATE ptr
type POWER_STATE_TYPE as _POWER_STATE_TYPE
type PPOWER_STATE_TYPE as POWER_STATE_TYPE ptr
type BUS_INTERFACE_STANDARD as _BUS_INTERFACE_STANDARD
type PBUS_INTERFACE_STANDARD as _BUS_INTERFACE_STANDARD ptr
type DEVICE_CAPABILITIES as _DEVICE_CAPABILITIES
type PDEVICE_CAPABILITIES as _DEVICE_CAPABILITIES ptr
type DEVICE_INTERFACE_CHANGE_NOTIFICATION as _DEVICE_INTERFACE_CHANGE_NOTIFICATION
type PDEVICE_INTERFACE_CHANGE_NOTIFICATION as _DEVICE_INTERFACE_CHANGE_NOTIFICATION ptr
type HWPROFILE_CHANGE_NOTIFICATION as _HWPROFILE_CHANGE_NOTIFICATION
type PHWPROFILE_CHANGE_NOTIFICATION as _HWPROFILE_CHANGE_NOTIFICATION ptr
type INTERFACE as _INTERFACE
type PINTERFACE as _INTERFACE ptr
type PLUGPLAY_NOTIFICATION_HEADER as _PLUGPLAY_NOTIFICATION_HEADER
type PPLUGPLAY_NOTIFICATION_HEADER as _PLUGPLAY_NOTIFICATION_HEADER ptr
type PNP_DEVICE_STATE as ULONG
type PPNP_DEVICE_STATE as ULONG ptr
type IO_ALLOCATION_ACTION as _IO_ALLOCATION_ACTION
type PIO_ALLOCATION_ACTION as IO_ALLOCATION_ACTION ptr

#define MAXIMUM_PROCESSORS 32
#define MAXIMUM_WAIT_OBJECTS 64
#define METHOD_BUFFERED 0
#define METHOD_IN_DIRECT 1
#define METHOD_OUT_DIRECT 2
#define METHOD_NEITHER 3
#define LOW_PRIORITY 0
#define LOW_REALTIME_PRIORITY 16
#define HIGH_PRIORITY 31
#define MAXIMUM_PRIORITY 32
#define FILE_SUPERSEDED &h00000000
#define FILE_OPENED &h00000001
#define FILE_CREATED &h00000002
#define FILE_OVERWRITTEN &h00000003
#define FILE_EXISTS &h00000004
#define FILE_DOES_NOT_EXIST &h00000005
#define FILE_LIST_DIRECTORY &h00000001
#define FILE_READ_DATA &h00000001
#define FILE_ADD_FILE &h00000002
#define FILE_WRITE_DATA &h00000002
#define FILE_ADD_SUBDIRECTORY &h00000004
#define FILE_APPEND_DATA &h00000004
#define FILE_CREATE_PIPE_INSTANCE &h00000004
#define FILE_READ_EA &h00000008
#define FILE_WRITE_EA &h00000010
#define FILE_EXECUTE &h00000020
#define FILE_TRAVERSE &h00000020
#define FILE_DELETE_CHILD &h00000040
#define FILE_READ_ATTRIBUTES &h00000080
#define FILE_WRITE_ATTRIBUTES &h00000100
#define FILE_SHARE_READ &h00000001
#define FILE_SHARE_WRITE &h00000002
#define FILE_SHARE_DELETE &h00000004
#define FILE_SHARE_VALID_FLAGS &h00000007
#define FILE_ATTRIBUTE_READONLY &h00000001
#define FILE_ATTRIBUTE_HIDDEN &h00000002
#define FILE_ATTRIBUTE_SYSTEM &h00000004
#define FILE_ATTRIBUTE_DIRECTORY &h00000010
#define FILE_ATTRIBUTE_ARCHIVE &h00000020
#define FILE_ATTRIBUTE_DEVICE &h00000040
#define FILE_ATTRIBUTE_NORMAL &h00000080
#define FILE_ATTRIBUTE_TEMPORARY &h00000100
#define FILE_ATTRIBUTE_SPARSE_FILE &h00000200
#define FILE_ATTRIBUTE_REPARSE_POINT &h00000400
#define FILE_ATTRIBUTE_COMPRESSED &h00000800
#define FILE_ATTRIBUTE_OFFLINE &h00001000
#define FILE_ATTRIBUTE_NOT_CONTENT_INDEXED &h00002000
#define FILE_ATTRIBUTE_ENCRYPTED &h00004000
#define FILE_ATTRIBUTE_VALID_FLAGS &h00007fb7
#define FILE_ATTRIBUTE_VALID_SET_FLAGS &h000031a7
#define FILE_COPY_STRUCTURED_STORAGE &h00000041
#define FILE_STRUCTURED_STORAGE &h00000441
#define FILE_VALID_OPTION_FLAGS &h00ffffff
#define FILE_VALID_PIPE_OPTION_FLAGS &h00000032
#define FILE_VALID_MAILSLOT_OPTION_FLAGS &h00000032
#define FILE_VALID_SET_FLAGS &h00000036
#define FILE_SUPERSEDE &h00000000
#define FILE_OPEN &h00000001
#define FILE_CREATE &h00000002
#define FILE_OPEN_IF &h00000003
#define FILE_OVERWRITE &h00000004
#define FILE_OVERWRITE_IF &h00000005
#define FILE_MAXIMUM_DISPOSITION &h00000005
#define FILE_DIRECTORY_FILE &h00000001
#define FILE_WRITE_THROUGH &h00000002
#define FILE_SEQUENTIAL_ONLY &h00000004
#define FILE_NO_INTERMEDIATE_BUFFERING &h00000008
#define FILE_SYNCHRONOUS_IO_ALERT &h00000010
#define FILE_SYNCHRONOUS_IO_NONALERT &h00000020
#define FILE_NON_DIRECTORY_FILE &h00000040
#define FILE_CREATE_TREE_CONNECTION &h00000080
#define FILE_COMPLETE_IF_OPLOCKED &h00000100
#define FILE_NO_EA_KNOWLEDGE &h00000200
#define FILE_OPEN_FOR_RECOVERY &h00000400
#define FILE_RANDOM_ACCESS &h00000800
#define FILE_DELETE_ON_CLOSE &h00001000
#define FILE_OPEN_BY_FILE_ID &h00002000
#define FILE_OPEN_FOR_BACKUP_INTENT &h00004000
#define FILE_NO_COMPRESSION &h00008000
#define FILE_RESERVE_OPFILTER &h00100000
#define FILE_OPEN_REPARSE_POINT &h00200000
#define FILE_OPEN_NO_RECALL &h00400000
#define FILE_OPEN_FOR_FREE_SPACE_QUERY &h00800000
#define FILE_ANY_ACCESS &h00000000
#define FILE_SPECIAL_ACCESS &h00000000
#define FILE_READ_ACCESS &h00000001
#define FILE_WRITE_ACCESS &h00000002
#define FILE_ALL_ACCESS (&hF0000 or &h100000L or &h1FF)
#define FILE_GENERIC_EXECUTE (&h20000 or &h00000080 or &h00000020 or &h100000L)
#define FILE_GENERIC_READ (&h20000 or &h00000001 or &h00000080 or &h00000008 or &h100000L)
#define FILE_GENERIC_WRITE (&h20000 or &h00000002 or &h00000100 or &h00000010 or &h00000004 or &h100000L)
#define DIRECTORY_QUERY (&h0001)
#define DIRECTORY_TRAVERSE (&h0002)
#define DIRECTORY_CREATE_OBJECT (&h0004)
#define DIRECTORY_CREATE_SUBDIRECTORY (&h0008)
#define DIRECTORY_ALL_ACCESS (&hF0000 or &hF)
#define IRP_MJ_CREATE &h00
#define IRP_MJ_CREATE_NAMED_PIPE &h01
#define IRP_MJ_CLOSE &h02
#define IRP_MJ_READ &h03
#define IRP_MJ_WRITE &h04
#define IRP_MJ_QUERY_INFORMATION &h05
#define IRP_MJ_SET_INFORMATION &h06
#define IRP_MJ_QUERY_EA &h07
#define IRP_MJ_SET_EA &h08
#define IRP_MJ_FLUSH_BUFFERS &h09
#define IRP_MJ_QUERY_VOLUME_INFORMATION &h0a
#define IRP_MJ_SET_VOLUME_INFORMATION &h&b
#define IRP_MJ_DIRECTORY_CONTROL &h0c
#define IRP_MJ_FILE_SYSTEM_CONTROL &h0d
#define IRP_MJ_DEVICE_CONTROL &h0e
#define IRP_MJ_INTERNAL_DEVICE_CONTROL &h0f
#define IRP_MJ_SCSI &h0f
#define IRP_MJ_SHUTDOWN &h10
#define IRP_MJ_LOCK_CONTROL &h11
#define IRP_MJ_CLEANUP &h12
#define IRP_MJ_CREATE_MAILSLOT &h13
#define IRP_MJ_QUERY_SECURITY &h14
#define IRP_MJ_SET_SECURITY &h15
#define IRP_MJ_POWER &h16
#define IRP_MJ_SYSTEM_CONTROL &h17
#define IRP_MJ_DEVICE_CHANGE &h18
#define IRP_MJ_QUERY_QUOTA &h19
#define IRP_MJ_SET_QUOTA &h1a
#define IRP_MJ_PNP &h1b
#define IRP_MJ_PNP_POWER &h1b
#define IRP_MJ_MAXIMUM_FUNCTION &h1b
#define IRP_MN_QUERY_DIRECTORY &h01
#define IRP_MN_NOTIFY_CHANGE_DIRECTORY &h02
#define IRP_MN_USER_FS_REQUEST &h00
#define IRP_MN_MOUNT_VOLUME &h01
#define IRP_MN_VERIFY_VOLUME &h02
#define IRP_MN_LOAD_FILE_SYSTEM &h03
#define IRP_MN_TRACK_LINK &h04
#define IRP_MN_KERNEL_CALL &h04
#define IRP_MN_LOCK &h01
#define IRP_MN_UNLOCK_SINGLE &h02
#define IRP_MN_UNLOCK_ALL &h03
#define IRP_MN_UNLOCK_ALL_BY_KEY &h04
#define IRP_MN_NORMAL &h00
#define IRP_MN_DPC &h01
#define IRP_MN_MDL &h02
#define IRP_MN_COMPLETE &h04
#define IRP_MN_COMPRESSED &h08
#define IRP_MN_MDL_DPC (&h02 or &h01)
#define IRP_MN_COMPLETE_MDL (&h04 or &h02)
#define IRP_MN_COMPLETE_MDL_DPC ((&h04 or &h02) or &h01)
#define IRP_MN_SCSI_CLASS &h01
#define IRP_MN_START_DEVICE &h00
#define IRP_MN_QUERY_REMOVE_DEVICE &h01
#define IRP_MN_REMOVE_DEVICE &h02
#define IRP_MN_CANCEL_REMOVE_DEVICE &h03
#define IRP_MN_STOP_DEVICE &h04
#define IRP_MN_QUERY_STOP_DEVICE &h05
#define IRP_MN_CANCEL_STOP_DEVICE &h06
#define IRP_MN_QUERY_DEVICE_RELATIONS &h07
#define IRP_MN_QUERY_INTERFACE &h08
#define IRP_MN_QUERY_CAPABILITIES &h09
#define IRP_MN_QUERY_RESOURCES &h0A
#define IRP_MN_QUERY_RESOURCE_REQUIREMENTS &h0B
#define IRP_MN_QUERY_DEVICE_TEXT &h0C
#define IRP_MN_FILTER_RESOURCE_REQUIREMENTS &h0D
#define IRP_MN_READ_CONFIG &h0F
#define IRP_MN_WRITE_CONFIG &h10
#define IRP_MN_EJECT &h11
#define IRP_MN_SET_LOCK &h12
#define IRP_MN_QUERY_ID &h13
#define IRP_MN_QUERY_PNP_DEVICE_STATE &h14
#define IRP_MN_QUERY_BUS_INFORMATION &h15
#define IRP_MN_DEVICE_USAGE_NOTIFICATION &h16
#define IRP_MN_SURPRISE_REMOVAL &h17
#define IRP_MN_QUERY_LEGACY_BUS_INFORMATION &h18
#define IRP_MN_WAIT_WAKE &h00
#define IRP_MN_POWER_SEQUENCE &h01
#define IRP_MN_SET_POWER &h02
#define IRP_MN_QUERY_POWER &h03
#define IRP_MN_QUERY_ALL_DATA &h00
#define IRP_MN_QUERY_SINGLE_INSTANCE &h01
#define IRP_MN_CHANGE_SINGLE_INSTANCE &h02
#define IRP_MN_CHANGE_SINGLE_ITEM &h03
#define IRP_MN_ENABLE_EVENTS &h04
#define IRP_MN_DISABLE_EVENTS &h05
#define IRP_MN_ENABLE_COLLECTION &h06
#define IRP_MN_DISABLE_COLLECTION &h07
#define IRP_MN_REGINFO &h08
#define IRP_MN_EXECUTE_METHOD &h09
#define IRP_MN_REGINFO_EX &h&b


enum _MODE
	KernelMode
	UserMode
	MaximumMode
end enum

enum _IO_ALLOCATION_ACTION
	KeepObject = 1
	DeallocateObject
	DeallocateObjectKeepRegisters
end enum

union _POWER_STATE
	SystemState as SYSTEM_POWER_STATE
	DeviceState as DEVICE_POWER_STATE
end union


enum _POWER_STATE_TYPE
	SystemPowerState
	DevicePowerState
end enum


type PDRIVER_CONTROL as function DDKAPI(byval as PDEVICE_OBJECT, byval as PIRP, byval as PVOID, byval as PVOID) as IO_ALLOCATION_ACTION
type PDRIVER_LIST_CONTROL as sub DDKAPI(byval as PDEVICE_OBJECT, byval as PIRP, byval as PSCATTER_GATHER_LIST, byval as PVOID)
type PDRIVER_ADD_DEVICE as function DDKAPI(byval as PDRIVER_OBJECT, byval as PDEVICE_OBJECT) as NTSTATUS
type PIO_COMPLETION_ROUTINE as function DDKAPI(byval as PDEVICE_OBJECT, byval as PIRP, byval as PVOID) as NTSTATUS
type PDRIVER_CANCEL as sub DDKAPI(byval as PDEVICE_OBJECT, byval as PIRP)
type PKDEFERRED_ROUTINE as sub DDKAPI(byval as PKDPC, byval as PVOID, byval as PVOID, byval as PVOID)
type PDRIVER_DISPATCH as function DDKAPI(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
type PIO_DPC_ROUTINE as sub DDKAPI(byval as PKDPC, byval as PDEVICE_OBJECT, byval as PIRP, byval as PVOID)
type PMM_DLL_INITIALIZE as function DDKAPI(byval as PUNICODE_STRING) as NTSTATUS
type PMM_DLL_UNLOAD as function DDKAPI() as NTSTATUS
type PDRIVER_ENTRY as function DDKAPI(byval as PDRIVER_OBJECT, byval as PUNICODE_STRING) as NTSTATUS
type PDRIVER_INITIALIZE as function DDKAPI(byval as PDRIVER_OBJECT, byval as PUNICODE_STRING) as NTSTATUS
type PKSERVICE_ROUTINE as function DDKAPI(byval as PKINTERRUPT, byval as PVOID) as BOOLEAN
type PIO_TIMER_ROUTINE as sub DDKAPI(byval as PDEVICE_OBJECT, byval as PVOID)
type PDRIVER_REINITIALIZE as sub DDKAPI(byval as PDRIVER_OBJECT, byval as PVOID, byval as ULONG)
type PDRIVER_STARTIO as function DDKAPI(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
type PKSYNCHRONIZE_ROUTINE as function DDKAPI(byval as PVOID) as BOOLEAN
type PDRIVER_UNLOAD as sub DDKAPI(byval as PDRIVER_OBJECT)
type PINTERFACE_REFERENCE as sub DDKAPI(byval as PVOID)
type PINTERFACE_DEREFERENCE as sub DDKAPI(byval as PVOID)
type PTRANSLATE_BUS_ADDRESS as function DDKAPI(byval as PVOID, byval as PHYSICAL_ADDRESS, byval as ULONG, byval as PULONG, byval as PPHYSICAL_ADDRESS) as BOOLEAN
type PGET_DMA_ADAPTER as function DDKAPI(byval as PVOID, byval as PDEVICE_DESCRIPTION, byval as PULONG) as PDMA_ADAPTER
type PGET_SET_DEVICE_DATA as function DDKAPI(byval as PVOID, byval as ULONG, byval as PVOID, byval as ULONG, byval as ULONG) as ULONG
type PDEVICE_CHANGE_COMPLETE_CALLBACK as sub DDKAPI(byval as PVOID)
type PIO_APC_ROUTINE as sub DDKAPI(byval as PVOID, byval as PIO_STATUS_BLOCK, byval as ULONG)
type PDRIVER_NOTIFICATION_CALLBACK_ROUTINE as function DDKAPI(byval as PVOID, byval as PVOID) as NTSTATUS
type PKNORMAL_ROUTINE as sub DDKAPI(byval as PVOID, byval as PVOID, byval as PVOID)
type PKKERNEL_ROUTINE as sub DDKAPI(byval as PKAPC, byval as PKNORMAL_ROUTINE ptr, byval as PVOID ptr, byval as PVOID ptr, byval as PVOID ptr)
type PKRUNDOWN_ROUTINE as sub DDKAPI(byval as PKAPC)
type PKTRANSFER_ROUTINE as function DDKAPI() as BOOLEAN

type _BUS_INTERFACE_STANDARD
	Size as USHORT
	Version as USHORT
	Context as PVOID
	InterfaceReference as PINTERFACE_REFERENCE
	InterfaceDereference as PINTERFACE_DEREFERENCE
	TranslateBusAddress as PTRANSLATE_BUS_ADDRESS
	GetDmaAdapter as PGET_DMA_ADAPTER
	SetBusData as PGET_SET_DEVICE_DATA
	GetBusData as PGET_SET_DEVICE_DATA
end type

type _DEVICE_CAPABILITIES
	Size as USHORT
	Version as USHORT
	DeviceD1:1 as ULONG
	DeviceD2:1 as ULONG
	LockSupported:1 as ULONG
	EjectSupported:1 as ULONG
	Removable:1 as ULONG
	DockDevice:1 as ULONG
	UniqueID:1 as ULONG
	SilentInstall:1 as ULONG
	RawDeviceOK:1 as ULONG
	SurpriseRemovalOK:1 as ULONG
	WakeFromD0:1 as ULONG
	WakeFromD1:1 as ULONG
	WakeFromD2:1 as ULONG
	WakeFromD3:1 as ULONG
	HardwareDisabled:1 as ULONG
	NonDynamic:1 as ULONG
	WarmEjectSupported:1 as ULONG
	NoDisplayInUI:1 as ULONG
	Reserved:14 as ULONG
	Address as ULONG
	UINumber as ULONG
	DeviceState(0 to PowerSystemMaximum-1) as DEVICE_POWER_STATE
	SystemWake as SYSTEM_POWER_STATE
	DeviceWake as DEVICE_POWER_STATE
	D1Latency as ULONG
	D2Latency as ULONG
	D3Latency as ULONG
end type

type _DEVICE_INTERFACE_CHANGE_NOTIFICATION
	Version as USHORT
	Size as USHORT
	Event as GUID
	InterfaceClassGuid as GUID
	SymbolicLinkName as PUNICODE_STRING
end type


type _HWPROFILE_CHANGE_NOTIFICATION
	Version as USHORT
	Size as USHORT
	Event as GUID
end type

type _INTERFACE
	Size as USHORT
	Version as USHORT
	Context as PVOID
	InterfaceReference as PINTERFACE_REFERENCE
	InterfaceDereference as PINTERFACE_DEREFERENCE
end type

type _PLUGPLAY_NOTIFICATION_HEADER
	Version as USHORT
	Size as USHORT
	Event as GUID
end type


#define PNP_DEVICE_DISABLED &h00000001
#define PNP_DEVICE_DONT_DISPLAY_IN_UI &h00000002
#define PNP_DEVICE_FAILED &h00000004
#define PNP_DEVICE_REMOVED &h00000008
#define PNP_DEVICE_RESOURCE_REQUIREMENTS_CHANGED &h00000010
#define PNP_DEVICE_NOT_DISABLEABLE &h00000020

type _TARGET_DEVICE_CUSTOM_NOTIFICATION
	Version as USHORT
	Size as USHORT
	Event as GUID
	FileObject as PFILE_OBJECT
	NameBufferOffset as LONG
	CustomDataBuffer(0 to 1-1) as UCHAR
end type

type TARGET_DEVICE_CUSTOM_NOTIFICATION as _TARGET_DEVICE_CUSTOM_NOTIFICATION
type PTARGET_DEVICE_CUSTOM_NOTIFICATION as _TARGET_DEVICE_CUSTOM_NOTIFICATION ptr

type _TARGET_DEVICE_REMOVAL_NOTIFICATION
	Version as USHORT
	Size as USHORT
	Event as GUID
	FileObject as PFILE_OBJECT
end type

enum _BUS_QUERY_ID_TYPE
	BusQueryDeviceID
	BusQueryHardwareIDs
	BusQueryCompatibleIDs
	BusQueryInstanceID
	BusQueryDeviceSerialNumber
end enum

enum _DEVICE_TEXT_TYPE
	DeviceTextDescription
	DeviceTextLocationInformation
end enum

enum _DEVICE_USAGE_NOTIFICATION_TYPE
	DeviceUsageTypeUndefined
	DeviceUsageTypePaging
	DeviceUsageTypeHibernation
	DeviceUsageTypeDumpFile
end enum

type _POWER_SEQUENCE
	SequenceD1 as ULONG
	SequenceD2 as ULONG
	SequenceD3 as ULONG
end type

enum DEVICE_REGISTRY_PROPERTY
	DevicePropertyDeviceDescription
	DevicePropertyHardwareID
	DevicePropertyCompatibleIDs
	DevicePropertyBootConfiguration
	DevicePropertyBootConfigurationTranslated
	DevicePropertyClassName
	DevicePropertyClassGuid
	DevicePropertyDriverKeyName
	DevicePropertyManufacturer
	DevicePropertyFriendlyName
	DevicePropertyLocationInformation
	DevicePropertyPhysicalDeviceObjectName
	DevicePropertyBusTypeGuid
	DevicePropertyLegacyBusType
	DevicePropertyBusNumber
	DevicePropertyEnumeratorName
	DevicePropertyAddress
	DevicePropertyUINumber
	DevicePropertyInstallState
	DevicePropertyRemovalPolicy
end enum


enum _IO_NOTIFICATION_EVENT_CATEGORY
	EventCategoryReserved
	EventCategoryHardwareProfileChange
	EventCategoryDeviceInterfaceChange
	EventCategoryTargetDeviceChange
end enum

#define PNPNOTIFY_DEVICE_INTERFACE_INCLUDE_EXISTING_INTERFACES &h00000001

#define SYMBOLIC_LINK_QUERY &h0001
#define SYMBOLIC_LINK_ALL_ACCESS (&hF0000 or &h1)
#define DUPLICATE_CLOSE_SOURCE &h00000001
#define DUPLICATE_SAME_ACCESS &h00000002
#define DUPLICATE_SAME_ATTRIBUTES &h00000004

type _OBJECT_NAME_INFORMATION
	Name as UNICODE_STRING
end type


union IO_STATUS_BLOCK__u
	Status as NTSTATUS
	Pointer as PVOID
end union

type _IO_STATUS_BLOCK
	Information as ULONG_PTR
	u as IO_STATUS_BLOCK__u
end type

type IO_STATUS_BLOCK as _IO_STATUS_BLOCK



type _KAPC
	Type as _CSHORT
	Size as _CSHORT
	Spare0 as ULONG
	Thread as PKTHREAD
	ApcListEntry as LIST_ENTRY
	KernelRoutine as PKKERNEL_ROUTINE
	RundownRoutine as PKRUNDOWN_ROUTINE
	NormalRoutine as PKNORMAL_ROUTINE
	NormalContext as PVOID
	SystemArgument1 as PVOID
	SystemArgument2 as PVOID
	ApcStateIndex as CCHAR
	ApcMode as KPROCESSOR_MODE
	Inserted as BOOLEAN
end type

type _KDEVICE_QUEUE
	Type as _CSHORT
	Size as _CSHORT
	DeviceListHead as LIST_ENTRY
	Lock as KSPIN_LOCK
	Busy as BOOLEAN
end type

type KDEVICE_QUEUE as _KDEVICE_QUEUE
type PKDEVICE_QUEUE as _KDEVICE_QUEUE ptr
type PRKDEVICE_QUEUE as _KDEVICE_QUEUE ptr

type _KDEVICE_QUEUE_ENTRY
	DeviceListEntry as LIST_ENTRY
	SortKey as ULONG
	Inserted as BOOLEAN
end type

type KDEVICE_QUEUE_ENTRY as _KDEVICE_QUEUE_ENTRY
type PKDEVICE_QUEUE_ENTRY as _KDEVICE_QUEUE_ENTRY ptr
type PRKDEVICE_QUEUE_ENTRY as _KDEVICE_QUEUE_ENTRY ptr

#define LOCK_QUEUE_WAIT 1
#define LOCK_QUEUE_OWNER 2

enum _KSPIN_LOCK_QUEUE_NUMBER
	LockQueueDispatcherLock
	LockQueueContextSwapLock
	LockQueuePfnLock
	LockQueueSystemSpaceLock
	LockQueueVacbLock
	LockQueueMasterLock
	LockQueueNonPagedPoolLock
	LockQueueIoCancelLock
	LockQueueWorkQueueLock
	LockQueueIoVpbLock
	LockQueueIoDatabaseLock
	LockQueueIoCompletionLock
	LockQueueNtfsStructLock
	LockQueueAfdWorkQueueLock
	LockQueueBcbLock
	LockQueueMaximumLock
end enum

type KSPIN_LOCK_QUEUE_NUMBER as _KSPIN_LOCK_QUEUE_NUMBER
type PKSPIN_LOCK_QUEUE_NUMBER as _KSPIN_LOCK_QUEUE_NUMBER

type _KSPIN_LOCK_QUEUE
	Next as _KSPIN_LOCK_QUEUE ptr
	Lock as PKSPIN_LOCK
end type

type KSPIN_LOCK_QUEUE as _KSPIN_LOCK_QUEUE
type PKSPIN_LOCK_QUEUE as _KSPIN_LOCK_QUEUE ptr

type _KLOCK_QUEUE_HANDLE
	LockQueue as KSPIN_LOCK_QUEUE
	OldIrql as KIRQL
end type

type KLOCK_QUEUE_HANDLE as _KLOCK_QUEUE_HANDLE
type PKLOCK_QUEUE_HANDLE as _KLOCK_QUEUE_HANDLE ptr

type _KDPC
	Type as _CSHORT
	Number as UCHAR
	Importance as UCHAR
	DpcListEntry as LIST_ENTRY
	DeferredRoutine as PKDEFERRED_ROUTINE
	DeferredContext as PVOID
	SystemArgument1 as PVOID
	SystemArgument2 as PVOID
	Lock as PULONG_PTR
end type

type _WAIT_CONTEXT_BLOCK
	WaitQueueEntry as KDEVICE_QUEUE_ENTRY
	DeviceRoutine as PDRIVER_CONTROL
	DeviceContext as PVOID
	NumberOfMapRegisters as ULONG
	DeviceObject as PVOID
	CurrentIrp as PVOID
	BufferChainingDpc as PKDPC
end type

type WAIT_CONTEXT_BLOCK as _WAIT_CONTEXT_BLOCK
type PWAIT_CONTEXT_BLOCK as _WAIT_CONTEXT_BLOCK ptr

type _DISPATCHER_HEADER
	Type as UCHAR
	Absolute as UCHAR
	Size as UCHAR
	Inserted as UCHAR
	SignalState as LONG
	WaitListHead as LIST_ENTRY
end type

type DISPATCHER_HEADER as _DISPATCHER_HEADER
type PDISPATCHER_HEADER as _DISPATCHER_HEADER ptr

type _KEVENT
	Header as DISPATCHER_HEADER
end type

type KEVENT as _KEVENT
type PKEVENT as _KEVENT ptr
type PRKEVENT as _KEVENT ptr

type _KSEMAPHORE
	Header as DISPATCHER_HEADER
	Limit as LONG
end type

type KSEMAPHORE as _KSEMAPHORE
type PKSEMAPHORE as _KSEMAPHORE ptr
type PRKSEMAPHORE as _KSEMAPHORE ptr

type _FAST_MUTEX
	Count as LONG
	Owner as PKTHREAD
	Contention as ULONG
	Event as KEVENT
	OldIrql as ULONG
end type

type FAST_MUTEX as _FAST_MUTEX
type PFAST_MUTEX as _FAST_MUTEX ptr

type _KTIMER
	Header as DISPATCHER_HEADER
	DueTime as ULARGE_INTEGER
	TimerListEntry as LIST_ENTRY
	Dpc as PKDPC
	Period as LONG
end type

type KTIMER as _KTIMER
type PKTIMER as _KTIMER ptr
type PRKTIMER as _KTIMER ptr

type _KMUTANT
	Header as DISPATCHER_HEADER
	MutantListEntry as LIST_ENTRY
	OwnerThread as PKTHREAD
	Abandoned as BOOLEAN
	ApcDisable as UCHAR
end type

type KMUTANT as _KMUTANT
type PKMUTANT as _KMUTANT ptr
type PRKMUTANT as _KMUTANT ptr
type KMUTEX as _KMUTANT
type PKMUTEX as _KMUTANT ptr
type PRKMUTEX as _KMUTANT ptr

enum _TIMER_TYPE
	NotificationTimer
	SynchronizationTimer
end enum

type TIMER_TYPE as _TIMER_TYPE

#define EVENT_INCREMENT 1
#define IO_NO_INCREMENT 0
#define IO_CD_ROM_INCREMENT 1
#define IO_DISK_INCREMENT 1
#define IO_KEYBOARD_INCREMENT 6
#define IO_MAILSLOT_INCREMENT 2
#define IO_MOUSE_INCREMENT 6
#define IO_NAMED_PIPE_INCREMENT 2
#define IO_NETWORK_INCREMENT 2
#define IO_PARALLEL_INCREMENT 1
#define IO_SERIAL_INCREMENT 2
#define IO_SOUND_INCREMENT 8
#define IO_VIDEO_INCREMENT 1
#define SEMAPHORE_INCREMENT 1


type IRP__Tail__Overlay__u__s
	DriverContext(0 to 4-1) as PVOID
end type

union IRP__Tail__Overlay__s__u
	CurrentStackLocation as PIO_STACK_LOCATION
	PacketType as ULONG
end union

type IRP__Tail__Overlay__s
	ListEntry as LIST_ENTRY
	u as IRP__Tail__Overlay__s__u
end type

union IRP__Tail__Overlay__u
	DeviceQueueEntry as KDEVICE_QUEUE_ENTRY
	s as IRP__Tail__Overlay__u__s
end union

type IRP__Tail__Overlay
	Thread as PETHREAD
	AuxiliaryBuffer as PCHAR
	OriginalFileObject as PFILE_OBJECT
	s as IRP__Tail__Overlay__s
	u as IRP__Tail__Overlay__u
end type

union IRP__Tail
	Apc as KAPC
	CompletionKey as PVOID
	Overlay as IRP__Tail__Overlay
end union

type IRP__Overlay__AsynchronousParameters
	UserApcRoutine as PIO_APC_ROUTINE
	UserApcContext as PVOID
end type

union IRP__Overlay
	AllocationSize as LARGE_INTEGER
	AsynchronousParameters as IRP__Overlay__AsynchronousParameters
end union


union IRP__AssociatedIrp
	MasterIrp as PIRP
	IrpCount as LONG
	SystemBuffer as PVOID
end union

type _IRP
	Type as _CSHORT
	Size as USHORT
	MdlAddress as PMDL
	Flags as ULONG
	ThreadListEntry as LIST_ENTRY
	IoStatus as IO_STATUS_BLOCK
	RequestorMode as KPROCESSOR_MODE
	PendingReturned as BOOLEAN
	StackCount as CHAR
	CurrentLocation as CHAR
	Cancel as BOOLEAN
	CancelIrql as KIRQL
	ApcEnvironment as CCHAR
	AllocationFlags as UCHAR
	UserIosb as PIO_STATUS_BLOCK
	UserEvent as PKEVENT
	CancelRoutine as PDRIVER_CANCEL
	UserBuffer as PVOID
	Tail as IRP__Tail
	Overlay as IRP__Overlay
	AssociatedIrp as IRP__AssociatedIrp
end type




#define SL_FORCE_ACCESS_CHECK &h01
#define SL_OPEN_PAGING_FILE &h02
#define SL_OPEN_TARGET_DIRECTORY &h04
#define SL_CASE_SENSITIVE &h80
#define SL_KEY_SPECIFIED &h01
#define SL_OVERRIDE_VERIFY_VOLUME &h02
#define SL_WRITE_THROUGH &h04
#define SL_FT_SEQUENTIAL_WRITE &h08
#define SL_FAIL_IMMEDIATELY &h01
#define SL_EXCLUSIVE_LOCK &h02
#define SL_RESTART_SCAN &h01
#define SL_RETURN_SINGLE_ENTRY &h02
#define SL_INDEX_SPECIFIED &h04
#define SL_WATCH_TREE &h01
#define SL_ALLOW_RAW_MOUNT &h01

enum 
	IRP_NOCACHE = &h1
	IRP_PAGING_IO = &h2
	IRP_MOUNT_COMPLETION = &h2
	IRP_SYNCHRONOUS_API = &h4
	IRP_ASSOCIATED_IRP = &h8
	IRP_BUFFERED_IO = &h10
	IRP_DEALLOCATE_BUFFER = &h20
	IRP_INPUT_OPERATION = &h40
	IRP_SYNCHRONOUS_PAGING_IO = &h40
	IRP_CREATE_OPERATION = &h80
	IRP_READ_OPERATION = &h100
	IRP_WRITE_OPERATION = &h200
	IRP_CLOSE_OPERATION = &h400
	IRP_DEFER_IO_COMPLETION = &h800
	IRP_OB_QUERY_NAME = &h1000
	IRP_HOLD_DEVICE_QUEUE = &h2000
	IRP_RETRY_IO_COMPLETION = &h4000
end enum

type _DRIVE_LAYOUT_INFORMATION_MBR
	Signature as ULONG
end type

type DRIVE_LAYOUT_INFORMATION_MBR as _DRIVE_LAYOUT_INFORMATION_MBR
type PDRIVE_LAYOUT_INFORMATION_MBR as _DRIVE_LAYOUT_INFORMATION_MBR ptr

type _DRIVE_LAYOUT_INFORMATION_GPT
	DiskId as GUID
	StartingUsableOffset as LARGE_INTEGER
	UsableLength as LARGE_INTEGER
	MaxPartitionCount as ULONG
end type

type DRIVE_LAYOUT_INFORMATION_GPT as _DRIVE_LAYOUT_INFORMATION_GPT
type PDRIVE_LAYOUT_INFORMATION_GPT as _DRIVE_LAYOUT_INFORMATION_GPT ptr

type _PARTITION_INFORMATION_MBR
	PartitionType as UCHAR
	BootIndicator as BOOLEAN
	RecognizedPartition as BOOLEAN
	HiddenSectors as ULONG
end type

type PARTITION_INFORMATION_MBR as _PARTITION_INFORMATION_MBR
type PPARTITION_INFORMATION_MBR as _PARTITION_INFORMATION_MBR ptr

type _BOOTDISK_INFORMATION
	BootPartitionOffset as LONGLONG
	SystemPartitionOffset as LONGLONG
	BootDeviceSignature as ULONG
	SystemDeviceSignature as ULONG
end type

type BOOTDISK_INFORMATION as _BOOTDISK_INFORMATION
type PBOOTDISK_INFORMATION as _BOOTDISK_INFORMATION ptr

type _BOOTDISK_INFORMATION_EX
	BootPartitionOffset as LONGLONG
	SystemPartitionOffset as LONGLONG
	BootDeviceSignature as ULONG
	SystemDeviceSignature as ULONG
	BootDeviceGuid as GUID
	SystemDeviceGuid as GUID
	BootDeviceIsGpt as BOOLEAN
	SystemDeviceIsGpt as BOOLEAN
end type

type BOOTDISK_INFORMATION_EX as _BOOTDISK_INFORMATION_EX
type PBOOTDISK_INFORMATION_EX as _BOOTDISK_INFORMATION_EX ptr

type _EISA_MEMORY_TYPE
	ReadWrite:1 as UCHAR
	Cached:1 as UCHAR
	Reserved0:1 as UCHAR
	Type:2 as UCHAR
	Shared:1 as UCHAR
	Reserved1:1 as UCHAR
	MoreEntries:1 as UCHAR
end type

type EISA_MEMORY_TYPE as _EISA_MEMORY_TYPE
type PEISA_MEMORY_TYPE as _EISA_MEMORY_TYPE ptr

'#include once "win/ddk/pshpack1.bi"

type _EISA_MEMORY_CONFIGURATION field = 1
	ConfigurationByte as EISA_MEMORY_TYPE
	DataSize as UCHAR
	AddressLowWord as USHORT
	AddressHighByte as UCHAR
	MemorySize as USHORT
end type

'#include once "win/ddk/poppack.bi"

type _EISA_IRQ_DESCRIPTOR
	Interrupt:4 as UCHAR
	Reserved:1 as UCHAR
	LevelTriggered:1 as UCHAR
	Shared:1 as UCHAR
	MoreEntries:1 as UCHAR
end type

type EISA_IRQ_DESCRIPTOR as _EISA_IRQ_DESCRIPTOR
type PEISA_IRQ_DESCRIPTOR as _EISA_IRQ_DESCRIPTOR ptr

type _EISA_IRQ_CONFIGURATION
	ConfigurationByte as EISA_IRQ_DESCRIPTOR
	Reserved as UCHAR
end type

type EISA_IRQ_CONFIGURATION as _EISA_IRQ_CONFIGURATION
type PEISA_IRQ_CONFIGURATION as _EISA_IRQ_CONFIGURATION ptr

type _DMA_CONFIGURATION_BYTE0
	Channel:3 as UCHAR
	Reserved:3 as UCHAR
	Shared:1 as UCHAR
	MoreEntries:1 as UCHAR
end type

type DMA_CONFIGURATION_BYTE0 as _DMA_CONFIGURATION_BYTE0

type _DMA_CONFIGURATION_BYTE1
	Reserved0:2 as UCHAR
	TransferSize:2 as UCHAR
	Timing:2 as UCHAR
	Reserved1:2 as UCHAR
end type

type DMA_CONFIGURATION_BYTE1 as _DMA_CONFIGURATION_BYTE1

type _EISA_DMA_CONFIGURATION
	ConfigurationByte0 as DMA_CONFIGURATION_BYTE0
	ConfigurationByte1 as DMA_CONFIGURATION_BYTE1
end type

type EISA_DMA_CONFIGURATION as _EISA_DMA_CONFIGURATION
type PEISA_DMA_CONFIGURATION as _EISA_DMA_CONFIGURATION ptr

'#include once "win/ddk/pshpack1.bi"

type _EISA_PORT_DESCRIPTOR field = 1
	NumberPorts:5 as UCHAR
	Reserved:1 as UCHAR
	Shared:1 as UCHAR
	MoreEntries:1 as UCHAR
end type


type _EISA_PORT_CONFIGURATION field = 1
	Configuration as EISA_PORT_DESCRIPTOR
	PortAddress as USHORT
end type

'#include once "win/ddk/poppack.bi"

type _CM_EISA_FUNCTION_INFORMATION
	CompressedId as ULONG
	IdSlotFlags1 as UCHAR
	IdSlotFlags2 as UCHAR
	MinorRevision as UCHAR
	MajorRevision as UCHAR
	Selections(0 to 26-1) as UCHAR
	FunctionFlags as UCHAR
	TypeString(0 to 80-1) as UCHAR
	EisaMemory(0 to 9-1) as EISA_MEMORY_CONFIGURATION
	EisaIrq(0 to 7-1) as EISA_IRQ_CONFIGURATION
	EisaDma(0 to 4-1) as EISA_DMA_CONFIGURATION
	EisaPort(0 to 20-1) as EISA_PORT_CONFIGURATION
	InitializationData(0 to 60-1) as UCHAR
end type

type CM_EISA_FUNCTION_INFORMATION as _CM_EISA_FUNCTION_INFORMATION
type PCM_EISA_FUNCTION_INFORMATION as _CM_EISA_FUNCTION_INFORMATION ptr

#define EISA_FUNCTION_ENABLED &h80
#define EISA_FREE_FORM_DATA &h40
#define EISA_HAS_PORT_INIT_ENTRY &h20
#define EISA_HAS_PORT_RANGE &h10
#define EISA_HAS_DMA_ENTRY &h08
#define EISA_HAS_IRQ_ENTRY &h04
#define EISA_HAS_MEMORY_ENTRY &h02
#define EISA_HAS_TYPE_ENTRY &h01
#define EISA_HAS_INFORMATION (&h10+&h08+&h04+&h02+&h01)

type _CM_EISA_SLOT_INFORMATION
	ReturnCode as UCHAR
	ReturnFlags as UCHAR
	MajorRevision as UCHAR
	MinorRevision as UCHAR
	Checksum as USHORT
	NumberFunctions as UCHAR
	FunctionInformation as UCHAR
	CompressedId as ULONG
end type

type CM_EISA_SLOT_INFORMATION as _CM_EISA_SLOT_INFORMATION
type PCM_EISA_SLOT_INFORMATION as _CM_EISA_SLOT_INFORMATION ptr

#define EISA_INVALID_SLOT &h80
#define EISA_INVALID_FUNCTION &h81
#define EISA_INVALID_CONFIGURATION &h82
#define EISA_EMPTY_SLOT &h83
#define EISA_INVALID_BIOS_CALL &h86

type _CM_FLOPPY_DEVICE_DATA
	Version as USHORT
	Revision as USHORT
	Size as zstring * 8
	MaxDensity as ULONG
	MountDensity as ULONG
	StepRateHeadUnloadTime as UCHAR
	HeadLoadTime as UCHAR
	MotorOffTime as UCHAR
	SectorLengthCode as UCHAR
	SectorPerTrack as UCHAR
	ReadWriteGapLength as UCHAR
	DataTransferLength as UCHAR
	FormatGapLength as UCHAR
	FormatFillCharacter as UCHAR
	HeadSettleTime as UCHAR
	MotorSettleTime as UCHAR
	MaximumTrackValue as UCHAR
	DataTransferRate as UCHAR
end type

type CM_FLOPPY_DEVICE_DATA as _CM_FLOPPY_DEVICE_DATA
type PCM_FLOPPY_DEVICE_DATA as _CM_FLOPPY_DEVICE_DATA ptr

enum _INTERFACE_TYPE
	InterfaceTypeUndefined = -1
	Internal
	Isa
	Eisa
	MicroChannel
	TurboChannel
	PCIBus
	VMEBus
	NuBus
	PCMCIABus
	CBus
	MPIBus
	MPSABus
	ProcessorInternal
	InternalPowerBus
	PNPISABus
	PNPBus
	MaximumInterfaceType
end enum

type INTERFACE_TYPE as _INTERFACE_TYPE
type PINTERFACE_TYPE as _INTERFACE_TYPE

type _PNP_BUS_INFORMATION
	BusTypeGuid as GUID
	LegacyBusType as INTERFACE_TYPE
	BusNumber as ULONG
end type

'#include once "win/ddk/pshpack1.bi"


type CM_PARTIAL_RESOURCE_DESCRIPTOR__u__DevicePrivate field = 1
	Data(0 to 3-1) as ULONG
end type

type CM_PARTIAL_RESOURCE_DESCRIPTOR__u__Dma field = 1
	Channel as ULONG
	Port as ULONG
	Reserved1 as ULONG
end type

type CM_PARTIAL_RESOURCE_DESCRIPTOR__u__Memory field = 1
	Start as PHYSICAL_ADDRESS
	Length as ULONG
end type

type CM_PARTIAL_RESOURCE_DESCRIPTOR__u__Interrupt field = 1
	Level as ULONG
	Vector as ULONG
	Affinity as ULONG
end type

type CM_PARTIAL_RESOURCE_DESCRIPTOR__u__Port field = 1
	Start as PHYSICAL_ADDRESS
	Length as ULONG
end type

type CM_PARTIAL_RESOURCE_DESCRIPTOR__u__Generic field = 1
	Start as PHYSICAL_ADDRESS
	Length as ULONG
end type

type CM_PARTIAL_RESOURCE_DESCRIPTOR__u__BusNumber field = 1
	Start as ULONG
	Length as ULONG
	Reserved as ULONG
end type

type CM_PARTIAL_RESOURCE_DESCRIPTOR_NESTED_DeviceSpecificData field = 1
	DataSize as ULONG
	Reserved1 as ULONG
	Reserved2 as ULONG
end type

union CM_PARTIAL_RESOURCE_DESCRIPTOR__u field = 1
	DeviceSpecificData as CM_PARTIAL_RESOURCE_DESCRIPTOR_NESTED_DeviceSpecificData
	BusNumber as CM_PARTIAL_RESOURCE_DESCRIPTOR__u__BusNumber
	DevicePrivate as CM_PARTIAL_RESOURCE_DESCRIPTOR__u__DevicePrivate
	Dma as CM_PARTIAL_RESOURCE_DESCRIPTOR__u__Dma
	Memory as CM_PARTIAL_RESOURCE_DESCRIPTOR__u__Memory
	Interrupt as CM_PARTIAL_RESOURCE_DESCRIPTOR__u__Interrupt
	Port as CM_PARTIAL_RESOURCE_DESCRIPTOR__u__Port
	Generic as CM_PARTIAL_RESOURCE_DESCRIPTOR__u__Generic
end union

type _CM_PARTIAL_RESOURCE_DESCRIPTOR field = 1
	Type as UCHAR
	ShareDisposition as UCHAR
	Flags as USHORT
	u as CM_PARTIAL_RESOURCE_DESCRIPTOR__u
end type

type PNP_BUS_INFORMATION as _PNP_BUS_INFORMATION
type PPNP_BUS_INFORMATION as _PNP_BUS_INFORMATION ptr
type CM_PARTIAL_RESOURCE_DESCRIPTOR as _CM_PARTIAL_RESOURCE_DESCRIPTOR
type PCM_PARTIAL_RESOURCE_DESCRIPTOR as _CM_PARTIAL_RESOURCE_DESCRIPTOR ptr






#define CmResourceTypeNull 0
#define CmResourceTypePort 1
#define CmResourceTypeInterrupt 2
#define CmResourceTypeMemory 3
#define CmResourceTypeDma 4
#define CmResourceTypeDeviceSpecific 5
#define CmResourceTypeBusNumber 6
#define CmResourceTypeMaximum 7
#define CmResourceTypeNonArbitrated 128
#define CmResourceTypeConfigData 128
#define CmResourceTypeDevicePrivate 129
#define CmResourceTypePcCardConfig 130
#define CmResourceTypeMfCardConfig 131

enum _CM_SHARE_DISPOSITION
	CmResourceShareUndetermined
	CmResourceShareDeviceExclusive
	CmResourceShareDriverExclusive
	CmResourceShareShared
end enum

type CM_SHARE_DISPOSITION as _CM_SHARE_DISPOSITION

#define CM_RESOURCE_PORT_MEMORY &h0000
#define CM_RESOURCE_PORT_IO &h0001
#define CM_RESOURCE_PORT_10_BIT_DECODE &h0004
#define CM_RESOURCE_PORT_12_BIT_DECODE &h0008
#define CM_RESOURCE_PORT_16_BIT_DECODE &h0010
#define CM_RESOURCE_PORT_POSITIVE_DECODE &h0020
#define CM_RESOURCE_PORT_PASSIVE_DECODE &h0040
#define CM_RESOURCE_PORT_WINDOW_DECODE &h0080
#define CM_RESOURCE_INTERRUPT_LEVEL_SENSITIVE &h0000
#define CM_RESOURCE_INTERRUPT_LATCHED &h0001
#define CM_RESOURCE_MEMORY_READ_WRITE &h0000
#define CM_RESOURCE_MEMORY_READ_ONLY &h0001
#define CM_RESOURCE_MEMORY_WRITE_ONLY &h0002
#define CM_RESOURCE_MEMORY_PREFETCHABLE &h0004
#define CM_RESOURCE_MEMORY_COMBINEDWRITE &h0008
#define CM_RESOURCE_MEMORY_24 &h0010
#define CM_RESOURCE_MEMORY_CACHEABLE &h0020
#define CM_RESOURCE_DMA_8 &h0000
#define CM_RESOURCE_DMA_16 &h0001
#define CM_RESOURCE_DMA_32 &h0002
#define CM_RESOURCE_DMA_8_AND_16 &h0004
#define CM_RESOURCE_DMA_BUS_MASTER &h0008
#define CM_RESOURCE_DMA_TYPE_A &h0010
#define CM_RESOURCE_DMA_TYPE_B &h0020
#define CM_RESOURCE_DMA_TYPE_F &h0040

type _CM_PARTIAL_RESOURCE_LIST field = 1
	Version as USHORT
	Revision as USHORT
	Count as ULONG
	PartialDescriptors(0 to 1-1) as CM_PARTIAL_RESOURCE_DESCRIPTOR
end type

type CM_PARTIAL_RESOURCE_LIST as _CM_PARTIAL_RESOURCE_LIST
type PCM_PARTIAL_RESOURCE_LIST as _CM_PARTIAL_RESOURCE_LIST ptr

type _CM_FULL_RESOURCE_DESCRIPTOR field = 1
	InterfaceType as INTERFACE_TYPE
	BusNumber as ULONG
	PartialResourceList as CM_PARTIAL_RESOURCE_LIST
end type

type CM_FULL_RESOURCE_DESCRIPTOR as _CM_FULL_RESOURCE_DESCRIPTOR
type PCM_FULL_RESOURCE_DESCRIPTOR as _CM_FULL_RESOURCE_DESCRIPTOR ptr

type _CM_RESOURCE_LIST field = 1
	Count as ULONG
	List(0 to 1-1) as CM_FULL_RESOURCE_DESCRIPTOR
end type

type CM_RESOURCE_LIST as _CM_RESOURCE_LIST
type PCM_RESOURCE_LIST as _CM_RESOURCE_LIST ptr

type _CM_INT13_DRIVE_PARAMETER field = 1
	DriveSelect as USHORT
	MaxCylinders as ULONG
	SectorsPerTrack as USHORT
	MaxHeads as USHORT
	NumberDrives as USHORT
end type

type CM_INT13_DRIVE_PARAMETER as _CM_INT13_DRIVE_PARAMETER
type PCM_INT13_DRIVE_PARAMETER as _CM_INT13_DRIVE_PARAMETER ptr

'#include once "win/ddk/poppack.bi"

type _CM_KEYBOARD_DEVICE_DATA
	Version as USHORT
	Revision as USHORT
	Type as UCHAR
	Subtype as UCHAR
	KeyboardFlags as USHORT
end type

type CM_KEYBOARD_DEVICE_DATA as _CM_KEYBOARD_DEVICE_DATA
type PCM_KEYBOARD_DEVICE_DATA as _CM_KEYBOARD_DEVICE_DATA ptr

#define KEYBOARD_INSERT_ON &h80
#define KEYBOARD_CAPS_LOCK_ON &h40
#define KEYBOARD_NUM_LOCK_ON &h20
#define KEYBOARD_SCROLL_LOCK_ON &h10
#define KEYBOARD_ALT_KEY_DOWN &h08
#define KEYBOARD_CTRL_KEY_DOWN &h04
#define KEYBOARD_LEFT_SHIFT_DOWN &h02
#define KEYBOARD_RIGHT_SHIFT_DOWN &h01

type _CM_MCA_POS_DATA
	AdapterId as USHORT
	PosData1 as UCHAR
	PosData2 as UCHAR
	PosData3 as UCHAR
	PosData4 as UCHAR
end type

type CM_MCA_POS_DATA as _CM_MCA_POS_DATA
type PCM_MCA_POS_DATA as _CM_MCA_POS_DATA ptr

type CM_Power_Data_s
	PD_Size as ULONG
	PD_MostRecentPowerState as DEVICE_POWER_STATE
	PD_Capabilities as ULONG
	PD_D1Latency as ULONG
	PD_D2Latency as ULONG
	PD_D3Latency as ULONG
	PD_PowerStateMapping(0 to PowerSystemMaximum-1) as DEVICE_POWER_STATE
end type

type CM_POWER_DATA as CM_Power_Data_s
type PCM_POWER_DATA as CM_Power_Data_s ptr

#define PDCAP_D0_SUPPORTED &h00000001
#define PDCAP_D1_SUPPORTED &h00000002
#define PDCAP_D2_SUPPORTED &h00000004
#define PDCAP_D3_SUPPORTED &h00000008
#define PDCAP_WAKE_FROM_D0_SUPPORTED &h00000010
#define PDCAP_WAKE_FROM_D1_SUPPORTED &h00000020
#define PDCAP_WAKE_FROM_D2_SUPPORTED &h00000040
#define PDCAP_WAKE_FROM_D3_SUPPORTED &h00000080
#define PDCAP_WARM_EJECT_SUPPORTED &h00000100

type _CM_SCSI_DEVICE_DATA
	Version as USHORT
	Revision as USHORT
	HostIdentifier as UCHAR
end type

type CM_SCSI_DEVICE_DATA as _CM_SCSI_DEVICE_DATA
type PCM_SCSI_DEVICE_DATA as _CM_SCSI_DEVICE_DATA ptr

type _CM_SERIAL_DEVICE_DATA
	Version as USHORT
	Revision as USHORT
	BaudClock as ULONG
end type

type CM_SERIAL_DEVICE_DATA as _CM_SERIAL_DEVICE_DATA
type PCM_SERIAL_DEVICE_DATA as _CM_SERIAL_DEVICE_DATA ptr

#define IO_RESOURCE_PREFERRED &h01
#define IO_RESOURCE_DEFAULT &h02
#define IO_RESOURCE_ALTERNATIVE &h08


type IO_RESOURCE_DESCRIPTOR__u__ConfigData
	Priority as ULONG
	Reserved1 as ULONG
	Reserved2 as ULONG
end type

type IO_RESOURCE_DESCRIPTOR__u__BusNumber
	Length as ULONG
	MinBusNumber as ULONG
	MaxBusNumber as ULONG
	Reserved as ULONG
end type

type IO_RESOURCE_DESCRIPTOR__u__DevicePrivate
	Data(0 to 3-1) as ULONG
end type

type IO_RESOURCE_DESCRIPTOR__u__Generic
	Length as ULONG
	Alignment as ULONG
	MinimumAddress as PHYSICAL_ADDRESS
	MaximumAddress as PHYSICAL_ADDRESS
end type

type IO_RESOURCE_DESCRIPTOR__u__Dma
	MinimumChannel as ULONG
	MaximumChannel as ULONG
end type

type IO_RESOURCE_DESCRIPTOR__u__Interrupt
	MinimumVector as ULONG
	MaximumVector as ULONG
end type

type IO_RESOURCE_DESCRIPTOR__u__Memory
	Length as ULONG
	Alignment as ULONG
	MinimumAddress as PHYSICAL_ADDRESS
	MaximumAddress as PHYSICAL_ADDRESS
end type

type IO_RESOURCE_DESCRIPTOR__u__Port
	Length as ULONG
	Alignment as ULONG
	MinimumAddress as PHYSICAL_ADDRESS
	MaximumAddress as PHYSICAL_ADDRESS
end type

union IO_RESOURCE_DESCRIPTOR__u
	ConfigData as IO_RESOURCE_DESCRIPTOR__u__ConfigData
	BusNumber as IO_RESOURCE_DESCRIPTOR__u__BusNumber
	DevicePrivate as IO_RESOURCE_DESCRIPTOR__u__DevicePrivate
	Generic as IO_RESOURCE_DESCRIPTOR__u__Generic
	Dma as IO_RESOURCE_DESCRIPTOR__u__Dma
	Interrupt as IO_RESOURCE_DESCRIPTOR__u__Interrupt
	Memory as IO_RESOURCE_DESCRIPTOR__u__Memory
	Port as IO_RESOURCE_DESCRIPTOR__u__Port
end union

type _IO_RESOURCE_DESCRIPTOR
	Option as UCHAR
	Type as UCHAR
	ShareDisposition as UCHAR
	Spare1 as UCHAR
	Flags as USHORT
	Spare2 as USHORT
	u as IO_RESOURCE_DESCRIPTOR__u
end type

type IO_RESOURCE_DESCRIPTOR as _IO_RESOURCE_DESCRIPTOR
type PIO_RESOURCE_DESCRIPTOR as _IO_RESOURCE_DESCRIPTOR ptr




type _IO_RESOURCE_LIST
	Version as USHORT
	Revision as USHORT
	Count as ULONG
	Descriptors(0 to 1-1) as IO_RESOURCE_DESCRIPTOR
end type

type IO_RESOURCE_LIST as _IO_RESOURCE_LIST
type PIO_RESOURCE_LIST as _IO_RESOURCE_LIST ptr

type _IO_RESOURCE_REQUIREMENTS_LIST
	ListSize as ULONG
	InterfaceType as INTERFACE_TYPE
	BusNumber as ULONG
	SlotNumber as ULONG
	Reserved(0 to 3-1) as ULONG
	AlternativeLists as ULONG
	List(0 to 1-1) as IO_RESOURCE_LIST
end type

type IO_RESOURCE_REQUIREMENTS_LIST as _IO_RESOURCE_REQUIREMENTS_LIST
type PIO_RESOURCE_REQUIREMENTS_LIST as _IO_RESOURCE_REQUIREMENTS_LIST ptr

type _CONTROLLER_OBJECT
	Type as _CSHORT
	Size as _CSHORT
	ControllerExtension as PVOID
	DeviceWaitQueue as KDEVICE_QUEUE
	Spare1 as ULONG
	Spare2 as LARGE_INTEGER
end type

type CONTROLLER_OBJECT as _CONTROLLER_OBJECT
type PCONTROLLER_OBJECT as _CONTROLLER_OBJECT ptr

enum _DMA_WIDTH
	Width8Bits
	Width16Bits
	Width32Bits
	MaximumDmaWidth
end enum

type DMA_WIDTH as _DMA_WIDTH
type PDMA_WIDTH as _DMA_WIDTH

enum _DMA_SPEED
	Compatible
	TypeA
	TypeB
	TypeC
	TypeF
	MaximumDmaSpeed
end enum

type DMA_SPEED as _DMA_SPEED
type PDMA_SPEED as _DMA_SPEED

#define DEVICE_DESCRIPTION_VERSION &h0000
#define DEVICE_DESCRIPTION_VERSION1 &h0001
#define DEVICE_DESCRIPTION_VERSION2 &h0002

type _DEVICE_DESCRIPTION
	Version as ULONG
	Master as BOOLEAN
	ScatterGather as BOOLEAN
	DemandMode as BOOLEAN
	AutoInitialize as BOOLEAN
	Dma32BitAddresses as BOOLEAN
	IgnoreCount as BOOLEAN
	Reserved1 as BOOLEAN
	Dma64BitAddresses as BOOLEAN
	BusNumber as ULONG
	DmaChannel as ULONG
	InterfaceType as INTERFACE_TYPE
	DmaWidth as DMA_WIDTH
	DmaSpeed as DMA_SPEED
	MaximumLength as ULONG
	DmaPort as ULONG
end type

#define VPB_MOUNTED &h0001
#define VPB_LOCKED &h0002
#define VPB_PERSISTENT &h0004
#define VPB_REMOVE_PENDING &h0008
#define VPB_RAW_MOUNT &h0010

type _VPB
	Type as _CSHORT
	Size as _CSHORT
	Flags as USHORT
	VolumeLabelLength as USHORT
	DeviceObject as PDEVICE_OBJECT
	RealDevice as PDEVICE_OBJECT
	SerialNumber as ULONG
	ReferenceCount as ULONG
	VolumeLabel(0 to (32*sizeof(WCHAR))/sizeof(WCHAR)-1) as WCHAR
end type

type VPB as _VPB
type PVPB as _VPB ptr

#define DO_VERIFY_VOLUME &h00000002
#define DO_BUFFERED_IO &h00000004
#define DO_EXCLUSIVE &h00000008
#define DO_DIRECT_IO &h00000010
#define DO_MAP_IO_BUFFER &h00000020
#define DO_DEVICE_HAS_NAME &h00000040
#define DO_DEVICE_INITIALIZING &h00000080
#define DO_SYSTEM_BOOT_PARTITION &h00000100
#define DO_LONG_TERM_REQUESTS &h00000200
#define DO_NEVER_LAST_DEVICE &h00000400
#define DO_SHUTDOWN_REGISTERED &h00000800
#define DO_BUS_ENUMERATED_DEVICE &h00001000
#define DO_POWER_PAGABLE &h00002000
#define DO_POWER_INRUSH &h00004000
#define DO_LOW_PRIORITY_FILESYSTEM &h00010000
#define FILE_REMOVABLE_MEDIA &h00000001
#define FILE_READ_ONLY_DEVICE &h00000002
#define FILE_FLOPPY_DISKETTE &h00000004
#define FILE_WRITE_ONCE_MEDIA &h00000008
#define FILE_REMOTE_DEVICE &h00000010
#define FILE_DEVICE_IS_MOUNTED &h00000020
#define FILE_VIRTUAL_VOLUME &h00000040
#define FILE_AUTOGENERATED_DEVICE_NAME &h00000080
#define FILE_DEVICE_SECURE_OPEN &h00000100
#define FILE_BYTE_ALIGNMENT &h00000000
#define FILE_WORD_ALIGNMENT &h00000001
#define FILE_LONG_ALIGNMENT &h00000003
#define FILE_QUAD_ALIGNMENT &h00000007
#define FILE_OCTA_ALIGNMENT &h0000000f
#define FILE_32_BYTE_ALIGNMENT &h0000001f
#define FILE_64_BYTE_ALIGNMENT &h0000003f
#define FILE_128_BYTE_ALIGNMENT &h0000007f
#define FILE_256_BYTE_ALIGNMENT &h000000ff
#define FILE_512_BYTE_ALIGNMENT &h000001ff
#define FILE_DEVICE_BEEP &h00000001
#define FILE_DEVICE_CD_ROM &h00000002
#define FILE_DEVICE_CD_ROM_FILE_SYSTEM &h00000003
#define FILE_DEVICE_CONTROLLER &h00000004
#define FILE_DEVICE_DATALINK &h00000005
#define FILE_DEVICE_DFS &h00000006
#define FILE_DEVICE_DISK &h00000007
#define FILE_DEVICE_DISK_FILE_SYSTEM &h00000008
#define FILE_DEVICE_FILE_SYSTEM &h00000009
#define FILE_DEVICE_INPORT_PORT &h0000000a
#define FILE_DEVICE_KEYBOARD &h000000&b
#define FILE_DEVICE_MAILSLOT &h0000000c
#define FILE_DEVICE_MIDI_IN &h0000000d
#define FILE_DEVICE_MIDI_OUT &h0000000e
#define FILE_DEVICE_MOUSE &h0000000f
#define FILE_DEVICE_MULTI_UNC_PROVIDER &h00000010
#define FILE_DEVICE_NAMED_PIPE &h00000011
#define FILE_DEVICE_NETWORK &h00000012
#define FILE_DEVICE_NETWORK_BROWSER &h00000013
#define FILE_DEVICE_NETWORK_FILE_SYSTEM &h00000014
#define FILE_DEVICE_NULL &h00000015
#define FILE_DEVICE_PARALLEL_PORT &h00000016
#define FILE_DEVICE_PHYSICAL_NETCARD &h00000017
#define FILE_DEVICE_PRINTER &h00000018
#define FILE_DEVICE_SCANNER &h00000019
#define FILE_DEVICE_SERIAL_MOUSE_PORT &h0000001a
#define FILE_DEVICE_SERIAL_PORT &h0000001b
#define FILE_DEVICE_SCREEN &h0000001c
#define FILE_DEVICE_SOUND &h0000001d
#define FILE_DEVICE_STREAMS &h0000001e
#define FILE_DEVICE_TAPE &h0000001f
#define FILE_DEVICE_TAPE_FILE_SYSTEM &h00000020
#define FILE_DEVICE_TRANSPORT &h00000021
#define FILE_DEVICE_UNKNOWN &h00000022
#define FILE_DEVICE_VIDEO &h00000023
#define FILE_DEVICE_VIRTUAL_DISK &h00000024
#define FILE_DEVICE_WAVE_IN &h00000025
#define FILE_DEVICE_WAVE_OUT &h00000026
#define FILE_DEVICE_8042_PORT &h00000027
#define FILE_DEVICE_NETWORK_REDIRECTOR &h00000028
#define FILE_DEVICE_BATTERY &h00000029
#define FILE_DEVICE_BUS_EXTENDER &h0000002a
#define FILE_DEVICE_MODEM &h0000002b
#define FILE_DEVICE_VDM &h0000002c
#define FILE_DEVICE_MASS_STORAGE &h0000002d
#define FILE_DEVICE_SMB &h0000002e
#define FILE_DEVICE_KS &h0000002f
#define FILE_DEVICE_CHANGER &h00000030
#define FILE_DEVICE_SMARTCARD &h00000031
#define FILE_DEVICE_ACPI &h00000032
#define FILE_DEVICE_DVD &h00000033
#define FILE_DEVICE_FULLSCREEN_VIDEO &h00000034
#define FILE_DEVICE_DFS_FILE_SYSTEM &h00000035
#define FILE_DEVICE_DFS_VOLUME &h00000036
#define FILE_DEVICE_SERENUM &h00000037
#define FILE_DEVICE_TERMSRV &h00000038
#define FILE_DEVICE_KSEC &h00000039
#define FILE_DEVICE_FIPS &h0000003a

union DEVICE_OBJECT__Queue
	ListEntry as LIST_ENTRY
	Wcb as WAIT_CONTEXT_BLOCK
end union

type _DEVICE_OBJECT
	Type as _CSHORT
	Size as USHORT
	ReferenceCount as LONG
	DriverObject as PDRIVER_OBJECT
	NextDevice as PDEVICE_OBJECT
	AttachedDevice as PDEVICE_OBJECT
	CurrentIrp as PIRP
	Timer as PIO_TIMER
	Flags as ULONG
	Characteristics as ULONG
	Vpb as PVPB
	DeviceExtension as PVOID
	DeviceType as ULONG
	StackSize as CCHAR
	AlignmentRequirement as ULONG
	DeviceQueue as KDEVICE_QUEUE
	Dpc as KDPC
	ActiveThreadCount as ULONG
	SecurityDescriptor as PSECURITY_DESCRIPTOR
	DeviceLock as KEVENT
	SectorSize as USHORT
	Spare1 as USHORT
	DeviceObjectExtension as PDEVOBJ_EXTENSION
	Reserved as PVOID
	Queue as DEVICE_OBJECT__Queue
end type





enum _DEVICE_RELATION_TYPE
	BusRelations
	EjectionRelations
	PowerRelations
	RemovalRelations
	TargetDeviceRelation
	SingleBusRelations
end enum

type DEVICE_RELATION_TYPE as _DEVICE_RELATION_TYPE
type PDEVICE_RELATION_TYPE as _DEVICE_RELATION_TYPE

type _DEVICE_RELATIONS
	Count as ULONG
	Objects(0 to 1-1) as PDEVICE_OBJECT
end type

type DEVICE_RELATIONS as _DEVICE_RELATIONS
type PDEVICE_RELATIONS as _DEVICE_RELATIONS ptr

type _SCATTER_GATHER_ELEMENT
	Address as PHYSICAL_ADDRESS
	Length as ULONG
	Reserved as ULONG_PTR
end type

type _SCATTER_GATHER_LIST
	NumberOfElements as ULONG
	Reserved as ULONG_PTR
	Elements(0 to 0) as SCATTER_GATHER_ELEMENT
end type

type _MDL
	Next as PMDL
	Size as _CSHORT
	MdlFlags as _CSHORT
	Process as PEPROCESS
	MappedSystemVa as PVOID
	StartVa as PVOID
	ByteCount as ULONG
	ByteOffset as ULONG
end type

#define MDL_MAPPED_TO_SYSTEM_VA &h0001
#define MDL_PAGES_LOCKED &h0002
#define MDL_SOURCE_IS_NONPAGED_POOL &h0004
#define MDL_ALLOCATED_FIXED_SIZE &h0008
#define MDL_PARTIAL &h0010
#define MDL_PARTIAL_HAS_BEEN_MAPPED &h0020
#define MDL_IO_PAGE_READ &h0040
#define MDL_WRITE_OPERATION &h0080
#define MDL_PARENT_MAPPED_SYSTEM_VA &h0100
#define MDL_FREE_EXTRA_PTES &h0200
#define MDL_IO_SPACE &h0800
#define MDL_NETWORK_HEADER &h1000
#define MDL_MAPPING_CAN_FAIL &h2000
#define MDL_ALLOCATED_MUST_SUCCEED &h4000

type PPUT_DMA_ADAPTER as sub DDKAPI(byval as PDMA_ADAPTER)
type PALLOCATE_COMMON_BUFFER as function DDKAPI(byval as PDMA_ADAPTER, byval as ULONG, byval as PPHYSICAL_ADDRESS, byval as BOOLEAN) as PVOID
type PFREE_COMMON_BUFFER as sub DDKAPI(byval as PDMA_ADAPTER, byval as ULONG, byval as PHYSICAL_ADDRESS, byval as PVOID, byval as BOOLEAN)
type PALLOCATE_ADAPTER_CHANNEL as function DDKAPI(byval as PDMA_ADAPTER, byval as PDEVICE_OBJECT, byval as ULONG, byval as PDRIVER_CONTROL, byval as PVOID) as NTSTATUS
type PFLUSH_ADAPTER_BUFFERS as function DDKAPI(byval as PDMA_ADAPTER, byval as PMDL, byval as PVOID, byval as PVOID, byval as ULONG, byval as BOOLEAN) as BOOLEAN
type PFREE_ADAPTER_CHANNEL as sub DDKAPI(byval as PDMA_ADAPTER)
type PFREE_MAP_REGISTERS as sub DDKAPI(byval as PDMA_ADAPTER, byval as PVOID, byval as ULONG)
type PMAP_TRANSFER as function DDKAPI(byval as PDMA_ADAPTER, byval as PMDL, byval as PVOID, byval as PVOID, byval as PULONG, byval as BOOLEAN) as PHYSICAL_ADDRESS
type PGET_DMA_ALIGNMENT as function DDKAPI(byval as PDMA_ADAPTER) as ULONG
type PREAD_DMA_COUNTER as function DDKAPI(byval as PDMA_ADAPTER) as ULONG
type PGET_SCATTER_GATHER_LIST as function DDKAPI(byval as PDMA_ADAPTER, byval as PDEVICE_OBJECT, byval as PMDL, byval as PVOID, byval as ULONG, byval as PDRIVER_LIST_CONTROL, byval as PVOID, byval as BOOLEAN) as NTSTATUS
type PPUT_SCATTER_GATHER_LIST as sub DDKAPI(byval as PDMA_ADAPTER, byval as PSCATTER_GATHER_LIST, byval as BOOLEAN)
type PCALCULATE_SCATTER_GATHER_LIST_SIZE as function DDKAPI(byval as PDMA_ADAPTER, byval as PMDL, byval as PVOID, byval as ULONG, byval as PULONG, byval as PULONG) as NTSTATUS
type PBUILD_SCATTER_GATHER_LIST as function DDKAPI(byval as PDMA_ADAPTER, byval as PDEVICE_OBJECT, byval as PMDL, byval as PVOID, byval as ULONG, byval as PDRIVER_LIST_CONTROL, byval as PVOID, byval as BOOLEAN, byval as PVOID, byval as ULONG) as NTSTATUS
type PBUILD_MDL_FROM_SCATTER_GATHER_LIST as function DDKAPI(byval as PDMA_ADAPTER, byval as PSCATTER_GATHER_LIST, byval as PMDL, byval as PMDL ptr) as NTSTATUS

type _DMA_OPERATIONS
	Size as ULONG
	PutDmaAdapter as PPUT_DMA_ADAPTER
	AllocateCommonBuffer as PALLOCATE_COMMON_BUFFER
	FreeCommonBuffer as PFREE_COMMON_BUFFER
	AllocateAdapterChannel as PALLOCATE_ADAPTER_CHANNEL
	FlushAdapterBuffers as PFLUSH_ADAPTER_BUFFERS
	FreeAdapterChannel as PFREE_ADAPTER_CHANNEL
	FreeMapRegisters as PFREE_MAP_REGISTERS
	MapTransfer as PMAP_TRANSFER
	GetDmaAlignment as PGET_DMA_ALIGNMENT
	ReadDmaCounter as PREAD_DMA_COUNTER
	GetScatterGatherList as PGET_SCATTER_GATHER_LIST
	PutScatterGatherList as PPUT_SCATTER_GATHER_LIST
	CalculateScatterGatherList as PCALCULATE_SCATTER_GATHER_LIST_SIZE
	BuildScatterGatherList as PBUILD_SCATTER_GATHER_LIST
	BuildMdlFromScatterGatherList as PBUILD_MDL_FROM_SCATTER_GATHER_LIST
end type

type DMA_OPERATIONS as _DMA_OPERATIONS
type PDMA_OPERATIONS as _DMA_OPERATIONS ptr

type _DMA_ADAPTER
	Version as USHORT
	Size as USHORT
	DmaOperations as PDMA_OPERATIONS
end type

type DMA_ADAPTER as _DMA_ADAPTER

enum _FILE_INFORMATION_CLASS
	FileDirectoryInformation = 1
	FileFullDirectoryInformation
	FileBothDirectoryInformation
	FileBasicInformation
	FileStandardInformation
	FileInternalInformation
	FileEaInformation
	FileAccessInformation
	FileNameInformation
	FileRenameInformation
	FileLinkInformation
	FileNamesInformation
	FileDispositionInformation
	FilePositionInformation
	FileFullEaInformation
	FileModeInformation
	FileAlignmentInformation
	FileAllInformation
	FileAllocationInformation
	FileEndOfFileInformation
	FileAlternateNameInformation
	FileStreamInformation
	FilePipeInformation
	FilePipeLocalInformation
	FilePipeRemoteInformation
	FileMailslotQueryInformation
	FileMailslotSetInformation
	FileCompressionInformation
	FileObjectIdInformation
	FileCompletionInformation
	FileMoveClusterInformation
	FileQuotaInformation
	FileReparsePointInformation
	FileNetworkOpenInformation
	FileAttributeTagInformation
	FileTrackingInformation
	FileIdBothDirectoryInformation
	FileIdFullDirectoryInformation
	FileValidDataLengthInformation
	FileShortNameInformation
	FileMaximumInformation
end enum

type FILE_INFORMATION_CLASS as _FILE_INFORMATION_CLASS
type PFILE_INFORMATION_CLASS as _FILE_INFORMATION_CLASS

type _FILE_POSITION_INFORMATION
	CurrentByteOffset as LARGE_INTEGER
end type

type FILE_POSITION_INFORMATION as _FILE_POSITION_INFORMATION
type PFILE_POSITION_INFORMATION as _FILE_POSITION_INFORMATION ptr

type _FILE_ALIGNMENT_INFORMATION
	AlignmentRequirement as ULONG
end type

type FILE_ALIGNMENT_INFORMATION as _FILE_ALIGNMENT_INFORMATION

type _FILE_NAME_INFORMATION
	FileNameLength as ULONG
	FileName(0 to 1-1) as WCHAR
end type

type FILE_NAME_INFORMATION as _FILE_NAME_INFORMATION
type PFILE_NAME_INFORMATION as _FILE_NAME_INFORMATION ptr

type _FILE_BASIC_INFORMATION
	CreationTime as LARGE_INTEGER
	LastAccessTime as LARGE_INTEGER
	LastWriteTime as LARGE_INTEGER
	ChangeTime as LARGE_INTEGER
	FileAttributes as ULONG
end type

type FILE_BASIC_INFORMATION as _FILE_BASIC_INFORMATION
type PFILE_BASIC_INFORMATION as _FILE_BASIC_INFORMATION ptr

type _FILE_STANDARD_INFORMATION
	AllocationSize as LARGE_INTEGER
	EndOfFile as LARGE_INTEGER
	NumberOfLinks as ULONG
	DeletePending as BOOLEAN
	Directory as BOOLEAN
end type

type FILE_STANDARD_INFORMATION as _FILE_STANDARD_INFORMATION
type PFILE_STANDARD_INFORMATION as _FILE_STANDARD_INFORMATION ptr

type _FILE_NETWORK_OPEN_INFORMATION
	CreationTime as LARGE_INTEGER
	LastAccessTime as LARGE_INTEGER
	LastWriteTime as LARGE_INTEGER
	ChangeTime as LARGE_INTEGER
	AllocationSize as LARGE_INTEGER
	EndOfFile as LARGE_INTEGER
	FileAttributes as ULONG
end type

type FILE_NETWORK_OPEN_INFORMATION as _FILE_NETWORK_OPEN_INFORMATION
type PFILE_NETWORK_OPEN_INFORMATION as _FILE_NETWORK_OPEN_INFORMATION ptr

type _FILE_ATTRIBUTE_TAG_INFORMATION
	FileAttributes as ULONG
	ReparseTag as ULONG
end type

type FILE_ATTRIBUTE_TAG_INFORMATION as _FILE_ATTRIBUTE_TAG_INFORMATION
type PFILE_ATTRIBUTE_TAG_INFORMATION as _FILE_ATTRIBUTE_TAG_INFORMATION ptr

type _FILE_DISPOSITION_INFORMATION
	DoDeleteFile as BOOLEAN
end type

type FILE_DISPOSITION_INFORMATION as _FILE_DISPOSITION_INFORMATION
type PFILE_DISPOSITION_INFORMATION as _FILE_DISPOSITION_INFORMATION ptr

type _FILE_END_OF_FILE_INFORMATION
	EndOfFile as LARGE_INTEGER
end type

type FILE_END_OF_FILE_INFORMATION as _FILE_END_OF_FILE_INFORMATION
type PFILE_END_OF_FILE_INFORMATION as _FILE_END_OF_FILE_INFORMATION ptr

type _FILE_VALID_DATA_LENGTH_INFORMATION
	ValidDataLength as LARGE_INTEGER
end type

type FILE_VALID_DATA_LENGTH_INFORMATION as _FILE_VALID_DATA_LENGTH_INFORMATION
type PFILE_VALID_DATA_LENGTH_INFORMATION as _FILE_VALID_DATA_LENGTH_INFORMATION ptr

enum _FSINFOCLASS
	FileFsVolumeInformation = 1
	FileFsLabelInformation
	FileFsSizeInformation
	FileFsDeviceInformation
	FileFsAttributeInformation
	FileFsControlInformation
	FileFsFullSizeInformation
	FileFsObjectIdInformation
	FileFsDriverPathInformation
	FileFsMaximumInformation
end enum

type FS_INFORMATION_CLASS as _FSINFOCLASS
type PFS_INFORMATION_CLASS as _FSINFOCLASS

type _FILE_FS_DEVICE_INFORMATION
	DeviceType as ULONG
	Characteristics as ULONG
end type

type FILE_FS_DEVICE_INFORMATION as _FILE_FS_DEVICE_INFORMATION
type PFILE_FS_DEVICE_INFORMATION as _FILE_FS_DEVICE_INFORMATION ptr

type _FILE_FULL_EA_INFORMATION
	NextEntryOffset as ULONG
	Flags as UCHAR
	EaNameLength as UCHAR
	EaValueLength as USHORT
	EaName as zstring * 1
end type

type FILE_FULL_EA_INFORMATION as _FILE_FULL_EA_INFORMATION
type PFILE_FULL_EA_INFORMATION as _FILE_FULL_EA_INFORMATION ptr
type ERESOURCE_THREAD as ULONG_PTR
type PERESOURCE_THREAD as ERESOURCE_THREAD ptr

union OWNER_ENTRY__u
	OwnerCount as LONG
	TableSize as ULONG
end union

type _OWNER_ENTRY
	OwnerThread as ERESOURCE_THREAD
	u as OWNER_ENTRY__u
end type

type OWNER_ENTRY as _OWNER_ENTRY
type POWNER_ENTRY as _OWNER_ENTRY ptr



#define ResourceNeverExclusive &h0010
#define ResourceReleaseByOtherThread &h0020
#define ResourceOwnedExclusive &h0080
#define RESOURCE_HASH_TABLE_SIZE 64


union ERESOURCE__u
	Address as PVOID
	CreatorBackTraceIndex as ULONG_PTR
end union


type _ERESOURCE
	SystemResourcesList as LIST_ENTRY
	OwnerTable as POWNER_ENTRY
	ActiveCount as SHORT
	Flag as USHORT
	SharedWaiters as PKSEMAPHORE
	ExclusiveWaiters as PKEVENT
	OwnerThreads(0 to 2-1) as OWNER_ENTRY
	ContentionCount as ULONG
	NumberOfSharedWaiters as USHORT
	NumberOfExclusiveWaiters as USHORT
	SpinLock as KSPIN_LOCK
	u as ERESOURCE__u
end type

type ERESOURCE as _ERESOURCE
type PERESOURCE as _ERESOURCE ptr


type _DRIVER_EXTENSION
	DriverObject as PDRIVER_OBJECT
	AddDevice as PVOID
	Count as ULONG
	ServiceKeyName as UNICODE_STRING
end type

type DRIVER_EXTENSION as _DRIVER_EXTENSION
type PDRIVER_EXTENSION as _DRIVER_EXTENSION ptr
type PFAST_IO_CHECK_IF_POSSIBLE as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as ULONG, byval as BOOLEAN, byval as ULONG, byval as BOOLEAN, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_READ as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as ULONG, byval as BOOLEAN, byval as ULONG, byval as PVOID, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_WRITE as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as ULONG, byval as BOOLEAN, byval as ULONG, byval as PVOID, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_QUERY_BASIC_INFO as function DDKAPI(byval as PFILE_OBJECT, byval as BOOLEAN, byval as PFILE_BASIC_INFORMATION, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_QUERY_STANDARD_INFO as function DDKAPI(byval as PFILE_OBJECT, byval as BOOLEAN, byval as PFILE_STANDARD_INFORMATION, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_LOCK as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as PLARGE_INTEGER, byval as PEPROCESS, byval as ULONG, byval as BOOLEAN, byval as BOOLEAN, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_UNLOCK_SINGLE as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as PLARGE_INTEGER, byval as PEPROCESS, byval as ULONG, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_UNLOCK_ALL as function DDKAPI(byval as PFILE_OBJECT, byval as PEPROCESS, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_UNLOCK_ALL_BY_KEY as function DDKAPI(byval as PFILE_OBJECT, byval as PVOID, byval as ULONG, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_DEVICE_CONTROL as function DDKAPI(byval as PFILE_OBJECT, byval as BOOLEAN, byval as PVOID, byval as ULONG, byval as PVOID, byval as ULONG, byval as ULONG, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_ACQUIRE_FILE as sub DDKAPI(byval as PFILE_OBJECT)
type PFAST_IO_RELEASE_FILE as sub DDKAPI(byval as PFILE_OBJECT)
type PFAST_IO_DETACH_DEVICE as sub DDKAPI(byval as PDEVICE_OBJECT, byval as PDEVICE_OBJECT)
type PFAST_IO_QUERY_NETWORK_OPEN_INFO as function DDKAPI(byval as PFILE_OBJECT, byval as BOOLEAN, byval as _FILE_NETWORK_OPEN_INFORMATION ptr, byval as _IO_STATUS_BLOCK ptr, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_ACQUIRE_FOR_MOD_WRITE as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as _ERESOURCE ptr ptr, byval as PDEVICE_OBJECT) as NTSTATUS
type PFAST_IO_MDL_READ as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as ULONG, byval as ULONG, byval as PMDL ptr, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_MDL_READ_COMPLETE as function DDKAPI(byval as PFILE_OBJECT, byval as PMDL, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_PREPARE_MDL_WRITE as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as ULONG, byval as ULONG, byval as PMDL ptr, byval as PIO_STATUS_BLOCK, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_MDL_WRITE_COMPLETE as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as PMDL, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_READ_COMPRESSED as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as ULONG, byval as ULONG, byval as PVOID, byval as PMDL ptr, byval as PIO_STATUS_BLOCK, byval as PCOMPRESSED_DATA_INFO, byval as ULONG, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_WRITE_COMPRESSED as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as ULONG, byval as ULONG, byval as PVOID, byval as PMDL ptr, byval as PIO_STATUS_BLOCK, byval as PCOMPRESSED_DATA_INFO, byval as ULONG, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_MDL_READ_COMPLETE_COMPRESSED as function DDKAPI(byval as PFILE_OBJECT, byval as PMDL, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_MDL_WRITE_COMPLETE_COMPRESSED as function DDKAPI(byval as PFILE_OBJECT, byval as PLARGE_INTEGER, byval as PMDL, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_QUERY_OPEN as function DDKAPI(byval as PIRP, byval as PFILE_NETWORK_OPEN_INFORMATION, byval as PDEVICE_OBJECT) as BOOLEAN
type PFAST_IO_RELEASE_FOR_MOD_WRITE as function DDKAPI(byval as PFILE_OBJECT, byval as _ERESOURCE ptr, byval as PDEVICE_OBJECT) as NTSTATUS
type PFAST_IO_ACQUIRE_FOR_CCFLUSH as function DDKAPI(byval as PFILE_OBJECT, byval as PDEVICE_OBJECT) as NTSTATUS
type PFAST_IO_RELEASE_FOR_CCFLUSH as function DDKAPI(byval as PFILE_OBJECT, byval as PDEVICE_OBJECT) as NTSTATUS

type _FAST_IO_DISPATCH
	SizeOfFastIoDispatch as ULONG
	FastIoCheckIfPossible as PFAST_IO_CHECK_IF_POSSIBLE
	FastIoRead as PFAST_IO_READ
	FastIoWrite as PFAST_IO_WRITE
	FastIoQueryBasicInfo as PFAST_IO_QUERY_BASIC_INFO
	FastIoQueryStandardInfo as PFAST_IO_QUERY_STANDARD_INFO
	FastIoLock as PFAST_IO_LOCK
	FastIoUnlockSingle as PFAST_IO_UNLOCK_SINGLE
	FastIoUnlockAll as PFAST_IO_UNLOCK_ALL
	FastIoUnlockAllByKey as PFAST_IO_UNLOCK_ALL_BY_KEY
	FastIoDeviceControl as PFAST_IO_DEVICE_CONTROL
	AcquireFileForNtCreateSection as PFAST_IO_ACQUIRE_FILE
	ReleaseFileForNtCreateSection as PFAST_IO_RELEASE_FILE
	FastIoDetachDevice as PFAST_IO_DETACH_DEVICE
	FastIoQueryNetworkOpenInfo as PFAST_IO_QUERY_NETWORK_OPEN_INFO
	AcquireForModWrite as PFAST_IO_ACQUIRE_FOR_MOD_WRITE
	MdlRead as PFAST_IO_MDL_READ
	MdlReadComplete as PFAST_IO_MDL_READ_COMPLETE
	PrepareMdlWrite as PFAST_IO_PREPARE_MDL_WRITE
	MdlWriteComplete as PFAST_IO_MDL_WRITE_COMPLETE
	FastIoReadCompressed as PFAST_IO_READ_COMPRESSED
	FastIoWriteCompressed as PFAST_IO_WRITE_COMPRESSED
	MdlReadCompleteCompressed as PFAST_IO_MDL_READ_COMPLETE_COMPRESSED
	MdlWriteCompleteCompressed as PFAST_IO_MDL_WRITE_COMPLETE_COMPRESSED
	FastIoQueryOpen as PFAST_IO_QUERY_OPEN
	ReleaseForModWrite as PFAST_IO_RELEASE_FOR_MOD_WRITE
	AcquireForCcFlush as PFAST_IO_ACQUIRE_FOR_CCFLUSH
	ReleaseForCcFlush as PFAST_IO_RELEASE_FOR_CCFLUSH
end type

type FAST_IO_DISPATCH as _FAST_IO_DISPATCH
type PFAST_IO_DISPATCH as _FAST_IO_DISPATCH ptr

type _DRIVER_OBJECT
	Type as _CSHORT
	Size as _CSHORT
	DeviceObject as PDEVICE_OBJECT
	Flags as ULONG
	DriverStart as PVOID
	DriverSize as ULONG
	DriverSection as PVOID
	DriverExtension as PDRIVER_EXTENSION
	DriverName as UNICODE_STRING
	HardwareDatabase as PUNICODE_STRING
	FastIoDispatch as PFAST_IO_DISPATCH
	DriverInit as PDRIVER_INITIALIZE
	DriverStartIo as PDRIVER_STARTIO
	DriverUnload as PDRIVER_UNLOAD
	MajorFunction(0 to &H1b+1-1) as PDRIVER_DISPATCH
end type

type _SECTION_OBJECT_POINTERS
	DataSectionObject as PVOID
	SharedCacheMap as PVOID
	ImageSectionObject as PVOID
end type

type SECTION_OBJECT_POINTERS as _SECTION_OBJECT_POINTERS
type PSECTION_OBJECT_POINTERS as _SECTION_OBJECT_POINTERS ptr

type _IO_COMPLETION_CONTEXT
	Port as PVOID
	Key as PVOID
end type

type IO_COMPLETION_CONTEXT as _IO_COMPLETION_CONTEXT
type PIO_COMPLETION_CONTEXT as _IO_COMPLETION_CONTEXT ptr

#define FO_FILE_OPEN &h00000001
#define FO_SYNCHRONOUS_IO &h00000002
#define FO_ALERTABLE_IO &h00000004
#define FO_NO_INTERMEDIATE_BUFFERING &h00000008
#define FO_WRITE_THROUGH &h00000010
#define FO_SEQUENTIAL_ONLY &h00000020
#define FO_CACHE_SUPPORTED &h00000040
#define FO_NAMED_PIPE &h00000080
#define FO_STREAM_FILE &h00000100
#define FO_MAILSLOT &h00000200
#define FO_GENERATE_AUDIT_ON_CLOSE &h00000400
#define FO_DIRECT_DEVICE_OPEN &h00000800
#define FO_FILE_MODIFIED &h00001000
#define FO_FILE_SIZE_CHANGED &h00002000
#define FO_CLEANUP_COMPLETE &h00004000
#define FO_TEMPORARY_FILE &h00008000
#define FO_DELETE_ON_CLOSE &h00010000
#define FO_OPENED_CASE_SENSITIVE &h00020000
#define FO_HANDLE_CREATED &h00040000
#define FO_FILE_FAST_IO_READ &h00080000
#define FO_RANDOM_ACCESS &h00100000
#define FO_FILE_OPEN_CANCELLED &h00200000
#define FO_VOLUME_OPEN &h00400000
#define FO_FILE_OBJECT_HAS_EXTENSION &h00800000
#define FO_REMOTE_ORIGIN &h01000000

type _FILE_OBJECT
	Type as _CSHORT
	Size as _CSHORT
	DeviceObject as PDEVICE_OBJECT
	Vpb as PVPB
	FsContext as PVOID
	FsContext2 as PVOID
	SectionObjectPointer as PSECTION_OBJECT_POINTERS
	PrivateCacheMap as PVOID
	FinalStatus as NTSTATUS
	RelatedFileObject as PFILE_OBJECT
	LockOperation as BOOLEAN
	DeletePending as BOOLEAN
	ReadAccess as BOOLEAN
	WriteAccess as BOOLEAN
	DeleteAccess as BOOLEAN
	SharedRead as BOOLEAN
	SharedWrite as BOOLEAN
	SharedDelete as BOOLEAN
	Flags as ULONG
	FileName as UNICODE_STRING
	CurrentByteOffset as LARGE_INTEGER
	Waiters as ULONG
	Busy as ULONG
	LastLock as PVOID
	Lock as KEVENT
	Event as KEVENT
	CompletionContext as PIO_COMPLETION_CONTEXT
end type

enum _SECURITY_OPERATION_CODE
	SetSecurityDescriptor
	QuerySecurityDescriptor
	DeleteSecurityDescriptor
	AssignSecurityDescriptor
end enum

type SECURITY_OPERATION_CODE as _SECURITY_OPERATION_CODE
type PSECURITY_OPERATION_CODE as _SECURITY_OPERATION_CODE

#define INITIAL_PRIVILEGE_COUNT 3

type _INITIAL_PRIVILEGE_SET
	PrivilegeCount as ULONG
	Control as ULONG
	Privilege(0 to 3-1) as LUID_AND_ATTRIBUTES
end type

type INITIAL_PRIVILEGE_SET as _INITIAL_PRIVILEGE_SET
type PINITIAL_PRIVILEGE_SET as _INITIAL_PRIVILEGE_SET ptr

type _SECURITY_SUBJECT_CONTEXT
	ClientToken as PACCESS_TOKEN
	ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL
	PrimaryToken as PACCESS_TOKEN
	ProcessAuditId as PVOID
end type

type SECURITY_SUBJECT_CONTEXT as _SECURITY_SUBJECT_CONTEXT
type PSECURITY_SUBJECT_CONTEXT as _SECURITY_SUBJECT_CONTEXT ptr

'#include once "win/ddk/pshpack4.bi"

union ACCESS_STATE__Privileges
	InitialPrivilegeSet as INITIAL_PRIVILEGE_SET
	PrivilegeSet as PRIVILEGE_SET
end union


type _ACCESS_STATE
	OperationID as LUID
	SecurityEvaluated as BOOLEAN
	GenerateAudit as BOOLEAN
	GenerateOnClose as BOOLEAN
	PrivilegesAllocated as BOOLEAN
	Flags as ULONG
	RemainingDesiredAccess as ACCESS_MASK
	PreviouslyGrantedAccess as ACCESS_MASK
	OriginalDesiredAccess as ACCESS_MASK
	SubjectSecurityContext as SECURITY_SUBJECT_CONTEXT
	SecurityDescriptor as PSECURITY_DESCRIPTOR
	AuxData as PVOID
	AuditPrivileges as BOOLEAN
	ObjectName as UNICODE_STRING
	ObjectTypeName as UNICODE_STRING
	Privileges as ACCESS_STATE__Privileges
end type

type ACCESS_STATE as _ACCESS_STATE
type PACCESS_STATE as _ACCESS_STATE ptr


'#include once "win/ddk/poppack.bi"

type _IO_SECURITY_CONTEXT
	SecurityQos as PSECURITY_QUALITY_OF_SERVICE
	AccessState as PACCESS_STATE
	DesiredAccess as ACCESS_MASK
	FullCreateOptions as ULONG
end type

type IO_SECURITY_CONTEXT as _IO_SECURITY_CONTEXT
type PIO_SECURITY_CONTEXT as _IO_SECURITY_CONTEXT ptr

type _IO_CSQ_IRP_CONTEXT
	Type as ULONG
	Irp as PIRP
	Csq as PIO_CSQ
end type

type PIO_CSQ_INSERT_IRP as sub DDKAPI(byval as PIO_CSQ, byval as PIRP)
type PIO_CSQ_REMOVE_IRP as sub DDKAPI(byval as PIO_CSQ, byval as PIRP)
type PIO_CSQ_PEEK_NEXT_IRP as function DDKAPI(byval as PIO_CSQ, byval as PIRP, byval as PVOID) as PIRP
type PIO_CSQ_ACQUIRE_LOCK as sub DDKAPI(byval as PIO_CSQ, byval as PKIRQL)
type PIO_CSQ_RELEASE_LOCK as sub DDKAPI(byval as PIO_CSQ, byval as KIRQL)
type PIO_CSQ_COMPLETE_CANCELED_IRP as sub DDKAPI(byval as PIO_CSQ, byval as PIRP)

type _IO_CSQ
	Type as ULONG
	CsqInsertIrp as PIO_CSQ_INSERT_IRP
	CsqRemoveIrp as PIO_CSQ_REMOVE_IRP
	CsqPeekNextIrp as PIO_CSQ_PEEK_NEXT_IRP
	CsqAcquireLock as PIO_CSQ_ACQUIRE_LOCK
	CsqReleaseLock as PIO_CSQ_RELEASE_LOCK
	CsqCompleteCanceledIrp as PIO_CSQ_COMPLETE_CANCELED_IRP
	ReservePointer as PVOID
end type

'#include once "win/ddk/pshpack4.bi"


type IO_STACK_LOCATION__Parameters__Others
	Argument1 as PVOID
	Argument2 as PVOID
	Argument3 as PVOID
	Argument4 as PVOID
end type

type IO_STACK_LOCATION__Parameters__WMI
	ProviderId as ULONG_PTR
	DataPath as PVOID
	BufferSize as ULONG
	Buffer as PVOID
end type

type IO_STACK_LOCATION__Parameters__StartDevice
	AllocatedResources as PCM_RESOURCE_LIST
	AllocatedResourcesTranslated as PCM_RESOURCE_LIST
end type

type IO_STACK_LOCATION__Parameters__Power
	SystemContext as ULONG
	Type as POWER_STATE_TYPE
	State as POWER_STATE
	ShutdownType as POWER_ACTION
end type

type IO_STACK_LOCATION__Parameters__PowerSequence
	PowerSequence as PPOWER_SEQUENCE
end type

type IO_STACK_LOCATION__Parameters__WaitWake
	PowerState as SYSTEM_POWER_STATE
end type

type IO_STACK_LOCATION__Parameters__UsageNotification
	InPath as BOOLEAN
	Reserved(0 to 3-1) as BOOLEAN
	Type as DEVICE_USAGE_NOTIFICATION_TYPE
end type

type IO_STACK_LOCATION__Parameters__QueryDeviceText
	DeviceTextType as DEVICE_TEXT_TYPE
	LocaleId as LCID
end type

type IO_STACK_LOCATION__Parameters__QueryId
	IdType as BUS_QUERY_ID_TYPE
end type

type IO_STACK_LOCATION__Parameters__SetLock
	Lock as BOOLEAN
end type

type IO_STACK_LOCATION__Parameters__ReadWriteConfig
	WhichSpace as ULONG
	Buffer as PVOID
	Offset as ULONG
	Length as ULONG
end type

type IO_STACK_LOCATION__Parameters__FRR
	IoResourceRequirementList as PIO_RESOURCE_REQUIREMENTS_LIST
end type

type IO_STACK_LOCATION__Parameters__DC
	Capabilities as PDEVICE_CAPABILITIES
end type

type IO_STACK_LOCATION__Parameters__QueryInterface
	InterfaceType as GUID ptr
	Size as USHORT
	Version as USHORT
	Interface as PINTERFACE
	InterfaceSpecificData as PVOID
end type

type IO_STACK_LOCATION__Parameters__QDR
	Type as DEVICE_RELATION_TYPE
end type

type IO_STACK_LOCATION__Parameters__Scsi
	Srb as PSCSI_REQUEST_BLOCK
end type

type IO_STACK_LOCATION__Parameters__VerifyVolume
	Vpb as PVPB
	DeviceObject as PDEVICE_OBJECT
end type

type IO_STACK_LOCATION__Parameters__MountVolume
	Vpb as PVPB
	DeviceObject as PDEVICE_OBJECT
end type

type IO_STACK_LOCATION__Parameters__SetSecurity
	SecurityInformation as SECURITY_INFORMATION
	SecurityDescriptor as PSECURITY_DESCRIPTOR
end type

type IO_STACK_LOCATION__Parameters__QuerySecurity
	SecurityInformation as SECURITY_INFORMATION
	Length as ULONG
end type

type IO_STACK_LOCATION__Parameters__DeviceIoControl
	OutputBufferLength as ULONG
	InputBufferLength as ULONG
	IoControlCode as ULONG
	Type3InputBuffer as PVOID
end type

type IO_STACK_LOCATION__Parameters__QueryVolume
	Length as ULONG
	FsInformationClass as FS_INFORMATION_CLASS
end type

type IO_STACK_LOCATION__N_Parameters__SetFile__N_u__N__s
	ReplaceIfExists as BOOLEAN
	AdvanceOnly as BOOLEAN
end type

union IO_STACK_LOCATION__Parameters__SetFile__N_u
	ClusterCount as ULONG
	DeleteHandle as HANDLE
	s as IO_STACK_LOCATION__N_Parameters__SetFile__N_u__N__s
end union

type IO_STACK_LOCATION__Parameters__SetFile
	Length as ULONG
	FileInformationClass as FILE_INFORMATION_CLASS
	FileObject as PFILE_OBJECT
	u as IO_STACK_LOCATION__Parameters__SetFile__N_u
end type



type IO_STACK_LOCATION__Parameters__QueryFile
	Length as ULONG
	FileInformationClass as FILE_INFORMATION_CLASS
end type

type IO_STACK_LOCATION__Parameters__Write
	Length as ULONG
	Key as ULONG
	ByteOffset as LARGE_INTEGER
end type

type IO_STACK_LOCATION__Parameters__Read
	Length as ULONG
	Key as ULONG
	ByteOffset as LARGE_INTEGER
end type

type IO_STACK_LOCATION__Parameters__Create
	SecurityContext as PIO_SECURITY_CONTEXT
	Options as ULONG
	FileAttributes as USHORT
	ShareAccess as USHORT
	EaLength as ULONG
end type


union IO_STACK_LOCATION__Parameters
	Others as IO_STACK_LOCATION__Parameters__Others
	WMI as IO_STACK_LOCATION__Parameters__WMI
	StartDevice as IO_STACK_LOCATION__Parameters__StartDevice
	Power as IO_STACK_LOCATION__Parameters__Power
	PowerSequence as IO_STACK_LOCATION__Parameters__PowerSequence
	WaitWake as IO_STACK_LOCATION__Parameters__WaitWake
	UsageNotification as IO_STACK_LOCATION__Parameters__UsageNotification
	QueryDeviceText as IO_STACK_LOCATION__Parameters__QueryDeviceText
	QueryId as IO_STACK_LOCATION__Parameters__QueryId
	SetLock as IO_STACK_LOCATION__Parameters__SetLock
	ReadWriteConfig as IO_STACK_LOCATION__Parameters__ReadWriteConfig
	FilterResourceRequirements as IO_STACK_LOCATION__Parameters__FRR
	DeviceCapabilities as IO_STACK_LOCATION__Parameters__DC
	QueryInterface as IO_STACK_LOCATION__Parameters__QueryInterface
	QueryDeviceRelations as IO_STACK_LOCATION__Parameters__QDR
	Scsi as IO_STACK_LOCATION__Parameters__Scsi
	VerifyVolume as IO_STACK_LOCATION__Parameters__VerifyVolume
	MountVolume as IO_STACK_LOCATION__Parameters__MountVolume
	SetSecurity as IO_STACK_LOCATION__Parameters__SetSecurity
	QuerySecurity as IO_STACK_LOCATION__Parameters__QuerySecurity
	DeviceIoControl as IO_STACK_LOCATION__Parameters__DeviceIoControl
	QueryVolume as IO_STACK_LOCATION__Parameters__QueryVolume
	SetFile as IO_STACK_LOCATION__Parameters__SetFile
	QueryFile as IO_STACK_LOCATION__Parameters__QueryFile
	Write as IO_STACK_LOCATION__Parameters__Write
	Read as IO_STACK_LOCATION__Parameters__Read
	Create as IO_STACK_LOCATION__Parameters__Create
end union


type _IO_STACK_LOCATION
	MajorFunction as UCHAR
	MinorFunction as UCHAR
	Flags as UCHAR
	Control as UCHAR
	DeviceObject as PDEVICE_OBJECT
	FileObject as PFILE_OBJECT
	CompletionRoutine as PIO_COMPLETION_ROUTINE
	Context as PVOID
	Parameters as IO_STACK_LOCATION__Parameters
end type


'#include once "win/ddk/poppack.bi"

#define SL_PENDING_RETURNED &h01
#define SL_INVOKE_ON_CANCEL &h20
#define SL_INVOKE_ON_SUCCESS &h40
#define SL_INVOKE_ON_ERROR &h80

enum _KEY_INFORMATION_CLASS
	KeyBasicInformation
	KeyNodeInformation
	KeyFullInformation
	KeyNameInformation
	KeyCachedInformation
	KeyFlagsInformation
end enum

type KEY_INFORMATION_CLASS as _KEY_INFORMATION_CLASS

type _KEY_BASIC_INFORMATION
	LastWriteTime as LARGE_INTEGER
	TitleIndex as ULONG
	NameLength as ULONG
	Name(0 to 1-1) as WCHAR
end type

type KEY_BASIC_INFORMATION as _KEY_BASIC_INFORMATION
type PKEY_BASIC_INFORMATION as _KEY_BASIC_INFORMATION ptr

type _KEY_FULL_INFORMATION
	LastWriteTime as LARGE_INTEGER
	TitleIndex as ULONG
	ClassOffset as ULONG
	ClassLength as ULONG
	SubKeys as ULONG
	MaxNameLen as ULONG
	MaxClassLen as ULONG
	Values as ULONG
	MaxValueNameLen as ULONG
	MaxValueDataLen as ULONG
	Class(0 to 1-1) as WCHAR
end type

type KEY_FULL_INFORMATION as _KEY_FULL_INFORMATION
type PKEY_FULL_INFORMATION as _KEY_FULL_INFORMATION ptr

type _KEY_NODE_INFORMATION
	LastWriteTime as LARGE_INTEGER
	TitleIndex as ULONG
	ClassOffset as ULONG
	ClassLength as ULONG
	NameLength as ULONG
	Name(0 to 1-1) as WCHAR
end type

type KEY_NODE_INFORMATION as _KEY_NODE_INFORMATION
type PKEY_NODE_INFORMATION as _KEY_NODE_INFORMATION ptr

type _KEY_VALUE_BASIC_INFORMATION
	TitleIndex as ULONG
	Type as ULONG
	NameLength as ULONG
	Name(0 to 1-1) as WCHAR
end type

type KEY_VALUE_BASIC_INFORMATION as _KEY_VALUE_BASIC_INFORMATION
type PKEY_VALUE_BASIC_INFORMATION as _KEY_VALUE_BASIC_INFORMATION ptr

type _KEY_VALUE_FULL_INFORMATION
	TitleIndex as ULONG
	Type as ULONG
	DataOffset as ULONG
	DataLength as ULONG
	NameLength as ULONG
	Name(0 to 1-1) as WCHAR
end type

type KEY_VALUE_FULL_INFORMATION as _KEY_VALUE_FULL_INFORMATION
type PKEY_VALUE_FULL_INFORMATION as _KEY_VALUE_FULL_INFORMATION ptr

type _KEY_VALUE_PARTIAL_INFORMATION
	TitleIndex as ULONG
	Type as ULONG
	DataLength as ULONG
	Data(0 to 1-1) as UCHAR
end type

type KEY_VALUE_PARTIAL_INFORMATION as _KEY_VALUE_PARTIAL_INFORMATION
type PKEY_VALUE_PARTIAL_INFORMATION as _KEY_VALUE_PARTIAL_INFORMATION ptr

type _KEY_VALUE_PARTIAL_INFORMATION_ALIGN64
	Type as ULONG
	DataLength as ULONG
	Data(0 to 1-1) as UCHAR
end type

type KEY_VALUE_PARTIAL_INFORMATION_ALIGN64 as _KEY_VALUE_PARTIAL_INFORMATION_ALIGN64
type PKEY_VALUE_PARTIAL_INFORMATION_ALIGN64 as _KEY_VALUE_PARTIAL_INFORMATION_ALIGN64 ptr

type _KEY_VALUE_ENTRY
	ValueName as PUNICODE_STRING
	DataLength as ULONG
	DataOffset as ULONG
	Type as ULONG
end type

type KEY_VALUE_ENTRY as _KEY_VALUE_ENTRY
type PKEY_VALUE_ENTRY as _KEY_VALUE_ENTRY ptr

enum _KEY_VALUE_INFORMATION_CLASS
	KeyValueBasicInformation
	KeyValueFullInformation
	KeyValuePartialInformation
	KeyValueFullInformationAlign64
	KeyValuePartialInformationAlign64
end enum

type KEY_VALUE_INFORMATION_CLASS as _KEY_VALUE_INFORMATION_CLASS

#define REG_NONE 0
#define REG_SZ 1
#define REG_EXPAND_SZ 2
#define REG_BINARY 3
#define REG_DWORD 4
#define REG_DWORD_LITTLE_ENDIAN 4
#define REG_DWORD_BIG_ENDIAN 5
#define REG_LINK 6
#define REG_MULTI_SZ 7
#define REG_RESOURCE_LIST 8
#define REG_FULL_RESOURCE_DESCRIPTOR 9
#define REG_RESOURCE_REQUIREMENTS_LIST 10
#define REG_QWORD 11
#define REG_QWORD_LITTLE_ENDIAN 11
#define PCI_TYPE0_ADDRESSES 6
#define PCI_TYPE1_ADDRESSES 2
#define PCI_TYPE2_ADDRESSES 5



type PCI_COMMON_CONFIG__u__type2__Range
	Base as ULONG
	Limit as ULONG
end type


type PCI_COMMON_CONFIG__u__type2
	SocketRegistersBaseAddress as ULONG
	CapabilitiesPtr as UCHAR
	Reserved as UCHAR
	SecondaryStatus as USHORT
	PrimaryBus as UCHAR
	SecondaryBus as UCHAR
	SubordinateBus as UCHAR
	SecondaryLatency as UCHAR
	InterruptLine as UCHAR
	InterruptPin as UCHAR
	BridgeControl as USHORT
	Range as PCI_COMMON_CONFIG__u__type2__Range ptr
end type


type PCI_COMMON_CONFIG__u__type1
	BaseAddresses(0 to 2-1) as ULONG
	PrimaryBus as UCHAR
	SecondaryBus as UCHAR
	SubordinateBus as UCHAR
	SecondaryLatency as UCHAR
	IOBase as UCHAR
	IOLimit as UCHAR
	SecondaryStatus as USHORT
	MemoryBase as USHORT
	MemoryLimit as USHORT
	PrefetchBase as USHORT
	PrefetchLimit as USHORT
	PrefetchBaseUpper32 as ULONG
	PrefetchLimitUpper32 as ULONG
	IOBaseUpper16 as USHORT
	IOLimitUpper16 as USHORT
	CapabilitiesPtr as UCHAR
	Reserved1(0 to 3-1) as UCHAR
	ROMBaseAddress as ULONG
	InterruptLine as UCHAR
	InterruptPin as UCHAR
	BridgeControl as USHORT
end type

type PCI_COMMON_CONFIG__u__type0
	BaseAddresses(0 to 6-1) as ULONG
	CIS as ULONG
	SubVendorID as USHORT
	SubSystemID as USHORT
	ROMBaseAddress as ULONG
	CapabilitiesPtr as UCHAR
	Reserved1(0 to 3-1) as UCHAR
	Reserved2 as ULONG
	InterruptLine as UCHAR
	InterruptPin as UCHAR
	MinimumGrant as UCHAR
	MaximumLatency as UCHAR
end type


union PCI_COMMON_CONFIG__u
	type2 as PCI_COMMON_CONFIG__u__type2
	type1 as PCI_COMMON_CONFIG__u__type1
	type0 as PCI_COMMON_CONFIG__u__type0
end union

type _PCI_COMMON_CONFIG
	VendorID as USHORT
	DeviceID as USHORT
	Command as USHORT
	Status as USHORT
	RevisionID as UCHAR
	ProgIf as UCHAR
	SubClass as UCHAR
	BaseClass as UCHAR
	CacheLineSize as UCHAR
	LatencyTimer as UCHAR
	HeaderType as UCHAR
	BIST as UCHAR
	DeviceSpecific(0 to 192-1) as UCHAR
	u as PCI_COMMON_CONFIG__u
end type

type PCI_COMMON_CONFIG as _PCI_COMMON_CONFIG
type PPCI_COMMON_CONFIG as _PCI_COMMON_CONFIG ptr


#define PCI_ENABLE_IO_SPACE &h0001
#define PCI_ENABLE_MEMORY_SPACE &h0002
#define PCI_ENABLE_BUS_MASTER &h0004
#define PCI_ENABLE_SPECIAL_CYCLES &h0008
#define PCI_ENABLE_WRITE_AND_INVALIDATE &h0010
#define PCI_ENABLE_VGA_COMPATIBLE_PALETTE &h0020
#define PCI_ENABLE_PARITY &h0040
#define PCI_ENABLE_WAIT_CYCLE &h0080
#define PCI_ENABLE_SERR &h0100
#define PCI_ENABLE_FAST_BACK_TO_BACK &h0200
#define PCI_STATUS_CAPABILITIES_LIST &h0010
#define PCI_STATUS_66MHZ_CAPABLE &h0020
#define PCI_STATUS_UDF_SUPPORTED &h0040
#define PCI_STATUS_FAST_BACK_TO_BACK &h0080
#define PCI_STATUS_DATA_PARITY_DETECTED &h0100
#define PCI_STATUS_DEVSEL &h0600
#define PCI_STATUS_SIGNALED_TARGET_ABORT &h0800
#define PCI_STATUS_RECEIVED_TARGET_ABORT &h1000
#define PCI_STATUS_RECEIVED_MASTER_ABORT &h2000
#define PCI_STATUS_SIGNALED_SYSTEM_ERROR &h4000
#define PCI_STATUS_DETECTED_PARITY_ERROR &h8000
#define PCI_MULTIFUNCTION &h80
#define PCI_DEVICE_TYPE &h00
#define PCI_BRIDGE_TYPE &h01
#define PCI_CARDBUS_BRIDGE_TYPE &h02

type PCI_SLOT_NUMBER__u__bits
	DeviceNumber:5 as ULONG
	FunctionNumber:3 as ULONG
	Reserved:24 as ULONG
end type

union PCI_SLOT_NUMBER__u
	AsULONG as ULONG
	bits as PCI_SLOT_NUMBER__u__bits
end union

type _PCI_SLOT_NUMBER
	u as PCI_SLOT_NUMBER__u
end type

type PCI_SLOT_NUMBER as _PCI_SLOT_NUMBER
type PPCI_SLOT_NUMBER as _PCI_SLOT_NUMBER ptr




enum _POOL_TYPE
	NonPagedPool
	PagedPool
	NonPagedPoolMustSucceed
	DontUseThisType
	NonPagedPoolCacheAligned
	PagedPoolCacheAligned
	NonPagedPoolCacheAlignedMustS
	MaxPoolType
	NonPagedPoolSession = 32
	PagedPoolSession
	NonPagedPoolMustSucceedSession
	DontUseThisTypeSession
	NonPagedPoolCacheAlignedSession
	PagedPoolCacheAlignedSession
	NonPagedPoolCacheAlignedMustSSession
end enum

type POOL_TYPE as _POOL_TYPE

enum _EX_POOL_PRIORITY
	LowPoolPriority
	LowPoolPrioritySpecialPoolOverrun = 8
	LowPoolPrioritySpecialPoolUnderrun = 9
	NormalPoolPriority = 16
	NormalPoolPrioritySpecialPoolOverrun = 24
	NormalPoolPrioritySpecialPoolUnderrun = 25
	HighPoolPriority = 32
	HighPoolPrioritySpecialPoolOverrun = 40
	HighPoolPrioritySpecialPoolUnderrun = 41
end enum

type EX_POOL_PRIORITY as _EX_POOL_PRIORITY

#define PRIVILEGE_SET_ALL_NECESSARY 1

type _RTL_OSVERSIONINFOW
	dwOSVersionInfoSize as ULONG
	dwMajorVersion as ULONG
	dwMinorVersion as ULONG
	dwBuildNumber as ULONG
	dwPlatformId as ULONG
	szCSDVersion(0 to 128-1) as WCHAR
end type

type RTL_OSVERSIONINFOW as _RTL_OSVERSIONINFOW
type PRTL_OSVERSIONINFOW as _RTL_OSVERSIONINFOW ptr

type _RTL_OSVERSIONINFOEXW
	dwOSVersionInfoSize as ULONG
	dwMajorVersion as ULONG
	dwMinorVersion as ULONG
	dwBuildNumber as ULONG
	dwPlatformId as ULONG
	szCSDVersion(0 to 128-1) as WCHAR
	wServicePackMajor as USHORT
	wServicePackMinor as USHORT
	wSuiteMask as USHORT
	wProductType as UCHAR
	wReserved as UCHAR
end type

type RTL_OSVERSIONINFOEXW as _RTL_OSVERSIONINFOEXW
type PRTL_OSVERSIONINFOEXW as _RTL_OSVERSIONINFOEXW ptr



#define VER_MINORVERSION &h0000001
#define VER_MAJORVERSION &h0000002
#define VER_BUILDNUMBER &h0000004
#define VER_PLATFORMID &h0000008
#define VER_SERVICEPACKMINOR &h0000010
#define VER_SERVICEPACKMAJOR &h0000020
#define VER_SUITENAME &h0000040
#define VER_PRODUCT_TYPE &h0000080
#define VER_EQUAL 1
#define VER_GREATER 2
#define VER_GREATER_EQUAL 3
#define VER_LESS 4
#define VER_LESS_EQUAL 5
#define VER_AND 6
#define VER_OR 7
#define VER_CONDITION_MASK 7
#define VER_NUM_BITS_PER_CONDITION_MASK 3

type _RTL_BITMAP
	SizeOfBitMap as ULONG
	Buffer as PULONG
end type

type RTL_BITMAP as _RTL_BITMAP
type PRTL_BITMAP as _RTL_BITMAP ptr

type _RTL_BITMAP_RUN
	StartingIndex as ULONG
	NumberOfBits as ULONG
end type

type RTL_BITMAP_RUN as _RTL_BITMAP_RUN
type PRTL_BITMAP_RUN as _RTL_BITMAP_RUN ptr
type PRTL_QUERY_REGISTRY_ROUTINE as function DDKAPI(byval as PWSTR, byval as ULONG, byval as PVOID, byval as ULONG, byval as PVOID, byval as PVOID) as NTSTATUS

#define RTL_REGISTRY_ABSOLUTE 0
#define RTL_REGISTRY_SERVICES 1
#define RTL_REGISTRY_CONTROL 2
#define RTL_REGISTRY_WINDOWS_NT 3
#define RTL_REGISTRY_DEVICEMAP 4
#define RTL_REGISTRY_USER 5
#define RTL_QUERY_REGISTRY_SUBKEY &h00000001
#define RTL_QUERY_REGISTRY_TOPKEY &h00000002
#define RTL_QUERY_REGISTRY_REQUIRED &h00000004
#define RTL_QUERY_REGISTRY_NOVALUE &h00000008
#define RTL_QUERY_REGISTRY_NOEXPAND &h00000010
#define RTL_QUERY_REGISTRY_DIRECT &h00000020
#define RTL_QUERY_REGISTRY_DELETE &h00000040

type _RTL_QUERY_REGISTRY_TABLE
	QueryRoutine as PRTL_QUERY_REGISTRY_ROUTINE
	Flags as ULONG
	Name as PWSTR
	EntryContext as PVOID
	DefaultType as ULONG
	DefaultData as PVOID
	DefaultLength as ULONG
end type

type RTL_QUERY_REGISTRY_TABLE as _RTL_QUERY_REGISTRY_TABLE
type PRTL_QUERY_REGISTRY_TABLE as _RTL_QUERY_REGISTRY_TABLE ptr

type _TIME_FIELDS
	Year as _CSHORT
	Month as _CSHORT
	Day as _CSHORT
	Hour as _CSHORT
	Minute as _CSHORT
	Second as _CSHORT
	Milliseconds as _CSHORT
	Weekday as _CSHORT
end type

type TIME_FIELDS as _TIME_FIELDS
type PTIME_FIELDS as _TIME_FIELDS ptr
type PALLOCATE_FUNCTION as function DDKAPI(byval as POOL_TYPE, byval as SIZE_T, byval as ULONG) as PVOID
type PFREE_FUNCTION as sub DDKAPI(byval as PVOID)

union GENERAL_LOOKASIDE__u3
	LastAllocateMisses as ULONG
	LastAllocateHits as ULONG
end union

union GENERAL_LOOKASIDE__u2
	FreeMisses as ULONG
	FreeHits as ULONG
end union

union GENERAL_LOOKASIDE__u
	AllocateMisses as ULONG
	AllocateHits as ULONG
end union

type _GENERAL_LOOKASIDE
	ListHead as SLIST_HEADER
	Depth as USHORT
	MaximumDepth as USHORT
	TotalAllocates as ULONG
	TotalFrees as ULONG
	Type as POOL_TYPE
	Tag as ULONG
	Size as ULONG
	Allocate as PALLOCATE_FUNCTION
	Free as PFREE_FUNCTION
	ListEntry as LIST_ENTRY
	LastTotalAllocates as ULONG
	Future(0 to 2-1) as ULONG
	u3 as GENERAL_LOOKASIDE__u3
	u2 as GENERAL_LOOKASIDE__u2
	u as GENERAL_LOOKASIDE__u
end type

type GENERAL_LOOKASIDE as _GENERAL_LOOKASIDE
type PGENERAL_LOOKASIDE as _GENERAL_LOOKASIDE ptr



union NPAGED_LOOKASIDE_LIST__u3
	LastAllocateMisses as ULONG
	LastAllocateHits as ULONG
end union

union NPAGED_LOOKASIDE_LIST__u2
	FreeMisses as ULONG
	FreeHits as ULONG
end union

union NPAGED_LOOKASIDE_LIST__u
	AllocateMisses as ULONG
	AllocateHits as ULONG
end union

type _NPAGED_LOOKASIDE_LIST
	ListHead as SLIST_HEADER
	Depth as USHORT
	MaximumDepth as USHORT
	TotalAllocates as ULONG
	TotalFrees as ULONG
	Type as POOL_TYPE
	Tag as ULONG
	Size as ULONG
	Allocate as PALLOCATE_FUNCTION
	Free as PFREE_FUNCTION
	ListEntry as LIST_ENTRY
	LastTotalAllocates as ULONG
	Future(0 to 2-1) as ULONG
	Obsoleted as KSPIN_LOCK
	u3 as NPAGED_LOOKASIDE_LIST__u3
	u2 as NPAGED_LOOKASIDE_LIST__u2
	u as NPAGED_LOOKASIDE_LIST__u
end type

type NPAGED_LOOKASIDE_LIST as _NPAGED_LOOKASIDE_LIST
type PNPAGED_LOOKASIDE_LIST as _NPAGED_LOOKASIDE_LIST ptr


union PAGED_LOOKASIDE_LIST__u3
	LastAllocateMisses as ULONG
	LastAllocateHits as ULONG
end union

union PAGED_LOOKASIDE_LIST__u2
	FreeMisses as ULONG
	FreeHits as ULONG
end union

union PAGED_LOOKASIDE_LIST__u
	AllocateMisses as ULONG
	AllocateHits as ULONG
end union

type _PAGED_LOOKASIDE_LIST
	ListHead as SLIST_HEADER
	Depth as USHORT
	MaximumDepth as USHORT
	TotalAllocates as ULONG
	TotalFrees as ULONG
	Type as POOL_TYPE
	Tag as ULONG
	Size as ULONG
	Allocate as PALLOCATE_FUNCTION
	Free as PFREE_FUNCTION
	ListEntry as LIST_ENTRY
	LastTotalAllocates as ULONG
	Future(0 to 2-1) as ULONG
	Obsoleted as FAST_MUTEX
	u3 as PAGED_LOOKASIDE_LIST__u3
	u2 as PAGED_LOOKASIDE_LIST__u2
	u as PAGED_LOOKASIDE_LIST__u
end type

type PAGED_LOOKASIDE_LIST as _PAGED_LOOKASIDE_LIST
type PPAGED_LOOKASIDE_LIST as _PAGED_LOOKASIDE_LIST ptr


type PCALLBACK_OBJECT as _CALLBACK_OBJECT ptr
type PCALLBACK_FUNCTION as sub DDKAPI(byval as PVOID, byval as PVOID, byval as PVOID)

enum _EVENT_TYPE
	NotificationEvent
	SynchronizationEvent
end enum

type EVENT_TYPE as _EVENT_TYPE

enum _KWAIT_REASON
	Executive
	FreePage
	PageIn
	PoolAllocation
	DelayExecution
	Suspended
	UserRequest
	WrExecutive
	WrFreePage
	WrPageIn
	WrPoolAllocation
	WrDelayExecution
	WrSuspended
	WrUserRequest
	WrEventPair
	WrQueue
	WrLpcReceive
	WrLpcReply
	WrVirtualMemory
	WrPageOut
	WrRendezvous
	Spare2
	Spare3
	Spare4
	Spare5
	Spare6
	WrKernel
	MaximumWaitReason
end enum

type KWAIT_REASON as _KWAIT_REASON

type _KWAIT_BLOCK
	WaitListEntry as LIST_ENTRY
	Thread as PKTHREAD
	Object as PVOID
	NextWaitBlock as _KWAIT_BLOCK ptr
	WaitKey as USHORT
	WaitType as USHORT
end type

type KWAIT_BLOCK as _KWAIT_BLOCK
type PKWAIT_BLOCK as _KWAIT_BLOCK ptr
type PRKWAIT_BLOCK as _KWAIT_BLOCK ptr
type PIO_REMOVE_LOCK_TRACKING_BLOCK as _IO_REMOVE_LOCK_TRACKING_BLOCK ptr

type _IO_REMOVE_LOCK_COMMON_BLOCK
	Removed as BOOLEAN
	Reserved(0 to 3-1) as BOOLEAN
	IoCount as LONG
	RemoveEvent as KEVENT
end type

type IO_REMOVE_LOCK_COMMON_BLOCK as _IO_REMOVE_LOCK_COMMON_BLOCK

type _IO_REMOVE_LOCK_DBG_BLOCK
	Signature as LONG
	HighWatermark as LONG
	MaxLockedTicks as LONGLONG
	AllocateTag as LONG
	LockList as LIST_ENTRY
	Spin as KSPIN_LOCK
	LowMemoryCount as LONG
	Reserved1(0 to 4-1) as ULONG
	Reserved2 as PVOID
	Blocks as PIO_REMOVE_LOCK_TRACKING_BLOCK
end type

type IO_REMOVE_LOCK_DBG_BLOCK as _IO_REMOVE_LOCK_DBG_BLOCK

type _IO_REMOVE_LOCK
	Common as IO_REMOVE_LOCK_COMMON_BLOCK
end type

type IO_REMOVE_LOCK as _IO_REMOVE_LOCK
type PIO_REMOVE_LOCK as _IO_REMOVE_LOCK ptr
type PIO_WORKITEM as _IO_WORKITEM ptr
type PIO_WORKITEM_ROUTINE as sub DDKAPI(byval as PDEVICE_OBJECT, byval as PVOID)

type _SHARE_ACCESS
	OpenCount as ULONG
	Readers as ULONG
	Writers as ULONG
	Deleters as ULONG
	SharedRead as ULONG
	SharedWrite as ULONG
	SharedDelete as ULONG
end type

type SHARE_ACCESS as _SHARE_ACCESS
type PSHARE_ACCESS as _SHARE_ACCESS ptr

enum _KINTERRUPT_MODE
	LevelSensitive
	Latched
end enum

type KINTERRUPT_MODE as _KINTERRUPT_MODE
type PKINTERRUPT_ROUTINE as sub DDKAPI()

enum _KPROFILE_SOURCE
	ProfileTime
	ProfileAlignmentFixup
	ProfileTotalIssues
	ProfilePipelineDry
	ProfileLoadInstructions
	ProfilePipelineFrozen
	ProfileBranchInstructions
	ProfileTotalNonissues
	ProfileDcacheMisses
	ProfileIcacheMisses
	ProfileCacheMisses
	ProfileBranchMispredictions
	ProfileStoreInstructions
	ProfileFpInstructions
	ProfileIntegerInstructions
	Profile2Issue
	Profile3Issue
	Profile4Issue
	ProfileSpecialInstructions
	ProfileTotalCycles
	ProfileIcacheIssues
	ProfileDcacheAccesses
	ProfileMemoryBarrierCycles
	ProfileLoadLinkedIssues
	ProfileMaximum
end enum

type KPROFILE_SOURCE as _KPROFILE_SOURCE

enum _CREATE_FILE_TYPE
	CreateFileTypeNone
	CreateFileTypeNamedPipe
	CreateFileTypeMailslot
end enum

type CREATE_FILE_TYPE as _CREATE_FILE_TYPE

type _CONFIGURATION_INFORMATION
	DiskCount as ULONG
	FloppyCount as ULONG
	CdRomCount as ULONG
	TapeCount as ULONG
	ScsiPortCount as ULONG
	SerialCount as ULONG
	ParallelCount as ULONG
	AtDiskPrimaryAddressClaimed as BOOLEAN
	AtDiskSecondaryAddressClaimed as BOOLEAN
	Version as ULONG
	MediumChangerCount as ULONG
end type

type CONFIGURATION_INFORMATION as _CONFIGURATION_INFORMATION
type PCONFIGURATION_INFORMATION as _CONFIGURATION_INFORMATION ptr

enum _CONFIGURATION_TYPE
	ArcSystem
	CentralProcessor
	FloatingPointProcessor
	PrimaryIcache
	PrimaryDcache
	SecondaryIcache
	SecondaryDcache
	SecondaryCache
	EisaAdapter
	TcAdapter
	ScsiAdapter
	DtiAdapter
	MultiFunctionAdapter
	DiskController
	TapeController
	CdromController
	WormController
	SerialController
	NetworkController
	DisplayController
	ParallelController
	PointerController
	KeyboardController
	AudioController
	OtherController
	DiskPeripheral
	FloppyDiskPeripheral
	TapePeripheral
	ModemPeripheral
	MonitorPeripheral
	PrinterPeripheral
	PointerPeripheral
	KeyboardPeripheral
	TerminalPeripheral
	OtherPeripheral
	LinePeripheral
	NetworkPeripheral
	SystemMemory
	DockingInformation
	RealModeIrqRoutingTable
	MaximumType
end enum

type CONFIGURATION_TYPE as _CONFIGURATION_TYPE
type PCONFIGURATION_TYPE as _CONFIGURATION_TYPE
type PIO_QUERY_DEVICE_ROUTINE as function DDKAPI(byval as PVOID, byval as PUNICODE_STRING, byval as INTERFACE_TYPE, byval as ULONG, byval as PKEY_VALUE_FULL_INFORMATION ptr, byval as CONFIGURATION_TYPE, byval as ULONG, byval as PKEY_VALUE_FULL_INFORMATION ptr, byval as CONFIGURATION_TYPE, byval as ULONG, byval as PKEY_VALUE_FULL_INFORMATION ptr) as NTSTATUS

enum _WORK_QUEUE_TYPE
	CriticalWorkQueue
	DelayedWorkQueue
	HyperCriticalWorkQueue
	MaximumWorkQueue
end enum

type WORK_QUEUE_TYPE as _WORK_QUEUE_TYPE
type PWORKER_THREAD_ROUTINE as sub DDKAPI(byval as PVOID)

type _WORK_QUEUE_ITEM
	List as LIST_ENTRY
	WorkerRoutine as PWORKER_THREAD_ROUTINE
	Parameter as PVOID
end type

type WORK_QUEUE_ITEM as _WORK_QUEUE_ITEM
type PWORK_QUEUE_ITEM as _WORK_QUEUE_ITEM ptr

enum _KBUGCHECK_BUFFER_DUMP_STATE
	BufferEmpty
	BufferInserted
	BufferStarted
	BufferFinished
	BufferIncomplete
end enum

type KBUGCHECK_BUFFER_DUMP_STATE as _KBUGCHECK_BUFFER_DUMP_STATE
type PKBUGCHECK_CALLBACK_ROUTINE as sub DDKAPI(byval as PVOID, byval as ULONG)

type _KBUGCHECK_CALLBACK_RECORD
	Entry as LIST_ENTRY
	CallbackRoutine as PKBUGCHECK_CALLBACK_ROUTINE
	Buffer as PVOID
	Length as ULONG
	Component as PUCHAR
	Checksum as ULONG_PTR
	State as UCHAR
end type

type KBUGCHECK_CALLBACK_RECORD as _KBUGCHECK_CALLBACK_RECORD
type PKBUGCHECK_CALLBACK_RECORD as _KBUGCHECK_CALLBACK_RECORD ptr

enum _KDPC_IMPORTANCE
	LowImportance
	MediumImportance
	HighImportance
end enum

type KDPC_IMPORTANCE as _KDPC_IMPORTANCE

enum _MEMORY_CACHING_TYPE_ORIG
	MmFrameBufferCached = 2
end enum

type MEMORY_CACHING_TYPE_ORIG as _MEMORY_CACHING_TYPE_ORIG

enum _MEMORY_CACHING_TYPE
	MmNonCached = 0
	MmCached = 1
	MmWriteCombined = MmFrameBufferCached
	MmHardwareCoherentCached
	MmNonCachedUnordered
	MmUSWCCached
	MmMaximumCacheType
end enum

type MEMORY_CACHING_TYPE as _MEMORY_CACHING_TYPE

enum _MM_PAGE_PRIORITY
	LowPagePriority
	NormalPagePriority = 16
	HighPagePriority = 32
end enum

type MM_PAGE_PRIORITY as _MM_PAGE_PRIORITY

enum _LOCK_OPERATION
	IoReadAccess
	IoWriteAccess
	IoModifyAccess
end enum

type LOCK_OPERATION as _LOCK_OPERATION

enum _MM_SYSTEM_SIZE
	MmSmallSystem
	MmMediumSystem
	MmLargeSystem
end enum

type MM_SYSTEM_SIZE as _MM_SYSTEM_SIZE

type _OBJECT_HANDLE_INFORMATION
	HandleAttributes as ULONG
	GrantedAccess as ACCESS_MASK
end type

type OBJECT_HANDLE_INFORMATION as _OBJECT_HANDLE_INFORMATION
type POBJECT_HANDLE_INFORMATION as _OBJECT_HANDLE_INFORMATION ptr

type _CLIENT_ID
	UniqueProcess as HANDLE
	UniqueThread as HANDLE
end type

type CLIENT_ID as _CLIENT_ID
type PCLIENT_ID as _CLIENT_ID ptr
type PKSTART_ROUTINE as sub DDKAPI(byval as PVOID)
type PCREATE_PROCESS_NOTIFY_ROUTINE as sub DDKAPI(byval as HANDLE, byval as HANDLE, byval as BOOLEAN)
type PCREATE_THREAD_NOTIFY_ROUTINE as sub DDKAPI(byval as HANDLE, byval as HANDLE, byval as BOOLEAN)

type IMAGE_INFO__u__s
	ImageAddressingMode:8 as ULONG
	SystemModeImage:1 as ULONG
	ImageMappedToAllPids:1 as ULONG
	Reserved:22 as ULONG
end type

union IMAGE_INFO__u
	Properties as ULONG
	s as IMAGE_INFO__u__s
end union


type _IMAGE_INFO
	ImageBase as PVOID
	ImageSelector as ULONG
	ImageSize as SIZE_T
	ImageSectionNumber as ULONG
	u as IMAGE_INFO__u
end type

type IMAGE_INFO as _IMAGE_INFO
type PIMAGE_INFO as _IMAGE_INFO ptr



#define IMAGE_ADDRESSING_MODE_32BIT 3

type PLOAD_IMAGE_NOTIFY_ROUTINE as sub DDKAPI(byval as PUNICODE_STRING, byval as HANDLE, byval as PIMAGE_INFO)

enum _PROCESSINFOCLASS
	ProcessBasicInformation
	ProcessQuotaLimits
	ProcessIoCounters
	ProcessVmCounters
	ProcessTimes
	ProcessBasePriority
	ProcessRaisePriority
	ProcessDebugPort
	ProcessExceptionPort
	ProcessAccessToken
	ProcessLdtInformation
	ProcessLdtSize
	ProcessDefaultHardErrorMode
	ProcessIoPortHandlers
	ProcessPooledUsageAndLimits
	ProcessWorkingSetWatch
	ProcessUserModeIOPL
	ProcessEnableAlignmentFaultFixup
	ProcessPriorityClass
	ProcessWx86Information
	ProcessHandleCount
	ProcessAffinityMask
	ProcessPriorityBoost
	ProcessDeviceMap
	ProcessSessionInformation
	ProcessForegroundInformation
	ProcessWow64Information
	ProcessImageFileName
	ProcessLUIDDeviceMapsEnabled
	ProcessBreakOnTermination
	ProcessDebugObjectHandle
	ProcessDebugFlags
	ProcessHandleTracing
	MaxProcessInfoClass
end enum

type PROCESSINFOCLASS as _PROCESSINFOCLASS

enum _THREADINFOCLASS
	ThreadBasicInformation
	ThreadTimes
	ThreadPriority
	ThreadBasePriority
	ThreadAffinityMask
	ThreadImpersonationToken
	ThreadDescriptorTableEntry
	ThreadEnableAlignmentFaultFixup
	ThreadEventPair_Reusable
	ThreadQuerySetWin32StartAddress
	ThreadZeroTlsCell
	ThreadPerformanceCount
	ThreadAmILastThread
	ThreadIdealProcessor
	ThreadPriorityBoost
	ThreadSetTlsArrayAddress
	ThreadIsIoPending
	ThreadHideFromDebugger
	ThreadBreakOnTermination
	MaxThreadInfoClass
end enum

type THREADINFOCLASS as _THREADINFOCLASS

#define ES_SYSTEM_REQUIRED &h00000001
#define ES_DISPLAY_REQUIRED &h00000002
#define ES_USER_PRESENT &h00000004
#define ES_CONTINUOUS &h80000000

type EXECUTION_STATE as ULONG
type PREQUEST_POWER_COMPLETE as sub DDKAPI(byval as PDEVICE_OBJECT, byval as UCHAR, byval as POWER_STATE, byval as PVOID, byval as PIO_STATUS_BLOCK)

enum _TRACE_INFORMATION_CLASS
	TraceIdClass
	TraceHandleClass
	TraceEnableFlagsClass
	TraceEnableLevelClass
	GlobalLoggerHandleClass
	EventLoggerHandleClass
	AllLoggerHandlesClass
	TraceHandleByNameClass
end enum

type TRACE_INFORMATION_CLASS as _TRACE_INFORMATION_CLASS
type PEX_CALLBACK_FUNCTION as function DDKAPI(byval as PVOID, byval as PVOID, byval as PVOID) as NTSTATUS

enum _PARTITION_STYLE
	PARTITION_STYLE_MBR
	PARTITION_STYLE_GPT
end enum

type PARTITION_STYLE as _PARTITION_STYLE

type _CREATE_DISK_MBR
	Signature as ULONG
end type

type CREATE_DISK_MBR as _CREATE_DISK_MBR
type PCREATE_DISK_MBR as _CREATE_DISK_MBR ptr

type _CREATE_DISK_GPT
	DiskId as GUID
	MaxPartitionCount as ULONG
end type

type CREATE_DISK_GPT as _CREATE_DISK_GPT
type PCREATE_DISK_GPT as _CREATE_DISK_GPT ptr

union CREATE_DISK__u
	Mbr as CREATE_DISK_MBR
	Gpt as CREATE_DISK_GPT
end union

type _CREATE_DISK
	PartitionStyle as PARTITION_STYLE
	u as CREATE_DISK__u
end type

type CREATE_DISK as _CREATE_DISK
type PCREATE_DISK as _CREATE_DISK ptr

type DISK_SIGNATURE__u__Gpt
	DiskId as GUID
end type

type DISK_SIGNATURE__u__Mbr
	Signature as ULONG
	CheckSum as ULONG
end type


union DISK_SIGNATURE__u
	Gpt as DISK_SIGNATURE__u__Gpt
	Mbr as DISK_SIGNATURE__u__Mbr
end union

type _DISK_SIGNATURE
	PartitionStyle as ULONG
	u as DISK_SIGNATURE__u
end type

type DISK_SIGNATURE as _DISK_SIGNATURE
type PDISK_SIGNATURE as _DISK_SIGNATURE ptr



type PTIME_UPDATE_NOTIFY_ROUTINE as sub DDKAPI(byval as HANDLE, byval as KPROCESSOR_MODE)

#define DBG_STATUS_CONTROL_C 1
#define DBG_STATUS_SYSRQ 2
#define DBG_STATUS_BUGCHECK_FIRST 3
#define DBG_STATUS_BUGCHECK_SECOND 4
#define DBG_STATUS_FATAL 5
#define DBG_STATUS_DEBUG_CONTROL 6
#define DBG_STATUS_WORKER 7

type _PHYSICAL_MEMORY_RANGE
	BaseAddress as PHYSICAL_ADDRESS
	NumberOfBytes as LARGE_INTEGER
end type

type PHYSICAL_MEMORY_RANGE as _PHYSICAL_MEMORY_RANGE
type PPHYSICAL_MEMORY_RANGE as _PHYSICAL_MEMORY_RANGE ptr
type PDRIVER_VERIFIER_THUNK_ROUTINE as function DDKAPI(byval as PVOID) as ULONG_PTR

type _DRIVER_VERIFIER_THUNK_PAIRS
	PristineRoutine as PDRIVER_VERIFIER_THUNK_ROUTINE
	NewRoutine as PDRIVER_VERIFIER_THUNK_ROUTINE
end type

type DRIVER_VERIFIER_THUNK_PAIRS as _DRIVER_VERIFIER_THUNK_PAIRS
type PDRIVER_VERIFIER_THUNK_PAIRS as _DRIVER_VERIFIER_THUNK_PAIRS ptr

#define DRIVER_VERIFIER_SPECIAL_POOLING &h0001
#define DRIVER_VERIFIER_FORCE_IRQL_CHECKING &h0002
#define DRIVER_VERIFIER_INJECT_ALLOCATION_FAILURES &h0004
#define DRIVER_VERIFIER_TRACK_POOL_ALLOCATIONS &h0008
#define DRIVER_VERIFIER_IO_CHECKING &h0010
#define RTL_RANGE_LIST_ADD_IF_CONFLICT &h00000001
#define RTL_RANGE_LIST_ADD_SHARED &h00000002
#define RTL_RANGE_LIST_SHARED_OK &h00000001
#define RTL_RANGE_LIST_NULL_CONFLICT_OK &h00000002
#define RTL_RANGE_LIST_SHARED_OK &h00000001
#define RTL_RANGE_LIST_NULL_CONFLICT_OK &h00000002
#define RTL_RANGE_LIST_MERGE_IF_CONFLICT &h00000001

type _RTL_RANGE
	Start as ULONGLONG
	End as ULONGLONG
	UserData as PVOID
	Owner as PVOID
	Attributes as UCHAR
	Flags as UCHAR
end type

type RTL_RANGE as _RTL_RANGE
type PRTL_RANGE as _RTL_RANGE ptr

#define RTL_RANGE_SHARED &h01
#define RTL_RANGE_CONFLICT &h02

type _RTL_RANGE_LIST
	ListHead as LIST_ENTRY
	Flags as ULONG
	Count as ULONG
	Stamp as ULONG
end type

type RTL_RANGE_LIST as _RTL_RANGE_LIST
type PRTL_RANGE_LIST as _RTL_RANGE_LIST ptr

type _RANGE_LIST_ITERATOR
	RangeListHead as PLIST_ENTRY
	MergedHead as PLIST_ENTRY
	Current as PVOID
	Stamp as ULONG
end type

type RTL_RANGE_LIST_ITERATOR as _RANGE_LIST_ITERATOR
type PRTL_RANGE_LIST_ITERATOR as _RANGE_LIST_ITERATOR ptr
type PRTL_CONFLICT_RANGE_CALLBACK as function DDKAPI(byval as PVOID, byval as PRTL_RANGE) as BOOLEAN

#define HASH_STRING_ALGORITHM_DEFAULT 0
#define HASH_STRING_ALGORITHM_X65599 1
#define HASH_STRING_ALGORITHM_INVALID &hffffffff

enum _SUITE_TYPE
	SmallBusiness
	Enterprise
	BackOffice
	CommunicationServer
	TerminalServer
	SmallBusinessRestricted
	EmbeddedNT
	DataCenter
	SingleUserTS
	Personal
	Blade
	MaxSuiteType
end enum

type SUITE_TYPE as _SUITE_TYPE
type PTIMER_APC_ROUTINE as sub DDKAPI(byval as PVOID, byval as ULONG, byval as LONG)
type WMI_NOTIFICATION_CALLBACK as sub DDKAPI(byval as PVOID, byval as PVOID)
type PFN_NUMBER as ULONG
type PPFN_NUMBER as ULONG ptr

#define PASSIVE_LEVEL 0
#define LOW_LEVEL 0
#define APC_LEVEL 1
#define DISPATCH_LEVEL 2
#define SYNCH_LEVEL 27
#define PROFILE_LEVEL 27
#define CLOCK1_LEVEL 28
#define CLOCK2_LEVEL 28
#define IPI_LEVEL 29
#define POWER_LEVEL 30
#define HIGH_LEVEL 31

union KPCR_TIB__u
	FiberData as PVOID
	Version as DWORD
end union

type _KPCR_TIB
	ExceptionList as PVOID
	StackBase as PVOID
	StackLimit as PVOID
	SubSystemTib as PVOID
	ArbitraryUserPointer as PVOID
	Self as PNT_TIB
	u as KPCR_TIB__u
end type

type KPCR_TIB as _KPCR_TIB
type PKPCR_TIB as _KPCR_TIB ptr


#define PCR_MINOR_VERSION 1
#define PCR_MAJOR_VERSION 1

type _KPCR
	Tib as KPCR_TIB
	Self as _KPCR ptr
	PCRCB as PKPRCB
	Irql as KIRQL
	IRR as ULONG
	IrrActive as ULONG
	IDR as ULONG
	KdVersionBlock as PVOID
	IDT as PUSHORT
	GDT as PUSHORT
	TSS as PKTSS
	MajorVersion as USHORT
	MinorVersion as USHORT
	SetMember as KAFFINITY
	StallScaleFactor as ULONG
	SpareUnused as UCHAR
	Number as UCHAR
end type

type KPCR as _KPCR
type PKPCR as _KPCR ptr

type _KFLOATING_SAVE
	ControlWord as ULONG
	StatusWord as ULONG
	ErrorOffset as ULONG
	ErrorSelector as ULONG
	DataOffset as ULONG
	DataSelector as ULONG
	Cr0NpxState as ULONG
	Spare1 as ULONG
end type

type KFLOATING_SAVE as _KFLOATING_SAVE
type PKFLOATING_SAVE as _KFLOATING_SAVE ptr

enum _INTERLOCKED_RESULT
	ResultNegative = ((&h8000 and  not &h4000) and (&h8000 or &h4000))
	ResultZero = (( not &h8000 and &h4000) and (&h8000 or &h4000))
	ResultPositive = (( not &h8000 and  not &h4000) and (&h8000 or &h4000))
end enum

type _IO_ERROR_LOG_PACKET
	MajorFunctionCode as UCHAR
	RetryCount as UCHAR
	DumpDataSize as USHORT
	NumberOfStrings as USHORT
	StringOffset as USHORT
	EventCategory as USHORT
	ErrorCode as NTSTATUS
	UniqueErrorValue as ULONG
	FinalStatus as NTSTATUS
	SequenceNumber as ULONG
	IoControlCode as ULONG
	DeviceOffset as LARGE_INTEGER
	DumpData(0 to 1-1) as ULONG
end type

type IO_ERROR_LOG_PACKET as _IO_ERROR_LOG_PACKET
type PIO_ERROR_LOG_PACKET as _IO_ERROR_LOG_PACKET ptr

type INTERLOCKED_RESULT as _INTERLOCKED_RESULT


type SSDT as function DDKAPI() as PVOID
type PSSDT as SSDT ptr
type SSPT as UCHAR
type PSSPT as UCHAR ptr

type _SSDT_ENTRY
	SSDT as PSSDT
	ServiceCounterTable as PULONG
	NumberOfServices as ULONG
	SSPT as PSSPT
end type

type SSDT_ENTRY as _SSDT_ENTRY
type PSSDT_ENTRY as _SSDT_ENTRY ptr


enum _MMFLUSH_TYPE
	MmFlushForDelete
	MmFlushForWrite
end enum

type MMFLUSH_TYPE as _MMFLUSH_TYPE

#define PAGE_SIZE &h1000
#define PAGE_SHIFT 12L
#define KI_USER_SHARED_DATA &hffdf0000
#define EFLAG_SIGN &h8000
#define EFLAG_ZERO &h4000
#define EFLAG_SELECT (&h8000 or &h4000)
#define RESULT_NEGATIVE ((&h8000 and  not &h4000) and (&h8000 or &h4000))
#define RESULT_ZERO (( not &h8000 and &h4000) and (&h8000 or &h4000))
#define RESULT_POSITIVE (( not &h8000 and  not &h4000) and (&h8000 or &h4000))

#define AT_EXTENDABLE_FILE &h00002000
#define SEC_NO_CHANGE &h00400000
#define AT_RESERVED &h20000000
#define AT_ROUND_TO_PAGE &h40000000
#define PROTECTED_POOL &h80000000





extern "windows"

declare function KeGetCurrentIrql DDKAPI alias "KeGetCurrentIrql" () as KIRQL
#ifndef InterlockedIncrement
declare function InterlockedIncrement DDKAPI alias "InterlockedIncrement" (byval Addend as PLONG) as LONG
#endif
#ifndef InterlockedDecrement
declare function InterlockedDecrement DDKAPI alias "InterlockedDecrement" (byval Addend as PLONG) as LONG
#endif
#ifndef InterlockedCompareExchange 
declare function InterlockedCompareExchange DDKAPI alias "InterlockedCompareExchange" (byval Destination as PLONG, byval Exchange as LONG, byval Comparand as LONG) as LONG
#endif
#ifndef InterlockedExchange 
declare function InterlockedExchange DDKAPI alias "InterlockedExchange" (byval Target as PLONG, byval Value as LONG) as LONG
#endif
#ifndef InterlockedExchangeAdd 
declare function InterlockedExchangeAdd DDKAPI alias "InterlockedExchangeAdd" (byval Addend as PLONG, byval Value as LONG) as LONG
#endif
declare function InterlockedPopEntrySList DDKAPI alias "InterlockedPopEntrySList" (byval ListHead as PSLIST_HEADER) as PSINGLE_LIST_ENTRY
declare function InterlockedPushEntrySList DDKAPI alias "InterlockedPushEntrySList" (byval ListHead as PSLIST_HEADER, byval ListEntry as PSINGLE_LIST_ENTRY) as PSINGLE_LIST_ENTRY
declare sub KefAcquireSpinLockAtDpcLevel DDKAPI alias "KefAcquireSpinLockAtDpcLevel" (byval SpinLock as PKSPIN_LOCK)
declare sub KefReleaseSpinLockFromDpcLevel DDKAPI alias "KefReleaseSpinLockFromDpcLevel" (byval SpinLock as PKSPIN_LOCK)
declare sub RtlAssert DDKAPI alias "RtlAssert" (byval FailedAssertion as PVOID, byval FileName as PVOID, byval LineNumber as ULONG, byval Message as PCHAR)
declare function PopEntryList DDKAPI alias "PopEntryList" (byval ListHead as PSINGLE_LIST_ENTRY) as PSINGLE_LIST_ENTRY
declare function RemoveHeadList DDKAPI alias "RemoveHeadList" (byval ListHead as PLIST_ENTRY) as PLIST_ENTRY
declare function RemoveTailList DDKAPI alias "RemoveTailList" (byval ListHead as PLIST_ENTRY) as PLIST_ENTRY
declare function RtlAnsiStringToUnicodeSize DDKAPI alias "RtlAnsiStringToUnicodeSize" (byval AnsiString as PANSI_STRING) as ULONG
declare function RtlAddRange DDKAPI alias "RtlAddRange" (byval RangeList as PRTL_RANGE_LIST, byval Start as ULONGLONG, byval End as ULONGLONG, byval Attributes as UCHAR, byval Flags as ULONG, byval UserData as PVOID, byval Owner as PVOID) as NTSTATUS
declare function RtlAnsiStringToUnicodeString DDKAPI alias "RtlAnsiStringToUnicodeString" (byval DestinationString as PUNICODE_STRING, byval SourceString as PANSI_STRING, byval AllocateDestinationString as BOOLEAN) as NTSTATUS
declare function RtlAppendUnicodeStringToString DDKAPI alias "RtlAppendUnicodeStringToString" (byval Destination as PUNICODE_STRING, byval Source as PUNICODE_STRING) as NTSTATUS
declare function RtlAppendUnicodeToString DDKAPI alias "RtlAppendUnicodeToString" (byval Destination as PUNICODE_STRING, byval Source as PCWSTR) as NTSTATUS
declare function RtlAreBitsClear DDKAPI alias "RtlAreBitsClear" (byval BitMapHeader as PRTL_BITMAP, byval StartingIndex as ULONG, byval Length as ULONG) as BOOLEAN
declare function RtlAreBitsSet DDKAPI alias "RtlAreBitsSet" (byval BitMapHeader as PRTL_BITMAP, byval StartingIndex as ULONG, byval Length as ULONG) as BOOLEAN
declare function RtlCharToInteger DDKAPI alias "RtlCharToInteger" (byval pString as PCSZ, byval lBase as ULONG, byval Value as PULONG) as NTSTATUS
declare function RtlCheckBit DDKAPI alias "RtlCheckBit" (byval BitMapHeader as PRTL_BITMAP, byval BitPosition as ULONG) as ULONG
declare function RtlCheckRegistryKey DDKAPI alias "RtlCheckRegistryKey" (byval RelativeTo as ULONG, byval Path as PWSTR) as NTSTATUS
declare sub RtlClearAllBits DDKAPI alias "RtlClearAllBits" (byval BitMapHeader as PRTL_BITMAP)
declare sub RtlClearBit DDKAPI alias "RtlClearBit" (byval BitMapHeader as PRTL_BITMAP, byval BitNumber as ULONG)
declare sub RtlClearBits DDKAPI alias "RtlClearBits" (byval BitMapHeader as PRTL_BITMAP, byval StartingIndex as ULONG, byval NumberToClear as ULONG)
declare function RtlCompareMemory DDKAPI alias "RtlCompareMemory" (byval Source1 as any ptr, byval Source2 as any ptr, byval Length as SIZE_T) as SIZE_T
declare function RtlCompareString DDKAPI alias "RtlCompareString" (byval String1 as PSTRING, byval String2 as PSTRING, byval CaseInSensitive as BOOLEAN) as LONG
declare function RtlCompareUnicodeString DDKAPI alias "RtlCompareUnicodeString" (byval String1 as PUNICODE_STRING, byval String2 as PUNICODE_STRING, byval CaseInSensitive as BOOLEAN) as LONG
declare function RtlConvertLongToLargeInteger DDKAPI alias "RtlConvertLongToLargeInteger" (byval SignedInteger as LONG) as LARGE_INTEGER
declare function RtlConvertLongToLuid DDKAPI alias "RtlConvertLongToLuid" (byval Long as LONG) as LUID
declare function RtlConvertUlongToLargeInteger DDKAPI alias "RtlConvertUlongToLargeInteger" (byval UnsignedInteger as ULONG) as LARGE_INTEGER
declare function RtlConvertUlongToLuid DDKAPI alias "RtlConvertUlongToLuid" (byval Ulong as ULONG) as LUID
declare sub RtlCopyMemory32 DDKAPI alias "RtlCopyMemory32" (byval Destination as any ptr, byval Source as any ptr, byval Length as ULONG)
declare function RtlCopyRangeList DDKAPI alias "RtlCopyRangeList" (byval CopyRangeList as PRTL_RANGE_LIST, byval RangeList as PRTL_RANGE_LIST) as NTSTATUS
declare sub RtlCopyString DDKAPI alias "RtlCopyString" (byval DestinationString as PSTRING, byval SourceString as PSTRING)
declare sub RtlCopyUnicodeString DDKAPI alias "RtlCopyUnicodeString" (byval DestinationString as PUNICODE_STRING, byval SourceString as PUNICODE_STRING)
declare function RtlCreateRegistryKey DDKAPI alias "RtlCreateRegistryKey" (byval RelativeTo as ULONG, byval Path as PWSTR) as NTSTATUS
declare function RtlCreateSecurityDescriptor DDKAPI alias "RtlCreateSecurityDescriptor" (byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval Revision as ULONG) as NTSTATUS
declare function RtlDeleteOwnersRanges DDKAPI alias "RtlDeleteOwnersRanges" (byval RangeList as PRTL_RANGE_LIST, byval Owner as PVOID) as NTSTATUS
declare function RtlDeleteRange DDKAPI alias "RtlDeleteRange" (byval RangeList as PRTL_RANGE_LIST, byval Start as ULONGLONG, byval End as ULONGLONG, byval Owner as PVOID) as NTSTATUS
declare function RtlDeleteRegistryValue DDKAPI alias "RtlDeleteRegistryValue" (byval RelativeTo as ULONG, byval Path as PCWSTR, byval ValueName as PCWSTR) as NTSTATUS
declare function RtlDosPathNameToNtPathName_U DDKAPI alias "RtlDosPathNameToNtPathName_U" (byval DosPathName as PCWSTR, byval NtPathName as PUNICODE_STRING, byval NtFileNamePart as PCWSTR ptr, byval DirectoryInfo as any ptr) as BOOL
declare function RtlEqualString DDKAPI alias "RtlEqualString" (byval String1 as PSTRING, byval String2 as PSTRING, byval CaseInSensitive as BOOLEAN) as BOOLEAN
declare function RtlEqualUnicodeString DDKAPI alias "RtlEqualUnicodeString" (byval String1 as UNICODE_STRING ptr, byval String2 as UNICODE_STRING ptr, byval CaseInSensitive as BOOLEAN) as BOOLEAN
declare function RtlFindClearBits DDKAPI alias "RtlFindClearBits" (byval BitMapHeader as PRTL_BITMAP, byval NumberToFind as ULONG, byval HintIndex as ULONG) as ULONG
declare function RtlFindClearBitsAndSet DDKAPI alias "RtlFindClearBitsAndSet" (byval BitMapHeader as PRTL_BITMAP, byval NumberToFind as ULONG, byval HintIndex as ULONG) as ULONG
declare function RtlFindClearRuns DDKAPI alias "RtlFindClearRuns" (byval BitMapHeader as PRTL_BITMAP, byval RunArray as PRTL_BITMAP_RUN, byval SizeOfRunArray as ULONG, byval LocateLongestRuns as BOOLEAN) as ULONG
declare function RtlFindFirstRunClear DDKAPI alias "RtlFindFirstRunClear" (byval BitMapHeader as PRTL_BITMAP, byval StartingIndex as PULONG) as ULONG
declare function RtlFindLastBackwardRunClear DDKAPI alias "RtlFindLastBackwardRunClear" (byval BitMapHeader as PRTL_BITMAP, byval FromIndex as ULONG, byval StartingRunIndex as PULONG) as ULONG
declare function RtlFindLeastSignificantBit DDKAPI alias "RtlFindLeastSignificantBit" (byval Set as ULONGLONG) as CCHAR
declare function RtlFindLongestRunClear DDKAPI alias "RtlFindLongestRunClear" (byval BitMapHeader as PRTL_BITMAP, byval StartingIndex as PULONG) as ULONG
declare function RtlFindMostSignificantBit DDKAPI alias "RtlFindMostSignificantBit" (byval Set as ULONGLONG) as CCHAR
declare function RtlFindNextForwardRunClear DDKAPI alias "RtlFindNextForwardRunClear" (byval BitMapHeader as PRTL_BITMAP, byval FromIndex as ULONG, byval StartingRunIndex as PULONG) as ULONG
declare function RtlFindRange DDKAPI alias "RtlFindRange" (byval RangeList as PRTL_RANGE_LIST, byval Minimum as ULONGLONG, byval Maximum as ULONGLONG, byval Length as ULONG, byval Alignment as ULONG, byval Flags as ULONG, byval AttributeAvailableMask as UCHAR, byval Context as PVOID, byval Callback as PRTL_CONFLICT_RANGE_CALLBACK, byval Start as PULONGLONG) as NTSTATUS
declare function RtlFindSetBits DDKAPI alias "RtlFindSetBits" (byval BitMapHeader as PRTL_BITMAP, byval NumberToFind as ULONG, byval HintIndex as ULONG) as ULONG
declare function RtlFindSetBitsAndClear DDKAPI alias "RtlFindSetBitsAndClear" (byval BitMapHeader as PRTL_BITMAP, byval NumberToFind as ULONG, byval HintIndex as ULONG) as ULONG
declare sub RtlFreeAnsiString DDKAPI alias "RtlFreeAnsiString" (byval AnsiString as PANSI_STRING)
declare sub RtlFreeRangeList DDKAPI alias "RtlFreeRangeList" (byval RangeList as PRTL_RANGE_LIST)
declare sub RtlFreeUnicodeString DDKAPI alias "RtlFreeUnicodeString" (byval UnicodeString as PUNICODE_STRING)
declare sub RtlGetCallersAddress DDKAPI alias "RtlGetCallersAddress" (byval CallersAddress as PVOID ptr, byval CallersCaller as PVOID ptr)
declare function RtlGetVersion DDKAPI alias "RtlGetVersion" (byval lpVersionInformation as PRTL_OSVERSIONINFOW) as NTSTATUS
declare function RtlGetFirstRange DDKAPI alias "RtlGetFirstRange" (byval RangeList as PRTL_RANGE_LIST, byval Iterator as PRTL_RANGE_LIST_ITERATOR, byval Range as PRTL_RANGE ptr) as NTSTATUS
declare function RtlGetNextRange DDKAPI alias "RtlGetNextRange" (byval Iterator as PRTL_RANGE_LIST_ITERATOR, byval Range as PRTL_RANGE ptr, byval MoveForwards as BOOLEAN) as NTSTATUS
declare function RtlGUIDFromString DDKAPI alias "RtlGUIDFromString" (byval GuidString as PUNICODE_STRING, byval Guid as GUID ptr) as NTSTATUS
declare function RtlHashUnicodeString DDKAPI alias "RtlHashUnicodeString" (byval String as UNICODE_STRING ptr, byval CaseInSensitive as BOOLEAN, byval HashAlgorithm as ULONG, byval HashValue as PULONG) as NTSTATUS
declare sub RtlInitAnsiString DDKAPI alias "RtlInitAnsiString" (byval DestinationString as PANSI_STRING, byval SourceString as PCSZ)
declare sub RtlInitializeBitMap DDKAPI alias "RtlInitializeBitMap" (byval BitMapHeader as PRTL_BITMAP, byval BitMapBuffer as PULONG, byval SizeOfBitMap as ULONG)
declare sub RtlInitializeRangeList DDKAPI alias "RtlInitializeRangeList" (byval RangeList as PRTL_RANGE_LIST)
declare sub RtlInitString DDKAPI alias "RtlInitString" (byval DestinationString as PSTRING, byval SourceString as PCSZ)
declare sub RtlInitUnicodeString DDKAPI alias "RtlInitUnicodeString" (byval DestinationString as PUNICODE_STRING, byval SourceString as PCWSTR)
declare function RtlInt64ToUnicodeString DDKAPI alias "RtlInt64ToUnicodeString" (byval Value as ULONGLONG, byval Base as ULONG, byval String as PUNICODE_STRING) as NTSTATUS
declare function RtlIntegerToUnicodeString DDKAPI alias "RtlIntegerToUnicodeString" (byval Value as ULONG, byval Base as ULONG, byval String as PUNICODE_STRING) as NTSTATUS
declare function RtlIntPtrToUnicodeString DDKAPI alias "RtlIntPtrToUnicodeString" (byval Value as PLONG, byval Base as ULONG, byval String as PUNICODE_STRING) as NTSTATUS
declare function RtlInvertRangeList DDKAPI alias "RtlInvertRangeList" (byval InvertedRangeList as PRTL_RANGE_LIST, byval RangeList as PRTL_RANGE_LIST) as NTSTATUS
declare function RtlIsRangeAvailable DDKAPI alias "RtlIsRangeAvailable" (byval RangeList as PRTL_RANGE_LIST, byval Start as ULONGLONG, byval End as ULONGLONG, byval Flags as ULONG, byval AttributeAvailableMask as UCHAR, byval Context as PVOID, byval Callback as PRTL_CONFLICT_RANGE_CALLBACK, byval Available as PBOOLEAN) as NTSTATUS
declare function RtlLengthSecurityDescriptor DDKAPI alias "RtlLengthSecurityDescriptor" (byval SecurityDescriptor as PSECURITY_DESCRIPTOR) as ULONG
declare sub RtlMapGenericMask DDKAPI alias "RtlMapGenericMask" (byval AccessMask as PACCESS_MASK, byval GenericMapping as PGENERIC_MAPPING)
declare function RtlMergeRangeLists DDKAPI alias "RtlMergeRangeLists" (byval MergedRangeList as PRTL_RANGE_LIST, byval RangeList1 as PRTL_RANGE_LIST, byval RangeList2 as PRTL_RANGE_LIST, byval Flags as ULONG) as NTSTATUS
declare function RtlNumberOfClearBits DDKAPI alias "RtlNumberOfClearBits" (byval BitMapHeader as PRTL_BITMAP) as ULONG
declare function RtlNumberOfSetBits DDKAPI alias "RtlNumberOfSetBits" (byval BitMapHeader as PRTL_BITMAP) as ULONG
declare sub RtlPrefetchMemoryNonTemporal DDKAPI alias "RtlPrefetchMemoryNonTemporal" (byval Source as PVOID, byval Length as SIZE_T)
declare function RtlPrefixUnicodeString DDKAPI alias "RtlPrefixUnicodeString" (byval String1 as PUNICODE_STRING, byval String2 as PUNICODE_STRING, byval CaseInSensitive as BOOLEAN) as BOOLEAN
declare function RtlQueryRegistryValues DDKAPI alias "RtlQueryRegistryValues" (byval RelativeTo as ULONG, byval Path as PCWSTR, byval QueryTable as PRTL_QUERY_REGISTRY_TABLE, byval Context as PVOID, byval Environment as PVOID) as NTSTATUS
declare sub RtlRetrieveUlong DDKAPI alias "RtlRetrieveUlong" (byval DestinationAddress as PULONG, byval SourceAddress as PULONG)
declare sub RtlRetrieveUshort DDKAPI alias "RtlRetrieveUshort" (byval DestinationAddress as PUSHORT, byval SourceAddress as PUSHORT)
declare sub RtlSetAllBits DDKAPI alias "RtlSetAllBits" (byval BitMapHeader as PRTL_BITMAP)
declare sub RtlSetBit DDKAPI alias "RtlSetBit" (byval BitMapHeader as PRTL_BITMAP, byval BitNumber as ULONG)
declare sub RtlSetBits DDKAPI alias "RtlSetBits" (byval BitMapHeader as PRTL_BITMAP, byval StartingIndex as ULONG, byval NumberToSet as ULONG)
declare function RtlSetDaclSecurityDescriptor DDKAPI alias "RtlSetDaclSecurityDescriptor" (byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval DaclPresent as BOOLEAN, byval Dacl as PACL, byval DaclDefaulted as BOOLEAN) as NTSTATUS
declare sub RtlStoreUlong DDKAPI alias "RtlStoreUlong" (byval Address as PULONG, byval Value as ULONG)
declare sub RtlStoreUlonglong DDKAPI alias "RtlStoreUlonglong" (byval Address as PULONGLONG, byval Value as ULONGLONG)
declare sub RtlStoreUlongPtr DDKAPI alias "RtlStoreUlongPtr" (byval Address as PULONG_PTR, byval Value as ULONG_PTR)
declare sub RtlStoreUshort DDKAPI alias "RtlStoreUshort" (byval Address as PUSHORT, byval Value as USHORT)
declare function RtlStringFromGUID DDKAPI alias "RtlStringFromGUID" (byval Guid as GUID ptr, byval GuidString as PUNICODE_STRING) as NTSTATUS
declare function RtlTestBit DDKAPI alias "RtlTestBit" (byval BitMapHeader as PRTL_BITMAP, byval BitNumber as ULONG) as BOOLEAN
declare function RtlTimeFieldsToTime DDKAPI alias "RtlTimeFieldsToTime" (byval TimeFields as PTIME_FIELDS, byval Time as PLARGE_INTEGER) as BOOLEAN
declare sub RtlTimeToTimeFields DDKAPI alias "RtlTimeToTimeFields" (byval Time as PLARGE_INTEGER, byval TimeFields as PTIME_FIELDS)
declare function RtlUlongByteSwap DDKAPI alias "RtlUlongByteSwap" (byval Source as ULONG) as ULONG
declare function RtlUlonglongByteSwap DDKAPI alias "RtlUlonglongByteSwap" (byval Source as ULONGLONG) as ULONGLONG
declare function RtlUnicodeStringToAnsiSize DDKAPI alias "RtlUnicodeStringToAnsiSize" (byval UnicodeString as PUNICODE_STRING) as ULONG
declare function RtlUnicodeStringToAnsiString DDKAPI alias "RtlUnicodeStringToAnsiString" (byval DestinationString as PANSI_STRING, byval SourceString as PUNICODE_STRING, byval AllocateDestinationString as BOOLEAN) as NTSTATUS
declare function RtlUnicodeStringToInteger DDKAPI alias "RtlUnicodeStringToInteger" (byval String as PUNICODE_STRING, byval Base as ULONG, byval Value as PULONG) as NTSTATUS
declare function RtlUpcaseUnicodeChar DDKAPI alias "RtlUpcaseUnicodeChar" (byval SourceCharacter as WCHAR) as WCHAR
declare function RtlUpcaseUnicodeString DDKAPI alias "RtlUpcaseUnicodeString" (byval DestinationString as PUNICODE_STRING, byval SourceString as PCUNICODE_STRING, byval AllocateDestinationString as BOOLEAN) as NTSTATUS
declare function RtlUpperChar DDKAPI alias "RtlUpperChar" (byval Character as CHAR) as CHAR
declare sub RtlUpperString DDKAPI alias "RtlUpperString" (byval DestinationString as PSTRING, byval SourceString as PSTRING)
declare function RtlUshortByteSwap DDKAPI alias "RtlUshortByteSwap" (byval Source as USHORT) as USHORT
declare function RtlValidRelativeSecurityDescriptor DDKAPI alias "RtlValidRelativeSecurityDescriptor" (byval SecurityDescriptorInput as PSECURITY_DESCRIPTOR, byval SecurityDescriptorLength as ULONG, byval RequiredInformation as SECURITY_INFORMATION) as BOOLEAN
declare function RtlValidSecurityDescriptor DDKAPI alias "RtlValidSecurityDescriptor" (byval SecurityDescriptor as PSECURITY_DESCRIPTOR) as BOOLEAN
declare function RtlVerifyVersionInfo DDKAPI alias "RtlVerifyVersionInfo" (byval VersionInfo as PRTL_OSVERSIONINFOEXW, byval TypeMask as ULONG, byval ConditionMask as ULONGLONG) as NTSTATUS
declare function RtlVolumeDeviceToDosName DDKAPI alias "RtlVolumeDeviceToDosName" (byval VolumeDeviceObject as PVOID, byval DosName as PUNICODE_STRING) as NTSTATUS
declare function RtlWalkFrameChain DDKAPI alias "RtlWalkFrameChain" (byval Callers as PVOID ptr, byval Count as ULONG, byval Flags as ULONG) as ULONG
declare function RtlWriteRegistryValue DDKAPI alias "RtlWriteRegistryValue" (byval RelativeTo as ULONG, byval Path as PCWSTR, byval ValueName as PCWSTR, byval ValueType as ULONG, byval ValueData as PVOID, byval ValueLength as ULONG) as NTSTATUS
declare function RtlxUnicodeStringToAnsiSize DDKAPI alias "RtlxUnicodeStringToAnsiSize" (byval UnicodeString as PUNICODE_STRING) as ULONG
declare sub ExAcquireFastMutex DDKAPI alias "ExAcquireFastMutex" (byval FastMutex as PFAST_MUTEX)
declare sub ExAcquireFastMutexUnsafe DDKAPI alias "ExAcquireFastMutexUnsafe" (byval FastMutex as PFAST_MUTEX)
declare function ExAcquireResourceExclusiveLite DDKAPI alias "ExAcquireResourceExclusiveLite" (byval Resource as PERESOURCE, byval Wait as BOOLEAN) as BOOLEAN
declare function ExAcquireResourceSharedLite DDKAPI alias "ExAcquireResourceSharedLite" (byval Resource as PERESOURCE, byval Wait as BOOLEAN) as BOOLEAN
declare function ExAcquireSharedStarveExclusive DDKAPI alias "ExAcquireSharedStarveExclusive" (byval Resource as PERESOURCE, byval Wait as BOOLEAN) as BOOLEAN
declare function ExAcquireSharedWaitForExclusive DDKAPI alias "ExAcquireSharedWaitForExclusive" (byval Resource as PERESOURCE, byval Wait as BOOLEAN) as BOOLEAN
declare function ExInterlockedPopEntrySList DDKAPI alias "ExInterlockedPopEntrySList" (byval ListHead as PSLIST_HEADER, byval Lock as PKSPIN_LOCK) as PSINGLE_LIST_ENTRY
declare function ExInterlockedPushEntrySList DDKAPI alias "ExInterlockedPushEntrySList" (byval ListHead as PSLIST_HEADER, byval ListEntry as PSINGLE_LIST_ENTRY, byval Lock as PKSPIN_LOCK) as PSINGLE_LIST_ENTRY
declare function ExAllocateFromNPagedLookasideList DDKAPI alias "ExAllocateFromNPagedLookasideList" (byval Lookaside as PNPAGED_LOOKASIDE_LIST) as PVOID
declare sub ExFreeToNPagedLookasideList DDKAPI alias "ExFreeToNPagedLookasideList" (byval Lookaside as PNPAGED_LOOKASIDE_LIST, byval Entry as PVOID)
declare function ExAllocateFromPagedLookasideList DDKAPI alias "ExAllocateFromPagedLookasideList" (byval Lookaside as PPAGED_LOOKASIDE_LIST) as PVOID
declare sub ExFreeToPagedLookasideList DDKAPI alias "ExFreeToPagedLookasideList" (byval Lookaside as PPAGED_LOOKASIDE_LIST, byval Entry as PVOID)
declare function ExAllocatePoolWithQuotaTag DDKAPI alias "ExAllocatePoolWithQuotaTag" (byval PoolType as POOL_TYPE, byval NumberOfBytes as SIZE_T, byval Tag as ULONG) as PVOID
declare function ExAllocatePoolWithTag DDKAPI alias "ExAllocatePoolWithTag" (byval PoolType as POOL_TYPE, byval NumberOfBytes as SIZE_T, byval Tag as ULONG) as PVOID
declare function ExAllocatePool DDKAPI alias "ExAllocatePool" (byval PoolType as POOL_TYPE, byval NumberOfBytes as SIZE_T) as PVOID
declare function ExAllocatePoolWithQuota DDKAPI alias "ExAllocatePoolWithQuota" (byval PoolType as POOL_TYPE, byval NumberOfBytes as SIZE_T) as PVOID
declare function ExAllocatePoolWithTagPriority DDKAPI alias "ExAllocatePoolWithTagPriority" (byval PoolType as POOL_TYPE, byval NumberOfBytes as SIZE_T, byval Tag as ULONG, byval Priority as EX_POOL_PRIORITY) as PVOID
declare sub ExConvertExclusiveToSharedLite DDKAPI alias "ExConvertExclusiveToSharedLite" (byval Resource as PERESOURCE)
declare function ExCreateCallback DDKAPI alias "ExCreateCallback" (byval CallbackObject as PCALLBACK_OBJECT ptr, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval Create as BOOLEAN, byval AllowMultipleCallbacks as BOOLEAN) as NTSTATUS
declare sub ExDeleteNPagedLookasideList DDKAPI alias "ExDeleteNPagedLookasideList" (byval Lookaside as PNPAGED_LOOKASIDE_LIST)
declare sub ExDeletePagedLookasideList DDKAPI alias "ExDeletePagedLookasideList" (byval Lookaside as PPAGED_LOOKASIDE_LIST)
declare function ExDeleteResourceLite DDKAPI alias "ExDeleteResourceLite" (byval Resource as PERESOURCE) as NTSTATUS
declare sub ExFreePool DDKAPI alias "ExFreePool" (byval P as PVOID)
declare sub ExFreePoolWithTag DDKAPI alias "ExFreePoolWithTag" (byval P as PVOID, byval Tag as ULONG)
declare function ExGetExclusiveWaiterCount DDKAPI alias "ExGetExclusiveWaiterCount" (byval Resource as PERESOURCE) as ULONG
declare function ExGetPreviousMode DDKAPI alias "ExGetPreviousMode" () as KPROCESSOR_MODE
declare function ExGetSharedWaiterCount DDKAPI alias "ExGetSharedWaiterCount" (byval Resource as PERESOURCE) as ULONG
declare sub KeInitializeEvent DDKAPI alias "KeInitializeEvent" (byval Event as PRKEVENT, byval Type as EVENT_TYPE, byval State as BOOLEAN)
declare sub ExInitializeNPagedLookasideList DDKAPI alias "ExInitializeNPagedLookasideList" (byval Lookaside as PNPAGED_LOOKASIDE_LIST, byval Allocate as PALLOCATE_FUNCTION, byval Free as PFREE_FUNCTION, byval Flags as ULONG, byval Size as SIZE_T, byval Tag as ULONG, byval Depth as USHORT)
declare sub ExInitializePagedLookasideList DDKAPI alias "ExInitializePagedLookasideList" (byval Lookaside as PPAGED_LOOKASIDE_LIST, byval Allocate as PALLOCATE_FUNCTION, byval Free as PFREE_FUNCTION, byval Flags as ULONG, byval Size as SIZE_T, byval Tag as ULONG, byval Depth as USHORT)
declare function ExInitializeResourceLite DDKAPI alias "ExInitializeResourceLite" (byval Resource as PERESOURCE) as NTSTATUS
declare function ExInterlockedAddLargeInteger DDKAPI alias "ExInterlockedAddLargeInteger" (byval Addend as PLARGE_INTEGER, byval Increment as LARGE_INTEGER, byval Lock as PKSPIN_LOCK) as LARGE_INTEGER
declare sub ExInterlockedAddLargeStatistic DDKAPI alias "ExInterlockedAddLargeStatistic" (byval Addend as PLARGE_INTEGER, byval Increment as ULONG)
declare function ExInterlockedAddUlong DDKAPI alias "ExInterlockedAddUlong" (byval Addend as PULONG, byval Increment as ULONG, byval Lock as PKSPIN_LOCK) as ULONG
declare function ExfInterlockedAddUlong DDKAPI alias "ExfInterlockedAddUlong" (byval Addend as PULONG, byval Increment as ULONG, byval Lock as PKSPIN_LOCK) as ULONG
declare function ExInterlockedCompareExchange64 DDKAPI alias "ExInterlockedCompareExchange64" (byval Destination as PLONGLONG, byval Exchange as PLONGLONG, byval Comparand as PLONGLONG, byval Lock as PKSPIN_LOCK) as LONGLONG
declare function ExInterlockedFlushSList DDKAPI alias "ExInterlockedFlushSList" (byval ListHead as PSLIST_HEADER) as PSINGLE_LIST_ENTRY
declare function ExInterlockedInsertHeadList DDKAPI alias "ExInterlockedInsertHeadList" (byval ListHead as PLIST_ENTRY, byval ListEntry as PLIST_ENTRY, byval Lock as PKSPIN_LOCK) as PLIST_ENTRY
declare function ExfInterlockedInsertHeadList DDKAPI alias "ExfInterlockedInsertHeadList" (byval ListHead as PLIST_ENTRY, byval ListEntry as PLIST_ENTRY, byval Lock as PKSPIN_LOCK) as PLIST_ENTRY
declare function ExInterlockedInsertTailList DDKAPI alias "ExInterlockedInsertTailList" (byval ListHead as PLIST_ENTRY, byval ListEntry as PLIST_ENTRY, byval Lock as PKSPIN_LOCK) as PLIST_ENTRY
declare function ExfInterlockedInsertTailList DDKAPI alias "ExfInterlockedInsertTailList" (byval ListHead as PLIST_ENTRY, byval ListEntry as PLIST_ENTRY, byval Lock as PKSPIN_LOCK) as PLIST_ENTRY
declare function ExInterlockedPopEntryList DDKAPI alias "ExInterlockedPopEntryList" (byval ListHead as PSINGLE_LIST_ENTRY, byval Lock as PKSPIN_LOCK) as PSINGLE_LIST_ENTRY
declare function ExfInterlockedPopEntryList DDKAPI alias "ExfInterlockedPopEntryList" (byval ListHead as PSINGLE_LIST_ENTRY, byval Lock as PKSPIN_LOCK) as PSINGLE_LIST_ENTRY
declare function ExInterlockedPushEntryList DDKAPI alias "ExInterlockedPushEntryList" (byval ListHead as PSINGLE_LIST_ENTRY, byval ListEntry as PSINGLE_LIST_ENTRY, byval Lock as PKSPIN_LOCK) as PSINGLE_LIST_ENTRY
declare function ExfInterlockedPushEntryList DDKAPI alias "ExfInterlockedPushEntryList" (byval ListHead as PSINGLE_LIST_ENTRY, byval ListEntry as PSINGLE_LIST_ENTRY, byval Lock as PKSPIN_LOCK) as PSINGLE_LIST_ENTRY
declare function ExInterlockedRemoveHeadList DDKAPI alias "ExInterlockedRemoveHeadList" (byval ListHead as PLIST_ENTRY, byval Lock as PKSPIN_LOCK) as PLIST_ENTRY
declare function ExfInterlockedRemoveHeadList DDKAPI alias "ExfInterlockedRemoveHeadList" (byval ListHead as PLIST_ENTRY, byval Lock as PKSPIN_LOCK) as PLIST_ENTRY
declare function ExIsProcessorFeaturePresent DDKAPI alias "ExIsProcessorFeaturePresent" (byval ProcessorFeature as ULONG) as BOOLEAN
declare function ExIsResourceAcquiredExclusiveLite DDKAPI alias "ExIsResourceAcquiredExclusiveLite" (byval Resource as PERESOURCE) as BOOLEAN
declare function ExIsResourceAcquiredLite DDKAPI alias "ExIsResourceAcquiredLite" (byval Resource as PERESOURCE) as USHORT
declare function ExIsResourceAcquiredSharedLite DDKAPI alias "ExIsResourceAcquiredSharedLite" (byval Resource as PERESOURCE) as USHORT
declare sub ExLocalTimeToSystemTime DDKAPI alias "ExLocalTimeToSystemTime" (byval LocalTime as PLARGE_INTEGER, byval SystemTime as PLARGE_INTEGER)
declare sub ExNotifyCallback DDKAPI alias "ExNotifyCallback" (byval CallbackObject as PCALLBACK_OBJECT, byval Argument1 as PVOID, byval Argument2 as PVOID)
declare sub ExRaiseAccessViolation DDKAPI alias "ExRaiseAccessViolation" ()
declare sub ExRaiseDatatypeMisalignment DDKAPI alias "ExRaiseDatatypeMisalignment" ()
declare sub ExRaiseStatus DDKAPI alias "ExRaiseStatus" (byval Status as NTSTATUS)
declare function ExRegisterCallback DDKAPI alias "ExRegisterCallback" (byval CallbackObject as PCALLBACK_OBJECT, byval CallbackFunction as PCALLBACK_FUNCTION, byval CallbackContext as PVOID) as PVOID
declare sub ExReinitializeResourceLite DDKAPI alias "ExReinitializeResourceLite" (byval Resource as PERESOURCE)
declare sub ExReleaseFastMutex DDKAPI alias "ExReleaseFastMutex" (byval FastMutex as PFAST_MUTEX)
declare sub ExReleaseFastMutexUnsafe DDKAPI alias "ExReleaseFastMutexUnsafe" (byval FastMutex as PFAST_MUTEX)
declare sub ExReleaseResourceForThreadLite DDKAPI alias "ExReleaseResourceForThreadLite" (byval Resource as PERESOURCE, byval ResourceThreadId as ERESOURCE_THREAD)
declare sub ExReleaseResourceLite DDKAPI alias "ExReleaseResourceLite" (byval Resource as PERESOURCE)
declare sub ExSetResourceOwnerPointer DDKAPI alias "ExSetResourceOwnerPointer" (byval Resource as PERESOURCE, byval OwnerPointer as PVOID)
declare function ExSetTimerResolution DDKAPI alias "ExSetTimerResolution" (byval DesiredTime as ULONG, byval SetResolution as BOOLEAN) as ULONG
declare sub ExSystemTimeToLocalTime DDKAPI alias "ExSystemTimeToLocalTime" (byval SystemTime as PLARGE_INTEGER, byval LocalTime as PLARGE_INTEGER)
declare function ExTryToAcquireFastMutex DDKAPI alias "ExTryToAcquireFastMutex" (byval FastMutex as PFAST_MUTEX) as BOOLEAN
declare function ExTryToAcquireResourceExclusiveLite DDKAPI alias "ExTryToAcquireResourceExclusiveLite" (byval Resource as PERESOURCE) as BOOLEAN
declare sub ExUnregisterCallback DDKAPI alias "ExUnregisterCallback" (byval CbRegistration as PVOID)
declare function ExUuidCreate DDKAPI alias "ExUuidCreate" (byval Uuid as UUID ptr) as NTSTATUS
declare function ExVerifySuite DDKAPI alias "ExVerifySuite" (byval SuiteType as SUITE_TYPE) as BOOLEAN
declare sub ProbeForRead DDKAPI alias "ProbeForRead" (byval Address as any ptr, byval Length as ULONG, byval Alignment as ULONG)
declare sub ProbeForWrite DDKAPI alias "ProbeForWrite" (byval Address as any ptr, byval Length as ULONG, byval Alignment as ULONG)
declare function CmRegisterCallback DDKAPI alias "CmRegisterCallback" (byval Function as PEX_CALLBACK_FUNCTION, byval Context as PVOID, byval Cookie as PLARGE_INTEGER) as NTSTATUS
declare function CmUnRegisterCallback DDKAPI alias "CmUnRegisterCallback" (byval Cookie as LARGE_INTEGER) as NTSTATUS
declare function FsRtlIsTotalDeviceFailure DDKAPI alias "FsRtlIsTotalDeviceFailure" (byval Status as NTSTATUS) as BOOLEAN
declare sub HalExamineMBR DDKAPI alias "HalExamineMBR" (byval DeviceObject as PDEVICE_OBJECT, byval SectorSize as ULONG, byval MBRTypeIdentifier as ULONG, byval Buffer as PVOID)
declare sub READ_PORT_BUFFER_UCHAR DDKAPI alias "READ_PORT_BUFFER_UCHAR" (byval Port as PUCHAR, byval Buffer as PUCHAR, byval Count as ULONG)
declare sub READ_PORT_BUFFER_ULONG DDKAPI alias "READ_PORT_BUFFER_ULONG" (byval Port as PULONG, byval Buffer as PULONG, byval Count as ULONG)
declare sub READ_PORT_BUFFER_USHORT DDKAPI alias "READ_PORT_BUFFER_USHORT" (byval Port as PUSHORT, byval Buffer as PUSHORT, byval Count as ULONG)
declare function READ_PORT_UCHAR DDKAPI alias "READ_PORT_UCHAR" (byval Port as PUCHAR) as UCHAR
declare function READ_PORT_ULONG DDKAPI alias "READ_PORT_ULONG" (byval Port as PULONG) as ULONG
declare function READ_PORT_USHORT DDKAPI alias "READ_PORT_USHORT" (byval Port as PUSHORT) as USHORT
declare sub READ_REGISTER_BUFFER_UCHAR DDKAPI alias "READ_REGISTER_BUFFER_UCHAR" (byval Register as PUCHAR, byval Buffer as PUCHAR, byval Count as ULONG)
declare sub READ_REGISTER_BUFFER_ULONG DDKAPI alias "READ_REGISTER_BUFFER_ULONG" (byval Register as PULONG, byval Buffer as PULONG, byval Count as ULONG)
declare sub READ_REGISTER_BUFFER_USHORT DDKAPI alias "READ_REGISTER_BUFFER_USHORT" (byval Register as PUSHORT, byval Buffer as PUSHORT, byval Count as ULONG)
declare function READ_REGISTER_UCHAR DDKAPI alias "READ_REGISTER_UCHAR" (byval Register as PUCHAR) as UCHAR
declare function READ_REGISTER_ULONG DDKAPI alias "READ_REGISTER_ULONG" (byval Register as PULONG) as ULONG
declare function READ_REGISTER_USHORT DDKAPI alias "READ_REGISTER_USHORT" (byval Register as PUSHORT) as USHORT
declare sub WRITE_PORT_BUFFER_UCHAR DDKAPI alias "WRITE_PORT_BUFFER_UCHAR" (byval Port as PUCHAR, byval Buffer as PUCHAR, byval Count as ULONG)
declare sub WRITE_PORT_BUFFER_ULONG DDKAPI alias "WRITE_PORT_BUFFER_ULONG" (byval Port as PULONG, byval Buffer as PULONG, byval Count as ULONG)
declare sub WRITE_PORT_BUFFER_USHORT DDKAPI alias "WRITE_PORT_BUFFER_USHORT" (byval Port as PUSHORT, byval Buffer as PUSHORT, byval Count as ULONG)
declare sub WRITE_PORT_UCHAR DDKAPI alias "WRITE_PORT_UCHAR" (byval Port as PUCHAR, byval Value as UCHAR)
declare sub WRITE_PORT_ULONG DDKAPI alias "WRITE_PORT_ULONG" (byval Port as PULONG, byval Value as ULONG)
declare sub WRITE_PORT_USHORT DDKAPI alias "WRITE_PORT_USHORT" (byval Port as PUSHORT, byval Value as USHORT)
declare sub WRITE_REGISTER_BUFFER_UCHAR DDKAPI alias "WRITE_REGISTER_BUFFER_UCHAR" (byval Register as PUCHAR, byval Buffer as PUCHAR, byval Count as ULONG)
declare sub WRITE_REGISTER_BUFFER_ULONG DDKAPI alias "WRITE_REGISTER_BUFFER_ULONG" (byval Register as PULONG, byval Buffer as PULONG, byval Count as ULONG)
declare sub WRITE_REGISTER_BUFFER_USHORT DDKAPI alias "WRITE_REGISTER_BUFFER_USHORT" (byval Register as PUSHORT, byval Buffer as PUSHORT, byval Count as ULONG)
declare sub WRITE_REGISTER_UCHAR DDKAPI alias "WRITE_REGISTER_UCHAR" (byval Register as PUCHAR, byval Value as UCHAR)
declare sub WRITE_REGISTER_ULONG DDKAPI alias "WRITE_REGISTER_ULONG" (byval Register as PULONG, byval Value as ULONG)
declare sub WRITE_REGISTER_USHORT DDKAPI alias "WRITE_REGISTER_USHORT" (byval Register as PUSHORT, byval Value as USHORT)
declare sub IoAcquireCancelSpinLock DDKAPI alias "IoAcquireCancelSpinLock" (byval Irql as PKIRQL)
declare function IoAcquireRemoveLockEx DDKAPI alias "IoAcquireRemoveLockEx" (byval RemoveLock as PIO_REMOVE_LOCK, byval Tag as PVOID, byval File as PCSTR, byval Line as ULONG, byval RemlockSize as ULONG) as NTSTATUS
declare sub IoAllocateController DDKAPI alias "IoAllocateController" (byval ControllerObject as PCONTROLLER_OBJECT, byval DeviceObject as PDEVICE_OBJECT, byval ExecutionRoutine as PDRIVER_CONTROL, byval Context as PVOID)
declare function IoAllocateDriverObjectExtension DDKAPI alias "IoAllocateDriverObjectExtension" (byval DriverObject as PDRIVER_OBJECT, byval ClientIdentificationAddress as PVOID, byval DriverObjectExtensionSize as ULONG, byval DriverObjectExtension as PVOID ptr) as NTSTATUS
declare function IoAllocateErrorLogEntry DDKAPI alias "IoAllocateErrorLogEntry" (byval IoObject as PVOID, byval EntrySize as UCHAR) as PVOID
declare function IoAllocateIrp DDKAPI alias "IoAllocateIrp" (byval StackSize as CCHAR, byval ChargeQuota as BOOLEAN) as PIRP
declare function IoAllocateMdl DDKAPI alias "IoAllocateMdl" (byval VirtualAddress as PVOID, byval Length as ULONG, byval SecondaryBuffer as BOOLEAN, byval ChargeQuota as BOOLEAN, byval Irp as PIRP) as PMDL
declare function IoAllocateWorkItem DDKAPI alias "IoAllocateWorkItem" (byval DeviceObject as PDEVICE_OBJECT) as PIO_WORKITEM
declare function IoAttachDevice DDKAPI alias "IoAttachDevice" (byval SourceDevice as PDEVICE_OBJECT, byval TargetDevice as PUNICODE_STRING, byval AttachedDevice as PDEVICE_OBJECT ptr) as NTSTATUS
declare function IoAttachDeviceToDeviceStack DDKAPI alias "IoAttachDeviceToDeviceStack" (byval SourceDevice as PDEVICE_OBJECT, byval TargetDevice as PDEVICE_OBJECT) as PDEVICE_OBJECT
declare function IoBuildAsynchronousFsdRequest DDKAPI alias "IoBuildAsynchronousFsdRequest" (byval MajorFunction as ULONG, byval DeviceObject as PDEVICE_OBJECT, byval Buffer as PVOID, byval Length as ULONG, byval StartingOffset as PLARGE_INTEGER, byval IoStatusBlock as PIO_STATUS_BLOCK) as PIRP
declare function IoBuildDeviceIoControlRequest DDKAPI alias "IoBuildDeviceIoControlRequest" (byval IoControlCode as ULONG, byval DeviceObject as PDEVICE_OBJECT, byval InputBuffer as PVOID, byval InputBufferLength as ULONG, byval OutputBuffer as PVOID, byval OutputBufferLength as ULONG, byval InternalDeviceIoControl as BOOLEAN, byval Event as PKEVENT, byval IoStatusBlock as PIO_STATUS_BLOCK) as PIRP
declare sub IoBuildPartialMdl DDKAPI alias "IoBuildPartialMdl" (byval SourceMdl as PMDL, byval TargetMdl as PMDL, byval VirtualAddress as PVOID, byval Length as ULONG)
declare function IoBuildSynchronousFsdRequest DDKAPI alias "IoBuildSynchronousFsdRequest" (byval MajorFunction as ULONG, byval DeviceObject as PDEVICE_OBJECT, byval Buffer as PVOID, byval Length as ULONG, byval StartingOffset as PLARGE_INTEGER, byval Event as PKEVENT, byval IoStatusBlock as PIO_STATUS_BLOCK) as PIRP
declare function IofCallDriver DDKAPI alias "IofCallDriver" (byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
declare sub IoCancelFileOpen DDKAPI alias "IoCancelFileOpen" (byval DeviceObject as PDEVICE_OBJECT, byval FileObject as PFILE_OBJECT)
declare function IoCancelIrp DDKAPI alias "IoCancelIrp" (byval Irp as PIRP) as BOOLEAN
declare function IoCheckShareAccess DDKAPI alias "IoCheckShareAccess" (byval DesiredAccess as ACCESS_MASK, byval DesiredShareAccess as ULONG, byval FileObject as PFILE_OBJECT, byval ShareAccess as PSHARE_ACCESS, byval Update as BOOLEAN) as NTSTATUS
declare sub IofCompleteRequest DDKAPI alias "IofCompleteRequest" (byval Irp as PIRP, byval PriorityBoost as CCHAR)
declare function IoConnectInterrupt DDKAPI alias "IoConnectInterrupt" (byval InterruptObject as PKINTERRUPT ptr, byval ServiceRoutine as PKSERVICE_ROUTINE, byval ServiceContext as PVOID, byval SpinLock as PKSPIN_LOCK, byval Vector as ULONG, byval Irql as KIRQL, byval SynchronizeIrql as KIRQL, byval InterruptMode as KINTERRUPT_MODE, byval ShareVector as BOOLEAN, byval ProcessorEnableMask as KAFFINITY, byval FloatingSave as BOOLEAN) as NTSTATUS
declare function IoCreateController DDKAPI alias "IoCreateController" (byval Size as ULONG) as PCONTROLLER_OBJECT
declare function IoCreateDevice DDKAPI alias "IoCreateDevice" (byval DriverObject as PDRIVER_OBJECT, byval DeviceExtensionSize as ULONG, byval DeviceName as PUNICODE_STRING, byval DeviceType as ULONG, byval DeviceCharacteristics as ULONG, byval Exclusive as BOOLEAN, byval DeviceObject as PDEVICE_OBJECT ptr) as NTSTATUS
declare function IoCreateDisk DDKAPI alias "IoCreateDisk" (byval DeviceObject as PDEVICE_OBJECT, byval Disk as PCREATE_DISK) as NTSTATUS
declare function IoCreateFile DDKAPI alias "IoCreateFile" (byval FileHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval IoStatusBlock as PIO_STATUS_BLOCK, byval AllocationSize as PLARGE_INTEGER, byval FileAttributes as ULONG, byval ShareAccess as ULONG, byval Disposition as ULONG, byval CreateOptions as ULONG, byval EaBuffer as PVOID, byval EaLength as ULONG, byval CreateFileType as CREATE_FILE_TYPE, byval ExtraCreateParameters as PVOID, byval Options as ULONG) as NTSTATUS
declare function IoCreateNotificationEvent DDKAPI alias "IoCreateNotificationEvent" (byval EventName as PUNICODE_STRING, byval EventHandle as PHANDLE) as PKEVENT
declare function IoCreateSymbolicLink DDKAPI alias "IoCreateSymbolicLink" (byval SymbolicLinkName as PUNICODE_STRING, byval DeviceName as PUNICODE_STRING) as NTSTATUS
declare function IoCreateSynchronizationEvent DDKAPI alias "IoCreateSynchronizationEvent" (byval EventName as PUNICODE_STRING, byval EventHandle as PHANDLE) as PKEVENT
declare function IoCreateUnprotectedSymbolicLink DDKAPI alias "IoCreateUnprotectedSymbolicLink" (byval SymbolicLinkName as PUNICODE_STRING, byval DeviceName as PUNICODE_STRING) as NTSTATUS
declare sub IoCsqInitialize DDKAPI alias "IoCsqInitialize" (byval Csq as PIO_CSQ, byval CsqInsertIrp as PIO_CSQ_INSERT_IRP, byval CsqRemoveIrp as PIO_CSQ_REMOVE_IRP, byval CsqPeekNextIrp as PIO_CSQ_PEEK_NEXT_IRP, byval CsqAcquireLock as PIO_CSQ_ACQUIRE_LOCK, byval CsqReleaseLock as PIO_CSQ_RELEASE_LOCK, byval CsqCompleteCanceledIrp as PIO_CSQ_COMPLETE_CANCELED_IRP)
declare sub IoCsqInsertIrp DDKAPI alias "IoCsqInsertIrp" (byval Csq as PIO_CSQ, byval Irp as PIRP, byval Context as PIO_CSQ_IRP_CONTEXT)
declare function IoCsqRemoveIrp DDKAPI alias "IoCsqRemoveIrp" (byval Csq as PIO_CSQ, byval Context as PIO_CSQ_IRP_CONTEXT) as PIRP
declare function IoCsqRemoveNextIrp DDKAPI alias "IoCsqRemoveNextIrp" (byval Csq as PIO_CSQ, byval PeekContext as PVOID) as PIRP
declare sub IoDeleteController DDKAPI alias "IoDeleteController" (byval ControllerObject as PCONTROLLER_OBJECT)
declare sub IoDeleteDevice DDKAPI alias "IoDeleteDevice" (byval DeviceObject as PDEVICE_OBJECT)
declare function IoDeleteSymbolicLink DDKAPI alias "IoDeleteSymbolicLink" (byval SymbolicLinkName as PUNICODE_STRING) as NTSTATUS
declare sub IoDetachDevice DDKAPI alias "IoDetachDevice" (byval TargetDevice as PDEVICE_OBJECT)
declare sub IoDisconnectInterrupt DDKAPI alias "IoDisconnectInterrupt" (byval InterruptObject as PKINTERRUPT)
declare function IoForwardIrpSynchronously DDKAPI alias "IoForwardIrpSynchronously" (byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as BOOLEAN
declare sub IoFreeController DDKAPI alias "IoFreeController" (byval ControllerObject as PCONTROLLER_OBJECT)
declare sub IoFreeErrorLogEntry DDKAPI alias "IoFreeErrorLogEntry" (byval ElEntry as PVOID)
declare sub IoFreeIrp DDKAPI alias "IoFreeIrp" (byval Irp as PIRP)
declare sub IoFreeMdl DDKAPI alias "IoFreeMdl" (byval Mdl as PMDL)
declare sub IoFreeWorkItem DDKAPI alias "IoFreeWorkItem" (byval pIOWorkItem as PIO_WORKITEM)
declare function IoGetAttachedDevice DDKAPI alias "IoGetAttachedDevice" (byval DeviceObject as PDEVICE_OBJECT) as PDEVICE_OBJECT
declare function IoGetAttachedDeviceReference DDKAPI alias "IoGetAttachedDeviceReference" (byval DeviceObject as PDEVICE_OBJECT) as PDEVICE_OBJECT
declare function IoGetBootDiskInformation DDKAPI alias "IoGetBootDiskInformation" (byval BootDiskInformation as PBOOTDISK_INFORMATION, byval Size as ULONG) as NTSTATUS
declare function IoGetConfigurationInformation DDKAPI alias "IoGetConfigurationInformation" () as PCONFIGURATION_INFORMATION
declare function IoGetCurrentProcess DDKAPI alias "IoGetCurrentProcess" () as PEPROCESS
declare function IoGetDeviceInterfaceAlias DDKAPI alias "IoGetDeviceInterfaceAlias" (byval SymbolicLinkName as PUNICODE_STRING, byval AliasInterfaceClassGuid as GUID ptr, byval AliasSymbolicLinkName as PUNICODE_STRING) as NTSTATUS
declare function IoGetDeviceInterfaces DDKAPI alias "IoGetDeviceInterfaces" (byval InterfaceClassGuid as GUID ptr, byval PhysicalDeviceObject as PDEVICE_OBJECT, byval Flags as ULONG, byval SymbolicLinkList as PWSTR ptr) as NTSTATUS
declare function IoGetDeviceObjectPointer DDKAPI alias "IoGetDeviceObjectPointer" (byval ObjectName as PUNICODE_STRING, byval DesiredAccess as ACCESS_MASK, byval FileObject as PFILE_OBJECT ptr, byval DeviceObject as PDEVICE_OBJECT ptr) as NTSTATUS
declare function IoGetDeviceProperty DDKAPI alias "IoGetDeviceProperty" (byval DeviceObject as PDEVICE_OBJECT, byval DeviceProperty as DEVICE_REGISTRY_PROPERTY, byval BufferLength as ULONG, byval PropertyBuffer as PVOID, byval ResultLength as PULONG) as NTSTATUS
declare function IoGetDeviceToVerify DDKAPI alias "IoGetDeviceToVerify" (byval Thread as PETHREAD) as PDEVICE_OBJECT
declare function IoGetDmaAdapter DDKAPI alias "IoGetDmaAdapter" (byval PhysicalDeviceObject as PDEVICE_OBJECT, byval DeviceDescription as PDEVICE_DESCRIPTION, byval NumberOfMapRegisters as PULONG) as PDMA_ADAPTER
declare function IoGetDriverObjectExtension DDKAPI alias "IoGetDriverObjectExtension" (byval DriverObject as PDRIVER_OBJECT, byval ClientIdentificationAddress as PVOID) as PVOID
declare function IoGetFileObjectGenericMapping DDKAPI alias "IoGetFileObjectGenericMapping" () as PGENERIC_MAPPING
declare function IoGetInitialStack DDKAPI alias "IoGetInitialStack" () as PVOID
declare function IoGetRelatedDeviceObject DDKAPI alias "IoGetRelatedDeviceObject" (byval FileObject as PFILE_OBJECT) as PDEVICE_OBJECT
declare function IoGetRemainingStackSize DDKAPI alias "IoGetRemainingStackSize" () as ULONG
declare sub IoGetStackLimits DDKAPI alias "IoGetStackLimits" (byval LowLimit as PULONG_PTR, byval HighLimit as PULONG_PTR)
declare sub KeInitializeDpc DDKAPI alias "KeInitializeDpc" (byval Dpc as PRKDPC, byval DeferredRoutine as PKDEFERRED_ROUTINE, byval DeferredContext as PVOID)
declare sub IoInitializeIrp DDKAPI alias "IoInitializeIrp" (byval Irp as PIRP, byval PacketSize as USHORT, byval StackSize as CCHAR)
declare sub IoInitializeRemoveLockEx DDKAPI alias "IoInitializeRemoveLockEx" (byval Lock as PIO_REMOVE_LOCK, byval AllocateTag as ULONG, byval MaxLockedMinutes as ULONG, byval HighWatermark as ULONG, byval RemlockSize as ULONG)
declare function IoInitializeTimer DDKAPI alias "IoInitializeTimer" (byval DeviceObject as PDEVICE_OBJECT, byval TimerRoutine as PIO_TIMER_ROUTINE, byval Context as PVOID) as NTSTATUS
declare sub IoInvalidateDeviceRelations DDKAPI alias "IoInvalidateDeviceRelations" (byval DeviceObject as PDEVICE_OBJECT, byval Type as DEVICE_RELATION_TYPE)
declare sub IoInvalidateDeviceState DDKAPI alias "IoInvalidateDeviceState" (byval PhysicalDeviceObject as PDEVICE_OBJECT)
declare function IoIs32bitProcess DDKAPI alias "IoIs32bitProcess" (byval Irp as PIRP) as BOOLEAN
declare function IoIsWdmVersionAvailable DDKAPI alias "IoIsWdmVersionAvailable" (byval MajorVersion as UCHAR, byval MinorVersion as UCHAR) as BOOLEAN
declare function IoMakeAssociatedIrp DDKAPI alias "IoMakeAssociatedIrp" (byval Irp as PIRP, byval StackSize as CCHAR) as PIRP
declare function IoOpenDeviceInterfaceRegistryKey DDKAPI alias "IoOpenDeviceInterfaceRegistryKey" (byval SymbolicLinkName as PUNICODE_STRING, byval DesiredAccess as ACCESS_MASK, byval DeviceInterfaceKey as PHANDLE) as NTSTATUS
declare function IoOpenDeviceRegistryKey DDKAPI alias "IoOpenDeviceRegistryKey" (byval DeviceObject as PDEVICE_OBJECT, byval DevInstKeyType as ULONG, byval DesiredAccess as ACCESS_MASK, byval DevInstRegKey as PHANDLE) as NTSTATUS
declare function IoQueryDeviceDescription DDKAPI alias "IoQueryDeviceDescription" (byval BusType as PINTERFACE_TYPE, byval BusNumber as PULONG, byval ControllerType as PCONFIGURATION_TYPE, byval ControllerNumber as PULONG, byval PeripheralType as PCONFIGURATION_TYPE, byval PeripheralNumber as PULONG, byval CalloutRoutine as PIO_QUERY_DEVICE_ROUTINE, byval Context as PVOID) as NTSTATUS
declare sub IoQueueWorkItem DDKAPI alias "IoQueueWorkItem" (byval pIOWorkItem as PIO_WORKITEM, byval Routine as PIO_WORKITEM_ROUTINE, byval QueueType as WORK_QUEUE_TYPE, byval Context as PVOID)
declare sub IoRaiseHardError DDKAPI alias "IoRaiseHardError" (byval Irp as PIRP, byval Vpb as PVPB, byval RealDeviceObject as PDEVICE_OBJECT)
declare function IoRaiseInformationalHardError DDKAPI alias "IoRaiseInformationalHardError" (byval ErrorStatus as NTSTATUS, byval String as PUNICODE_STRING, byval Thread as PKTHREAD) as BOOLEAN
declare function IoReadDiskSignature DDKAPI alias "IoReadDiskSignature" (byval DeviceObject as PDEVICE_OBJECT, byval BytesPerSector as ULONG, byval Signature as PDISK_SIGNATURE) as NTSTATUS
declare function IoReadPartitionTableEx DDKAPI alias "IoReadPartitionTableEx" (byval DeviceObject as PDEVICE_OBJECT, byval PartitionBuffer as PDRIVE_LAYOUT_INFORMATION_EX ptr) as NTSTATUS
declare sub IoRegisterBootDriverReinitialization DDKAPI alias "IoRegisterBootDriverReinitialization" (byval DriverObject as PDRIVER_OBJECT, byval DriverReinitializationRoutine as PDRIVER_REINITIALIZE, byval Context as PVOID)
declare function IoRegisterDeviceInterface DDKAPI alias "IoRegisterDeviceInterface" (byval PhysicalDeviceObject as PDEVICE_OBJECT, byval InterfaceClassGuid as GUID ptr, byval ReferenceString as PUNICODE_STRING, byval SymbolicLinkName as PUNICODE_STRING) as NTSTATUS
declare sub IoRegisterDriverReinitialization DDKAPI alias "IoRegisterDriverReinitialization" (byval DriverObject as PDRIVER_OBJECT, byval DriverReinitializationRoutine as PDRIVER_REINITIALIZE, byval Context as PVOID)
declare function IoRegisterPlugPlayNotification DDKAPI alias "IoRegisterPlugPlayNotification" (byval EventCategory as IO_NOTIFICATION_EVENT_CATEGORY, byval EventCategoryFlags as ULONG, byval EventCategoryData as PVOID, byval DriverObject as PDRIVER_OBJECT, byval CallbackRoutine as PDRIVER_NOTIFICATION_CALLBACK_ROUTINE, byval Context as PVOID, byval NotificationEntry as PVOID ptr) as NTSTATUS
declare function IoRegisterShutdownNotification DDKAPI alias "IoRegisterShutdownNotification" (byval DeviceObject as PDEVICE_OBJECT) as NTSTATUS
declare sub IoReleaseCancelSpinLock DDKAPI alias "IoReleaseCancelSpinLock" (byval Irql as KIRQL)
declare sub IoReleaseRemoveLockAndWaitEx DDKAPI alias "IoReleaseRemoveLockAndWaitEx" (byval RemoveLock as PIO_REMOVE_LOCK, byval Tag as PVOID, byval RemlockSize as ULONG)
declare sub IoReleaseRemoveLockEx DDKAPI alias "IoReleaseRemoveLockEx" (byval RemoveLock as PIO_REMOVE_LOCK, byval Tag as PVOID, byval RemlockSize as ULONG)
declare sub IoRemoveShareAccess DDKAPI alias "IoRemoveShareAccess" (byval FileObject as PFILE_OBJECT, byval ShareAccess as PSHARE_ACCESS)
declare function IoReportDetectedDevice DDKAPI alias "IoReportDetectedDevice" (byval DriverObject as PDRIVER_OBJECT, byval LegacyBusType as INTERFACE_TYPE, byval BusNumber as ULONG, byval SlotNumber as ULONG, byval ResourceList as PCM_RESOURCE_LIST, byval ResourceRequirements as PIO_RESOURCE_REQUIREMENTS_LIST, byval ResourceAssigned as BOOLEAN, byval DeviceObject as PDEVICE_OBJECT ptr) as NTSTATUS
declare function IoReportResourceForDetection DDKAPI alias "IoReportResourceForDetection" (byval DriverObject as PDRIVER_OBJECT, byval DriverList as PCM_RESOURCE_LIST, byval DriverListSize as ULONG, byval DeviceObject as PDEVICE_OBJECT, byval DeviceList as PCM_RESOURCE_LIST, byval DeviceListSize as ULONG, byval ConflictDetected as PBOOLEAN) as NTSTATUS
declare function IoReportResourceUsage DDKAPI alias "IoReportResourceUsage" (byval DriverClassName as PUNICODE_STRING, byval DriverObject as PDRIVER_OBJECT, byval DriverList as PCM_RESOURCE_LIST, byval DriverListSize as ULONG, byval DeviceObject as PDEVICE_OBJECT, byval DeviceList as PCM_RESOURCE_LIST, byval DeviceListSize as ULONG, byval OverrideConflict as BOOLEAN, byval ConflictDetected as PBOOLEAN) as NTSTATUS
declare function IoReportTargetDeviceChange DDKAPI alias "IoReportTargetDeviceChange" (byval PhysicalDeviceObject as PDEVICE_OBJECT, byval NotificationStructure as PVOID) as NTSTATUS
declare function IoReportTargetDeviceChangeAsynchronous DDKAPI alias "IoReportTargetDeviceChangeAsynchronous" (byval PhysicalDeviceObject as PDEVICE_OBJECT, byval NotificationStructure as PVOID, byval Callback as PDEVICE_CHANGE_COMPLETE_CALLBACK, byval Context as PVOID) as NTSTATUS
declare sub IoRequestDeviceEject DDKAPI alias "IoRequestDeviceEject" (byval PhysicalDeviceObject as PDEVICE_OBJECT)
declare sub IoReuseIrp DDKAPI alias "IoReuseIrp" (byval Irp as PIRP, byval Status as NTSTATUS)
declare sub IoSetCompletionRoutineEx DDKAPI alias "IoSetCompletionRoutineEx" (byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP, byval CompletionRoutine as PIO_COMPLETION_ROUTINE, byval Context as PVOID, byval InvokeOnSuccess as BOOLEAN, byval InvokeOnError as BOOLEAN, byval InvokeOnCancel as BOOLEAN)
declare function IoSetDeviceInterfaceState DDKAPI alias "IoSetDeviceInterfaceState" (byval SymbolicLinkName as PUNICODE_STRING, byval Enable as BOOLEAN) as NTSTATUS
declare sub IoSetHardErrorOrVerifyDevice DDKAPI alias "IoSetHardErrorOrVerifyDevice" (byval Irp as PIRP, byval DeviceObject as PDEVICE_OBJECT)
declare function IoSetPartitionInformationEx DDKAPI alias "IoSetPartitionInformationEx" (byval DeviceObject as PDEVICE_OBJECT, byval PartitionNumber as ULONG, byval PartitionInfo as PSET_PARTITION_INFORMATION_EX) as NTSTATUS
declare sub IoSetShareAccess DDKAPI alias "IoSetShareAccess" (byval DesiredAccess as ACCESS_MASK, byval DesiredShareAccess as ULONG, byval FileObject as PFILE_OBJECT, byval ShareAccess as PSHARE_ACCESS)
declare sub IoSetStartIoAttributes DDKAPI alias "IoSetStartIoAttributes" (byval DeviceObject as PDEVICE_OBJECT, byval DeferredStartIo as BOOLEAN, byval NonCancelable as BOOLEAN)
declare function IoSetSystemPartition DDKAPI alias "IoSetSystemPartition" (byval VolumeNameString as PUNICODE_STRING) as NTSTATUS
declare function IoSetThreadHardErrorMode DDKAPI alias "IoSetThreadHardErrorMode" (byval EnableHardErrors as BOOLEAN) as BOOLEAN
declare sub IoStartNextPacket DDKAPI alias "IoStartNextPacket" (byval DeviceObject as PDEVICE_OBJECT, byval Cancelable as BOOLEAN)
declare sub IoStartNextPacketByKey DDKAPI alias "IoStartNextPacketByKey" (byval DeviceObject as PDEVICE_OBJECT, byval Cancelable as BOOLEAN, byval Key as ULONG)
declare sub IoStartPacket DDKAPI alias "IoStartPacket" (byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP, byval Key as PULONG, byval CancelFunction as PDRIVER_CANCEL)
declare sub IoStartTimer DDKAPI alias "IoStartTimer" (byval DeviceObject as PDEVICE_OBJECT)
declare sub IoStopTimer DDKAPI alias "IoStopTimer" (byval DeviceObject as PDEVICE_OBJECT)
declare function IoUnregisterPlugPlayNotification DDKAPI alias "IoUnregisterPlugPlayNotification" (byval NotificationEntry as PVOID) as NTSTATUS
declare sub IoUnregisterShutdownNotification DDKAPI alias "IoUnregisterShutdownNotification" (byval DeviceObject as PDEVICE_OBJECT)
declare sub IoUpdateShareAccess DDKAPI alias "IoUpdateShareAccess" (byval FileObject as PFILE_OBJECT, byval ShareAccess as PSHARE_ACCESS)
declare function IoVerifyPartitionTable DDKAPI alias "IoVerifyPartitionTable" (byval DeviceObject as PDEVICE_OBJECT, byval FixErrors as BOOLEAN) as NTSTATUS
declare function IoVolumeDeviceToDosName DDKAPI alias "IoVolumeDeviceToDosName" (byval VolumeDeviceObject as PVOID, byval DosName as PUNICODE_STRING) as NTSTATUS
declare function IoWMIAllocateInstanceIds DDKAPI alias "IoWMIAllocateInstanceIds" (byval Guid as GUID ptr, byval InstanceCount as ULONG, byval FirstInstanceId as ULONG ptr) as NTSTATUS
declare function IoWMIDeviceObjectToProviderId DDKAPI alias "IoWMIDeviceObjectToProviderId" (byval DeviceObject as PDEVICE_OBJECT) as ULONG
declare function IoWMIDeviceObjectToInstanceName DDKAPI alias "IoWMIDeviceObjectToInstanceName" (byval DataBlockObject as PVOID, byval DeviceObject as PDEVICE_OBJECT, byval InstanceName as PUNICODE_STRING) as NTSTATUS
declare function IoWMIExecuteMethod DDKAPI alias "IoWMIExecuteMethod" (byval DataBlockObject as PVOID, byval InstanceName as PUNICODE_STRING, byval MethodId as ULONG, byval InBufferSize as ULONG, byval OutBufferSize as PULONG, byval InOutBuffer as PUCHAR) as NTSTATUS
declare function IoWMIHandleToInstanceName DDKAPI alias "IoWMIHandleToInstanceName" (byval DataBlockObject as PVOID, byval FileHandle as HANDLE, byval InstanceName as PUNICODE_STRING) as NTSTATUS
declare function IoWMIOpenBlock DDKAPI alias "IoWMIOpenBlock" (byval DataBlockGuid as GUID ptr, byval DesiredAccess as ULONG, byval DataBlockObject as PVOID ptr) as NTSTATUS
declare function IoWMIQueryAllData DDKAPI alias "IoWMIQueryAllData" (byval DataBlockObject as PVOID, byval InOutBufferSize as ULONG ptr, byval OutBuffer as PVOID) as NTSTATUS
declare function IoWMIQueryAllDataMultiple DDKAPI alias "IoWMIQueryAllDataMultiple" (byval DataBlockObjectList as PVOID ptr, byval ObjectCount as ULONG, byval InOutBufferSize as ULONG ptr, byval OutBuffer as PVOID) as NTSTATUS
declare function IoWMIQuerySingleInstance DDKAPI alias "IoWMIQuerySingleInstance" (byval DataBlockObject as PVOID, byval InstanceName as PUNICODE_STRING, byval InOutBufferSize as ULONG ptr, byval OutBuffer as PVOID) as NTSTATUS
declare function IoWMIQuerySingleInstanceMultiple DDKAPI alias "IoWMIQuerySingleInstanceMultiple" (byval DataBlockObjectList as PVOID ptr, byval InstanceNames as PUNICODE_STRING, byval ObjectCount as ULONG, byval InOutBufferSize as ULONG ptr, byval OutBuffer as PVOID) as NTSTATUS
declare function IoWMIRegistrationControl DDKAPI alias "IoWMIRegistrationControl" (byval DeviceObject as PDEVICE_OBJECT, byval Action as ULONG) as NTSTATUS
declare function IoWMISetNotificationCallback DDKAPI alias "IoWMISetNotificationCallback" (byval Object as PVOID, byval Callback as WMI_NOTIFICATION_CALLBACK, byval Context as PVOID) as NTSTATUS
declare function IoWMISetSingleInstance DDKAPI alias "IoWMISetSingleInstance" (byval DataBlockObject as PVOID, byval InstanceName as PUNICODE_STRING, byval Version as ULONG, byval ValueBufferSize as ULONG, byval ValueBuffer as PVOID) as NTSTATUS
declare function IoWMISetSingleItem DDKAPI alias "IoWMISetSingleItem" (byval DataBlockObject as PVOID, byval InstanceName as PUNICODE_STRING, byval DataItemId as ULONG, byval Version as ULONG, byval ValueBufferSize as ULONG, byval ValueBuffer as PVOID) as NTSTATUS
declare function IoWMISuggestInstanceName DDKAPI alias "IoWMISuggestInstanceName" (byval PhysicalDeviceObject as PDEVICE_OBJECT, byval SymbolicLinkName as PUNICODE_STRING, byval CombineNames as BOOLEAN, byval SuggestedInstanceName as PUNICODE_STRING) as NTSTATUS
declare function IoWMIWriteEvent DDKAPI alias "IoWMIWriteEvent" (byval WnodeEventItem as PVOID) as NTSTATUS
declare sub IoWriteErrorLogEntry DDKAPI alias "IoWriteErrorLogEntry" (byval ElEntry as PVOID)
declare function IoWritePartitionTableEx DDKAPI alias "IoWritePartitionTableEx" (byval DeviceObject as PDEVICE_OBJECT, byval PartitionBuffer as PDRIVE_LAYOUT_INFORMATION_EX) as NTSTATUS
declare sub KeAcquireInStackQueuedSpinLock DDKAPI alias "KeAcquireInStackQueuedSpinLock" (byval SpinLock as PKSPIN_LOCK, byval LockHandle as PKLOCK_QUEUE_HANDLE)
declare sub KeAcquireInStackQueuedSpinLockAtDpcLevel DDKAPI alias "KeAcquireInStackQueuedSpinLockAtDpcLevel" (byval SpinLock as PKSPIN_LOCK, byval LockHandle as PKLOCK_QUEUE_HANDLE)
declare function KeAcquireInterruptSpinLock DDKAPI alias "KeAcquireInterruptSpinLock" (byval Interrupt as PKINTERRUPT) as KIRQL
declare sub KeAcquireSpinLock DDKAPI alias "KeAcquireSpinLock" (byval SpinLock as PKSPIN_LOCK, byval OldIrql as PKIRQL)
declare function KeAddSystemServiceTable DDKAPI alias "KeAddSystemServiceTable" (byval SSDT as PSSDT, byval ServiceCounterTable as PULONG, byval NumberOfServices as ULONG, byval SSPT as PSSPT, byval TableIndex as ULONG) as BOOLEAN
declare function KeAreApcsDisabled DDKAPI alias "KeAreApcsDisabled" () as BOOLEAN
declare sub KeAttachProcess DDKAPI alias "KeAttachProcess" (byval Process as PEPROCESS)
declare sub KeBugCheck DDKAPI alias "KeBugCheck" (byval BugCheckCode as ULONG)
declare sub KeBugCheckEx DDKAPI alias "KeBugCheckEx" (byval BugCheckCode as ULONG, byval BugCheckParameter1 as ULONG_PTR, byval BugCheckParameter2 as ULONG_PTR, byval BugCheckParameter3 as ULONG_PTR, byval BugCheckParameter4 as ULONG_PTR)
declare function KeCancelTimer DDKAPI alias "KeCancelTimer" (byval Timer as PKTIMER) as BOOLEAN
declare sub KeClearEvent DDKAPI alias "KeClearEvent" (byval Event as PRKEVENT)
declare function KeDelayExecutionThread DDKAPI alias "KeDelayExecutionThread" (byval WaitMode as KPROCESSOR_MODE, byval Alertable as BOOLEAN, byval Interval as PLARGE_INTEGER) as NTSTATUS
declare function KeDeregisterBugCheckCallback DDKAPI alias "KeDeregisterBugCheckCallback" (byval CallbackRecord as PKBUGCHECK_CALLBACK_RECORD) as BOOLEAN
declare sub KeDetachProcess DDKAPI alias "KeDetachProcess" ()
declare sub KeEnterCriticalRegion DDKAPI alias "KeEnterCriticalRegion" ()
declare function KeGetCurrentThread DDKAPI alias "KeGetCurrentThread" () as PRKTHREAD
declare function KeGetPreviousMode DDKAPI alias "KeGetPreviousMode" () as KPROCESSOR_MODE
declare function KeGetRecommendedSharedDataAlignment DDKAPI alias "KeGetRecommendedSharedDataAlignment" () as ULONG
declare sub KeInitializeApc DDKAPI alias "KeInitializeApc" (byval Apc as PKAPC, byval Thread as PKTHREAD, byval StateIndex as UCHAR, byval KernelRoutine as PKKERNEL_ROUTINE, byval RundownRoutine as PKRUNDOWN_ROUTINE, byval NormalRoutine as PKNORMAL_ROUTINE, byval Mode as UCHAR, byval Context as PVOID)
declare sub KeInitializeDeviceQueue DDKAPI alias "KeInitializeDeviceQueue" (byval DeviceQueue as PKDEVICE_QUEUE)
declare sub KeInitializeMutex DDKAPI alias "KeInitializeMutex" (byval Mutex as PRKMUTEX, byval Level as ULONG)
declare sub KeInitializeSemaphore DDKAPI alias "KeInitializeSemaphore" (byval Semaphore as PRKSEMAPHORE, byval Count as LONG, byval Limit as LONG)
declare sub KeInitializeSpinLock DDKAPI alias "KeInitializeSpinLock" (byval SpinLock as PKSPIN_LOCK)
declare sub KeInitializeTimer DDKAPI alias "KeInitializeTimer" (byval Timer as PKTIMER)
declare sub KeInitializeTimerEx DDKAPI alias "KeInitializeTimerEx" (byval Timer as PKTIMER, byval Type as TIMER_TYPE)
declare function KeInsertByKeyDeviceQueue DDKAPI alias "KeInsertByKeyDeviceQueue" (byval DeviceQueue as PKDEVICE_QUEUE, byval DeviceQueueEntry as PKDEVICE_QUEUE_ENTRY, byval SortKey as ULONG) as BOOLEAN
declare function KeInsertDeviceQueue DDKAPI alias "KeInsertDeviceQueue" (byval DeviceQueue as PKDEVICE_QUEUE, byval DeviceQueueEntry as PKDEVICE_QUEUE_ENTRY) as BOOLEAN
declare function KeInsertQueueDpc DDKAPI alias "KeInsertQueueDpc" (byval Dpc as PRKDPC, byval SystemArgument1 as PVOID, byval SystemArgument2 as PVOID) as BOOLEAN
declare sub KeLeaveCriticalRegion DDKAPI alias "KeLeaveCriticalRegion" ()
declare function KePulseEvent DDKAPI alias "KePulseEvent" (byval Event as PRKEVENT, byval Increment as KPRIORITY, byval Wait as BOOLEAN) as NTSTATUS
declare function KeQueryInterruptTime DDKAPI alias "KeQueryInterruptTime" () as ULONGLONG
declare function KeQueryPerformanceCounter DDKAPI alias "KeQueryPerformanceCounter" (byval PerformanceFrequency as PLARGE_INTEGER) as LARGE_INTEGER
declare function KeQueryPriorityThread DDKAPI alias "KeQueryPriorityThread" (byval Thread as PRKTHREAD) as KPRIORITY
declare sub KeQuerySystemTime DDKAPI alias "KeQuerySystemTime" (byval CurrentTime as PLARGE_INTEGER)
declare sub KeQueryTickCount DDKAPI alias "KeQueryTickCount" (byval TickCount as PLARGE_INTEGER)
declare function KeQueryTimeIncrement DDKAPI alias "KeQueryTimeIncrement" () as ULONG
declare function KeReadStateEvent DDKAPI alias "KeReadStateEvent" (byval Event as PRKEVENT) as LONG
declare function KeReadStateMutex DDKAPI alias "KeReadStateMutex" (byval Mutex as PRKMUTEX) as LONG
declare function KeReadStateSemaphore DDKAPI alias "KeReadStateSemaphore" (byval Semaphore as PRKSEMAPHORE) as LONG
declare function KeReadStateTimer DDKAPI alias "KeReadStateTimer" (byval Timer as PKTIMER) as BOOLEAN
declare function KeRegisterBugCheckCallback DDKAPI alias "KeRegisterBugCheckCallback" (byval CallbackRecord as PKBUGCHECK_CALLBACK_RECORD, byval CallbackRoutine as PKBUGCHECK_CALLBACK_ROUTINE, byval Buffer as PVOID, byval Length as ULONG, byval Component as PUCHAR) as BOOLEAN
declare sub KeReleaseInStackQueuedSpinLock DDKAPI alias "KeReleaseInStackQueuedSpinLock" (byval LockHandle as PKLOCK_QUEUE_HANDLE)
declare sub KeReleaseInStackQueuedSpinLockFromDpcLevel DDKAPI alias "KeReleaseInStackQueuedSpinLockFromDpcLevel" (byval LockHandle as PKLOCK_QUEUE_HANDLE)
declare sub KeReleaseInterruptSpinLock DDKAPI alias "KeReleaseInterruptSpinLock" (byval Interrupt as PKINTERRUPT, byval OldIrql as KIRQL)
declare function KeReleaseMutex DDKAPI alias "KeReleaseMutex" (byval Mutex as PRKMUTEX, byval Wait as BOOLEAN) as LONG
declare function KeReleaseSemaphore DDKAPI alias "KeReleaseSemaphore" (byval Semaphore as PRKSEMAPHORE, byval Increment as KPRIORITY, byval Adjustment as LONG, byval Wait as BOOLEAN) as LONG
declare sub KeReleaseSpinLock DDKAPI alias "KeReleaseSpinLock" (byval SpinLock as PKSPIN_LOCK, byval NewIrql as KIRQL)
declare function KeRemoveByKeyDeviceQueue DDKAPI alias "KeRemoveByKeyDeviceQueue" (byval DeviceQueue as PKDEVICE_QUEUE, byval SortKey as ULONG) as PKDEVICE_QUEUE_ENTRY
declare function KeRemoveDeviceQueue DDKAPI alias "KeRemoveDeviceQueue" (byval DeviceQueue as PKDEVICE_QUEUE) as PKDEVICE_QUEUE_ENTRY
declare function KeRemoveEntryDeviceQueue DDKAPI alias "KeRemoveEntryDeviceQueue" (byval DeviceQueue as PKDEVICE_QUEUE, byval DeviceQueueEntry as PKDEVICE_QUEUE_ENTRY) as BOOLEAN
declare function KeRemoveQueueDpc DDKAPI alias "KeRemoveQueueDpc" (byval Dpc as PRKDPC) as BOOLEAN
declare function KeResetEvent DDKAPI alias "KeResetEvent" (byval Event as PRKEVENT) as LONG
declare function KeRestoreFloatingPointState DDKAPI alias "KeRestoreFloatingPointState" (byval FloatSave as PKFLOATING_SAVE) as NTSTATUS
declare function KeSaveFloatingPointState DDKAPI alias "KeSaveFloatingPointState" (byval FloatSave as PKFLOATING_SAVE) as NTSTATUS
declare function KeSetBasePriorityThread DDKAPI alias "KeSetBasePriorityThread" (byval Thread as PRKTHREAD, byval Increment as LONG) as LONG
declare function KeSetEvent DDKAPI alias "KeSetEvent" (byval Event as PRKEVENT, byval Increment as KPRIORITY, byval Wait as BOOLEAN) as LONG
declare sub KeSetImportanceDpc DDKAPI alias "KeSetImportanceDpc" (byval Dpc as PRKDPC, byval Importance as KDPC_IMPORTANCE)
declare function KeSetPriorityThread DDKAPI alias "KeSetPriorityThread" (byval Thread as PKTHREAD, byval Priority as KPRIORITY) as KPRIORITY
declare sub KeSetTargetProcessorDpc DDKAPI alias "KeSetTargetProcessorDpc" (byval Dpc as PRKDPC, byval Number as CCHAR)
declare function KeSetTimer DDKAPI alias "KeSetTimer" (byval Timer as PKTIMER, byval DueTime as LARGE_INTEGER, byval Dpc as PKDPC) as BOOLEAN
declare function KeSetTimerEx DDKAPI alias "KeSetTimerEx" (byval Timer as PKTIMER, byval DueTime as LARGE_INTEGER, byval Period as LONG, byval Dpc as PKDPC) as BOOLEAN
declare sub KeSetTimeUpdateNotifyRoutine DDKAPI alias "KeSetTimeUpdateNotifyRoutine" (byval NotifyRoutine as PTIME_UPDATE_NOTIFY_ROUTINE)
declare sub KeStallExecutionProcessor DDKAPI alias "KeStallExecutionProcessor" (byval MicroSeconds as ULONG)
declare function KeSynchronizeExecution DDKAPI alias "KeSynchronizeExecution" (byval Interrupt as PKINTERRUPT, byval SynchronizeRoutine as PKSYNCHRONIZE_ROUTINE, byval SynchronizeContext as PVOID) as BOOLEAN
declare function KeWaitForMultipleObjects DDKAPI alias "KeWaitForMultipleObjects" (byval Count as ULONG, byval Object as PVOID ptr, byval WaitType as WAIT_TYPE, byval WaitReason as KWAIT_REASON, byval WaitMode as KPROCESSOR_MODE, byval Alertable as BOOLEAN, byval Timeout as PLARGE_INTEGER, byval WaitBlockArray as PKWAIT_BLOCK) as NTSTATUS
declare function KeWaitForMutexObject DDKAPI alias "KeWaitForMutexObject" (byval Mutex as PRKMUTEX, byval WaitReason as KWAIT_REASON, byval WaitMode as KPROCESSOR_MODE, byval Alertable as BOOLEAN, byval Timeout as PLARGE_INTEGER) as NTSTATUS
declare function KeWaitForSingleObject DDKAPI alias "KeWaitForSingleObject" (byval Object as PVOID, byval WaitReason as KWAIT_REASON, byval WaitMode as KPROCESSOR_MODE, byval Alertable as BOOLEAN, byval Timeout as PLARGE_INTEGER) as NTSTATUS
declare sub KfLowerIrql DDKAPI alias "KfLowerIrql" (byval NewIrql as KIRQL)
declare function KfRaiseIrql DDKAPI alias "KfRaiseIrql" (byval NewIrql as KIRQL) as KIRQL
declare function KeRaiseIrqlToDpcLevel DDKAPI alias "KeRaiseIrqlToDpcLevel" () as KIRQL
declare function MmAdvanceMdl DDKAPI alias "MmAdvanceMdl" (byval Mdl as PMDL, byval NumberOfBytes as ULONG) as NTSTATUS
declare function MmAllocateContiguousMemory DDKAPI alias "MmAllocateContiguousMemory" (byval NumberOfBytes as ULONG, byval HighestAcceptableAddress as PHYSICAL_ADDRESS) as PVOID
declare function MmAllocateContiguousMemorySpecifyCache DDKAPI alias "MmAllocateContiguousMemorySpecifyCache" (byval NumberOfBytes as SIZE_T, byval LowestAcceptableAddress as PHYSICAL_ADDRESS, byval HighestAcceptableAddress as PHYSICAL_ADDRESS, byval BoundaryAddressMultiple as PHYSICAL_ADDRESS, byval CacheType as MEMORY_CACHING_TYPE) as PVOID
declare function MmAllocateMappingAddress DDKAPI alias "MmAllocateMappingAddress" (byval NumberOfBytes as SIZE_T, byval PoolTag as ULONG) as PVOID
declare function MmAllocateNonCachedMemory DDKAPI alias "MmAllocateNonCachedMemory" (byval NumberOfBytes as ULONG) as PVOID
declare function MmAllocatePagesForMdl DDKAPI alias "MmAllocatePagesForMdl" (byval LowAddress as PHYSICAL_ADDRESS, byval HighAddress as PHYSICAL_ADDRESS, byval SkipBytes as PHYSICAL_ADDRESS, byval TotalBytes as SIZE_T) as PMDL
declare sub MmBuildMdlForNonPagedPool DDKAPI alias "MmBuildMdlForNonPagedPool" (byval MemoryDescriptorList as PMDL)
declare function MmCreateSection DDKAPI alias "MmCreateSection" (byval SectionObject as PSECTION_OBJECT ptr, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval MaximumSize as PLARGE_INTEGER, byval SectionPageProtection as ULONG, byval AllocationAttributes as ULONG, byval FileHandle as HANDLE, byval File as PFILE_OBJECT) as NTSTATUS
declare function MmFlushImageSection DDKAPI alias "MmFlushImageSection" (byval SectionObjectPointer as PSECTION_OBJECT_POINTERS, byval FlushType as MMFLUSH_TYPE) as BOOLEAN
declare sub MmFreeContiguousMemory DDKAPI alias "MmFreeContiguousMemory" (byval BaseAddress as PVOID)
declare sub MmFreeContiguousMemorySpecifyCache DDKAPI alias "MmFreeContiguousMemorySpecifyCache" (byval BaseAddress as PVOID, byval NumberOfBytes as SIZE_T, byval CacheType as MEMORY_CACHING_TYPE)
declare sub MmFreeMappingAddress DDKAPI alias "MmFreeMappingAddress" (byval BaseAddress as PVOID, byval PoolTag as ULONG)
declare sub MmFreeNonCachedMemory DDKAPI alias "MmFreeNonCachedMemory" (byval BaseAddress as PVOID, byval NumberOfBytes as SIZE_T)
declare sub MmFreePagesFromMdl DDKAPI alias "MmFreePagesFromMdl" (byval MemoryDescriptorList as PMDL)
declare function MmGetPhysicalAddress DDKAPI alias "MmGetPhysicalAddress" (byval BaseAddress as PVOID) as PHYSICAL_ADDRESS
declare function MmGetPhysicalMemoryRanges DDKAPI alias "MmGetPhysicalMemoryRanges" () as PPHYSICAL_MEMORY_RANGE
declare function MmGetVirtualForPhysical DDKAPI alias "MmGetVirtualForPhysical" (byval PhysicalAddress as PHYSICAL_ADDRESS) as PVOID
declare function MmMapLockedPagesSpecifyCache DDKAPI alias "MmMapLockedPagesSpecifyCache" (byval MemoryDescriptorList as PMDL, byval AccessMode as KPROCESSOR_MODE, byval CacheType as MEMORY_CACHING_TYPE, byval BaseAddress as PVOID, byval BugCheckOnFailure as ULONG, byval Priority as MM_PAGE_PRIORITY) as PVOID
declare function MmMapLockedPagesWithReservedMapping DDKAPI alias "MmMapLockedPagesWithReservedMapping" (byval MappingAddress as PVOID, byval PoolTag as ULONG, byval MemoryDescriptorList as PMDL, byval CacheType as MEMORY_CACHING_TYPE) as PVOID
declare function MmMapUserAddressesToPage DDKAPI alias "MmMapUserAddressesToPage" (byval BaseAddress as PVOID, byval NumberOfBytes as SIZE_T, byval PageAddress as PVOID) as NTSTATUS
declare function MmMapVideoDisplay DDKAPI alias "MmMapVideoDisplay" (byval PhysicalAddress as PHYSICAL_ADDRESS, byval NumberOfBytes as SIZE_T, byval CacheType as MEMORY_CACHING_TYPE) as PVOID
declare function MmMapViewInSessionSpace DDKAPI alias "MmMapViewInSessionSpace" (byval Section as PVOID, byval MappedBase as PVOID ptr, byval ViewSize as PSIZE_T) as NTSTATUS
declare function MmMapViewInSystemSpace DDKAPI alias "MmMapViewInSystemSpace" (byval Section as PVOID, byval MappedBase as PVOID ptr, byval ViewSize as PSIZE_T) as NTSTATUS
declare function MmMarkPhysicalMemoryAsBad DDKAPI alias "MmMarkPhysicalMemoryAsBad" (byval StartAddress as PPHYSICAL_ADDRESS, byval NumberOfBytes as PLARGE_INTEGER) as NTSTATUS
declare function MmMarkPhysicalMemoryAsGood DDKAPI alias "MmMarkPhysicalMemoryAsGood" (byval StartAddress as PPHYSICAL_ADDRESS, byval NumberOfBytes as PLARGE_INTEGER) as NTSTATUS
declare function MmGetSystemRoutineAddress DDKAPI alias "MmGetSystemRoutineAddress" (byval SystemRoutineName as PUNICODE_STRING) as PVOID
declare function MmIsAddressValid DDKAPI alias "MmIsAddressValid" (byval VirtualAddress as PVOID) as BOOLEAN
declare function MmIsDriverVerifying DDKAPI alias "MmIsDriverVerifying" (byval DriverObject as PDRIVER_OBJECT) as LOGICAL
declare function MmIsThisAnNtAsSystem DDKAPI alias "MmIsThisAnNtAsSystem" () as BOOLEAN
declare function MmIsVerifierEnabled DDKAPI alias "MmIsVerifierEnabled" (byval VerifierFlags as PULONG) as NTSTATUS
declare function MmLockPagableDataSection DDKAPI alias "MmLockPagableDataSection" (byval AddressWithinSection as PVOID) as PVOID
declare function MmLockPagableImageSection DDKAPI alias "MmLockPagableImageSection" (byval AddressWithinSection as PVOID) as PVOID
declare sub MmLockPagableSectionByHandle DDKAPI alias "MmLockPagableSectionByHandle" (byval ImageSectionHandle as PVOID)
declare function MmMapIoSpace DDKAPI alias "MmMapIoSpace" (byval PhysicalAddress as PHYSICAL_ADDRESS, byval NumberOfBytes as ULONG, byval CacheEnable as MEMORY_CACHING_TYPE) as PVOID
declare function MmMapLockedPages DDKAPI alias "MmMapLockedPages" (byval MemoryDescriptorList as PMDL, byval AccessMode as KPROCESSOR_MODE) as PVOID
declare sub MmPageEntireDriver DDKAPI alias "MmPageEntireDriver" (byval AddressWithinSection as PVOID)
declare sub MmProbeAndLockProcessPages DDKAPI alias "MmProbeAndLockProcessPages" (byval MemoryDescriptorList as PMDL, byval Process as PEPROCESS, byval AccessMode as KPROCESSOR_MODE, byval Operation as LOCK_OPERATION)
declare function MmProtectMdlSystemAddress DDKAPI alias "MmProtectMdlSystemAddress" (byval MemoryDescriptorList as PMDL, byval NewProtect as ULONG) as NTSTATUS
declare sub MmUnmapLockedPages DDKAPI alias "MmUnmapLockedPages" (byval BaseAddress as PVOID, byval MemoryDescriptorList as PMDL)
declare function MmUnmapViewInSessionSpace DDKAPI alias "MmUnmapViewInSessionSpace" (byval MappedBase as PVOID) as NTSTATUS
declare function MmUnmapViewInSystemSpace DDKAPI alias "MmUnmapViewInSystemSpace" (byval MappedBase as PVOID) as NTSTATUS
declare sub MmUnsecureVirtualMemory DDKAPI alias "MmUnsecureVirtualMemory" (byval SecureHandle as HANDLE)
declare sub MmProbeAndLockPages DDKAPI alias "MmProbeAndLockPages" (byval MemoryDescriptorList as PMDL, byval AccessMode as KPROCESSOR_MODE, byval Operation as LOCK_OPERATION)
declare function MmQuerySystemSize DDKAPI alias "MmQuerySystemSize" () as MM_SYSTEM_SIZE
declare function MmRemovePhysicalMemory DDKAPI alias "MmRemovePhysicalMemory" (byval StartAddress as PPHYSICAL_ADDRESS, byval NumberOfBytes as PLARGE_INTEGER) as NTSTATUS
declare sub MmResetDriverPaging DDKAPI alias "MmResetDriverPaging" (byval AddressWithinSection as PVOID)
declare function MmSecureVirtualMemory DDKAPI alias "MmSecureVirtualMemory" (byval Address as PVOID, byval Size as SIZE_T, byval ProbeMode as ULONG) as HANDLE
declare function MmSizeOfMdl DDKAPI alias "MmSizeOfMdl" (byval Base as PVOID, byval Length as SIZE_T) as ULONG
declare sub MmUnlockPagableImageSection DDKAPI alias "MmUnlockPagableImageSection" (byval ImageSectionHandle as PVOID)
declare sub MmUnlockPages DDKAPI alias "MmUnlockPages" (byval MemoryDescriptorList as PMDL)
declare sub MmUnmapIoSpace DDKAPI alias "MmUnmapIoSpace" (byval BaseAddress as PVOID, byval NumberOfBytes as SIZE_T)
declare sub MmUnmapReservedMapping DDKAPI alias "MmUnmapReservedMapping" (byval BaseAddress as PVOID, byval PoolTag as ULONG, byval MemoryDescriptorList as PMDL)
declare sub MmUnmapVideoDisplay DDKAPI alias "MmUnmapVideoDisplay" (byval BaseAddress as PVOID, byval NumberOfBytes as SIZE_T)
declare function ObAssignSecurity DDKAPI alias "ObAssignSecurity" (byval AccessState as PACCESS_STATE, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval Object as PVOID, byval Type as POBJECT_TYPE) as NTSTATUS
declare sub ObDereferenceSecurityDescriptor DDKAPI alias "ObDereferenceSecurityDescriptor" (byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval Count as ULONG)
declare sub ObfDereferenceObject DDKAPI alias "ObfDereferenceObject" (byval Object as PVOID)
declare function ObGetObjectSecurity DDKAPI alias "ObGetObjectSecurity" (byval Object as PVOID, byval SecurityDescriptor as PSECURITY_DESCRIPTOR ptr, byval MemoryAllocated as PBOOLEAN) as NTSTATUS
declare function ObInsertObject DDKAPI alias "ObInsertObject" (byval Object as PVOID, byval PassedAccessState as PACCESS_STATE, byval DesiredAccess as ACCESS_MASK, byval AdditionalReferences as ULONG, byval ReferencedObject as PVOID ptr, byval Handle as PHANDLE) as NTSTATUS
declare sub ObfReferenceObject DDKAPI alias "ObfReferenceObject" (byval Object as PVOID)
declare function ObLogSecurityDescriptor DDKAPI alias "ObLogSecurityDescriptor" (byval InputSecurityDescriptor as PSECURITY_DESCRIPTOR, byval OutputSecurityDescriptor as PSECURITY_DESCRIPTOR ptr, byval RefBias as ULONG) as NTSTATUS
declare sub ObMakeTemporaryObject DDKAPI alias "ObMakeTemporaryObject" (byval Object as PVOID)
declare function ObOpenObjectByName DDKAPI alias "ObOpenObjectByName" (byval ObjectAttributes as POBJECT_ATTRIBUTES, byval ObjectType as POBJECT_TYPE, byval ParseContext as PVOID, byval AccessMode as KPROCESSOR_MODE, byval DesiredAccess as ACCESS_MASK, byval PassedAccessState as PACCESS_STATE, byval Handle as PHANDLE) as NTSTATUS
declare function ObOpenObjectByPointer DDKAPI alias "ObOpenObjectByPointer" (byval Object as PVOID, byval HandleAttributes as ULONG, byval PassedAccessState as PACCESS_STATE, byval DesiredAccess as ACCESS_MASK, byval ObjectType as POBJECT_TYPE, byval AccessMode as KPROCESSOR_MODE, byval Handle as PHANDLE) as NTSTATUS
declare function ObQueryObjectAuditingByHandle DDKAPI alias "ObQueryObjectAuditingByHandle" (byval Handle as HANDLE, byval GenerateOnClose as PBOOLEAN) as NTSTATUS
declare function ObReferenceObjectByHandle DDKAPI alias "ObReferenceObjectByHandle" (byval Handle as HANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectType as POBJECT_TYPE, byval AccessMode as KPROCESSOR_MODE, byval Object as PVOID ptr, byval HandleInformation as POBJECT_HANDLE_INFORMATION) as NTSTATUS
declare function ObReferenceObjectByName DDKAPI alias "ObReferenceObjectByName" (byval ObjectPath as PUNICODE_STRING, byval Attributes as ULONG, byval PassedAccessState as PACCESS_STATE, byval DesiredAccess as ACCESS_MASK, byval ObjectType as POBJECT_TYPE, byval AccessMode as KPROCESSOR_MODE, byval ParseContext as PVOID, byval Object as PVOID ptr) as NTSTATUS
declare function ObReferenceObjectByPointer DDKAPI alias "ObReferenceObjectByPointer" (byval Object as PVOID, byval DesiredAccess as ACCESS_MASK, byval ObjectType as POBJECT_TYPE, byval AccessMode as KPROCESSOR_MODE) as NTSTATUS
declare sub ObReferenceSecurityDescriptor DDKAPI alias "ObReferenceSecurityDescriptor" (byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval Count as ULONG)
declare sub ObReleaseObjectSecurity DDKAPI alias "ObReleaseObjectSecurity" (byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval MemoryAllocated as BOOLEAN)
declare function PsCreateSystemProcess DDKAPI alias "PsCreateSystemProcess" (byval ProcessHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES) as NTSTATUS
declare function PsCreateSystemThread DDKAPI alias "PsCreateSystemThread" (byval ThreadHandle as PHANDLE, byval DesiredAccess as ULONG, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval ProcessHandle as HANDLE, byval ClientId as PCLIENT_ID, byval StartRoutine as PKSTART_ROUTINE, byval StartContext as PVOID) as NTSTATUS
declare function PsGetCurrentProcessId DDKAPI alias "PsGetCurrentProcessId" () as HANDLE
declare function PsGetCurrentThreadId DDKAPI alias "PsGetCurrentThreadId" () as HANDLE
declare function PsGetVersion DDKAPI alias "PsGetVersion" (byval MajorVersion as PULONG, byval MinorVersion as PULONG, byval BuildNumber as PULONG, byval CSDVersion as PUNICODE_STRING) as BOOLEAN
declare function PsRemoveCreateThreadNotifyRoutine DDKAPI alias "PsRemoveCreateThreadNotifyRoutine" (byval NotifyRoutine as PCREATE_THREAD_NOTIFY_ROUTINE) as NTSTATUS
declare function PsRemoveLoadImageNotifyRoutine DDKAPI alias "PsRemoveLoadImageNotifyRoutine" (byval NotifyRoutine as PLOAD_IMAGE_NOTIFY_ROUTINE) as NTSTATUS
declare function PsSetCreateProcessNotifyRoutine DDKAPI alias "PsSetCreateProcessNotifyRoutine" (byval NotifyRoutine as PCREATE_PROCESS_NOTIFY_ROUTINE, byval Remove as BOOLEAN) as NTSTATUS
declare function PsSetCreateThreadNotifyRoutine DDKAPI alias "PsSetCreateThreadNotifyRoutine" (byval NotifyRoutine as PCREATE_THREAD_NOTIFY_ROUTINE) as NTSTATUS
declare function PsSetLoadImageNotifyRoutine DDKAPI alias "PsSetLoadImageNotifyRoutine" (byval NotifyRoutine as PLOAD_IMAGE_NOTIFY_ROUTINE) as NTSTATUS
declare function PsTerminateSystemThread DDKAPI alias "PsTerminateSystemThread" (byval ExitStatus as NTSTATUS) as NTSTATUS
declare function SeAccessCheck DDKAPI alias "SeAccessCheck" (byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval SubjectSecurityContext as PSECURITY_SUBJECT_CONTEXT, byval SubjectContextLocked as BOOLEAN, byval DesiredAccess as ACCESS_MASK, byval PreviouslyGrantedAccess as ACCESS_MASK, byval Privileges as PPRIVILEGE_SET ptr, byval GenericMapping as PGENERIC_MAPPING, byval AccessMode as KPROCESSOR_MODE, byval GrantedAccess as PACCESS_MASK, byval AccessStatus as PNTSTATUS) as BOOLEAN
declare function SeAssignSecurity DDKAPI alias "SeAssignSecurity" (byval ParentDescriptor as PSECURITY_DESCRIPTOR, byval ExplicitDescriptor as PSECURITY_DESCRIPTOR, byval NewDescriptor as PSECURITY_DESCRIPTOR ptr, byval IsDirectoryObject as BOOLEAN, byval SubjectContext as PSECURITY_SUBJECT_CONTEXT, byval GenericMapping as PGENERIC_MAPPING, byval PoolType as POOL_TYPE) as NTSTATUS
declare function SeAssignSecurityEx DDKAPI alias "SeAssignSecurityEx" (byval ParentDescriptor as PSECURITY_DESCRIPTOR, byval ExplicitDescriptor as PSECURITY_DESCRIPTOR, byval NewDescriptor as PSECURITY_DESCRIPTOR ptr, byval ObjectType as GUID ptr, byval IsDirectoryObject as BOOLEAN, byval AutoInheritFlags as ULONG, byval SubjectContext as PSECURITY_SUBJECT_CONTEXT, byval GenericMapping as PGENERIC_MAPPING, byval PoolType as POOL_TYPE) as NTSTATUS
declare function SeDeassignSecurity DDKAPI alias "SeDeassignSecurity" (byval SecurityDescriptor as PSECURITY_DESCRIPTOR ptr) as NTSTATUS
declare function SeSinglePrivilegeCheck DDKAPI alias "SeSinglePrivilegeCheck" (byval PrivilegeValue as LUID, byval PreviousMode as KPROCESSOR_MODE) as BOOLEAN
declare function SeValidSecurityDescriptor DDKAPI alias "SeValidSecurityDescriptor" (byval Length as ULONG, byval SecurityDescriptor as PSECURITY_DESCRIPTOR) as BOOLEAN
declare function NtOpenProcess DDKAPI alias "NtOpenProcess" (byval ProcessHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval ClientId as PCLIENT_ID) as NTSTATUS
declare function NtQueryInformationProcess DDKAPI alias "NtQueryInformationProcess" (byval ProcessHandle as HANDLE, byval ProcessInformationClass as PROCESSINFOCLASS, byval ProcessInformation as PVOID, byval ProcessInformationLength as ULONG, byval ReturnLength as PULONG) as NTSTATUS
declare function ZwCancelTimer DDKAPI alias "ZwCancelTimer" (byval TimerHandle as HANDLE, byval CurrentState as PBOOLEAN) as NTSTATUS
declare function NtClose DDKAPI alias "NtClose" (byval Handle as HANDLE) as NTSTATUS
declare function ZwClose DDKAPI alias "ZwClose" (byval Handle as HANDLE) as NTSTATUS
declare function ZwCreateDirectoryObject DDKAPI alias "ZwCreateDirectoryObject" (byval DirectoryHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES) as NTSTATUS
declare function NtCreateEvent DDKAPI alias "NtCreateEvent" (byval EventHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval ManualReset as BOOLEAN, byval InitialState as BOOLEAN) as NTSTATUS
declare function ZwCreateEvent DDKAPI alias "ZwCreateEvent" (byval EventHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval ManualReset as BOOLEAN, byval InitialState as BOOLEAN) as NTSTATUS
declare function ZwCreateFile DDKAPI alias "ZwCreateFile" (byval FileHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval IoStatusBlock as PIO_STATUS_BLOCK, byval AllocationSize as PLARGE_INTEGER, byval FileAttributes as ULONG, byval ShareAccess as ULONG, byval CreateDisposition as ULONG, byval CreateOptions as ULONG, byval EaBuffer as PVOID, byval EaLength as ULONG) as NTSTATUS
declare function ZwCreateKey DDKAPI alias "ZwCreateKey" (byval KeyHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval TitleIndex as ULONG, byval Class as PUNICODE_STRING, byval CreateOptions as ULONG, byval Disposition as PULONG) as NTSTATUS
declare function ZwCreateTimer DDKAPI alias "ZwCreateTimer" (byval TimerHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval TimerType as TIMER_TYPE) as NTSTATUS
declare function ZwDeleteKey DDKAPI alias "ZwDeleteKey" (byval KeyHandle as HANDLE) as NTSTATUS
declare function ZwDeleteValueKey DDKAPI alias "ZwDeleteValueKey" (byval KeyHandle as HANDLE, byval ValueName as PUNICODE_STRING) as NTSTATUS
declare function NtDeviceIoControlFile DDKAPI alias "NtDeviceIoControlFile" (byval DeviceHandle as HANDLE, byval Event as HANDLE, byval UserApcRoutine as PIO_APC_ROUTINE, byval UserApcContext as PVOID, byval IoStatusBlock as PIO_STATUS_BLOCK, byval IoControlCode as ULONG, byval InputBuffer as PVOID, byval InputBufferSize as ULONG, byval OutputBuffer as PVOID, byval OutputBufferSize as ULONG) as NTSTATUS
declare function ZwDeviceIoControlFile DDKAPI alias "ZwDeviceIoControlFile" (byval DeviceHandle as HANDLE, byval Event as HANDLE, byval UserApcRoutine as PIO_APC_ROUTINE, byval UserApcContext as PVOID, byval IoStatusBlock as PIO_STATUS_BLOCK, byval IoControlCode as ULONG, byval InputBuffer as PVOID, byval InputBufferSize as ULONG, byval OutputBuffer as PVOID, byval OutputBufferSize as ULONG) as NTSTATUS
declare function ZwEnumerateKey DDKAPI alias "ZwEnumerateKey" (byval KeyHandle as HANDLE, byval Index as ULONG, byval KeyInformationClass as KEY_INFORMATION_CLASS, byval KeyInformation as PVOID, byval Length as ULONG, byval ResultLength as PULONG) as NTSTATUS
declare function ZwEnumerateValueKey DDKAPI alias "ZwEnumerateValueKey" (byval KeyHandle as HANDLE, byval Index as ULONG, byval KeyValueInformationClass as KEY_VALUE_INFORMATION_CLASS, byval KeyValueInformation as PVOID, byval Length as ULONG, byval ResultLength as PULONG) as NTSTATUS
declare function ZwFlushKey DDKAPI alias "ZwFlushKey" (byval KeyHandle as HANDLE) as NTSTATUS
declare function ZwMakeTemporaryObject DDKAPI alias "ZwMakeTemporaryObject" (byval Handle as HANDLE) as NTSTATUS
declare function NtMapViewOfSection DDKAPI alias "NtMapViewOfSection" (byval SectionHandle as HANDLE, byval ProcessHandle as HANDLE, byval BaseAddress as PVOID ptr, byval ZeroBits as ULONG, byval CommitSize as ULONG, byval SectionOffset as PLARGE_INTEGER, byval ViewSize as PSIZE_T, byval InheritDisposition as SECTION_INHERIT, byval AllocationType as ULONG, byval Protect as ULONG) as NTSTATUS
declare function ZwMapViewOfSection DDKAPI alias "ZwMapViewOfSection" (byval SectionHandle as HANDLE, byval ProcessHandle as HANDLE, byval BaseAddress as PVOID ptr, byval ZeroBits as ULONG, byval CommitSize as ULONG, byval SectionOffset as PLARGE_INTEGER, byval ViewSize as PSIZE_T, byval InheritDisposition as SECTION_INHERIT, byval AllocationType as ULONG, byval Protect as ULONG) as NTSTATUS
declare function NtOpenFile DDKAPI alias "NtOpenFile" (byval FileHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval IoStatusBlock as PIO_STATUS_BLOCK, byval ShareAccess as ULONG, byval OpenOptions as ULONG) as NTSTATUS
declare function ZwOpenFile DDKAPI alias "ZwOpenFile" (byval FileHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES, byval IoStatusBlock as PIO_STATUS_BLOCK, byval ShareAccess as ULONG, byval OpenOptions as ULONG) as NTSTATUS
declare function ZwOpenKey DDKAPI alias "ZwOpenKey" (byval KeyHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES) as NTSTATUS
declare function ZwOpenSection DDKAPI alias "ZwOpenSection" (byval SectionHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES) as NTSTATUS
declare function ZwOpenSymbolicLinkObject DDKAPI alias "ZwOpenSymbolicLinkObject" (byval LinkHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES) as NTSTATUS
declare function ZwOpenTimer DDKAPI alias "ZwOpenTimer" (byval TimerHandle as PHANDLE, byval DesiredAccess as ACCESS_MASK, byval ObjectAttributes as POBJECT_ATTRIBUTES) as NTSTATUS
declare function ZwQueryInformationFile DDKAPI alias "ZwQueryInformationFile" (byval FileHandle as HANDLE, byval IoStatusBlock as PIO_STATUS_BLOCK, byval FileInformation as PVOID, byval Length as ULONG, byval FileInformationClass as FILE_INFORMATION_CLASS) as NTSTATUS
declare function ZwQueryKey DDKAPI alias "ZwQueryKey" (byval KeyHandle as HANDLE, byval KeyInformationClass as KEY_INFORMATION_CLASS, byval KeyInformation as PVOID, byval Length as ULONG, byval ResultLength as PULONG) as NTSTATUS
declare function ZwQuerySymbolicLinkObject DDKAPI alias "ZwQuerySymbolicLinkObject" (byval LinkHandle as HANDLE, byval LinkTarget as PUNICODE_STRING, byval ReturnedLength as PULONG) as NTSTATUS
declare function ZwQueryValueKey DDKAPI alias "ZwQueryValueKey" (byval KeyHandle as HANDLE, byval ValueName as PUNICODE_STRING, byval KeyValueInformationClass as KEY_VALUE_INFORMATION_CLASS, byval KeyValueInformation as PVOID, byval Length as ULONG, byval ResultLength as PULONG) as NTSTATUS
declare function NtReadFile DDKAPI alias "NtReadFile" (byval FileHandle as HANDLE, byval Event as HANDLE, byval ApcRoutine as PIO_APC_ROUTINE, byval ApcContext as PVOID, byval IoStatusBlock as PIO_STATUS_BLOCK, byval Buffer as PVOID, byval Length as ULONG, byval ByteOffset as PLARGE_INTEGER, byval Key as PULONG) as NTSTATUS
declare function ZwReadFile DDKAPI alias "ZwReadFile" (byval FileHandle as HANDLE, byval Event as HANDLE, byval ApcRoutine as PIO_APC_ROUTINE, byval ApcContext as PVOID, byval IoStatusBlock as PIO_STATUS_BLOCK, byval Buffer as PVOID, byval Length as ULONG, byval ByteOffset as PLARGE_INTEGER, byval Key as PULONG) as NTSTATUS
declare function NtSetEvent DDKAPI alias "NtSetEvent" (byval EventHandle as HANDLE, byval NumberOfThreadsReleased as PULONG) as NTSTATUS
declare function ZwSetEvent DDKAPI alias "ZwSetEvent" (byval EventHandle as HANDLE, byval NumberOfThreadsReleased as PULONG) as NTSTATUS
declare function ZwSetInformationFile DDKAPI alias "ZwSetInformationFile" (byval FileHandle as HANDLE, byval IoStatusBlock as PIO_STATUS_BLOCK, byval FileInformation as PVOID, byval Length as ULONG, byval FileInformationClass as FILE_INFORMATION_CLASS) as NTSTATUS
declare function ZwSetInformationThread DDKAPI alias "ZwSetInformationThread" (byval ThreadHandle as HANDLE, byval ThreadInformationClass as THREADINFOCLASS, byval ThreadInformation as PVOID, byval ThreadInformationLength as ULONG) as NTSTATUS
declare function ZwSetTimer DDKAPI alias "ZwSetTimer" (byval TimerHandle as HANDLE, byval DueTime as PLARGE_INTEGER, byval TimerApcRoutine as PTIMER_APC_ROUTINE, byval TimerContext as PVOID, byval WakeTimer as BOOLEAN, byval Period as LONG, byval PreviousState as PBOOLEAN) as NTSTATUS
declare function ZwSetValueKey DDKAPI alias "ZwSetValueKey" (byval KeyHandle as HANDLE, byval ValueName as PUNICODE_STRING, byval TitleIndex as ULONG, byval Type as ULONG, byval Data as PVOID, byval DataSize as ULONG) as NTSTATUS
declare function NtUnmapViewOfSection DDKAPI alias "NtUnmapViewOfSection" (byval ProcessHandle as HANDLE, byval BaseAddress as PVOID) as NTSTATUS
declare function ZwUnmapViewOfSection DDKAPI alias "ZwUnmapViewOfSection" (byval ProcessHandle as HANDLE, byval BaseAddress as PVOID) as NTSTATUS
declare function NtWaitForSingleObject DDKAPI alias "NtWaitForSingleObject" (byval Object as HANDLE, byval Alertable as BOOLEAN, byval Time as PLARGE_INTEGER) as NTSTATUS
declare function ZwWaitForSingleObject DDKAPI alias "ZwWaitForSingleObject" (byval Object as HANDLE, byval Alertable as BOOLEAN, byval Time as PLARGE_INTEGER) as NTSTATUS
declare function NtWriteFile DDKAPI alias "NtWriteFile" (byval FileHandle as HANDLE, byval Event as HANDLE, byval ApcRoutine as PIO_APC_ROUTINE, byval ApcContext as PVOID, byval IoStatusBlock as PIO_STATUS_BLOCK, byval Buffer as PVOID, byval Length as ULONG, byval ByteOffset as PLARGE_INTEGER, byval Key as PULONG) as NTSTATUS
declare function ZwWriteFile DDKAPI alias "ZwWriteFile" (byval FileHandle as HANDLE, byval Event as HANDLE, byval ApcRoutine as PIO_APC_ROUTINE, byval ApcContext as PVOID, byval IoStatusBlock as PIO_STATUS_BLOCK, byval Buffer as PVOID, byval Length as ULONG, byval ByteOffset as PLARGE_INTEGER, byval Key as PULONG) as NTSTATUS
declare function PoCallDriver DDKAPI alias "PoCallDriver" (byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
declare function PoRegisterDeviceForIdleDetection DDKAPI alias "PoRegisterDeviceForIdleDetection" (byval DeviceObject as PDEVICE_OBJECT, byval ConservationIdleTime as ULONG, byval PerformanceIdleTime as ULONG, byval State as DEVICE_POWER_STATE) as PULONG
declare function PoRegisterSystemState DDKAPI alias "PoRegisterSystemState" (byval StateHandle as PVOID, byval Flags as EXECUTION_STATE) as PVOID
declare function PoRequestPowerIrp DDKAPI alias "PoRequestPowerIrp" (byval DeviceObject as PDEVICE_OBJECT, byval MinorFunction as UCHAR, byval PowerState as POWER_STATE, byval CompletionFunction as PREQUEST_POWER_COMPLETE, byval Context as PVOID, byval Irp as PIRP ptr) as NTSTATUS
declare function PoRequestShutdownEvent DDKAPI alias "PoRequestShutdownEvent" (byval Event as PVOID ptr) as NTSTATUS
declare sub PoSetDeviceBusy DDKAPI alias "PoSetDeviceBusy" (byval IdlePointer as PULONG)
declare function PoSetPowerState DDKAPI alias "PoSetPowerState" (byval DeviceObject as PDEVICE_OBJECT, byval Type as POWER_STATE_TYPE, byval State as POWER_STATE) as POWER_STATE
declare sub PoSetSystemState DDKAPI alias "PoSetSystemState" (byval Flags as EXECUTION_STATE)
declare sub PoStartNextPowerIrp DDKAPI alias "PoStartNextPowerIrp" (byval Irp as PIRP)
declare sub PoUnregisterSystemState DDKAPI alias "PoUnregisterSystemState" (byval StateHandle as PVOID)
declare function WmiCompleteRequest DDKAPI alias "WmiCompleteRequest" (byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP, byval Status as NTSTATUS, byval BufferUsed as ULONG, byval PriorityBoost as CCHAR) as NTSTATUS
declare function WmiFireEvent DDKAPI alias "WmiFireEvent" (byval DeviceObject as PDEVICE_OBJECT, byval Guid as LPGUID, byval InstanceIndex as ULONG, byval EventDataSize as ULONG, byval EventData as PVOID) as NTSTATUS
declare function WmiQueryTraceInformation DDKAPI alias "WmiQueryTraceInformation" (byval TraceInformationClass as TRACE_INFORMATION_CLASS, byval TraceInformation as PVOID, byval TraceInformationLength as ULONG, byval RequiredLength as PULONG, byval Buffer as PVOID) as NTSTATUS
declare function WmiSystemControl DDKAPI alias "WmiSystemControl" (byval WmiLibInfo as PWMILIB_CONTEXT, byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP, byval IrpDisposition as PSYSCTL_IRP_DISPOSITION) as NTSTATUS
declare function WmiTraceMessage cdecl alias "WmiTraceMessage" (byval LoggerHandle as TRACEHANDLE, byval MessageFlags as ULONG, byval MessageGuid as LPGUID, byval MessageNumber as USHORT, ...) as NTSTATUS
declare sub KdDisableDebugger DDKAPI alias "KdDisableDebugger" ()
declare sub KdEnableDebugger DDKAPI alias "KdEnableDebugger" ()
declare sub DbgBreakPoint DDKAPI alias "DbgBreakPoint" ()
declare sub DbgBreakPointWithStatus DDKAPI alias "DbgBreakPointWithStatus" (byval Status as ULONG)
declare function DbgPrint cdecl alias "DbgPrint" (byval Format as PCH, ...) as ULONG
declare function DbgPrintEx cdecl alias "DbgPrintEx" (byval ComponentId as ULONG, byval Level as ULONG, byval Format as PCH, ...) as ULONG
declare function DbgPrintReturnControlC cdecl alias "DbgPrintReturnControlC" (byval Format as PCH, ...) as ULONG
declare function DbgQueryDebugFilterState DDKAPI alias "DbgQueryDebugFilterState" (byval ComponentId as ULONG, byval Level as ULONG) as NTSTATUS
declare function DbgSetDebugFilterState DDKAPI alias "DbgSetDebugFilterState" (byval ComponentId as ULONG, byval Level as ULONG, byval State as BOOLEAN) as NTSTATUS
declare function KeGetCurrentKPCR DDKAPI alias "KeGetCurrentKPCR" () as _KPCR ptr
#ifndef VerSetConditionMask 
declare function VerSetConditionMask DDKAPI alias "VerSetConditionMask" (byval ConditionMask as ULONGLONG, byval TypeMask as ULONG, byval Condition as UCHAR) as ULONGLONG
#endif

end extern

extern KdDebuggerNotPresent alias "KdDebuggerNotPresent" as PBOOLEAN
extern KdDebuggerEnabled alias "KdDebuggerEnabled" as PBOOLEAN
extern ExDesktopObjectType alias "ExDesktopObjectType" as POBJECT_TYPE
extern ExEventObjectType alias "ExEventObjectType" as POBJECT_TYPE
extern ExSemaphoreObjectType alias "ExSemaphoreObjectType" as POBJECT_TYPE
extern ExWindowStationObjectType alias "ExWindowStationObjectType" as POBJECT_TYPE
extern IoAdapterObjectType alias "IoAdapterObjectType" as POBJECT_TYPE
extern IoDeviceHandlerObjectSize alias "IoDeviceHandlerObjectSize" as ULONG
extern IoDeviceHandlerObjectType alias "IoDeviceHandlerObjectType" as POBJECT_TYPE
extern IoDeviceObjectType alias "IoDeviceObjectType" as POBJECT_TYPE
extern IoDriverObjectType alias "IoDriverObjectType" as POBJECT_TYPE
extern IoFileObjectType alias "IoFileObjectType" as POBJECT_TYPE
extern LpcPortObjectType alias "LpcPortObjectType" as POBJECT_TYPE
extern MmSectionObjectType alias "MmSectionObjectType" as POBJECT_TYPE
extern SeTokenObjectType alias "SeTokenObjectType" as POBJECT_TYPE
extern KeNumberProcessors alias "KeNumberProcessors" as CCHAR
extern HalDispatchTable alias "HalDispatchTable" as PHAL_DISPATCH_TABLE
extern HalPrivateDispatchTable alias "HalPrivateDispatchTable" as PHAL_PRIVATE_DISPATCH_TABLE
extern MmHighestUserAddress alias "MmHighestUserAddress" as PVOID ptr
extern MmSystemRangeStart alias "MmSystemRangeStart" as PVOID ptr
extern MmUserProbeAddress alias "MmUserProbeAddress" as ULONG ptr


#endif
