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

#if _WIN32_WINNT >= &h0600
	#include once "winapifamily.bi"
	#include once "devpropdef.bi"

	extern "C"

	#define _PCIPROP_
	extern DEVPKEY_PciRootBus_SecondaryInterface as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_CurrentSpeedAndMode as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_SupportedSpeedsAndModes as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_DeviceIDMessagingCapable as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_SecondaryBusWidth as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_ExtendedConfigAvailable as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_ExtendedPCIConfigOpRegionSupport as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_ASPMSupport as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_ClockPowerManagementSupport as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_PCISegmentGroupsSupport as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_MSISupport as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_PCIExpressNativeHotPlugControl as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_SHPCNativeHotPlugControl as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_PCIExpressNativePMEControl as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_PCIExpressAERControl as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_PCIExpressCapabilityControl as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_NativePciExpressControl as const DEVPROPKEY
	extern DEVPKEY_PciRootBus_SystemMsiSupport as const DEVPROPKEY
	extern DEVPKEY_PciDevice_DeviceType as const DEVPROPKEY
	extern DEVPKEY_PciDevice_CurrentSpeedAndMode as const DEVPROPKEY
	extern DEVPKEY_PciDevice_BaseClass as const DEVPROPKEY
	extern DEVPKEY_PciDevice_SubClass as const DEVPROPKEY
	extern DEVPKEY_PciDevice_ProgIf as const DEVPROPKEY
	extern DEVPKEY_PciDevice_CurrentPayloadSize as const DEVPROPKEY
	extern DEVPKEY_PciDevice_MaxPayloadSize as const DEVPROPKEY
	extern DEVPKEY_PciDevice_MaxReadRequestSize as const DEVPROPKEY
	extern DEVPKEY_PciDevice_CurrentLinkSpeed as const DEVPROPKEY
	extern DEVPKEY_PciDevice_CurrentLinkWidth as const DEVPROPKEY
	extern DEVPKEY_PciDevice_MaxLinkSpeed as const DEVPROPKEY
	extern DEVPKEY_PciDevice_MaxLinkWidth as const DEVPROPKEY
	extern DEVPKEY_PciDevice_ExpressSpecVersion as const DEVPROPKEY
	extern DEVPKEY_PciDevice_InterruptSupport as const DEVPROPKEY
	extern DEVPKEY_PciDevice_InterruptMessageMaximum as const DEVPROPKEY
	extern DEVPKEY_PciDevice_BarTypes as const DEVPROPKEY
	extern DEVPKEY_PciDevice_AERCapabilityPresent as const DEVPROPKEY
	extern DEVPKEY_PciDevice_FirmwareErrorHandling as const DEVPROPKEY
	extern DEVPKEY_PciDevice_Uncorrectable_Error_Mask as const DEVPROPKEY
	extern DEVPKEY_PciDevice_Uncorrectable_Error_Severity as const DEVPROPKEY
	extern DEVPKEY_PciDevice_Correctable_Error_Mask as const DEVPROPKEY
	extern DEVPKEY_PciDevice_ECRC_Errors as const DEVPROPKEY
	extern DEVPKEY_PciDevice_Error_Reporting as const DEVPROPKEY
	extern DEVPKEY_PciDevice_RootError_Reporting as const DEVPROPKEY
	extern DEVPKEY_PciDevice_S0WakeupSupported as const DEVPROPKEY
	extern DEVPKEY_PciDevice_SriovSupport as const DEVPROPKEY
	extern DEVPKEY_PciDevice_Label_Id as const DEVPROPKEY
	extern DEVPKEY_PciDevice_Label_String as const DEVPROPKEY
	extern DEVPKEY_PciDevice_AcsSupport as const DEVPROPKEY
	extern DEVPKEY_PciDevice_AriSupport as const DEVPROPKEY

	const DevProp_PciRootBus_SecondaryInterface_PciConventional = 0
	const DevProp_PciRootBus_SecondaryInterface_PciXMode1 = 1
	const DevProp_PciRootBus_SecondaryInterface_PciXMode2 = 2
	const DevProp_PciRootBus_SecondaryInterface_PciExpress = 3
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_Conventional_33Mhz = 0
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_Conventional_66Mhz = 1
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_66Mhz = 2
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_100Mhz = 3
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_133Mhz = 4
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_ECC_66Mhz = 5
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_ECC_100Mhz = 6
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_ECC_133Mhz = 7
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_266_Mode2_66Mhz = 8
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_266_Mode2_100Mhz = 9
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_266_Mode2_133Mhz = 10
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_533_Mode2_66Mhz = 11
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_533_Mode2_100Mhz = 12
	const DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_533_Mode2_133Mhz = 13
	const DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_Conventional_33Mhz = 1
	const DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_Conventional_66Mhz = 2
	const DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_66Mhz = 4
	const DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_133Mhz = 8
	const DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_266Mhz = 16
	const DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_533Mhz = 32
	const DevProp_PciRootBus_BusWidth_32Bits = 0
	const DevProp_PciRootBus_BusWidth_64Bits = 1
	const DevProp_PciDevice_DeviceType_PciConventional = 0
	const DevProp_PciDevice_DeviceType_PciX = 1
	const DevProp_PciDevice_DeviceType_PciExpressEndpoint = 2
	const DevProp_PciDevice_DeviceType_PciExpressLegacyEndpoint = 3
	const DevProp_PciDevice_DeviceType_PciExpressRootComplexIntegratedEndpoint = 4
	const DevProp_PciDevice_DeviceType_PciExpressTreatedAsPci = 5
	const DevProp_PciDevice_BridgeType_PciConventional = 6
	const DevProp_PciDevice_BridgeType_PciX = 7
	const DevProp_PciDevice_BridgeType_PciExpressRootPort = 8
	const DevProp_PciDevice_BridgeType_PciExpressUpstreamSwitchPort = 9
	const DevProp_PciDevice_BridgeType_PciExpressDownstreamSwitchPort = 10
	const DevProp_PciDevice_BridgeType_PciExpressToPciXBridge = 11
	const DevProp_PciDevice_BridgeType_PciXToExpressBridge = 12
	const DevProp_PciDevice_BridgeType_PciExpressTreatedAsPci = 13
	const DevProp_PciDevice_CurrentSpeedAndMode_Pci_Conventional_33MHz = 0
	const DevProp_PciDevice_CurrentSpeedAndMode_Pci_Conventional_66MHz = 1
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode_Conventional_Pci = &h0
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_66Mhz = &h1
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_100Mhz = &h2
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_133MHZ = &h3
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_ECC_66Mhz = &h5
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_ECC_100Mhz = &h6
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_ECC_133Mhz = &h7
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_266_66MHz = &h9
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_266_100MHz = &ha
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_266_133MHz = &hb
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_533_66MHz = &hd
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_533_100MHz = &he
	const DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_533_133MHz = &hf
	const DevProp_PciExpressDevice_PayloadOrRequestSize_128Bytes = 0
	const DevProp_PciExpressDevice_PayloadOrRequestSize_256Bytes = 1
	const DevProp_PciExpressDevice_PayloadOrRequestSize_512Bytes = 2
	const DevProp_PciExpressDevice_PayloadOrRequestSize_1024Bytes = 3
	const DevProp_PciExpressDevice_PayloadOrRequestSize_2048Bytes = 4
	const DevProp_PciExpressDevice_PayloadOrRequestSize_4096Bytes = 5
	const DevProp_PciExpressDevice_LinkSpeed_TwoAndHalf_Gbps = 1
	const DevProp_PciExpressDevice_LinkSpeed_Five_Gbps = 2
	const DevProp_PciExpressDevice_LinkWidth_By_1 = 1
	const DevProp_PciExpressDevice_LinkWidth_By_2 = 2
	const DevProp_PciExpressDevice_LinkWidth_By_4 = 4
	const DevProp_PciExpressDevice_LinkWidth_By_8 = 8
	const DevProp_PciExpressDevice_LinkWidth_By_12 = 12
	const DevProp_PciExpressDevice_LinkWidth_By_16 = 16
	const DevProp_PciExpressDevice_LinkWidth_By_32 = 32
	const DevProp_PciExpressDevice_LinkSpeed_TwoAndHalf_Gbps = 1
	const DevProp_PciExpressDevice_Spec_Version_10 = 1
	const DevProp_PciExpressDevice_Spec_Version_11 = 2
	const DevProp_PciDevice_InterruptType_LineBased = 1
	const DevProp_PciDevice_InterruptType_Msi = 2
	const DevProp_PciDevice_InterruptType_MsiX = 4
	#define DevProp_PciDevice_IoBarCount(_PD) ((_PD) and &hff)
	#define DevProp_PciDevice_NonPrefetchable_MemoryBarCount(_PD) (((_PD) shr 8) and &hff)
	#define DevProp_PciDevice_32BitPrefetchable_MemoryBarCount(_PD) (((_PD) shr 16) and &hff)
	#define DevProp_PciDevice_64BitPrefetchable_MemoryBarCount(_PD) (((_PD) shr 24) and &hff)
	const DevProp_PciDevice_SriovSupport_Ok = &h0
	const DevProp_PciDevice_SriovSupport_MissingAcs = &h1
	const DevProp_PciDevice_SriovSupport_MissingPfDriver = &h2
	const DevProp_PciDevice_SriovSupport_NoBusResource = &h3
	const DevProp_PciDevice_SriovSupport_DidntGetVfBarSpace = &h4
	const DevProp_PciDevice_AcsSupport_Present = &h0
	const DevProp_PciDevice_AcsSupport_NotNeeded = &h1
	const DevProp_PciDevice_AcsSupport_Missing = &h2

	end extern
#endif
