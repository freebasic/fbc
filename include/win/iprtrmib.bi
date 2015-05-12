''
''
'' iprtrmib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_iprtrmib_bi__
#define __win_iprtrmib_bi__

#include once "win/ipifcons.bi"

#ifndef ANY_SIZE
#define ANY_SIZE 1
#endif
#define MAXLEN_PHYSADDR 8
#define MAXLEN_IFDESCR 256
#ifndef MAX_INTERFACE_NAME_LEN
#define MAX_INTERFACE_NAME_LEN 256
#endif
#define MIB_IPNET_TYPE_OTHER 1
#define MIB_IPNET_TYPE_INVALID 2
#define MIB_IPNET_TYPE_DYNAMIC 3
#define MIB_IPNET_TYPE_STATIC 4
#define MIB_TCP_RTO_OTHER 1
#define MIB_TCP_RTO_CONSTANT 2
#define MIB_TCP_RTO_RSRE 3
#define MIB_TCP_RTO_VANJ 4
#define MIB_TCP_STATE_CLOSED 1
#define MIB_TCP_STATE_LISTEN 2
#define MIB_TCP_STATE_SYN_SENT 3
#define MIB_TCP_STATE_SYN_RCVD 4
#define MIB_TCP_STATE_ESTAB 5
#define MIB_TCP_STATE_FIN_WAIT1 6
#define MIB_TCP_STATE_FIN_WAIT2 7
#define MIB_TCP_STATE_CLOSE_WAIT 8
#define MIB_TCP_STATE_CLOSING 9
#define MIB_TCP_STATE_LAST_ACK 10
#define MIB_TCP_STATE_TIME_WAIT 11
#define MIB_TCP_STATE_DELETE_TCB 12

type MIB_IPADDRROW
	dwAddr as DWORD
	dwIndex as DWORD
	dwMask as DWORD
	dwBCastAddr as DWORD
	dwReasmSize as DWORD
	unused1 as ushort
	unused2 as ushort
end type

type PMIB_IPADDRROW as MIB_IPADDRROW ptr

type MIB_IPADDRTABLE
	dwNumEntries as DWORD
	table(0 to 1-1) as MIB_IPADDRROW
end type

type PMIB_IPADDRTABLE as MIB_IPADDRTABLE ptr

type MIB_IPFORWARDROW
	dwForwardDest as DWORD
	dwForwardMask as DWORD
	dwForwardPolicy as DWORD
	dwForwardNextHop as DWORD
	dwForwardIfIndex as DWORD
	dwForwardType as DWORD
	dwForwardProto as DWORD
	dwForwardAge as DWORD
	dwForwardNextHopAS as DWORD
	dwForwardMetric1 as DWORD
	dwForwardMetric2 as DWORD
	dwForwardMetric3 as DWORD
	dwForwardMetric4 as DWORD
	dwForwardMetric5 as DWORD
end type

type PMIB_IPFORWARDROW as MIB_IPFORWARDROW ptr

type MIB_IPFORWARDTABLE
	dwNumEntries as DWORD
	table(0 to 1-1) as MIB_IPFORWARDROW
end type

type PMIB_IPFORWARDTABLE as MIB_IPFORWARDTABLE ptr

type MIB_IPNETROW
	dwIndex as DWORD
	dwPhysAddrLen as DWORD
	bPhysAddr(0 to 8-1) as UBYTE
	dwAddr as DWORD
	dwType as DWORD
end type

type PMIB_IPNETROW as MIB_IPNETROW ptr

type MIB_IPNETTABLE
	dwNumEntries as DWORD
	table(0 to 1-1) as MIB_IPNETROW
end type

type PMIB_IPNETTABLE as MIB_IPNETTABLE ptr

type MIBICMPSTATS
	dwMsgs as DWORD
	dwErrors as DWORD
	dwDestUnreachs as DWORD
	dwTimeExcds as DWORD
	dwParmProbs as DWORD
	dwSrcQuenchs as DWORD
	dwRedirects as DWORD
	dwEchos as DWORD
	dwEchoReps as DWORD
	dwTimestamps as DWORD
	dwTimestampReps as DWORD
	dwAddrMasks as DWORD
	dwAddrMaskReps as DWORD
end type

type PMIBICMPSTATS as MIBICMPSTATS ptr

type MIBICMPINFO
	icmpInStats as MIBICMPSTATS
	icmpOutStats as MIBICMPSTATS
end type

type PMIBICMPINFO as MIBICMPINFO ptr

type MIB_ICMP
	stats as MIBICMPINFO
end type

type PMIB_ICMP as MIB_ICMP ptr

type MIB_IFROW
	wszName as wstring * 256
	dwIndex as DWORD
	dwType as DWORD
	dwMtu as DWORD
	dwSpeed as DWORD
	dwPhysAddrLen as DWORD
	bPhysAddr(0 to 8-1) as UBYTE
	dwAdminStatus as DWORD
	dwOperStatus as DWORD
	dwLastChange as DWORD
	dwInOctets as DWORD
	dwInUcastPkts as DWORD
	dwInNUcastPkts as DWORD
	dwInDiscards as DWORD
	dwInErrors as DWORD
	dwInUnknownProtos as DWORD
	dwOutOctets as DWORD
	dwOutUcastPkts as DWORD
	dwOutNUcastPkts as DWORD
	dwOutDiscards as DWORD
	dwOutErrors as DWORD
	dwOutQLen as DWORD
	dwDescrLen as DWORD
	bDescr(0 to 256-1) as UBYTE
end type

type PMIB_IFROW as MIB_IFROW ptr

type MIB_IFTABLE
	dwNumEntries as DWORD
	table(0 to 1-1) as MIB_IFROW
end type

type PMIB_IFTABLE as MIB_IFTABLE ptr

type MIB_IPSTATS
	dwForwarding as DWORD
	dwDefaultTTL as DWORD
	dwInReceives as DWORD
	dwInHdrErrors as DWORD
	dwInAddrErrors as DWORD
	dwForwDatagrams as DWORD
	dwInUnknownProtos as DWORD
	dwInDiscards as DWORD
	dwInDelivers as DWORD
	dwOutRequests as DWORD
	dwRoutingDiscards as DWORD
	dwOutDiscards as DWORD
	dwOutNoRoutes as DWORD
	dwReasmTimeout as DWORD
	dwReasmReqds as DWORD
	dwReasmOks as DWORD
	dwReasmFails as DWORD
	dwFragOks as DWORD
	dwFragFails as DWORD
	dwFragCreates as DWORD
	dwNumIf as DWORD
	dwNumAddr as DWORD
	dwNumRoutes as DWORD
end type

type PMIB_IPSTATS as MIB_IPSTATS ptr

type MIB_TCPSTATS
	dwRtoAlgorithm as DWORD
	dwRtoMin as DWORD
	dwRtoMax as DWORD
	dwMaxConn as DWORD
	dwActiveOpens as DWORD
	dwPassiveOpens as DWORD
	dwAttemptFails as DWORD
	dwEstabResets as DWORD
	dwCurrEstab as DWORD
	dwInSegs as DWORD
	dwOutSegs as DWORD
	dwRetransSegs as DWORD
	dwInErrs as DWORD
	dwOutRsts as DWORD
	dwNumConns as DWORD
end type

type PMIB_TCPSTATS as MIB_TCPSTATS ptr

type MIB_TCPROW
	dwState as DWORD
	dwLocalAddr as DWORD
	dwLocalPort as DWORD
	dwRemoteAddr as DWORD
	dwRemotePort as DWORD
end type

type PMIB_TCPROW as MIB_TCPROW ptr

type MIB_TCPTABLE
	dwNumEntries as DWORD
	table(0 to 1-1) as MIB_TCPROW
end type

type PMIB_TCPTABLE as MIB_TCPTABLE ptr

type MIB_UDPSTATS
	dwInDatagrams as DWORD
	dwNoPorts as DWORD
	dwInErrors as DWORD
	dwOutDatagrams as DWORD
	dwNumAddrs as DWORD
end type

type PMIB_UDPSTATS as MIB_UDPSTATS ptr

type MIB_UDPROW
	dwLocalAddr as DWORD
	dwLocalPort as DWORD
end type

type PMIB_UDPROW as MIB_UDPROW ptr

type MIB_UDPTABLE
	dwNumEntries as DWORD
	table(0 to 1-1) as MIB_UDPROW
end type

type PMIB_UDPTABLE as MIB_UDPTABLE ptr

#endif
