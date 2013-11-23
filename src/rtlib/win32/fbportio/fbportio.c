/*
 * Tiny Windows kernel driver to enable I/O ports access
 * (currently 32bit only)
 *
 * This code (plus the .rc) is compiled into fbportio.sys, the driver binary
 * that can be put into '%windir%\system32\drivers'. libfb includes the driver
 * (as an array of bytes in a C module) and writes it back out as a file when
 * it's needed at runtime.
 */

/*
 * Many thanks to these useful references:
 *
 * http://www.beyondlogic.org/porttalk/porttalk.htm
 * http://www.codeproject.com/system/kportII.asp
 * http://www.logix4u.net/inpout32.htm
 *
 * This code was written to provide a tiny implementation of the theory described there.
 */

#include <ddk/ntddk.h>
#include "../fbportio.h"

#define DEVICE_NAME         L"\\Device\\fbportio"
#define DEVICE_DOS_NAME     L"\\DosDevices\\fbportio"
#define IOPM_SIZE           0x2000

typedef UCHAR IOPM[IOPM_SIZE];

static IOPM *IOPM_map = NULL;

__declspec(dllimport) NTSTATUS NTAPI PsLookupProcessByProcessId(IN HANDLE, OUT PEPROCESS *);

/* some undocumented kernel API calls ;) */
__declspec(dllimport) void NTAPI Ke386SetIoAccessMap(int, IOPM *);
__declspec(dllimport) void NTAPI Ke386IoSetAccessProcess(PEPROCESS, int);

static NTSTATUS STDCALL device_dispatch(IN PDEVICE_OBJECT DeviceObject, IN PIRP Irp)
{
    Irp->IoStatus.Information = 0;
    Irp->IoStatus.Status = STATUS_SUCCESS;
    IoCompleteRequest(Irp, IO_NO_INCREMENT);
    return STATUS_SUCCESS;
}

static NTSTATUS STDCALL device_control(IN PDEVICE_OBJECT DeviceObject, IN PIRP Irp)
{
    PIO_STACK_LOCATION stack;
    PULONG ldata;
    PUSHORT sdata;
    ULONG in_size, out_size;
    ULONG written_bytes = 0;
    NTSTATUS status;
    struct _EPROCESS *process;

    stack = IoGetCurrentIrpStackLocation(Irp);
    in_size = stack->Parameters.DeviceIoControl.InputBufferLength;
    out_size = stack->Parameters.DeviceIoControl.OutputBufferLength;
    ldata = (PULONG) Irp->AssociatedIrp.SystemBuffer;
    sdata = (PUSHORT) Irp->AssociatedIrp.SystemBuffer;

    switch (stack->Parameters.DeviceIoControl.IoControlCode) {
    case IOCTL_GRANT_IOPM:
        if (in_size < 4) {
            status = STATUS_BUFFER_TOO_SMALL;
        } else {
            HANDLE pid = (HANDLE) ldata[0];
            status = PsLookupProcessByProcessId(pid, &process);
            if (NT_SUCCESS(status)) {
                /* copy the IOPM bitmap to the process task state segment */
                Ke386SetIoAccessMap(1, IOPM_map);
                /* inform the kernel the process has a custom IOPM bitmap */
                Ke386IoSetAccessProcess(process, 1);
                status = STATUS_SUCCESS;
            }
        }
        break;

    case IOCTL_GET_VERSION:
        if (out_size < 2) {
            status = STATUS_BUFFER_TOO_SMALL;
        } else {
            sdata[0] = FBPORTIO_VERSION;
            written_bytes = 2;
            status = STATUS_SUCCESS;
        }
        break;

    default:
        status = STATUS_UNSUCCESSFUL;
        break;
    }

    Irp->IoStatus.Information = written_bytes;
    Irp->IoStatus.Status = status;
    IoCompleteRequest(Irp, IO_NO_INCREMENT);

    return status;
}

static VOID STDCALL driver_unload(IN PDRIVER_OBJECT DriverObject)
{
    WCHAR dos_name_buffer[] = DEVICE_DOS_NAME;

    UNICODE_STRING unicode_dos_name;

    if (IOPM_map) {
        MmFreeNonCachedMemory(IOPM_map, sizeof(IOPM));
    }

    RtlInitUnicodeString(&unicode_dos_name, dos_name_buffer);
    IoDeleteSymbolicLink(&unicode_dos_name);
    IoDeleteDevice(DriverObject->DeviceObject);
}

NTSTATUS STDCALL DriverEntry(IN PDRIVER_OBJECT DriverObject, IN PUNICODE_STRING RegistryPath)
{
    PDEVICE_OBJECT device_object;
    NTSTATUS status;
    WCHAR name_buffer[] = DEVICE_NAME;
    WCHAR dos_name_buffer[] = DEVICE_DOS_NAME;
    UNICODE_STRING unicode_name, unicode_dos_name;

    IOPM_map = MmAllocateNonCachedMemory(sizeof(IOPM));
    if (!IOPM_map) {
        return STATUS_INSUFFICIENT_RESOURCES;
    }

    /* clear all bits of the IOPM map, granting access to all ports */
    RtlZeroMemory(IOPM_map, sizeof(IOPM));
    RtlInitUnicodeString(&unicode_name, name_buffer);
    RtlInitUnicodeString(&unicode_dos_name, dos_name_buffer);

    status = IoCreateDevice(DriverObject, 0, &unicode_name, FILE_DEVICE_UNKNOWN,
                            0, FALSE, &device_object);
    if (!NT_SUCCESS(status)) {
        return status;
    }

    status = IoCreateSymbolicLink(&unicode_dos_name, &unicode_name);
    if (!NT_SUCCESS(status)) {
        return status;
    }

    DriverObject->MajorFunction[IRP_MJ_CREATE] = device_dispatch;
    DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL] = device_control;
    DriverObject->DriverUnload = driver_unload;

    return STATUS_SUCCESS;
}
