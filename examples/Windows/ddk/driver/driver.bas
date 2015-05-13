
'' NT driver example, written by voodooattack
    
    #include once "win\ddk\winddk.bi"
    
    #undef fb_RtInit
    
    declare function DriverEntry stdcall alias "DriverEntry" (byval pDriverObject as PDRIVER_OBJECT, _
                                                      byval pRegistryPath as PUNICODE_STRING) as NTSTATUS
    
    
    
    static shared dev_name as wstring ptr = @wstr("\Device\FBExample")
    static shared dev_dos_name as wstring ptr = @wstr("\DosDevices\FBExample")
    
    declare sub fb_RtInit stdcall alias "fb_RtInit"()
    
    declare function FBDriver_UnsupportedFunction(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
    declare function FBDriver_Create(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
    declare function FBDriver_Close(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
    declare function FBDriver_IoControl(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
    declare function FBDriver_Read(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
    declare function FBDriver_Write(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
    declare sub FBDriver_Unload(byval as PDRIVER_OBJECT)
    
    
    function DriverEntry(byval pDriverObject as PDRIVER_OBJECT, _
                         byval pRegistryPath as PUNICODE_STRING) as NTSTATUS
        
        dim Status as NTSTATUS = STATUS_SUCCESS
        dim pDeviceObject as PDEVICE_OBJECT = NULL
        
        dim as UNICODE_STRING usDriverName, usDosDeviceName
        dim i as integer
        
        DbgPrint(@!"FBExample: DriverEntry Called \r\n")
        
        RtlInitUnicodeString(@usDriverName, dev_name)
        RtlInitUnicodeString(@usDosDeviceName, dev_dos_name) 
    
        Status = IoCreateDevice(pDriverObject, _
                                0, _
                                @usDriverName, _
                                FILE_DEVICE_UNKNOWN, _
                                FILE_DEVICE_SECURE_OPEN, _
                                FALSE, _
                                @pDeviceObject)
        

        if (Status = STATUS_SUCCESS) then
            
            DbgPrint(@!"FBExample: Device created \r\n")
            
            for i = 0 to IRP_MJ_MAXIMUM_FUNCTION - 1
                pDriverObject->MajorFunction(i) = @FBDriver_UnsupportedFunction
            next
            
            with *pDriverObject
                .MajorFunction(IRP_MJ_CLOSE)  = @FBDriver_Close
                .MajorFunction(IRP_MJ_CREATE) = @FBDriver_Create
                .MajorFunction(IRP_MJ_DEVICE_CONTROL) = @FBDriver_IoControl
                .MajorFunction(IRP_MJ_READ) = @FBDriver_Read
                .MajorFunction(IRP_MJ_WRITE) = @FBDriver_Write
                .DriverUnload = @FBDriver_Unload
                .Flags or= DO_DIRECT_IO
                .Flags and= NOT (DO_DEVICE_INITIALIZING)
            end with
            
            IoCreateSymbolicLink(@usDosDeviceName, @usDriverName)
        else
            DbgPrint(@!"FBExample: Error creating device \r\n")
        end if
        
        return Status
        
    end function
    
    sub fb_RtInit()
        DbgPrint(@!"FBExample: fb_RtInit Called \r\n")
        return
    end sub
    
    declare function KeTickCount stdcall alias "KeTickCount" () as PLARGE_INTEGER
    
    function KeTickCount () as LARGE_INTEGER ptr
        static as LARGE_INTEGER c
        KeQueryTickCount(@c)
        return @c
    end function
    
    sub FBDriver_Unload(byval DriverObject as PDRIVER_OBJECT)
        
        dim usDosDeviceName as UNICODE_STRING
        
        DbgPrint(@!"FBExample: unloading.. \r\n")
        
        RtlInitUnicodeString(@usDosDeviceName, dev_dos_name)
        
        IoDeleteSymbolicLink(@usDosDeviceName)
        IoDeleteDevice(DriverObject->DeviceObject)
        
    end sub
    
    function FBDriver_UnsupportedFunction(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
        DbgPrint(@!"FBExample: Unsupported Function \r\n")
        return STATUS_NOT_SUPPORTED
    end function
    
    function FBDriver_Create(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
        DbgPrint(@!"FBExample: FBDriver_Create \r\n")
        return STATUS_SUCCESS
    end function

    function FBDriver_Close(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
        DbgPrint(@!"FBExample: FBDriver_Close \r\n")
        return STATUS_SUCCESS
    end function

    function FBDriver_IoControl(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
        DbgPrint(@!"FBExample: FBDriver_IoControl \r\n")
        return STATUS_SUCCESS
    end function

    function FBDriver_Read(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
        DbgPrint(@!"FBExample: FBDriver_Read \r\n")
        return STATUS_SUCCESS
    end function

    function FBDriver_Write(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
        DbgPrint(@!"FBExample: FBDriver_Write \r\n")
        return STATUS_SUCCESS
    end function
