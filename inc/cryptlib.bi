'*****************************************************************************
'*                                                                           *
'*                        cryptlib external API Interface                    *
'*                       Copyright Peter Gutmann 1997-2010                   *
'*                                                                           *
'*                 Ported to FreeBASIC (last update 26 March 2012)           *
'*                                                                           *
'*****************************************************************************

#ifndef _CRYPTLIB_DEFINED
#define _CRYPTLIB_DEFINED

#inclib "cl32"

' The current cryptlib version: 3.4.1

#define CRYPTLIB_VERSION   3410

' Uncomment this line to prevent the cryptlib Windows functions being included
' This line is not part of the original C headers and has been added to
' prevent windows.bi from crowding the namespace with Windows API functions
'#define cryptlibNoWindowsFunctions

/' Fixup for Windows support.  We need to include windows.h for various types
   and prototypes needed for DLL's.  In addition wincrypt.h defines some
   values with the same names as cryptlib ones, so we need to check for this
   and issue a warning not to mix cryptlib with CryptoAPI (that's like taking
   a bank vault and making one side out of papier mache).

   A second, less likely condition can occur when wincrypt.h is included
   after cryptlib.h, which shouldn't happen if developers follow the
   convention of including local headers after system headers, but can occur
   if they ignore this convention.  The NOCRYPT doesn't fix this since
   wincrypt.h can be pulled in indirectly and unconditionally, for example
   via winldap.h -> schnlsp.h -> schannel.h -> wincrypt.h.  To fix this, we
   create a redundant define for CRYPT_MODE_ECB which produces a compile
   error if wincrypt.h is included after cryptlib.h.  Since thie will
   conflict with the enum, we have to place it after the CRYPT_MODE_xxx
   enums '/

#if defined(__FB_WIN32__) and (not defined(cryptlibNoWindowsFunctions))
	#ifndef WIN32_LEAN_AND_MEAN
		#define WIN32_LEAN_AND_MEAN                 ' Skip RPC, OLE, Multimedia, etc
	#endif ' WIN32_LEAN_AND_MEAN
	#define NOCRYPT                                ' Disable include of wincrypt.h
	#include "windows.bi"

	/' Catch use of CryptoAPI and cryptlib at the same time.  wxWidgets
	   includes wincrypt.h by default so we undefine the conflicting values
	   and assume that the warning above will let users know that CryptoAPI
	   use isn't going to work properly, for anything else we require that the
	   user explicitly fix things '/
	#if defined(CRYPT_MODE_ECB)
		#print "Warning: Both cryptlib.h and wincrypt.h have been included into the same source file."
		#print "         These contain conflicting type names that prevent both from being used simultaneously."
		#ifdef __WXWINDOWS__
			#print "         To allow compilation to proceed the wincrypt.h encryption modes have been undefined."
			#undef CRYPT_MODE_ECB
			#undef CRYPT_MODE_CBC
			#undef CRYPT_MODE_CFB
			#undef CRYPT_MODE_OFB
		#else
			#print "         To allow compilation to proceed you need to avoid including wincrypt.h in your code."
			#error "cryptlib.h and wincrypt.h can't both be used at the same time due to conflicting type names"
		#endif ' __WXWINDOWS__
	#endif ' Clash with wincrypt.h defines
#endif ' Windows other than a cross-development environment
'/

'****************************************************************************
'*                                                                          *
'*                          Algorithm and Object Types                      *
'*                                                                          *
'****************************************************************************

enum CRYPT_ALGO_TYPE                              ' Algorithms

	' No encryption
	CRYPT_ALGO_NONE                                ' No encryption

	' Conventional encryption
	CRYPT_ALGO_DES                                 ' DES
	CRYPT_ALGO_3DES                                ' Triple DES
	CRYPT_ALGO_IDEA                                ' IDEA (only used for PGP 2.x)
	CRYPT_ALGO_RESERVED1                           ' Formerly CAST-128
	CRYPT_ALGO_RC2                                 ' RC2 (disabled by default)
	CRYPT_ALGO_RC4                                 ' RC4
	CRYPT_ALGO_RC5                                 ' RC5
	CRYPT_ALGO_AES                                 ' AES
	CRYPT_ALGO_BLOWFISH                            ' Blowfish
	CRYPT_ALGO_RESERVED2                           ' Formerly Skipjack

	' Public-key encryption
	CRYPT_ALGO_DH = 100                            ' Diffie-Hellman
	CRYPT_ALGO_RSA                                 ' RSA
	CRYPT_ALGO_DSA                                 ' DSA
	CRYPT_ALGO_ELGAMAL                             ' ElGamal
	CRYPT_ALGO_RESERVED3                           ' Formerly KEA
	CRYPT_ALGO_ECDSA                               ' ECDSA
	CRYPT_ALGO_ECDH                                ' ECDH

	' Hash algorithms
	CRYPT_ALGO_RESERVED4 = 200                     ' Formerly MD2
	CRYPT_ALGO_RESERVED5                           ' Formerly MD4
	CRYPT_ALGO_MD5                                 ' MD5
	CRYPT_ALGO_SHA1                                ' SHA/SHA1
	CRYPT_ALGO_SHA = CRYPT_ALGO_SHA1               ' Older form
	CRYPT_ALGO_RIPEMD160                           ' RIPE-MD 160
	CRYPT_ALGO_SHA2                                ' SHA-256
	CRYPT_ALGO_SHA256 = CRYPT_ALGO_SHA2            ' Alternate name
	CRYPT_ALGO_SHAng                               ' Future SHA-nextgen standard

	' MAC's
	CRYPT_ALGO_HMAC_MD5 = 300                      ' HMAC-MD5
	CRYPT_ALGO_HMAC_SHA1                           ' HMAC-SHA
	CRYPT_ALGO_HMAC_SHA_ = CRYPT_ALGO_HMAC_SHA1    ' Older form
	CRYPT_ALGO_HMAC_RIPEMD160                      ' HMAC-RIPEMD-160
	CRYPT_ALGO_HMAC_SHA2                           ' HMAC-SHA2
	CRYPT_ALGO_HMAC_SHAng                          ' HMAC-future-SHA-nextgen

	CRYPT_ALGO_LAST                                ' Last possible crypt algo value

	/' In order that we can scan through a range of algorithms with
	   cryptQueryCapability(), we define the following boundary points for
	   each algorithm class '/
	CRYPT_ALGO_FIRST_CONVENTIONAL = 1
	CRYPT_ALGO_LAST_CONVENTIONAL = 99
	CRYPT_ALGO_FIRST_PKC = 100
	CRYPT_ALGO_LAST_PKC = 199
	CRYPT_ALGO_FIRST_HASH = 200
	CRYPT_ALGO_LAST_HASH = 299
	CRYPT_ALGO_FIRST_MAC = 300
	CRYPT_ALGO_LAST_MAC = 399
end enum

enum CRYPT_MODE_TYPE                              ' Block cipher modes
	CRYPT_MODE_NONE                                ' No encryption mode
	CRYPT_MODE_ECB                                 ' ECB
	CRYPT_MODE_CBC                                 ' CBC
	CRYPT_MODE_CFB                                 ' CFB
	CRYPT_MODE_OFB                                 ' OFB
	CRYPT_MODE_GCM                                 ' GCM
	CRYPT_MODE_LAST                                ' Last possible crypt mode value
end enum

' Keyset subtypes

enum CRYPT_KEYSET_TYPE                            ' Keyset types
	CRYPT_KEYSET_NONE                              ' No keyset type
	CRYPT_KEYSET_FILE                              ' Generic flat file keyset
	CRYPT_KEYSET_HTTP                              ' Web page containing cert/CRL
	CRYPT_KEYSET_LDAP                              ' LDAP directory service
	CRYPT_KEYSET_ODBC                              ' Generic ODBC interface
	CRYPT_KEYSET_DATABASE                          ' Generic RDBMS interface
	CRYPT_KEYSET_ODBC_STORE                        ' ODBC certificate store
	CRYPT_KEYSET_DATABASE_STORE                    ' Database certificate store
	CRYPT_KEYSET_LAST                              ' Last possible keyset type
end enum

' Device subtypes

enum CRYPT_DEVICE_TYPE                            ' Crypto device types
	CRYPT_DEVICE_NONE                              ' No crypto device
	CRYPT_DEVICE_FORTEZZA                          ' Fortezza card - Placeholder only
	CRYPT_DEVICE_PKCS11                            ' PKCS #11 crypto token
	CRYPT_DEVICE_CRYPTOAPI                         ' Microsoft CryptoAPI
	CRYPT_DEVICE_HARDWARE                          ' Generic crypo HW plugin
	CRYPT_DEVICE_LAST                              ' Last possible crypto device type
end enum

' Certificate subtypes

enum CRYPT_CERTTYPE_TYPE                          ' Certificate object types
	CRYPT_CERTTYPE_NONE                            ' No certificate type
	CRYPT_CERTTYPE_CERTIFICATE                     ' Certificate
	CRYPT_CERTTYPE_ATTRIBUTE_CERT                  ' Attribute certificate
	CRYPT_CERTTYPE_CERTCHAIN                       ' PKCS #7 certificate chain
	CRYPT_CERTTYPE_CERTREQUEST                     ' PKCS #10 certification request
	CRYPT_CERTTYPE_REQUEST_CERT                    ' CRMF certification request
	CRYPT_CERTTYPE_REQUEST_REVOCATION              ' CRMF revocation request
	CRYPT_CERTTYPE_CRL                             ' CRL
	CRYPT_CERTTYPE_CMS_ATTRIBUTES                  ' CMS attributes
	CRYPT_CERTTYPE_RTCS_REQUEST                    ' RTCS request
	CRYPT_CERTTYPE_RTCS_RESPONSE                   ' RTCS response
	CRYPT_CERTTYPE_OCSP_REQUEST                    ' OCSP request
	CRYPT_CERTTYPE_OCSP_RESPONSE                   ' OCSP response
	CRYPT_CERTTYPE_PKIUSER                         ' PKI user information
	CRYPT_CERTTYPE_LAST                            ' Last possible cert.type
end enum

' Envelope/data format subtypes

enum CRYPT_FORMAT_TYPE
	CRYPT_FORMAT_NONE                              ' No format type
	CRYPT_FORMAT_AUTO                              ' Deenv, auto-determine type
	CRYPT_FORMAT_CRYPTLIB                          ' cryptlib native format
	CRYPT_FORMAT_CMS                               ' PKCS #7 / CMS / S/MIME fmt.
	CRYPT_FORMAT_PKCS7 = CRYPT_FORMAT_CMS
	CRYPT_FORMAT_SMIME                             ' as CMS with MSG-style behaviour
	CRYPT_FORMAT_PGP                               ' PGP format
	CRYPT_FORMAT_LAST                              ' Last possible format type
end enum

' Session subtypes

enum CRYPT_SESSION_TYPE
	CRYPT_SESSION_NONE                             ' No session type
	CRYPT_SESSION_SSH                              ' SSH
	CRYPT_SESSION_SSH_SERVER                       ' SSH server
	CRYPT_SESSION_SSL                              ' SSL/TLS
	CRYPT_SESSION_SSL_SERVER                       ' SSL/TLS server
	CRYPT_SESSION_RTCS                             ' RTCS
	CRYPT_SESSION_RTCS_SERVER                      ' RTCS server
	CRYPT_SESSION_OCSP                             ' OCSP
	CRYPT_SESSION_OCSP_SERVER                      ' OCSP server
	CRYPT_SESSION_TSP                              ' TSP
	CRYPT_SESSION_TSP_SERVER                       ' TSP server
	CRYPT_SESSION_CMP                              ' CMP
	CRYPT_SESSION_CMP_SERVER                       ' CMP server
	CRYPT_SESSION_SCEP                             ' SCEP
	CRYPT_SESSION_SCEP_SERVER                      ' SCEP server
	CRYPT_SESSION_CERTSTORE_SERVER                 ' HTTP cert store interface
	CRYPT_SESSION_LAST                             ' Last possible session type
end enum

' User subtypes

enum CRYPT_USER_TYPE
	CRYPT_USER_NONE                                ' No user type
	CRYPT_USER_NORMAL                              ' Normal user
	CRYPT_USER_SO                                  ' Security officer
	CRYPT_USER_CA                                  ' CA user
	CRYPT_USER_LAST                                ' Last possible user type
end enum


'****************************************************************************
'*                                                                          *
'*                              Attribute Types                             *
'*                                                                          *
'****************************************************************************

/' Attribute types.  These are arranged in the following order:

   PROPERTY  - Object property
   ATTRIBUTE - Generic attributes
   OPTION    - Global or object-specific config.option
   CTXINFO   - Context-specific attribute
   CERTINFO  - Certificate-specific attribute
   KEYINFO   - Keyset-specific attribute
   DEVINFO   - Device-specific attribute
   ENVINFO   - Envelope-specific attribute
   SESSINFO  - Session-specific attribute
   USERINFO  - User-specific attribute '/

enum CRYPT_ATTRIBUTE_TYPE
	CRYPT_ATTRIBUTE_NONE                           ' Non-value

	' Used internally
	CRYPT_PROPERTY_FIRST

	'*********************
	'* Object attributes *
	'*********************

	' Object properties
	CRYPT_PROPERTY_HIGHSECURITY                    ' Owned+non-forwardcount+locked
	CRYPT_PROPERTY_OWNER                           ' Object owner
	CRYPT_PROPERTY_FORWARDCOUNT                    ' No.of times object can be forwarded
	CRYPT_PROPERTY_LOCKED                          ' Whether properties can be chged/read
	CRYPT_PROPERTY_USAGECOUNT                      ' Usage count before object expires
	CRYPT_PROPERTY_NONEXPORTABLE                   ' Whether key is nonexp.from context

	' Used internally
	CRYPT_PROPERTY_LAST
	CRYPT_GENERIC_FIRST

	' Extended error information
	CRYPT_ATTRIBUTE_ERRORTYPE                      ' type of last error
	CRYPT_ATTRIBUTE_ERRORLOCUS                     ' Locus of last error
	CRYPT_ATTRIBUTE_ERRORMESSAGE                   ' Detailed error description

	' Generic information
	CRYPT_ATTRIBUTE_CURRENT_GROUP                  ' Cursor mgt: Group in attribute list
	CRYPT_ATTRIBUTE_CURRENT                        ' Cursor mgt: Entry in attribute list
	CRYPT_ATTRIBUTE_CURRENT_INSTANCE               ' Cursor mgt: Instance in attribute list
	CRYPT_ATTRIBUTE_BUFFERSIZE                     ' Internal data buffer size

	' User internally
	CRYPT_GENERIC_LAST
	CRYPT_OPTION_FIRST = 100

	'****************************
	'* Configuration attributes *
	'****************************

	' cryptlib information (read-only)
	CRYPT_OPTION_INFO_DESCRIPTION                  ' Text description
	CRYPT_OPTION_INFO_COPYRIGHT                    ' Copyright notice
	CRYPT_OPTION_INFO_MAJORVERSION                 ' Major release version
	CRYPT_OPTION_INFO_MINORVERSION                 ' Minor release version
	CRYPT_OPTION_INFO_STEPPING                     ' Release stepping

	' Encryption options
	CRYPT_OPTION_ENCR_ALGO                         ' Encryption algorithm
	CRYPT_OPTION_ENCR_HASH                         ' Hash algorithm
	CRYPT_OPTION_ENCR_MAC                          ' MAC algorithm

	' PKC options
	CRYPT_OPTION_PKC_ALGO                          ' Public-key encryption algorithm
	CRYPT_OPTION_PKC_KEYSIZE                       ' Public-key encryption key size

	' Signature options
	CRYPT_OPTION_SIG_ALGO                          ' Signature algorithm
	CRYPT_OPTION_SIG_KEYSIZE                       ' Signature keysize

	' Keying options
	CRYPT_OPTION_KEYING_ALGO                       ' Key processing algorithm
	CRYPT_OPTION_KEYING_ITERATIONS                 ' Key processing iterations

	' Certificate options
	CRYPT_OPTION_CERT_SIGNUNRECOGNISEDATTRIBUTES   ' Whether to sign unrecog.attrs
	CRYPT_OPTION_CERT_VALIDITY                     ' Certificate validity period
	CRYPT_OPTION_CERT_UPDATEINTERVAL               ' CRL update interval
	CRYPT_OPTION_CERT_COMPLIANCELEVEL              ' PKIX compliance level for cert chks.
	CRYPT_OPTION_CERT_REQUIREPOLICY                ' Whether explicit policy req'd for certs

	' CMS/SMIME options
	CRYPT_OPTION_CMS_DEFAULTATTRIBUTES             ' Add default CMS attributes
	CRYPT_OPTION_SMIME_DEFAULTATTRIBUTES = CRYPT_OPTION_CMS_DEFAULTATTRIBUTES

	' LDAP keyset options
	CRYPT_OPTION_KEYS_LDAP_OBJECTCLASS             ' Object class
	CRYPT_OPTION_KEYS_LDAP_OBJECTTYPE              ' Object type to fetch
	CRYPT_OPTION_KEYS_LDAP_FILTER                  ' Query filter
	CRYPT_OPTION_KEYS_LDAP_CACERTNAME              ' CA certificate attribute name
	CRYPT_OPTION_KEYS_LDAP_CERTNAME                ' Certificate attribute name
	CRYPT_OPTION_KEYS_LDAP_CRLNAME                 ' CRL attribute name
	CRYPT_OPTION_KEYS_LDAP_EMAILNAME               ' Email attribute name

	' Crypto device options
	CRYPT_OPTION_DEVICE_PKCS11_DVR01               ' Name of first PKCS #11 driver
	CRYPT_OPTION_DEVICE_PKCS11_DVR02               ' Name of second PKCS #11 driver
	CRYPT_OPTION_DEVICE_PKCS11_DVR03               ' Name of third PKCS #11 driver
	CRYPT_OPTION_DEVICE_PKCS11_DVR04               ' Name of fourth PKCS #11 driver
	CRYPT_OPTION_DEVICE_PKCS11_DVR05               ' Name of fifth PKCS #11 driver
	CRYPT_OPTION_DEVICE_PKCS11_HARDWAREONLY        ' Use only hardware mechanisms

	' Network access options
	CRYPT_OPTION_NET_SOCKS_SERVER                  ' Socks server name
	CRYPT_OPTION_NET_SOCKS_USERNAME                ' Socks user name
	CRYPT_OPTION_NET_HTTP_PROXY                    ' Web proxy server
	CRYPT_OPTION_NET_CONNECTTIMEOUT                ' Timeout for network connection setup
	CRYPT_OPTION_NET_READTIMEOUT                   ' Timeout for network reads
	CRYPT_OPTION_NET_WRITETIMEOUT                  ' Timeout for network writes

	' Miscellaneous options
	CRYPT_OPTION_MISC_ASYNCINIT                    ' Whether to init cryptlib async'ly
	CRYPT_OPTION_MISC_SIDECHANNELPROTECTION        ' Protect against side-channel attacks

	' cryptlib state information
	CRYPT_OPTION_CONFIGCHANGED                     ' Whether in-mem.opts match on-disk ones
	CRYPT_OPTION_SELFTESTOK                        ' Whether self-test was completed and OK

	' Used internally
	CRYPT_OPTION_LAST
	CRYPT_CTXINFO_FIRST = 1000

	'**********************
	'* Context attributes *
	'**********************

	' Algorithm and mode information
	CRYPT_CTXINFO_ALGO                             ' Algorithm
	CRYPT_CTXINFO_MODE                             ' Mode
	CRYPT_CTXINFO_NAME_ALGO                        ' Algorithm name
	CRYPT_CTXINFO_NAME_MODE                        ' Mode name
	CRYPT_CTXINFO_KEYSIZE                          ' Key size in bytes
	CRYPT_CTXINFO_BLOCKSIZE                        ' Block size
	CRYPT_CTXINFO_IVSIZE                           ' IV size
	CRYPT_CTXINFO_KEYING_ALGO                      ' Key processing algorithm
	CRYPT_CTXINFO_KEYING_ITERATIONS                ' Key processing iterations
	CRYPT_CTXINFO_KEYING_SALT                      ' Key processing salt
	CRYPT_CTXINFO_KEYING_VALUE                     ' Value used to derive key

	' State information
	CRYPT_CTXINFO_KEY                              ' Key
	CRYPT_CTXINFO_KEY_COMPONENTS                   ' Public-key components
	CRYPT_CTXINFO_IV                               ' IV
	CRYPT_CTXINFO_HASHVALUE                        ' Hash value

	' Misc.information
	CRYPT_CTXINFO_LABEL                            ' Label for private/secret key
	CRYPT_CTXINFO_PERSISTENT                       ' Obj.is backed by device or keyset

	' Used internally
	CRYPT_CTXINFO_LAST
	CRYPT_CERTINFO_FIRST = 2000

	'**************************
	'* Certificate attributes *
	'**************************

	/' Because there are so many cert attributes, we break them down into
	   blocks to minimise the number of values that change if a new one is
	   added halfway through '/

	/' Pseudo-information on a cert object or meta-information which is used
	   to control the way that a cert object is processed '/
	CRYPT_CERTINFO_SELFSIGNED                      ' Cert is self-signed
	CRYPT_CERTINFO_IMMUTABLE                       ' Cert is signed and immutable
	CRYPT_CERTINFO_XYZZY                           ' Cert is a magic just-works cert
	CRYPT_CERTINFO_CERTTYPE                        ' Certificate object type
	CRYPT_CERTINFO_FINGERPRINT                     ' Certificate fingerprints
	CRYPT_CERTINFO_FINGERPRINT_MD5 = CRYPT_CERTINFO_FINGERPRINT
	CRYPT_CERTINFO_FINGERPRINT_SHA1
	CRYPT_CERTINFO_FINGERPRINT_SHA = CRYPT_CERTINFO_FINGERPRINT_SHA1
	CRYPT_CERTINFO_FINGERPRINT_SHA2
	CRYPT_CERTINFO_FINGERPRINT_SHAng
	CRYPT_CERTINFO_CURRENT_CERTIFICATE             ' Cursor mgt: Rel.pos in chain/CRL/OCSP
	CRYPT_CERTINFO_TRUSTED_USAGE                   ' Usage that cert is trusted for
	CRYPT_CERTINFO_TRUSTED_IMPLICIT                ' Whether cert is implicitly trusted
	CRYPT_CERTINFO_SIGNATURELEVEL                  ' Amount of detail to include in sigs.

	' General certificate object information
	CRYPT_CERTINFO_VERSION                         ' Cert.format version
	CRYPT_CERTINFO_SERIALNUMBER                    ' Serial number
	CRYPT_CERTINFO_SUBJECTPUBLICKEYINFO            ' Public key
	CRYPT_CERTINFO_CERTIFICATE                     ' User certificate
	CRYPT_CERTINFO_USERCERTIFICATE = CRYPT_CERTINFO_CERTIFICATE
	CRYPT_CERTINFO_CACERTIFICATE                   ' CA certificate
	CRYPT_CERTINFO_ISSUERNAME                      ' Issuer DN
	CRYPT_CERTINFO_VALIDFROM                       ' Cert valid-from time
	CRYPT_CERTINFO_VALIDTO                         ' Cert valid-to time
	CRYPT_CERTINFO_SUBJECTNAME                     ' Subject DN
	CRYPT_CERTINFO_ISSUERUNIQUEID                  ' Issuer unique ID
	CRYPT_CERTINFO_SUBJECTUNIQUEID                 ' Subject unique ID
	CRYPT_CERTINFO_CERTREQUEST                     ' Cert.request (DN + public key)
	CRYPT_CERTINFO_THISUPDATE                      ' CRL/OCSP current-update time
	CRYPT_CERTINFO_NEXTUPDATE                      ' CRL/OCSP next-update time
	CRYPT_CERTINFO_REVOCATIONDATE                  ' CRL/OCSP cert-revocation time
	CRYPT_CERTINFO_REVOCATIONSTATUS' OCSP revocation status
	CRYPT_CERTINFO_CERTSTATUS                      ' RTCS certificate status
	CRYPT_CERTINFO_DN                              ' Currently selected DN in string form
	CRYPT_CERTINFO_PKIUSER_ID                      ' PKI user ID
	CRYPT_CERTINFO_PKIUSER_ISSUEPASSWORD           ' PKI user issue password
	CRYPT_CERTINFO_PKIUSER_REVPASSWORD             ' PKI user revocation password

	/' X.520 Distinguished Name components.  This is a composite field, the
	   DN to be manipulated is selected through the addition of a
	   pseudocomponent, and then one of the following is used to access the
	   DN components directly '/
	CRYPT_CERTINFO_COUNTRYNAME = CRYPT_CERTINFO_FIRST + 100 ' countryName
	CRYPT_CERTINFO_STATEORPROVINCENAME             ' stateOrProvinceName
	CRYPT_CERTINFO_LOCALITYNAME                    ' localityName
	CRYPT_CERTINFO_ORGANIZATIONNAME                ' organizationName
	CRYPT_CERTINFO_ORGANISATIONNAME = CRYPT_CERTINFO_ORGANIZATIONNAME
	CRYPT_CERTINFO_ORGANIZATIONALUNITNAME          ' organizationalUnitName
	CRYPT_CERTINFO_ORGANISATIONALUNITNAME = CRYPT_CERTINFO_ORGANIZATIONALUNITNAME
	CRYPT_CERTINFO_COMMONNAME                      ' commonName

	/' X.509 General Name components.  These are handled in the same way as
	   the DN composite field, with the current GeneralName being selected by
	   a pseudo-component after which the individual components can be
	   modified through one of the following '/
	CRYPT_CERTINFO_OTHERNAME_TYPEID                ' otherName.typeID
	CRYPT_CERTINFO_OTHERNAME_VALUE                 ' otherName.value
	CRYPT_CERTINFO_RFC822NAME                      ' rfc822Name
	CRYPT_CERTINFO_EMAIL = CRYPT_CERTINFO_RFC822NAME
	CRYPT_CERTINFO_DNSNAME                         ' dNSName
	CRYPT_CERTINFO_DIRECTORYNAME                   ' directoryName
	CRYPT_CERTINFO_EDIPARTYNAME_NAMEASSIGNER       ' ediPartyName.nameassigner
	CRYPT_CERTINFO_EDIPARTYNAME_PARTYNAME          ' ediPartyName.partyName
	CRYPT_CERTINFO_UNIFORMRESOURCEIDENTIFIER       ' uniformResourceIdentifier
	CRYPT_CERTINFO_IPADDRESS                       ' iPAddress
	CRYPT_CERTINFO_REGISTEREDID                    ' registeredID

	/' X.509 certificate extensions.  Although it would be nicer to use names
	   that match the extensions more closely (e.g.
	   CRYPT_CERTINFO_BASICCONSTRAINTS_PATHLENCONSTRAINT), these exceed the
	   32-character ANSI minimum length for unique names, and get really
	   hairy once you get into the weird policy constraints extensions whose
	   names wrap around the screen about three times.

	   The following values are defined in OID order, this isn't absolutely
	   necessary but saves an extra layer of processing when encoding them '/

	/' 1 2 840 113549 1 9 7 challengePassword.  This is here even though it's
	   a CMS attribute because SCEP stuffs it into PKCS #10 requests '/
	   CRYPT_CERTINFO_CHALLENGEPASSWORD = CRYPT_CERTINFO_FIRST + 200

	' 1 3 6 1 4 1 3029 3 1 4 cRLExtReason
	CRYPT_CERTINFO_CRLEXTREASON

	' 1 3 6 1 4 1 3029 3 1 5 keyFeatures
	CRYPT_CERTINFO_KEYFEATURES

	' 1 3 6 1 5 5 7 1 1 authorityInfoAccess
	CRYPT_CERTINFO_AUTHORITYINFOACCESS
	CRYPT_CERTINFO_AUTHORITYINFO_RTCS              ' accessDescription.accessLocation
	CRYPT_CERTINFO_AUTHORITYINFO_OCSP              ' accessDescription.accessLocation
	CRYPT_CERTINFO_AUTHORITYINFO_CAISSUERS         ' accessDescription.accessLocation
	CRYPT_CERTINFO_AUTHORITYINFO_CERTSTORE         ' accessDescription.accessLocation
	CRYPT_CERTINFO_AUTHORITYINFO_CRLS              ' accessDescription.accessLocation

	' 1 3 6 1 5 5 7 1 2 biometricInfo
	CRYPT_CERTINFO_BIOMETRICINFO
	CRYPT_CERTINFO_BIOMETRICINFO_TYPE              ' biometricData.typeOfData
	CRYPT_CERTINFO_BIOMETRICINFO_HASHALGO          ' biometricData.hashAlgorithm
	CRYPT_CERTINFO_BIOMETRICINFO_HASH              ' biometricData.dataHash
	CRYPT_CERTINFO_BIOMETRICINFO_URL               ' biometricData.sourceDataUri

	' 1 3 6 1 5 5 7 1 3 qcStatements
	CRYPT_CERTINFO_QCSTATEMENT
	CRYPT_CERTINFO_QCSTATEMENT_SEMANTICS
		' qcStatement.statementInfo.semanticsIdentifier
	CRYPT_CERTINFO_QCSTATEMENT_REGISTRATIONAUTHORITY
		' qcStatement.statementInfo.nameRegistrationAuthorities

	' 1 3 6 1 5 5 7 1 7 ipAddrBlocks
	CRYPT_CERTINFO_IPADDRESSBLOCKS
	CRYPT_CERTINFO_IPADDRESSBLOCKS_ADDRESSFAMILY   ' addressFamily
	'' CRYPT_CERTINFO_IPADDRESSBLOCKS_INHERIT         ' ipAddress.inherit
	CRYPT_CERTINFO_IPADDRESSBLOCKS_PREFIX          ' ipAddress.addressPrefix
	CRYPT_CERTINFO_IPADDRESSBLOCKS_MIN             ' ipAddress.addressRangeMin
	CRYPT_CERTINFO_IPADDRESSBLOCKS_MAX             ' ipAddress.addressRangeMax

	' 1 3 6 1 5 5 7 1 8 autonomousSysIds
	CRYPT_CERTINFO_AUTONOMOUSSYSIDS
	'' CRYPT_CERTINFO_AUTONOMOUSSYSIDS_ASNUM_INHERIT  ' asNum.inherit
	CRYPT_CERTINFO_AUTONOMOUSSYSIDS_ASNUM_ID       ' asNum.id
	CRYPT_CERTINFO_AUTONOMOUSSYSIDS_ASNUM_MIN      ' asNum.min
	CRYPT_CERTINFO_AUTONOMOUSSYSIDS_ASNUM_MAX      ' asNum.max

	' 1 3 6 1 5 5 7 48 1 2 ocspNonce
	CRYPT_CERTINFO_OCSP_NONCE                      ' nonce

	' 1 3 6 1 5 5 7 48 1 4 ocspAcceptableResponses
	CRYPT_CERTINFO_OCSP_RESPONSE
	CRYPT_CERTINFO_OCSP_RESPONSE_OCSP              ' OCSP standard response

	' 1 3 6 1 5 5 7 48 1 5 ocspNoCheck
	CRYPT_CERTINFO_OCSP_NOCHECK

	' 1 3 6 1 5 5 7 48 1 6 ocspArchiveCutoff
	CRYPT_CERTINFO_OCSP_ARCHIVECUTOFF

	' 1 3 6 1 5 5 7 48 1 11 subjectInfoAccess
	CRYPT_CERTINFO_SUBJECTINFOACCESS
	CRYPT_CERTINFO_SUBJECTINFO_TIMESTAMPING        ' accessDescription.accessLocation
	CRYPT_CERTINFO_SUBJECTINFO_CAREPOSITORY        ' accessDescription.accessLocation
	CRYPT_CERTINFO_SUBJECTINFO_SIGNEDOBJECTREPOSITORY ' accessDescription.accessLocation
	CRYPT_CERTINFO_SUBJECTINFO_RPKIMANIFEST        ' accessDescription.accessLocation
	CRYPT_CERTINFO_SUBJECTINFO_SIGNEDOBJECT        ' accessDescription.accessLocation

	' 1 3 36 8 3 1 siggDateOfCertGen
	CRYPT_CERTINFO_SIGG_DATEOFCERTGEN

	' 1 3 36 8 3 2 siggProcuration
	CRYPT_CERTINFO_SIGG_PROCURATION
	CRYPT_CERTINFO_SIGG_PROCURE_COUNTRY            ' country
	CRYPT_CERTINFO_SIGG_PROCURE_TYPEOFSUBSTITUTION ' typeOfSubstitution
	CRYPT_CERTINFO_SIGG_PROCURE_SIGNINGFOR         ' signingFor.thirdPerson

	' 1 3 36 8 3 3 siggAdmissions
	CRYPT_CERTINFO_SIGG_ADMISSIONS
	CRYPT_CERTINFO_SIGG_ADMISSIONS_AUTHORITY       ' authority
	CRYPT_CERTINFO_SIGG_ADMISSIONS_NAMINGAUTHID    ' namingAuth.iD
	CRYPT_CERTINFO_SIGG_ADMISSIONS_NAMINGAUTHURL   ' namingAuth.uRL
	CRYPT_CERTINFO_SIGG_ADMISSIONS_NAMINGAUTHTEXT  ' namingAuth.text
	CRYPT_CERTINFO_SIGG_ADMISSIONS_PROFESSIONITEM  ' professionItem
	CRYPT_CERTINFO_SIGG_ADMISSIONS_PROFESSIONOID   ' professionOID
	CRYPT_CERTINFO_SIGG_ADMISSIONS_REGISTRATIONNUMBER ' registrationNumber

	' 1 3 36 8 3 4 siggMonetaryLimit
	CRYPT_CERTINFO_SIGG_MONETARYLIMIT
	CRYPT_CERTINFO_SIGG_MONETARY_CURRENCY          ' currency
	CRYPT_CERTINFO_SIGG_MONETARY_AMOUNT            ' amount
	CRYPT_CERTINFO_SIGG_MONETARY_EXPONENT          ' exponent

	' 1 3 36 8 3 5 siggDeclarationOfMajority
	CRYPT_CERTINFO_SIGG_DECLARATIONOFMAJORITY
	CRYPT_CERTINFO_SIGG_DECLARATIONOFMAJORITY_COUNTRY ' fullAgeAtCountry

	' 1 3 36 8 3 8 siggRestriction
	CRYPT_CERTINFO_SIGG_RESTRICTION

	' 1 3 36 8 3 13 siggCertHash
	CRYPT_CERTINFO_SIGG_CERTHASH

	' 1 3 36 8 3 15 siggAdditionalInformation
	CRYPT_CERTINFO_SIGG_ADDITIONALINFORMATION

	' 1 3 101 1 4 1 strongExtranet
	CRYPT_CERTINFO_STRONGEXTRANET
	CRYPT_CERTINFO_STRONGEXTRANET_ZONE             ' sxNetIDList.sxNetID.zone
	CRYPT_CERTINFO_STRONGEXTRANET_ID               ' sxNetIDList.sxNetID.id

	' 2 5 29 9 subjectDirectoryAttributes
	CRYPT_CERTINFO_SUBJECTDIRECTORYATTRIBUTES
	CRYPT_CERTINFO_SUBJECTDIR_TYPE                 ' attribute.type
	CRYPT_CERTINFO_SUBJECTDIR_VALUES               ' attribute.values

	' 2 5 29 14 subjectKeyIdentifier
	CRYPT_CERTINFO_SUBJECTKEYIDENTIFIER

	' 2 5 29 15 keyUsage
	CRYPT_CERTINFO_KEYUSAGE

	' 2 5 29 16 privateKeyUsagePeriod
	CRYPT_CERTINFO_PRIVATEKEYUSAGEPERIOD
	CRYPT_CERTINFO_PRIVATEKEY_NOTBEFORE            ' notBefore
	CRYPT_CERTINFO_PRIVATEKEY_NOTAFTER             ' notAfter

	' 2 5 29 17 subjectAltName
	CRYPT_CERTINFO_SUBJECTALTNAME

	' 2 5 29 18 issuerAltName
	CRYPT_CERTINFO_ISSUERALTNAME

	' 2 5 29 19 basicConstraints
	CRYPT_CERTINFO_BASICCONSTRAINTS
	CRYPT_CERTINFO_CA                              ' cA
	CRYPT_CERTINFO_AUTHORITY = CRYPT_CERTINFO_CA
	CRYPT_CERTINFO_PATHLENCONSTRAINT               ' pathLenConstraint

	' 2 5 29 20 cRLNumber
	CRYPT_CERTINFO_CRLNUMBER

	' 2 5 29 21 cRLReason
	CRYPT_CERTINFO_CRLREASON

	' 2 5 29 23 holdInstructionCode
	CRYPT_CERTINFO_HOLDINSTRUCTIONCODE

	' 2 5 29 24 invalidityDate
	CRYPT_CERTINFO_INVALIDITYDATE

	' 2 5 29 27 deltaCRLIndicator
	CRYPT_CERTINFO_DELTACRLINDICATOR

	' 2 5 29 28 issuingDistributionPoint
	CRYPT_CERTINFO_ISSUINGDISTRIBUTIONPOINT
	CRYPT_CERTINFO_ISSUINGDIST_FULLNAME            ' distributionPointName.fullName
	CRYPT_CERTINFO_ISSUINGDIST_USERCERTSONLY       ' onlyContainsUserCerts
	CRYPT_CERTINFO_ISSUINGDIST_CACERTSONLY         ' onlyContainsCACerts
	CRYPT_CERTINFO_ISSUINGDIST_SOMEREASONSONLY     ' onlySomeReasons
	CRYPT_CERTINFO_ISSUINGDIST_INDIRECTCRL         ' indirectCRL

	' 2 5 29 29 certificateIssuer
	CRYPT_CERTINFO_CERTIFICATEISSUER

	' 2 5 29 30 nameConstraints
	CRYPT_CERTINFO_NAMECONSTRAINTS
	CRYPT_CERTINFO_PERMITTEDSUBTREES               ' permittedSubtrees
	CRYPT_CERTINFO_EXCLUDEDSUBTREES                ' excludedSubtrees

	' 2 5 29 31 cRLDistributionPoint
	CRYPT_CERTINFO_CRLDISTRIBUTIONPOINT
	CRYPT_CERTINFO_CRLDIST_FULLNAME                ' distributionPointName.fullName
	CRYPT_CERTINFO_CRLDIST_REASONS                 ' reasons
	CRYPT_CERTINFO_CRLDIST_CRLISSUER               ' cRLIssuer

	' 2 5 29 32 certificatePolicies
	CRYPT_CERTINFO_CERTIFICATEPOLICIES
	CRYPT_CERTINFO_CERTPOLICYID                    ' policyInformation.policyIdentifier
	CRYPT_CERTINFO_CERTPOLICY_CPSURI
	' policyInformation.policyQualifiers.qualifier.cPSuri
	CRYPT_CERTINFO_CERTPOLICY_ORGANIZATION
	' policyInformation.policyQualifiers.qualifier.usernotice.noticeRef.organization
	CRYPT_CERTINFO_CERTPOLICY_NOTICENUMBERS
	' policyInformation.policyQualifiers.qualifier.usernotice.noticeRef.noticeNumbers
	CRYPT_CERTINFO_CERTPOLICY_EXPLICITTEXT
	' policyInformation.policyQualifiers.qualifier.usernotice.explicitText

	' 2 5 29 33 policyMappings
	CRYPT_CERTINFO_POLICYMAPPINGS
	CRYPT_CERTINFO_ISSUERDOMAINPOLICY              ' policyMappings.issuerDomainPolicy
	CRYPT_CERTINFO_SUBJECTDOMAINPOLICY             ' policyMappings.subjectDomainPolicy

	' 2 5 29 35 authorityKeyIdentifier
	CRYPT_CERTINFO_AUTHORITYKEYIDENTIFIER
	CRYPT_CERTINFO_AUTHORITY_KEYIDENTIFIER         ' keyIdentifier
	CRYPT_CERTINFO_AUTHORITY_CERTISSUER            ' authorityCertIssuer
	CRYPT_CERTINFO_AUTHORITY_CERTSERIALNUMBER      ' authorityCertSerialNumber

	' 2 5 29 36 policyConstraints
	CRYPT_CERTINFO_POLICYCONSTRAINTS
	CRYPT_CERTINFO_REQUIREEXPLICITPOLICY           ' policyConstraints.requireExplicitPolicy
	CRYPT_CERTINFO_INHIBITPOLICYMAPPING            ' policyConstraints.inhibitPolicyMapping

	' 2 5 29 37 extKeyUsage
	CRYPT_CERTINFO_EXTKEYUSAGE
	CRYPT_CERTINFO_EXTKEY_MS_INDIVIDUALCODESIGNING ' individualCodeSigning
	CRYPT_CERTINFO_EXTKEY_MS_COMMERCIALCODESIGNING ' commercialCodeSigning
	CRYPT_CERTINFO_EXTKEY_MS_CERTTRUSTLISTSIGNING  ' certTrustListSigning
	CRYPT_CERTINFO_EXTKEY_MS_TIMESTAMPSIGNING      ' timeStampSigning
	CRYPT_CERTINFO_EXTKEY_MS_SERVERGATEDCRYPTO     ' serverGatedCrypto
	CRYPT_CERTINFO_EXTKEY_MS_ENCRYPTEDFILESYSTEM   ' encrypedFileSystem
	CRYPT_CERTINFO_EXTKEY_SERVERAUTH               ' serverAuth
	CRYPT_CERTINFO_EXTKEY_CLIENTAUTH               ' clientAuth
	CRYPT_CERTINFO_EXTKEY_CODESIGNING              ' codeSigning
	CRYPT_CERTINFO_EXTKEY_EMAILPROTECTION          ' emailProtection
	CRYPT_CERTINFO_EXTKEY_IPSECENDSYSTEM           ' ipsecendSystem
	CRYPT_CERTINFO_EXTKEY_IPSECTUNNEL              ' ipsecTunnel
	CRYPT_CERTINFO_EXTKEY_IPSECUSER                ' ipsecUser
	CRYPT_CERTINFO_EXTKEY_TIMESTAMPING             ' timeStamping
	CRYPT_CERTINFO_EXTKEY_OCSPSIGNING              ' ocspSigning
	CRYPT_CERTINFO_EXTKEY_DIRECTORYSERVICE         ' directoryService
	CRYPT_CERTINFO_EXTKEY_ANYKEYUSAGE              ' anyExtendedKeyUsage
	CRYPT_CERTINFO_EXTKEY_NS_SERVERGATEDCRYPTO     ' serverGatedCrypto
	CRYPT_CERTINFO_EXTKEY_VS_SERVERGATEDCRYPTO_CA  ' serverGatedCrypto CA

	' 2 5 29 40 crlStreamIdentifier
	CRYPT_CERTINFO_CRLSTREAMIDENTIFIER

	' 2 5 29 46 freshestCRL
	CRYPT_CERTINFO_FRESHESTCRL
	CRYPT_CERTINFO_FRESHESTCRL_FULLNAME            ' distributionPointName.fullName
	CRYPT_CERTINFO_FRESHESTCRL_REASONS             ' reasons
	CRYPT_CERTINFO_FRESHESTCRL_CRLISSUER           ' cRLIssuer

	' 2 5 29 47 orderedList
	CRYPT_CERTINFO_ORDEREDLIST

	' 2 5 29 51 baseUpdateTime
	CRYPT_CERTINFO_BASEUPDATETIME

	' 2 5 29 53 deltaInfo
	CRYPT_CERTINFO_DELTAINFO
	CRYPT_CERTINFO_DELTAINFO_LOCATION              ' deltaLocation
	CRYPT_CERTINFO_DELTAINFO_NEXTDELTA             ' nextDelta

	' 2 5 29 54 inhibitAnyPolicy
	CRYPT_CERTINFO_INHIBITANYPOLICY

	' 2 5 29 58 toBeRevoked
	CRYPT_CERTINFO_TOBEREVOKED
	CRYPT_CERTINFO_TOBEREVOKED_CERTISSUER          ' certificateIssuer
	CRYPT_CERTINFO_TOBEREVOKED_REASONCODE          ' reasonCode
	CRYPT_CERTINFO_TOBEREVOKED_REVOCATIONTIME      ' revocationTime
	CRYPT_CERTINFO_TOBEREVOKED_CERTSERIALNUMBER    ' certSerialNumber

	' 2 5 29 59 revokedGroups
	CRYPT_CERTINFO_REVOKEDGROUPS
	CRYPT_CERTINFO_REVOKEDGROUPS_CERTISSUER        ' certificateIssuer
	CRYPT_CERTINFO_REVOKEDGROUPS_REASONCODE        ' reasonCode
	CRYPT_CERTINFO_REVOKEDGROUPS_INVALIDITYDATE    ' invalidityDate
	CRYPT_CERTINFO_REVOKEDGROUPS_STARTINGNUMBER    ' startingNumber
	CRYPT_CERTINFO_REVOKEDGROUPS_ENDINGNUMBER      ' endingNumber

	' 2 5 29 60 expiredCertsOnCRL
	CRYPT_CERTINFO_EXPIREDCERTSONCRL

	' 2 5 29 63 aaIssuingDistributionPoint
	CRYPT_CERTINFO_AAISSUINGDISTRIBUTIONPOINT
	CRYPT_CERTINFO_AAISSUINGDIST_FULLNAME          ' distributionPointName.fullName
	CRYPT_CERTINFO_AAISSUINGDIST_SOMEREASONSONLY   ' onlySomeReasons
	CRYPT_CERTINFO_AAISSUINGDIST_INDIRECTCRL       ' indirectCRL
	CRYPT_CERTINFO_AAISSUINGDIST_USERATTRCERTS     ' containsUserAttributeCerts
	CRYPT_CERTINFO_AAISSUINGDIST_AACERTS           ' containsAACerts
	CRYPT_CERTINFO_AAISSUINGDIST_SOACERTS          ' containsSOAPublicKeyCerts

	' 2 16 840 1 113730 1 x Netscape extensions
	CRYPT_CERTINFO_NS_CERTTYPE                     ' netscape-cert-type
	CRYPT_CERTINFO_NS_BASEURL                      ' netscape-base-url
	CRYPT_CERTINFO_NS_REVOCATIONURL                ' netscape-revocation-url
	CRYPT_CERTINFO_NS_CAREVOCATIONURL              ' netscape-ca-revocation-url
	CRYPT_CERTINFO_NS_CERTRENEWALURL               ' netscape-cert-renewal-url
	CRYPT_CERTINFO_NS_CAPOLICYURL                  ' netscape-ca-policy-url
	CRYPT_CERTINFO_NS_SSLSERVERNAME                ' netscape-ssl-server-name
	CRYPT_CERTINFO_NS_COMMENT                      ' netscape-comment

	' 2 23 42 7 0 SET hashedRootKey
	CRYPT_CERTINFO_SET_HASHEDROOTKEY
	CRYPT_CERTINFO_SET_ROOTKEYTHUMBPRINT           ' rootKeyThumbPrint

	' 2 23 42 7 1 SET certificateType
	CRYPT_CERTINFO_SET_CERTIFICATETYPE

	' 2 23 42 7 2 SET merchantData
	CRYPT_CERTINFO_SET_MERCHANTDATA
	CRYPT_CERTINFO_SET_MERID                       ' merID
	CRYPT_CERTINFO_SET_MERACQUIRERBIN              ' merAcquirerBIN
	CRYPT_CERTINFO_SET_MERCHANTLANGUAGE            ' merNames.language
	CRYPT_CERTINFO_SET_MERCHANTNAME                ' merNames.name
	CRYPT_CERTINFO_SET_MERCHANTCITY                ' merNames.city
	CRYPT_CERTINFO_SET_MERCHANTSTATEPROVINCE       ' merNames.stateProvince
	CRYPT_CERTINFO_SET_MERCHANTPOSTALCODE          ' merNames.postalCode
	CRYPT_CERTINFO_SET_MERCHANTCOUNTRYNAME         ' merNames.countryName
	CRYPT_CERTINFO_SET_MERCOUNTRY                  ' merCountry
	CRYPT_CERTINFO_SET_MERAUTHFLAG                 ' merAuthFlag

	' 2 23 42 7 3 SET certCardRequired
	CRYPT_CERTINFO_SET_CERTCARDREQUIRED

	' 2 23 42 7 4 SET tunneling
	CRYPT_CERTINFO_SET_TUNNELING
	CRYPT_CERTINFO_SET_TUNNELLING = CRYPT_CERTINFO_SET_TUNNELING
	CRYPT_CERTINFO_SET_TUNNELINGFLAG               ' tunneling
	CRYPT_CERTINFO_SET_TUNNELLINGFLAG = CRYPT_CERTINFO_SET_TUNNELINGFLAG
	CRYPT_CERTINFO_SET_TUNNELINGALGID              ' tunnelingAlgID
	CRYPT_CERTINFO_SET_TUNNELLINGALGID = CRYPT_CERTINFO_SET_TUNNELINGALGID

	' S/MIME attributes

	' 1 2 840 113549 1 9 3 contentType
	CRYPT_CERTINFO_CMS_CONTENTTYPE = CRYPT_CERTINFO_FIRST + 500

	' 1 2 840 113549 1 9 4 messageDigest
	CRYPT_CERTINFO_CMS_MESSAGEDIGEST

	' 1 2 840 113549 1 9 5 signingTime
	CRYPT_CERTINFO_CMS_SIGNINGTIME

	' 1 2 840 113549 1 9 6 counterSignature
	CRYPT_CERTINFO_CMS_COUNTERSIGNATURE            ' counterSignature

	' 1 2 840 113549 1 9 13 signingDescription
	CRYPT_CERTINFO_CMS_SIGNINGDESCRIPTION

	' 1 2 840 113549 1 9 15 sMIMECapabilities
	CRYPT_CERTINFO_CMS_SMIMECAPABILITIES
	CRYPT_CERTINFO_CMS_SMIMECAP_3DES               ' 3DES encryption
	CRYPT_CERTINFO_CMS_SMIMECAP_AES                ' AES encryption
	CRYPT_CERTINFO_CMS_SMIMECAP_CAST128            ' CAST-128 encryption
	CRYPT_CERTINFO_CMS_SMIMECAP_IDEA               ' IDEA encryption
	CRYPT_CERTINFO_CMS_SMIMECAP_RC2                ' RC2 encryption (w.128 key)
	CRYPT_CERTINFO_CMS_SMIMECAP_RC5                ' RC5 encryption (w.128 key)
	CRYPT_CERTINFO_CMS_SMIMECAP_SKIPJACK           ' Skipjack encryption
	CRYPT_CERTINFO_CMS_SMIMECAP_DES                ' DES encryption
	CRYPT_CERTINFO_CMS_SMIMECAP_SHAng              ' SHA2-ng hash
	CRYPT_CERTINFO_CMS_SMIMECAP_SHA2               ' SHA2-256 hash
	CRYPT_CERTINFO_CMS_SMIMECAP_SHA1               ' SHA1 hash
	CRYPT_CERTINFO_CMS_SMIMECAP_HMAC_SHAng         ' HMAC-SHA2-ng MAC
	CRYPT_CERTINFO_CMS_SMIMECAP_HMAC_SHA2          ' HMAC-SHA2-256 MAC
	CRYPT_CERTINFO_CMS_SMIMECAP_HMAC_SHA1          ' HMAC-SHA1 MAC
	CRYPT_CERTINFO_CMS_SMIMECAP_AUTHENC256         ' AuthEnc w.256-bit key
	CRYPT_CERTINFO_CMS_SMIMECAP_AUTHENC128         ' AuthEnc w.128-bit key
	CRYPT_CERTINFO_CMS_SMIMECAP_RSA_SHAng          ' RSA with SHA-ng signing
	CRYPT_CERTINFO_CMS_SMIMECAP_RSA_SHA2           ' RSA with SHA2-256 signing
	CRYPT_CERTINFO_CMS_SMIMECAP_RSA_SHA1           ' RSA with SHA1 signing
	CRYPT_CERTINFO_CMS_SMIMECAP_DSA_SHA1           ' DSA with SHA-1 signing
	CRYPT_CERTINFO_CMS_SMIMECAP_ECDSA_SHAng        ' ECDSA with SHA-ng signing
	CRYPT_CERTINFO_CMS_SMIMECAP_ECDSA_SHA2         ' ECDSA with SHA2-256 signing
	CRYPT_CERTINFO_CMS_SMIMECAP_ECDSA_SHA1         ' ECDSA with SHA-1 signing
	CRYPT_CERTINFO_CMS_SMIMECAP_PREFERSIGNEDDATA   ' preferSignedData
	CRYPT_CERTINFO_CMS_SMIMECAP_CANNOTDECRYPTANY   ' cannotDecryptAny
	CRYPT_CERTINFO_CMS_SMIMECAP_PREFERBINARYINSIDE ' preferBinaryInside

	' 1 2 840 113549 1 9 16 2 1 receiptRequest
	CRYPT_CERTINFO_CMS_RECEIPTREQUEST
	CRYPT_CERTINFO_CMS_RECEIPT_CONTENTIDENTIFIER   ' contentIdentifier
	CRYPT_CERTINFO_CMS_RECEIPT_FROM                ' receiptsFrom
	CRYPT_CERTINFO_CMS_RECEIPT_TO                  ' receiptsTo

	' 1 2 840 113549 1 9 16 2 2 essSecurityLabel
	CRYPT_CERTINFO_CMS_SECURITYLABEL
	CRYPT_CERTINFO_CMS_SECLABEL_POLICY             ' securityPolicyIdentifier
	CRYPT_CERTINFO_CMS_SECLABEL_CLASSIFICATION     ' securityClassification
	CRYPT_CERTINFO_CMS_SECLABEL_PRIVACYMARK        ' privacyMark
	CRYPT_CERTINFO_CMS_SECLABEL_CATTYPE            ' securityCategories.securityCategory.type
	CRYPT_CERTINFO_CMS_SECLABEL_CATVALUE           ' securityCategories.securityCategory.value

	' 1 2 840 113549 1 9 16 2 3 mlExpansionHistory
	CRYPT_CERTINFO_CMS_MLEXPANSIONHISTORY
	CRYPT_CERTINFO_CMS_MLEXP_ENTITYIDENTIFIER      ' mlData.mailListIdentifier.issuerandSerialNumber
	CRYPT_CERTINFO_CMS_MLEXP_TIME                  ' mlData.expansionTime
	CRYPT_CERTINFO_CMS_MLEXP_NONE                  ' mlData.mlReceiptPolicy.none
	CRYPT_CERTINFO_CMS_MLEXP_INSTEADOF             ' mlData.mlReceiptPolicy.insteadOf.generalNames.generalName
	CRYPT_CERTINFO_CMS_MLEXP_INADDITIONTO          ' mlData.mlReceiptPolicy.inAdditionTo.generalNames.generalName

	' 1 2 840 113549 1 9 16 2 4 contentHints
	CRYPT_CERTINFO_CMS_CONTENTHINTS
	CRYPT_CERTINFO_CMS_CONTENTHINT_DESCRIPTION     ' contentDescription
	CRYPT_CERTINFO_CMS_CONTENTHINT_TYPE            ' contentType

	' 1 2 840 113549 1 9 16 2 9 equivalentLabels
	CRYPT_CERTINFO_CMS_EQUIVALENTLABEL
	CRYPT_CERTINFO_CMS_EQVLABEL_POLICY             ' securityPolicyIdentifier
	CRYPT_CERTINFO_CMS_EQVLABEL_CLASSIFICATION     ' securityClassification
	CRYPT_CERTINFO_CMS_EQVLABEL_PRIVACYMARK        ' privacyMark
	CRYPT_CERTINFO_CMS_EQVLABEL_CATTYPE            ' securityCategories.securityCategory.type
	CRYPT_CERTINFO_CMS_EQVLABEL_CATVALUE           ' securityCategories.securityCategory.value

	' 1 2 840 113549 1 9 16 2 12 signingCertificate
	CRYPT_CERTINFO_CMS_SIGNINGCERTIFICATE
	CRYPT_CERTINFO_CMS_SIGNINGCERT_ESSCERTID       ' certs.essCertID
	CRYPT_CERTINFO_CMS_SIGNINGCERT_POLICIES        ' policies.policyInformation.policyIdentifier

	' 1 2 840 113549 1 9 16 2 47 signingCertificateV2
	CRYPT_CERTINFO_CMS_SIGNINGCERTIFICATEV2
	CRYPT_CERTINFO_CMS_SIGNINGCERTV2_ESSCERTIDV2   ' certs.essCertID
	CRYPT_CERTINFO_CMS_SIGNINGCERTV2_POLICIES      ' policies.policyInformation.policyIdentifier

	' 1 2 840 113549 1 9 16 2 15 signaturePolicyID
	CRYPT_CERTINFO_CMS_SIGNATUREPOLICYID
	CRYPT_CERTINFO_CMS_SIGPOLICYID                 ' sigPolicyID
	CRYPT_CERTINFO_CMS_SIGPOLICYHASH               ' sigPolicyHash
	CRYPT_CERTINFO_CMS_SIGPOLICY_CPSURI            ' sigPolicyQualifiers.sigPolicyQualifier.cPSuri
	CRYPT_CERTINFO_CMS_SIGPOLICY_ORGANIZATION
	' sigPolicyQualifiers.sigPolicyQualifier.usernotice.noticeRef.organization
	CRYPT_CERTINFO_CMS_SIGPOLICY_NOTICENUMBERS
	' sigPolicyQualifiers.sigPolicyQualifier.usernotice.noticeRef.noticeNumbers
	CRYPT_CERTINFO_CMS_SIGPOLICY_EXPLICITTEXT
	' sigPolicyQualifiers.sigPolicyQualifier.usernotice.explicitText

	' 1 2 840 113549 1 9 16 9 signatureTypeIdentifier
	CRYPT_CERTINFO_CMS_SIGTYPEIDENTIFIER
	CRYPT_CERTINFO_CMS_SIGTYPEID_ORIGINATORSIG     ' originatorSig
	CRYPT_CERTINFO_CMS_SIGTYPEID_DOMAINSIG         ' domainSig
	CRYPT_CERTINFO_CMS_SIGTYPEID_ADDITIONALATTRIBUTES ' additionalAttributesSig
	CRYPT_CERTINFO_CMS_SIGTYPEID_REVIEWSIG         ' reviewSig

	' 1 2 840 113549 1 9 25 3 randomNonce
	CRYPT_CERTINFO_CMS_NONCE                       ' randomNonce

	/' SCEP attributes:
	   2 16 840 1 113733 1 9 2 messageType
	   2 16 840 1 113733 1 9 3 pkiStatus
	   2 16 840 1 113733 1 9 4 failInfo
	   2 16 840 1 113733 1 9 5 senderNonce
	   2 16 840 1 113733 1 9 6 recipientNonce
	   2 16 840 1 113733 1 9 7 transID '/
	CRYPT_CERTINFO_SCEP_MESSAGETYPE                ' messageType
	CRYPT_CERTINFO_SCEP_PKISTATUS                  ' pkiStatus
	CRYPT_CERTINFO_SCEP_FAILINFO                   ' failInfo
	CRYPT_CERTINFO_SCEP_SENDERNONCE                ' senderNonce
	CRYPT_CERTINFO_SCEP_RECIPIENTNONCE             ' recipientNonce
	CRYPT_CERTINFO_SCEP_TRANSACTIONID              ' transID

	' 1 3 6 1 4 1 311 2 1 10 spcAgencyInfo
	CRYPT_CERTINFO_CMS_SPCAGENCYINFO
	CRYPT_CERTINFO_CMS_SPCAGENCYURL                ' spcAgencyInfo.url

	' 1 3 6 1 4 1 311 2 1 11 spcStatementType
	CRYPT_CERTINFO_CMS_SPCSTATEMENTTYPE
	CRYPT_CERTINFO_CMS_SPCSTMT_INDIVIDUALCODESIGNING ' individualCodeSigning
	CRYPT_CERTINFO_CMS_SPCSTMT_COMMERCIALCODESIGNING ' commercialCodeSigning

	' 1 3 6 1 4 1 311 2 1 12 spcOpusInfo
	CRYPT_CERTINFO_CMS_SPCOPUSINFO
	CRYPT_CERTINFO_CMS_SPCOPUSINFO_NAME            ' spcOpusInfo.name
	CRYPT_CERTINFO_CMS_SPCOPUSINFO_URL             ' spcOpusInfo.url

	' Used internally
	CRYPT_CERTINFO_LAST
	CRYPT_KEYINFO_FIRST = 3000

	'*********************
	'* Keyset attributes *
	'*********************

	CRYPT_KEYINFO_QUERY                            ' Keyset query
	CRYPT_KEYINFO_QUERY_REQUESTS                   ' Query of requests in cert store

	' Used internally
	CRYPT_KEYINFO_LAST
	CRYPT_DEVINFO_FIRST = 4000

	'*********************
	'* Device attributes *
	'*********************

	CRYPT_DEVINFO_INITIALISE                       ' Initialise device for use
	CRYPT_DEVINFO_INITIALIZE = CRYPT_DEVINFO_INITIALISE
	CRYPT_DEVINFO_AUTHENT_USER                     ' Authenticate user to device
	CRYPT_DEVINFO_AUTHENT_SUPERVISOR               ' Authenticate supervisor to dev.
	CRYPT_DEVINFO_SET_AUTHENT_USER                 ' Set user authent.value
	CRYPT_DEVINFO_SET_AUTHENT_SUPERVISOR           ' Set supervisor auth.val.
	CRYPT_DEVINFO_ZEROISE                          ' Zeroise device
	CRYPT_DEVINFO_ZEROIZE = CRYPT_DEVINFO_ZEROISE
	CRYPT_DEVINFO_LOGGEDIN                         ' Whether user is logged in
	CRYPT_DEVINFO_LABEL                            ' Device/token label

	' Used internally
	CRYPT_DEVINFO_LAST
	CRYPT_ENVINFO_FIRST = 5000

	'***********************
	'* Envelope attributes *
	'***********************

	/' Pseudo-information on an envelope or meta-information which is used to
	   control the way that data in an envelope is processed '/
	CRYPT_ENVINFO_DATASIZE                         ' Data size information
	CRYPT_ENVINFO_COMPRESSION                      ' Compression information
	CRYPT_ENVINFO_CONTENTTYPE                      ' Inner CMS content type
	CRYPT_ENVINFO_DETACHEDSIGNATURE                ' Detached signature
	CRYPT_ENVINFO_SIGNATURE_RESULT                 ' Signature check result
	CRYPT_ENVINFO_INTEGRITY                        ' Integrity-protection level

	' Resources required for enveloping/deenveloping
	CRYPT_ENVINFO_PASSWORD                         ' User password
	CRYPT_ENVINFO_KEY                              ' Conventional encryption key
	CRYPT_ENVINFO_SIGNATURE                        ' Signature/signature check key
	CRYPT_ENVINFO_SIGNATURE_EXTRADATA              ' Extra information added to CMS sigs
	CRYPT_ENVINFO_RECIPIENT                        ' Recipient email address
	CRYPT_ENVINFO_PUBLICKEY                        ' PKC encryption key
	CRYPT_ENVINFO_PRIVATEKEY                       ' PKC decryption key
	CRYPT_ENVINFO_PRIVATEKEY_LABEL                 ' Label of PKC decryption key
	CRYPT_ENVINFO_ORIGINATOR                       ' Originator info/key
	CRYPT_ENVINFO_SESSIONKEY                       ' Session key
	CRYPT_ENVINFO_HASH                             ' Hash value
	CRYPT_ENVINFO_TIMESTAMP                        ' Timestamp information

	' Keysets used to retrieve keys needed for enveloping/deenveloping
	CRYPT_ENVINFO_KEYSET_SIGCHECK                  ' Signature check keyset
	CRYPT_ENVINFO_KEYSET_ENCRYPT                   ' PKC encryption keyset
	CRYPT_ENVINFO_KEYSET_DECRYPT                   ' PKC decryption keyset

	' Used internally
	CRYPT_ENVINFO_LAST
	CRYPT_SESSINFO_FIRST = 6000

	'**********************
	'* Session attributes *
	'**********************

	' Pseudo-information about the session
	CRYPT_SESSINFO_ACTIVE                          ' Whether session is active
	CRYPT_SESSINFO_CONNECTIONACTIVE                ' Whether network connection is active

	' Security-related information
	CRYPT_SESSINFO_USERNAME                        ' User name
	CRYPT_SESSINFO_PASSWORD                        ' Password
	CRYPT_SESSINFO_PRIVATEKEY                      ' Server/client private key
	CRYPT_SESSINFO_KEYSET                          ' Certificate store
	CRYPT_SESSINFO_AUTHRESPONSE                    ' Session authorisation OK

	' Client/server information
	CRYPT_SESSINFO_SERVER_NAME                     ' Server name
	CRYPT_SESSINFO_SERVER_PORT                     ' Server port number
	CRYPT_SESSINFO_SERVER_FINGERPRINT              ' Server key fingerprint
	CRYPT_SESSINFO_CLIENT_NAME                     ' Client name
	CRYPT_SESSINFO_CLIENT_PORT                     ' Client port number
	CRYPT_SESSINFO_SESSION                         ' Transport mechanism
	CRYPT_SESSINFO_NETWORKSOCKET                   ' User-supplied network socket

	' Generic protocol-related information
	CRYPT_SESSINFO_VERSION                         ' Protocol version
	CRYPT_SESSINFO_REQUEST                         ' Cert.request object
	CRYPT_SESSINFO_RESPONSE                        ' Cert.response object
	CRYPT_SESSINFO_CACERTIFICATE                   ' Issuing CA certificate

	' Protocol-specific information
	CRYPT_SESSINFO_CMP_REQUESTTYPE                 ' Request type
	CRYPT_SESSINFO_CMP_PRIVKEYSET                  ' Private-key keyset
	CRYPT_SESSINFO_SSH_CHANNEL                     ' SSH current channel
	CRYPT_SESSINFO_SSH_CHANNEL_TYPE                ' SSH channel type
	CRYPT_SESSINFO_SSH_CHANNEL_ARG1                ' SSH channel argument 1
	CRYPT_SESSINFO_SSH_CHANNEL_ARG2                ' SSH channel argument 2
	CRYPT_SESSINFO_SSH_CHANNEL_ACTIVE              ' SSH channel active
	CRYPT_SESSINFO_SSL_OPTIONS                     ' SSL/TLS protocol options
	CRYPT_SESSINFO_TSP_MSGIMPRINT                  ' TSP message imprint

	' Used internally
	CRYPT_SESSINFO_LAST
	CRYPT_USERINFO_FIRST = 7000

	'**********************
	'*  User attributes   *
	'**********************

	' Security-related information
	CRYPT_USERINFO_PASSWORD                        ' Password

	' User role-related information
	CRYPT_USERINFO_CAKEY_CERTSIGN                  ' CA cert signing key
	CRYPT_USERINFO_CAKEY_CRLSIGN                   ' CA CRL signing key
	CRYPT_USERINFO_CAKEY_RTCSSIGN                  ' CA RTCS signing key
	CRYPT_USERINFO_CAKEY_OCSPSIGN                  ' CA OCSP signing key

	' Used internally for range checking
	CRYPT_USERINFO_LAST
	CRYPT_ATTRIBUTE_LAST = CRYPT_USERINFO_LAST

end enum

'****************************************************************************
'*                                                                           *
'*                       Attribute Subtypes and Related Values               *
'*                                                                           *
'****************************************************************************

' Flags for the X.509 keyUsage extension

#define CRYPT_KEYUSAGE_NONE               &h000
#define CRYPT_KEYUSAGE_DIGITALSIGNATURE   &h001
#define CRYPT_KEYUSAGE_NONREPUDIATION     &h002
#define CRYPT_KEYUSAGE_KEYENCIPHERMENT    &h004
#define CRYPT_KEYUSAGE_DATAENCIPHERMENT   &h008
#define CRYPT_KEYUSAGE_KEYAGREEMENT       &h010
#define CRYPT_KEYUSAGE_KEYCERTSIGN        &h020
#define CRYPT_KEYUSAGE_CRLSIGN            &h040
#define CRYPT_KEYUSAGE_ENCIPHERONLY       &h080
#define CRYPT_KEYUSAGE_DECIPHERONLY       &h100
#define CRYPT_KEYUSAGE_LAST               &h200   ' Last possible value

' X.509 cRLReason and cryptlib cRLExtReason codes

enum 
	CRYPT_CRLREASON_UNSPECIFIED
	CRYPT_CRLREASON_KEYCOMPROMISE
	CRYPT_CRLREASON_CACOMPROMISE
	CRYPT_CRLREASON_AFFILIATIONCHANGED
	CRYPT_CRLREASON_SUPERSEDED
	CRYPT_CRLREASON_CESSATIONOFOPERATION
	CRYPT_CRLREASON_CERTIFICATEHOLD
	CRYPT_CRLREASON_REMOVEFROMCRL = 8
	CRYPT_CRLREASON_PRIVILEGEWITHDRAWN
	CRYPT_CRLREASON_AACOMPROMISE
	CRYPT_CRLREASON_LAST                           ' end of standard CRL reasons
	CRYPT_CRLREASON_NEVERVALID = 20
	CRYPT_CRLEXTREASON_LAST
end enum

/' X.509 CRL reason flags.  These identify the same thing as the cRLReason
   codes but allow for multiple reasons to be specified.  note that these
   don't follow the X.509 naming since in that scheme the enumerated types
   and bitflags have the same names '/

#define CRYPT_CRLREASONFLAG_UNUSED        &h001
#define CRYPT_CRLREASONFLAG_KEYCOMPROMISE &h002
#define CRYPT_CRLREASONFLAG_CACOMPROMISE  &h004
#define CRYPT_CRLREASONFLAG_AFFILIATIONCHANGED &h008
#define CRYPT_CRLREASONFLAG_SUPERSEDED    &h010
#define CRYPT_CRLREASONFLAG_CESSATIONOFOPERATION &h020
#define CRYPT_CRLREASONFLAG_CERTIFICATEHOLD &h040
#define CRYPT_CRLREASONFLAG_LAST          &h080   ' Last poss.value

' X.509 CRL holdInstruction codes

enum 
	CRYPT_HOLDINSTRUCTION_NONE
	CRYPT_HOLDINSTRUCTION_CALLISSUER
	CRYPT_HOLDINSTRUCTION_REJECT
	CRYPT_HOLDINSTRUCTION_PICKUPTOKEN
	CRYPT_HOLDINSTRUCTION_LAST
end enum

' Certificate checking compliance levels

enum
	CRYPT_COMPLIANCELEVEL_OBLIVIOUS
	CRYPT_COMPLIANCELEVEL_REDUCED
	CRYPT_COMPLIANCELEVEL_STANDARD
	CRYPT_COMPLIANCELEVEL_PKIX_PARTIAL
	CRYPT_COMPLIANCELEVEL_PKIX_FULL
	CRYPT_COMPLIANCELEVEL_LAST
end enum

' Flags for the Netscape netscape-cert-type extension

#define CRYPT_NS_CERTTYPE_SSLCLIENT       &h001
#define CRYPT_NS_CERTTYPE_SSLSERVER       &h002
#define CRYPT_NS_CERTTYPE_SMIME           &h004
#define CRYPT_NS_CERTTYPE_OBJECTSIGNING   &h008
#define CRYPT_NS_CERTTYPE_RESERVED        &h010
#define CRYPT_NS_CERTTYPE_SSLCA           &h020
#define CRYPT_NS_CERTTYPE_SMIMECA         &h040
#define CRYPT_NS_CERTTYPE_OBJECTSIGNINGCA &h080
#define CRYPT_NS_CERTTYPE_LAST            &h100   ' Last possible value

' Flags for the SET certificate-type extension

#define CRYPT_SET_CERTTYPE_CARD           &h001
#define CRYPT_SET_CERTTYPE_MER            &h002
#define CRYPT_SET_CERTTYPE_PGWY           &h004
#define CRYPT_SET_CERTTYPE_CCA            &h008
#define CRYPT_SET_CERTTYPE_MCA            &h010
#define CRYPT_SET_CERTTYPE_PCA            &h020
#define CRYPT_SET_CERTTYPE_GCA            &h040
#define CRYPT_SET_CERTTYPE_BCA            &h080
#define CRYPT_SET_CERTTYPE_RCA            &h100
#define CRYPT_SET_CERTTYPE_ACQ            &h200
#define CRYPT_SET_CERTTYPE_LAST           &h400   ' Last possible value

' CMS contentType values

enum CRYPT_CONTENT_TYPE
	CRYPT_CONTENT_NONE
	CRYPT_CONTENT_DATA
	CRYPT_CONTENT_SIGNEDDATA
	CRYPT_CONTENT_ENVELOPEDDATA
	CRYPT_CONTENT_SIGNEDANDENVELOPEDDATA
	CRYPT_CONTENT_DIGESTEDDATA
	CRYPT_CONTENT_ENCRYPTEDDATA
	CRYPT_CONTENT_COMPRESSEDDATA
	CRYPT_CONTENT_AUTHDATA
	CRYPT_CONTENT_AUTHENVDATA
	CRYPT_CONTENT_TSTINFO
	CRYPT_CONTENT_SPCINDIRECTDATACONTEXT
	CRYPT_CONTENT_RTCSREQUEST
	CRYPT_CONTENT_RTCSRESPONSE
	CRYPT_CONTENT_RTCSRESPONSE_EXT
	CRYPT_CONTENT_MRTD
	CRYPT_CONTENT_LAST
end enum

' ESS securityClassification codes

enum 
	CRYPT_CLASSIFICATION_UNMARKED
	CRYPT_CLASSIFICATION_UNCLASSIFIED
	CRYPT_CLASSIFICATION_RESTRICTED
	CRYPT_CLASSIFICATION_CONFIDENTIAL
	CRYPT_CLASSIFICATION_SECRET
	CRYPT_CLASSIFICATION_TOP_SECRET
	CRYPT_CLASSIFICATION_LAST = 255
end enum

' RTCS certificate status

enum
	CRYPT_CERTSTATUS_VALID
	CRYPT_CERTSTATUS_NOTVALID
	CRYPT_CERTSTATUS_NONAUTHORITATIVE
	CRYPT_CERTSTATUS_UNKNOWN
end enum

' OCSP revocation status

enum
	CRYPT_OCSPSTATUS_NOTREVOKED
	CRYPT_OCSPSTATUS_REVOKED
	CRYPT_OCSPSTATUS_UNKNOWN
end enum

/' The amount of detail to include in signatures when signing certificate
   objects '/

enum CRYPT_SIGNATURELEVEL_TYPE
	CRYPT_SIGNATURELEVEL_NONE                      ' Include only signature
	CRYPT_SIGNATURELEVEL_SIGNERCERT                ' Include signer cert
	CRYPT_SIGNATURELEVEL_ALL                       ' Include all relevant info
	CRYPT_SIGNATURELEVEL_LAST                      ' Last possible sig.level type
end enum

/' The level of integrity protection to apply to enveloped data.  The
   default envelope protection for an envelope with keying information
   applied is encryption, this can be modified to use MAC-only protection
   (with no encryption) or hybrid encryption + authentication '/

enum CRYPT_INTEGRITY_TYPE
	CRYPT_INTEGRITY_NONE                           ' No integrity protection
	CRYPT_INTEGRITY_MACONLY                        ' MAC only, no encryption
	CRYPT_INTEGRITY_FULL                           ' Encryption + ingerity protection
end enum

/' The certificate export format type, which defines the format in which a
   certificate object is exported '/

enum CRYPT_CERTFORMAT_TYPE
	CRYPT_CERTFORMAT_NONE                          ' No certificate format
	CRYPT_CERTFORMAT_CERTIFICATE                   ' DER-encoded certificate
	CRYPT_CERTFORMAT_CERTCHAIN                     ' PKCS #7 certificate chain
	CRYPT_CERTFORMAT_TEXT_CERTIFICATE              ' base-64 wrapped cert
	CRYPT_CERTFORMAT_TEXT_CERTCHAIN                ' base-64 wrapped cert chain
	CRYPT_CERTFORMAT_XML_CERTIFICATE               ' XML wrapped cert
	CRYPT_CERTFORMAT_XML_CERTCHAIN                 ' XML wrapped cert chain
	CRYPT_CERTFORMAT_LAST                          ' Last possible cert.format type
end enum

' CMP request types

enum CRYPT_REQUESTTYPE_TYPE
	CRYPT_REQUESTTYPE_NONE                         ' No request type
	CRYPT_REQUESTTYPE_INITIALISATION               ' Initialisation request
	CRYPT_REQUESTTYPE_INITIALIZATION = CRYPT_REQUESTTYPE_INITIALISATION
	CRYPT_REQUESTTYPE_CERTIFICATE                  ' Certification request
	CRYPT_REQUESTTYPE_KEYUPDATE                    ' Key update request
	CRYPT_REQUESTTYPE_REVOCATION                   ' Cert revocation request
	CRYPT_REQUESTTYPE_PKIBOOT                      ' PKIBoot request
	CRYPT_REQUESTTYPE_LAST                         ' Last possible request type
end enum

' Key ID types

enum CRYPT_KEYID_TYPE
	CRYPT_KEYID_NONE                               ' No key ID type
	CRYPT_KEYID_NAME                               ' Key owner name
	CRYPT_KEYID_URI                                ' Key owner URI
	CRYPT_KEYID_EMAIL = CRYPT_KEYID_URI            ' Synonym: owner email addr.
	CRYPT_KEYID_LAST                               ' Last possible key ID type
end enum

' The encryption object types

enum CRYPT_OBJECT_TYPE
	CRYPT_OBJECT_NONE                              ' No object type
	CRYPT_OBJECT_ENCRYPTED_KEY                     ' Conventionally encrypted key
	CRYPT_OBJECT_PKCENCRYPTED_KEY                  ' PKC-encrypted key
	CRYPT_OBJECT_KEYAGREEMENT                      ' Key agreement information
	CRYPT_OBJECT_SIGNATURE                         ' Signature
	CRYPT_OBJECT_LAST                              ' Last possible object type
end enum

' Object/attribute error type information

enum CRYPT_ERRTYPE_TYPE
	CRYPT_ERRTYPE_NONE                             ' No error information
	CRYPT_ERRTYPE_ATTR_SIZE                        ' Attribute data too small or large
	CRYPT_ERRTYPE_ATTR_VALUE                       ' Attribute value is invalid
	CRYPT_ERRTYPE_ATTR_ABSENT                      ' Required attribute missing
	CRYPT_ERRTYPE_ATTR_PRESENT                     ' Non-allowed attribute present
	CRYPT_ERRTYPE_CONSTRAINT                       ' Cert: Constraint violation in object
	CRYPT_ERRTYPE_ISSUERCONSTRAINT                 ' Cert: Constraint viol.in issuing cert
	CRYPT_ERRTYPE_LAST                             ' Last possible error info type
end enum

' Cert store management action type

enum CRYPT_CERTACTION_TYPE
	CRYPT_CERTACTION_NONE                          ' No cert management action
	CRYPT_CERTACTION_CREATE                        ' Create cert store
	CRYPT_CERTACTION_CONNECT                       ' Connect to cert store
	CRYPT_CERTACTION_DISCONNECT                    ' Disconnect from cert store
	CRYPT_CERTACTION_ERROR                         ' Error information
	CRYPT_CERTACTION_ADDUSER                       ' Add PKI user
	CRYPT_CERTACTION_DELETEUSER                    ' Delete PKI user
	CRYPT_CERTACTION_REQUEST_CERT                  ' Cert request
	CRYPT_CERTACTION_REQUEST_RENEWAL               ' Cert renewal request
	CRYPT_CERTACTION_REQUEST_REVOCATION            ' Cert revocation request
	CRYPT_CERTACTION_CERT_CREATION                 ' Cert creation
	CRYPT_CERTACTION_CERT_CREATION_COMPLETE        ' Confirmation of cert creation
	CRYPT_CERTACTION_CERT_CREATION_DROP            ' Cancellation of cert creation
	CRYPT_CERTACTION_CERT_CREATION_REVERSE         ' Cancel of creation w.revocation
	CRYPT_CERTACTION_RESTART_CLEANUP               ' Delete reqs after restart
	CRYPT_CERTACTION_RESTART_REVOKE_CERT           ' Complete revocation after restart
	CRYPT_CERTACTION_ISSUE_CERT                    ' Cert issue
	CRYPT_CERTACTION_ISSUE_CRL                     ' CRL issue
	CRYPT_CERTACTION_REVOKE_CERT                   ' Cert revocation
	CRYPT_CERTACTION_EXPIRE_CERT                   ' Cert expiry
	CRYPT_CERTACTION_CLEANUP                       ' Clean up on restart
	CRYPT_CERTACTION_LAST                          ' Last possible cert store log action
end enum

/' SSL/TLS protocol options.  CRYPT_SSLOPTION_MINVER_SSLV3 is the same as
   CRYPT_SSLOPTION_NONE since this is the default '/

#define CRYPT_SSLOPTION_NONE              &h00
#define CRYPT_SSLOPTION_MINVER_SSLV3      &h00    ' Min.protocol version
#define CRYPT_SSLOPTION_MINVER_TLS10      &h01
#define CRYPT_SSLOPTION_MINVER_TLS11      &h02
#define CRYPT_SSLOPTION_MINVER_TLS12      &h03
#define CRYPT_SSLOPTION_SUITEB_128        &h04    ' SuiteB security levels
#define CRYPT_SSLOPTION_SUITEB_256        &h08

'****************************************************************************
'*                                                                          *
'*                              General Constants                           *
'*                                                                          *
'****************************************************************************

' The maximum user key size - 2048 bits

#define CRYPT_MAX_KEYSIZE      256

' The maximum IV size - 256 bits

#define CRYPT_MAX_IVSIZE        32

/' The maximum public-key component size - 4096 bits, and maximum component
   size for ECCs - 576 bits (to handle the P521 curve) '/

#define CRYPT_MAX_PKCSIZE      512
#define CRYPT_MAX_PKCSIZE_ECC   72

/' The maximum hash size - 512 bits.  Before 3.4 this was 256 bits, in the
   3.4 release it was increased to 512 bits to accommodate SHA-3 '/

#define CRYPT_MAX_HASHSIZE      64

' The maximum size of a text string (e.g.key owner name)

#define CRYPT_MAX_TEXTSIZE      64

/' A magic value indicating that the default setting for this parameter
   should be used.  The parentheses are to catch potential erroneous use
   in an expression '/

#define CRYPT_USE_DEFAULT     ( -100 )

' A magic value for unused parameters

#define CRYPT_UNUSED          ( -101 )

/' Cursor positioning codes for certificate/CRL extensions.  The parentheses
   are to catch potential erroneous use in an expression '/

#define CRYPT_CURSOR_FIRST    ( -200 )
#define CRYPT_CURSOR_PREVIOUS ( -201 )
#define CRYPT_CURSOR_NEXT     ( -202 )
#define CRYPT_CURSOR_LAST     ( -203 )

/' The type of information polling to perform to get random seed
   information.  These values have to be negative because they're used
   as magic length values for cryptAddRandom().  The parentheses are to
   catch potential erroneous use in an expression '/

#define CRYPT_RANDOM_FASTPOLL ( -300 )
#define CRYPT_RANDOM_SLOWPOLL ( -301 )

' Whether the PKC key is a public or private key

#define CRYPT_KEYTYPE_PRIVATE   0
#define CRYPT_KEYTYPE_PUBLIC    1

' Keyset open options

enum CRYPT_KEYOPT_TYPE
	CRYPT_KEYOPT_NONE                              ' No options
	CRYPT_KEYOPT_READONLY                          ' Open keyset in read-only mode
	CRYPT_KEYOPT_CREATE                            ' Create a new keyset
	CRYPT_KEYOPT_LAST                              ' Last possible key option type
end enum

' The various cryptlib objects - these are just integer handles

type as integer CRYPT_CERTIFICATE
type as integer CRYPT_CONTEXT
type as integer CRYPT_DEVICE
type as integer CRYPT_ENVELOPE
type as integer CRYPT_KEYSET
type as integer CRYPT_SESSION
type as integer CRYPT_USER

/' Sometimes we don't know the exact type of a cryptlib object, so we use a
   generic handle type to identify it '/

type as integer CRYPT_HANDLE

'****************************************************************************
'*                                                                          *
'*                          Encryption Data Structures                      *
'*                                                                          *
'****************************************************************************

' Results returned from the capability query

type CRYPT_QUERY_INFO
	' Algorithm information
	as zstring * CRYPT_MAX_TEXTSIZE algoName       ' Algorithm name
	as integer blockSize                           ' Block size of the algorithm
	as integer minKeySize                          ' Minimum key size in bytes
	as integer keySize                             ' Recommended key size in bytes
	as integer maxKeySize                          ' Maximum key size in bytes
end type

/' Results returned from the encoded object query.  These provide
   information on the objects created by cryptExportKey()/
   cryptCreateSignature() '/

type CRYPT_OBJECT_INFO
	' The object type
	as CRYPT_OBJECT_TYPE objectType

	' The encryption algorithm and mode
	as CRYPT_ALGO_TYPE cryptAlgo
	as CRYPT_MODE_TYPE cryptMode

	' The hash algorithm for Signature objects
	as CRYPT_ALGO_TYPE hashAlgo

	' The salt for derived keys
	as ubyte   salt(0 To (CRYPT_MAX_HASHSIZE - 1))
	as integer saltSize
end type

/' Key information for the public-key encryption algorithms.  These fields
   are not accessed directly, but can be manipulated with the init/set/
   destroyComponents() macros '/

type CRYPT_PKCINFO_RSA
	' Status information
	as integer isPublicKey                         ' Whether this is a public or private key

	' Public components
	as ubyte   n(0 To (CRYPT_MAX_PKCSIZE - 1))     ' Modulus
	as integer nLen                                ' Length of modulus in bits
	as ubyte   e(0 To (CRYPT_MAX_PKCSIZE - 1))     ' Public exponent
	as integer eLen                                ' Length of public exponent in bits

	' Private components
	as ubyte   d(0 To (CRYPT_MAX_PKCSIZE - 1))     ' Private exponent
	as integer dLen                                ' Length of private exponent in bits
	as ubyte   p(0 To (CRYPT_MAX_PKCSIZE - 1))     ' Prime factor 1
	as integer pLen                                ' Length of prime factor 1 in bits
	as ubyte   q(0 To (CRYPT_MAX_PKCSIZE - 1))     ' Prime factor 2
	as integer qLen                                ' Length of prime factor 2 in bits
	as ubyte   u(0 To (CRYPT_MAX_PKCSIZE - 1))     ' Mult.inverse of q, mod p
	as integer uLen                                ' Length of private exponent in bits
	as ubyte   e1(0 To (CRYPT_MAX_PKCSIZE - 1))    ' Private exponent 1 (PKCS)
	as integer e1Len                               ' Length of private exponent in bits
	as ubyte   e2(0 To (CRYPT_MAX_PKCSIZE - 1))    ' Private exponent 2 (PKCS)
	as integer e2Len                               ' Length of private exponent in bits
end type

type CRYPT_PKCINFO_DLP
	' Status information
	as integer isPublicKey                         ' Whether this is a public or private key

	' Public components
	as ubyte   p(0 To (CRYPT_MAX_PKCSIZE - 1))     ' Prime modulus
	as integer pLen                                ' Length of prime modulus in bits
	as ubyte   q(0 To (CRYPT_MAX_PKCSIZE - 1))     ' Prime divisor
	as integer qLen                                ' Length of prime divisor in bits
	as ubyte   g(0 To (CRYPT_MAX_PKCSIZE - 1))     ' h^( ( p - 1 ) / q ) mod p
	as integer gLen                                       ' Length of g in bits
	as ubyte   y(0 To (CRYPT_MAX_PKCSIZE - 1))     ' Public random integer
	as integer yLen                                ' Length of public integer in bits

	' Private components
	as ubyte   x(0 To (CRYPT_MAX_PKCSIZE - 1))     ' Private random integer
	as integer xLen                                ' Length of private integer in bits
end type

enum CRYPT_ECCCURVE_TYPE
	/' Named ECC curves.  Since these need to be mapped to all manner of
	   protocol- and mechanism-specific identifiers, when updating this list
	   grep for occurrences of CRYPT_ECCCURVE_P256 (the most common one) and
	   check whether any related mapping tables need to be updated '/
	CRYPT_ECCCURVE_NONE                            ' No ECC curve type
	CRYPT_ECCCURVE_P192                            ' NIST P192/X9.62 P192r1/SECG p192r1 curve
	CRYPT_ECCCURVE_P224                            ' NIST P224/X9.62 P224r1/SECG p224r1 curve
	CRYPT_ECCCURVE_P256                            ' NIST P256/X9.62 P256v1/SECG p256r1 curve
	CRYPT_ECCCURVE_P384                            ' NIST P384, SECG p384r1 curve
	CRYPT_ECCCURVE_P521                            ' NIST P521, SECG p521r1
	CRYPT_ECCCURVE_LAST                            ' Last valid ECC curve type
end enum

type CRYPT_PKCINFO_ECC
	' Status information
	as integer isPublicKey                         ' Whether this is a public or private key

	/' Curve domain parameters.  Either the curveType or the explicit domain
	   parameters must be provided '/
	as CRYPT_ECCCURVE_TYPE curveType               ' Named curve
	as ubyte   p(0 To (CRYPT_MAX_PKCSIZE_ECC - 1)) ' Prime defining Fq
	as integer pLen                                ' Length of prime in bits
	as ubyte   a(0 To (CRYPT_MAX_PKCSIZE_ECC - 1)) ' Element in Fq defining curve
	as integer aLen                                ' Length of element a in bits
	as ubyte   b(0 To (CRYPT_MAX_PKCSIZE_ECC - 1)) ' Element in Fq defining curve
	as integer bLen                                ' Length of element b in bits
	as ubyte   gx(0 To (CRYPT_MAX_PKCSIZE_ECC - 1))' Element in Fq defining point
	as integer gxLen                               ' Length of element gx in bits
	as ubyte   gy(0 To (CRYPT_MAX_PKCSIZE_ECC - 1))' Element in Fq defining point
	as integer gyLen                               ' Length of element gy in bits
	as ubyte   n(0 To (CRYPT_MAX_PKCSIZE_ECC - 1)) ' Order of point
	as integer nLen                                ' Length of order in bits
	as ubyte   h(0 To (CRYPT_MAX_PKCSIZE_ECC - 1)) ' Optional cofactor
	as integer hLen                                ' Length of cofactor in bits

	' Public components
	as ubyte   qx(0 To (CRYPT_MAX_PKCSIZE_ECC - 1))' Point Q on the curve
	as integer qxLen                               ' Length of point xq in bits
	as ubyte   qy(0 To (CRYPT_MAX_PKCSIZE_ECC - 1))' Point Q on the curve
	as integer qyLen                               ' Length of point xy in bits

	' Private components
	as ubyte   d(0 To (CRYPT_MAX_PKCSIZE_ECC - 1)) ' Private random integer
	as integer dLen                                ' Length of integer in bits
end type

'****************************************************************************
'*                                                                          *
'*                              Status Codes                                *
'*                                                                          *
'****************************************************************************

' No error in function call

#define CRYPT_OK            0                     ' No error

/' Error in parameters passed to function.  The parentheses are to catch
   potential erroneous use in an expression '/

#define CRYPT_ERROR_PARAM1      ( -1 )            ' Bad argument, parameter 1
#define CRYPT_ERROR_PARAM2      ( -2 )            ' Bad argument, parameter 2
#define CRYPT_ERROR_PARAM3      ( -3 )            ' Bad argument, parameter 3
#define CRYPT_ERROR_PARAM4      ( -4 )            ' Bad argument, parameter 4
#define CRYPT_ERROR_PARAM5      ( -5 )            ' Bad argument, parameter 5
#define CRYPT_ERROR_PARAM6      ( -6 )            ' Bad argument, parameter 6
#define CRYPT_ERROR_PARAM7      ( -7 )            ' Bad argument, parameter 7

' Errors due to insufficient resources

#define CRYPT_ERROR_MEMORY      ( -10 )           ' Out of memory
#define CRYPT_ERROR_NOTINITED   ( -11 )           ' Data has not been initialised
#define CRYPT_ERROR_INITED      ( -12 )           ' Data has already been init'd
#define CRYPT_ERROR_NOSECURE    ( -13 )           ' Opn.not avail.at requested sec.level
#define CRYPT_ERROR_RANDOM      ( -14 )           ' No reliable random data available
#define CRYPT_ERROR_FAILED      ( -15 )           ' Operation failed
#define CRYPT_ERROR_INTERNAL    ( -16 )           ' Internal consistency check failed

' Security violations

#define CRYPT_ERROR_NOTAVAIL    ( -20 )           ' This type of opn.not available
#define CRYPT_ERROR_PERMISSION  ( -21 )           ' No permiss.to perform this operation
#define CRYPT_ERROR_WRONGKEY    ( -22 )           ' Incorrect key used to decrypt data
#define CRYPT_ERROR_INCOMPLETE  ( -23 )           ' Operation incomplete/still in progress
#define CRYPT_ERROR_COMPLETE    ( -24 )           ' Operation complete/can't continue
#define CRYPT_ERROR_TIMEOUT     ( -25 )           ' Operation timed out before completion
#define CRYPT_ERROR_INVALID     ( -26 )           ' Invalid/inconsistent information
#define CRYPT_ERROR_SIGNALLED   ( -27 )           ' Resource destroyed by extnl.event

' High-level function errors

#define CRYPT_ERROR_OVERFLOW    ( -30 )           ' Resources/space exhausted
#define CRYPT_ERROR_UNDERFLOW   ( -31 )           ' not enough data available
#define CRYPT_ERROR_BADDATA     ( -32 )           ' Bad/unrecognised data format
#define CRYPT_ERROR_SIGNATURE   ( -33 )           ' Signature/integrity check failed

' Data access function errors

#define CRYPT_ERROR_OPEN        ( -40 )           ' Cannot open object
#define CRYPT_ERROR_READ        ( -41 )           ' Cannot read item from object
#define CRYPT_ERROR_WRITE       ( -42 )           ' Cannot write item to object
#define CRYPT_ERROR_NOTFOUND    ( -43 )           ' Requested item not found in object
#define CRYPT_ERROR_DUPLICATE   ( -44 )           ' Item already present in object

' Data enveloping errors

#define CRYPT_ENVELOPE_RESOURCE ( -50 )           ' Need resource to proceed

' Macros to examine return values

#define cryptStatusError(status)   ((status) < CRYPT_OK)
#define cryptStatusOK(status)      ((status) = CRYPT_OK)

'****************************************************************************
'*                                                                          *
'*                            General Functions                             *
'*                                                                          *
'****************************************************************************

' The following is necessary to stop C++ name mangling

#ifdef __FB_WIN32__
extern "Windows-MS"
#else
extern "C" ' Need to check this on a non-Windows system
#endif

' Initialise and shut down cryptlib

declare function cryptInit () as integer
declare function cryptEnd () as integer

' Query cryptlibs capabilities

declare function cryptQueryCapability (byval cryptAlgo as CRYPT_ALGO_TYPE, byval cryptQueryInfo as CRYPT_QUERY_INFO ptr) as integer

' Create and destroy an encryption context

declare function cryptCreateContext (byval cryptContext as CRYPT_CONTEXT ptr, byval cryptUser as CRYPT_USER, byval cryptAlgo as CRYPT_ALGO_TYPE) as integer
declare function cryptDestroyContext (byval cryptContext as CRYPT_CONTEXT) as integer

' Generic "destroy an object" function

declare function cryptDestroyObject (byval cryptObject as CRYPT_HANDLE) as integer

' Generate a key into a context

declare function cryptGenerateKey (byval cryptContext as CRYPT_CONTEXT) as integer
declare function cryptGenerateKeyAsync (byval cryptContext as CRYPT_CONTEXT) as integer
declare function cryptAsyncQuery (byval cryptObject as CRYPT_HANDLE) as integer
declare function cryptAsyncCancel (byval cryptObject as CRYPT_HANDLE) as integer

' Encrypt/decrypt/hash a block of memory

declare function cryptEncrypt (byval cryptContext as CRYPT_CONTEXT, byval buffer as any ptr, byval length as integer) as integer
declare function cryptDecrypt (byval cryptContext as CRYPT_CONTEXT, byval buffer as any ptr, byval length as integer) as integer

' Get/set/delete attribute functions

declare function cryptSetAttribute (byval cryptHandle as CRYPT_HANDLE, byval attributeType as CRYPT_ATTRIBUTE_TYPE, byval value as integer) as integer
declare function cryptSetAttributeString (byval cryptHandle as CRYPT_HANDLE, byval attributeType as CRYPT_ATTRIBUTE_TYPE, byval value as any ptr, byval valueLength as integer) as integer
declare function cryptGetAttribute (byval cryptHandle as CRYPT_HANDLE, byval attributeType as CRYPT_ATTRIBUTE_TYPE, byval value as integer ptr) as integer
declare function cryptGetAttributeString (byval cryptHandle as CRYPT_HANDLE, byval attributeType as CRYPT_ATTRIBUTE_TYPE, byval value as any ptr, byval valueLength as integer ptr) as integer
declare function cryptDeleteAttribute (byval cryptHandle as CRYPT_HANDLE, byval attributeType as CRYPT_ATTRIBUTE_TYPE) as integer

/' Oddball functions: Add random data to the pool, query an encoded signature
   or key data.  These are due to be replaced once a suitable alternative can
   be found '/

declare function cryptAddRandom (byval randomData as any ptr, byval randomDataLength as integer) as integer
declare function cryptQueryObject (byval objectData as any ptr, byval objectDataLength as integer, byval cryptObjectInfo as CRYPT_OBJECT_INFO ptr) as integer

'****************************************************************************
'*                                                                          *
'*                      Mid-level Encryption Functions                      *
'*                                                                          *
'****************************************************************************

' Export and import an encrypted session key

declare function cryptExportKey (byval encryptedKey as any ptr, byval encryptedKeyMaxLength as integer, byval encryptedKeyLength as integer ptr, byval exportKey as CRYPT_HANDLE, byval sessionKeyContext as CRYPT_CONTEXT) as integer
declare function cryptExportKeyEx (byval encryptedKey as any ptr, byval encryptedKeyMaxLength as integer, byval encryptedKeyLength as integer ptr, byval formatType as CRYPT_FORMAT_TYPE, byval exportKey as CRYPT_HANDLE, byval sessionKeyContext as CRYPT_CONTEXT) as integer
declare function cryptImportKey (byval encryptedKey as any ptr, byval encryptedKeyLength as integer, byval importKey as CRYPT_CONTEXT, byval sessionKeyContext as CRYPT_CONTEXT) as integer
declare function cryptImportKeyEx (byval encryptedKey as any ptr, byval encryptedKeyLength as integer, byval importKey as CRYPT_CONTEXT, byval sessionKeyContext as CRYPT_CONTEXT, byval returnedContext as CRYPT_CONTEXT ptr) as integer

' Create and check a digital signature

declare function cryptCreateSignature (byval signature as any ptr, byval signatureMaxLength as integer, byval signatureLength as integer ptr, byval signContext as CRYPT_CONTEXT, byval hashContext as CRYPT_CONTEXT) as integer
declare function cryptCreateSignatureEx (byval signature as any ptr, byval signatureMaxLength as integer, byval signatureLength as integer ptr, byval formatType as CRYPT_FORMAT_TYPE, byval signContext as CRYPT_CONTEXT, byval hashContext as CRYPT_CONTEXT, byval extraData as CRYPT_CERTIFICATE) as integer
declare function cryptCheckSignature (byval signature as any ptr, byval signatureLength as integer, byval sigCheckKey as CRYPT_HANDLE, byval hashContext as CRYPT_CONTEXT) as integer
declare function cryptCheckSignatureEx (byval signature as any ptr, byval signatureLength as integer, byval sigCheckKey as CRYPT_HANDLE, byval hashContext as CRYPT_CONTEXT, byval extraData as CRYPT_CERTIFICATE) as integer

'****************************************************************************
'*                                                                          *
'*                                  Keyset Functions                        *
'*                                                                          *
'****************************************************************************

' Open and close a keyset

declare function cryptKeysetOpen (byval keyset as CRYPT_KEYSET ptr, byval cryptUser as CRYPT_USER, byval keysetType as CRYPT_KEYSET_TYPE, byval name as zstring ptr, byval options as CRYPT_KEYOPT_TYPE) as integer
declare function cryptKeysetClose (byval keyset as CRYPT_KEYSET) as integer

' Get a key from a keyset or device

declare function cryptGetPublicKey (byval keyset as CRYPT_KEYSET, byval cryptContext as CRYPT_CONTEXT ptr, byval keyIDtype as CRYPT_KEYID_TYPE, byval keyID as zstring ptr) as integer
declare function cryptGetPrivateKey (byval keyset as CRYPT_KEYSET, byval cryptContext as CRYPT_CONTEXT ptr, byval keyIDtype as CRYPT_KEYID_TYPE, byval keyID as zstring ptr, byval password as zstring ptr) as integer
declare function cryptGetKey (byval keyset as CRYPT_KEYSET, byval cryptContext as CRYPT_CONTEXT ptr, byval keyIDtype as CRYPT_KEYID_TYPE, byval keyID as zstring ptr, byval password as zstring ptr) as integer

' Add/delete a key to/from a keyset or device

declare function cryptAddPublicKey (byval keyset as CRYPT_KEYSET, byval certificate as CRYPT_CERTIFICATE) as integer
declare function cryptAddPrivateKey (byval keyset as CRYPT_KEYSET, byval cryptKey as CRYPT_HANDLE, byval password as zstring ptr) as integer
declare function cryptDeleteKey (byval keyset as CRYPT_KEYSET, byval keyIDtype as CRYPT_KEYID_TYPE, byval keyID as zstring ptr) as integer

'****************************************************************************
'*                                                                          *
'*                              Certificate Functions                       *
'*                                                                          *
'****************************************************************************

' Create/destroy a certificate

declare function cryptCreateCert (byval certificate as CRYPT_CERTIFICATE ptr, byval cryptUser as CRYPT_USER, byval certType as CRYPT_CERTTYPE_TYPE) as integer
declare function cryptDestroyCert (byval certificate as CRYPT_CERTIFICATE) as integer

/' Get/add/delete certificate extensions.  These are direct data insertion
   functions whose use is discouraged, so they fix the string at char *
   rather than C_STR '/

declare function cryptGetCertExtension (byval certificate as CRYPT_CERTIFICATE, byval oid as zstring ptr, byval criticalFlag as integer ptr, byval extension as any ptr, byval extensionMaxLength as integer, byval extensionLength as integer ptr) as integer
declare function cryptAddCertExtension (byval certificate as CRYPT_CERTIFICATE, byval oid as zstring ptr, byval criticalFlag as integer, byval extension as any ptr, byval extensionLength as integer) as integer
declare function cryptDeleteCertExtension (byval certificate as CRYPT_CERTIFICATE, byval oid as zstring ptr) as integer

' Sign/sig.check a certificate/certification request

declare function cryptSignCert (byval certificate as CRYPT_CERTIFICATE, byval signContext as CRYPT_CONTEXT) as integer
declare function cryptCheckCert (byval certificate as CRYPT_CERTIFICATE, byval sigCheckKey as CRYPT_HANDLE) as integer

' Import/export a certificate/certification request

declare function cryptImportCert (byval certObject as any ptr, byval certObjectLength as integer, byval cryptUser as CRYPT_USER, byval certificate as CRYPT_CERTIFICATE ptr) as integer
declare function cryptExportCert (byval certObject as any ptr, byval certObjectMaxLength as integer, byval certObjectLength as integer ptr, byval certFormatType as CRYPT_CERTFORMAT_TYPE, byval certificate as CRYPT_CERTIFICATE) as integer

' CA management functions

declare function cryptCAAddItem (byval keyset as CRYPT_KEYSET, byval certificate as CRYPT_CERTIFICATE) as integer
declare function cryptCAGetItem (byval keyset as CRYPT_KEYSET, byval certificate as CRYPT_CERTIFICATE ptr, byval certType as CRYPT_CERTTYPE_TYPE, byval keyIDtype as CRYPT_KEYID_TYPE, byval keyID as zstring ptr) as integer
declare function cryptCADeleteItem (byval keyset as CRYPT_KEYSET, byval certType as CRYPT_CERTTYPE_TYPE, byval keyIDtype as CRYPT_KEYID_TYPE, byval keyID as zstring ptr) as integer
declare function cryptCACertManagement (byval certificate as CRYPT_CERTIFICATE ptr, byval action as CRYPT_CERTACTION_TYPE, byval keyset as CRYPT_KEYSET, byval caKey as CRYPT_CONTEXT, byval certRequest as CRYPT_CERTIFICATE) as integer

'****************************************************************************
'*                                                                          *
'*                          Envelope and Session Functions                  *
'*                                                                          *
'****************************************************************************

' Create/destroy an envelope

declare function cryptCreateEnvelope (byval envelope as CRYPT_ENVELOPE ptr, byval cryptUser as CRYPT_USER, byval formatType as CRYPT_FORMAT_TYPE) as integer
declare function cryptDestroyEnvelope (byval envelope as CRYPT_ENVELOPE) as integer

' Create/destroy a session

declare function cryptCreateSession (byval session as CRYPT_SESSION ptr, byval cryptUser as CRYPT_USER, byval formatType as CRYPT_SESSION_TYPE) as integer
declare function cryptDestroySession (byval session as CRYPT_SESSION) as integer

' Add/remove data to/from and envelope or session

declare function cryptPushData (byval envelope as CRYPT_HANDLE, byval buffer as any ptr, byval length as integer, byval bytesCopied as integer ptr) as integer
declare function cryptFlushData (byval envelope as CRYPT_HANDLE) as integer
declare function cryptPopData (byval envelope as CRYPT_HANDLE, byval buffer as any ptr, byval length as integer, byval bytesCopied as integer ptr) as integer

'****************************************************************************
'*                                                                          *
'*                              Device Functions                            *
'*                                                                          *
'****************************************************************************

' Open and close a device

declare function cryptDeviceOpen (byval device as CRYPT_DEVICE ptr, byval cryptUser as CRYPT_USER, byval deviceType as CRYPT_DEVICE_TYPE, byval name as zstring ptr) as integer
declare function cryptDeviceClose (byval device as CRYPT_DEVICE) as integer

' Query a devices capabilities

declare function cryptDeviceQueryCapability (byval device as CRYPT_DEVICE, byval cryptAlgo as CRYPT_ALGO_TYPE, byval cryptQueryInfo as CRYPT_QUERY_INFO ptr) as integer

' Create an encryption context via the device

declare function cryptDeviceCreateContext (byval device as CRYPT_DEVICE, byval cryptContext as CRYPT_CONTEXT ptr, byval cryptAlgo as CRYPT_ALGO_TYPE) as integer

'****************************************************************************
'*                                                                          *
'*                          User Management Functions                       *
'*                                                                          *
'****************************************************************************

' Log on and off (create/destroy a user object)

declare function cryptLogin (byval user as CRYPT_USER ptr, byval name as zstring ptr, byval password as zstring ptr) as integer
declare function cryptLogout (byval user as CRYPT_USER) as integer

'****************************************************************************
'*                                                                          *
'*                          User Interface Functions                        *
'*                                                                          *
'****************************************************************************

#if defined(__FB_WIN32__) and (not defined(cryptlibNoWindowsFunctions))

' User interface functions, only available under Win32

declare function cryptUIGenerateKey (byval cryptDevice as CRYPT_DEVICE, byval cryptContext as CRYPT_CONTEXT ptr, byval cryptCert as CRYPT_CERTIFICATE, byval password as zstring ptr, byval hWnd as HWND) as integer
declare function cryptUIDisplayCert (byval cryptCert as CRYPT_CERTIFICATE, byval hWnd as HWND) as integer

#endif ' Win32

end extern

#endif ' _CRYPTLIB_DEFINED
