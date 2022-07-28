#!/bin/sh

NombreCrypto="curso"
MainPort="4333"
TestnetPort="4332"
FirstKeyAddressMain="C"
FirstKeyAddressTest="c"

# Funcion que devuelve la codificacion del numero correspondiente a la primer letra de la billetera
TablaBTC()
{
	case $1 in
		"1")
			return $((0))
			;;
		"2")
			return $((3))
			;;
		"3")
			return $((5))
			;;
		"4")
			return $((8))
			;;
		"5")
			return $((10))
			;;
		"6")
			return $((13))
			;;
		"7")
			return $((15))
			;;
		"8")
			return $((18))
			;;
		"9")
			return $((20))
			;;
		"A")
			return $((23))
			;;
		"B")
			return $((25))
			;;
		"C")
			return $((28))
			;;
		"D")
			return $((30))
			;;
		"E")
			return $((33))
			;;
		"F")
			return $((35))
			;;
		"G")
			return $((38))
			;;
		"H")
			return $((40))
			;;
		"J")
			return $((43))
			;;
		"K")
			return $((45))
			;;
		"L")
			return $((48))
			;;
		"M")
			return $((50))
			;;
		"N")
			return $((53))
			;;
		"P")
			return $((55))
			;;
		"Q")
			return $((58))
			;;
		"R")
			return $((60))
			;;
		"S")
			return $((63))
			;;
		"T")
			return $((65))
			;;
		"U")
			return $((68))
			;;
		"V")
			return $((70))
			;;
		"W")
			return $((73))
			;;
		"X")
			return $((75))
			;;
		"Y")
			return $((78))
			;;
		"Z")
			return $((80))
			;;
		"a")
			return $((83))
			;;
		"b")
			return $((85))
			;;
		"c")
			return $((88))
			;;
		"d")
			return $((90))
			;;
		"e")
			return $((93))
			;;
		"f")
			return $((95))
			;;
		"g")
			return $((98))
			;;
		"h")
			return $((100))
			;;
		"i")
			return $((103))
			;;
		"j")
			return $((105))
			;;
		"k")
			return $((108))
			;;
		"m")
			return $((110))
			;;
		"n")
			return $((113))
			;;
		"o")
			return $((115))
			;;
		"p")
			return $((118))
			;;
		"q")
			return $((120))
			;;
		"r")
			return $((123))
			;;
		"s")
			return $((125))
			;;
		"t")
			return $((128))
			;;
		"u")
			return $((130))
			;;
		"v")
			return $((133))
			;;
		"w")
			return $((135))
			;;
		"x")
			return $((138))
			;;
		"y")
			return $((140))
			;;
		"z")
			return $((143))
			;;
		esac
}


MagicGenerator()
{
	sleep 1
	RANDOM=$(date +%s)
	R1=$(( $RANDOM % 16 ))
	O=$(( $RANDOM % 37 ))
	A=$(($R1*7+$O))
	A=$(( $A % 16 ))
	RANDOM=$(( $RANDOM + $A ))

	R2=$(( $RANDOM % 16 ))
	O=$(( $RANDOM % 37 ))
	A=$(($R2*11+$O))
	A=$(( $A % 16 ))
	RANDOM=$(( $RANDOM + $A ))

	R3=$(( $RANDOM % 16 ))
	O=$(( $RANDOM % 37 ))
	A=$(($R3*13+$O))
	A=$(( $A % 16 ))
	RANDOM=$(( $RANDOM + $A ))
	R4=$(( $RANDOM % 16 ))
	O=$(( $R4 % 5 ))

	sleep $O
	case $1 in
		"1")	
			hexa=$R1
			;;
		"2")	
			hexa=$R2
			;;
		"3")	
			hexa=$R3
			;;
		"4")	
			hexa=$R4
			;;
	esac

	return $(($hexa))
}

cd
cd Desktop/
cd $NombreCrypto
find . -type f -print0 | xargs -0 sed -i 's/9333/'$MainPort'/g'
find . -type f -print0 | xargs -0 sed -i 's/9332/'$TestnetPort'/g'
cd src/
TablaBTC  $FirstKeyAddressMain
Letra=$?
sed -i 's/PUBKEY_ADDRESS = 48/PUBKEY_ADDRESS = '$Letra'/g' base58.h
TablaBTC  $FirstKeyAddressTest
Letra=$?
sed -i 's/PUBKEY_ADDRESS_TEST = 111/PUBKEY_ADDRESS_TEST = '$Letra'/g' base58.h
cd
cd Desktop/
openssl ecparam -genkey -name secp256k1 -out alertkey.pem
openssl ec -in alertkey.pem -text > alertkey.hex
openssl ecparam -genkey -name secp256k1 -out testnetalert.pem
openssl ec -in testnetalert.pem -text > testnetalert.hex
openssl ecparam -genkey -name secp256k1 -out genesiscoinbase.pem
openssl ec -in genesiscoinbase.pem -text > genesiscoinbase.hex
sleep 2

cd /opt/lampp/htdocs/CreateCoin
rm -f *.txt 
sleep 2
cd
cd Desktop/
cd $NombreCrypto
cd src/

/usr/bin/firefox http://localhost/CreateCoin/decoding.php?archivo=alertkey &
sleep 10
PublicKey=$(cat /opt/lampp/htdocs/CreateCoin/alertkey.txt)
sed -i 's/040184710fa689ad5023690c80f3a49c8f13f8d45b8c857fbcbc8bc4a8e4d3eb4b10f4d4604fa08dce601aaf0f470216fe1b51850b4acf21b179c45070ac7b03a9/'$PublicKey'/g' alert.cpp

/usr/bin/firefox http://localhost/CreateCoin/decoding.php?archivo=testnetalert &
sleep 10
PublicKey=$(cat /opt/lampp/htdocs/CreateCoin/testnetalert.txt)
sed -i 's/04302390343f91cc401d56d68b123028bf52e5fca1939df127f63c6467cdf9c8e2c14b61104cf817d0b780da337893ecc4aaff1309e536162dabbdb45200ca2b0a/'$PublicKey'/g' alert.cpp

/usr/bin/firefox http://localhost/CreateCoin/decoding.php?archivo=genesiscoinbase &
sleep 10
PublicKey=$(cat /opt/lampp/htdocs/CreateCoin/genesiscoinbase.txt)
sed -i 's/040184710fa689ad5023690c80f3a49c8f13f8d45b8c857fbcbc8bc4a8e4d3eb4b10f4d4604fa08dce601aaf0f470216fe1b51850b4acf21b179c45070ac7b03a9/'$PublicKey'/g' main.cpp


MagicGenerator "1"
Magic=$?
Magic1=$(echo "obase=16; ibase16=10; $Magic" | bc)
MagicGenerator "2"
Magic=$?
Magic2=$(echo "obase=16; ibase16=10; $Magic" | bc)
MagicGenerator "3"
Magic=$?
Magic3=$(echo "obase=16; ibase16=10; $Magic" | bc)
MagicGenerator "4"
Magic=$?
Magic0=$(echo "obase=16; ibase16=10; $Magic" | bc)
pchMessageStart0="0xf"
pchMessageStart1="0xc"
pchMessageStart2="0xb"
pchMessageStart3="0xd"
pchMessageStart0=$(echo $pchMessageStart0$Magic0 |tr [[:upper:]] [[:lower:]] )
echo $pchMessageStart0
pchMessageStart1=$(echo $pchMessageStart1$Magic1 |tr [[:upper:]] [[:lower:]] )
echo $pchMessageStart1
pchMessageStart2=$(echo $pchMessageStart2$Magic2 |tr [[:upper:]] [[:lower:]] )
echo $pchMessageStart2
pchMessageStart3=$(echo $pchMessageStart3$Magic3 |tr [[:upper:]] [[:lower:]] )
echo $pchMessageStart3
sed -i 's/0xfc/'$pchMessageStart0'/g' main.cpp
sed -i 's/0xc1/'$pchMessageStart1'/g' main.cpp
sed -i 's/0xb7/'$pchMessageStart2'/g' main.cpp
sed -i 's/0xdc/'$pchMessageStart3'/g' main.cpp

#Aca termine hoy 21 de junio en el video 2 de aqua minuto 8.24

Magic=$(( $Magic + 3 ))
Magic=$(( $Magic % 16 ))
Magic0=$(echo "obase=16; ibase16=10; $Magic" | bc)
MagicGenerator "1"
Magic=$?
Magic1=$(echo "obase=16; ibase16=10; $Magic" | bc)
MagicGenerator "2"
Magic=$?
Magic2=$(echo "obase=16; ibase16=10; $Magic" | bc)
MagicGenerator "3"
Magic=$?
Magic3=$(echo "obase=16; ibase16=10; $Magic" | bc)
pchMessageStart0="0xf"
pchMessageStart1="0xc"
pchMessageStart2="0xb"
pchMessageStart3="0xd"
pchMessageStart0=$(echo $pchMessageStart0$Magic0 |tr [[:upper:]] [[:lower:]] )
echo $pchMessageStart0
pchMessageStart1=$(echo $pchMessageStart1$Magic1 |tr [[:upper:]] [[:lower:]] )
echo $pchMessageStart1
pchMessageStart2=$(echo $pchMessageStart2$Magic2 |tr [[:upper:]] [[:lower:]] )
echo $pchMessageStart2
pchMessageStart3=$(echo $pchMessageStart3$Magic3 |tr [[:upper:]] [[:lower:]] )
echo $pchMessageStart3
sed -i 's/0xfb/'$pchMessageStart0'/g' main.cpp
sed -i 's/0xc0/'$pchMessageStart1'/g' main.cpp
sed -i 's/0xb6/'$pchMessageStart2'/g' main.cpp
sed -i 's/0xdb/'$pchMessageStart3'/g' main.cpp


#borramos hardcoded dns adresses (line 1187 net.cpp tiene que quedar solo null, null)

sed -i 's/{"'$NombreCrypto'tools.com", "dnsseed.'$NombreCrypto'tools.com"},//g' net.cpp
sed -i 's/{"'$NombreCrypto'pool.org", "dnsseed.'$NombreCrypto'pool.org"},//g' net.cpp
sed -i 's/{"xurious.com", "dnsseed.ltc.xurious.com"},//g' net.cpp
sed -i 's/{"koin-project.com", "dnsseed.koin-project.com"},//g' net.cpp
sed -i 's/{"weminemnc.com", "dnsseed.weminemnc.com"},//g' net.cpp

sed -i 's/{"'$NombreCrypto'tools.com", "testnet-seed.'$NombreCrypto'tools.com"},//g' net.cpp
sed -i 's/{"xurious.com", "testnet-seed.ltc.xurious.com"},//g' net.cpp
sed -i 's/{"wemine-testnet.com", "dnsseed.wemine-testnet.com"},//g' net.cpp


#borramos hardcoded IP adresses (line 1236 net.cpp tiene que quedar solo null, null)

sed -i 's/0x38a9b992, 0x73d4f3a2, 0x43eda52e, 0xa1c4a2b2, 0x73c41955, 0x6992f3a2, 0x729cb992, 0x8b53b205,//g' net.cpp
sed -i 's/0xb651ec36, 0x8b422e4e, 0x0fe421b2, 0x83c1a2b2, 0xbd432705, 0x2e11b018, 0x281544c1, 0x8b72f3a2,//g' net.cpp
sed -i 's/0xb934555f, 0x2ba02e4e, 0x6ab7c936, 0x8728555f, 0x03bfd143, 0x0a73df5b, 0xcd2b5a50, 0x746df3a2,//g' net.cpp
sed -i 's/0x7481bb25, 0x6f4d4550, 0x78582f4e, 0xa03a0f46, 0xe8b0e2bc, 0xa2d17042, 0x718a09b0, 0xdaffd4a2,//g' net.cpp
sed -i 's/0xbb1a175e, 0xb21f09b0, 0xb5549bc0, 0xe404c755, 0x95d882c3, 0xfff3692e, 0x3777d9c7, 0x425b2746,//g' net.cpp
sed -i 's/0x497990c6, 0xb2782dcc, 0xf9352225, 0xa75cd443, 0x4c05fb94, 0x44c91c2e, 0x47c6a5bc, 0xd606fb94,//g' net.cpp
sed -i 's/0xc1b9e2bc, 0x32acd23e, 0x89560da2, 0x5bebdad8, 0x3a210e08, 0xbdc5795b, 0xcc86bb25, 0xbe9f28bc,//g' net.cpp
sed -i 's/0xef3ff3a2, 0xca29df59, 0xe4fd175e, 0x1f3eaa6b, 0xacdbaa6b, 0xb05f042e, 0x81ed6cd8, 0x9a3c0cc3,//g' net.cpp
sed -i 's/0x4200175e, 0x5a017ebc, 0x42ef4c90, 0x8abfd143, 0x24fbf3a2, 0x140846a6, 0x4f7d9553, 0xeea5d151,//g' net.cpp
sed -i 's/0xe67c0905, 0x52d8048e, 0xcabd2e4e, 0xe276692e, 0x07dea445, 0xdde3f3a2, 0x6c47bb25, 0xae0efb94,//g' net.cpp

sed -i 's/0xf5e15a51, 0xaebdd25b, 0xf341175e, 0x46532705, 0xc47728bc, 0xe4e14c90, 0x9dc8f752, 0x050c042e,//g' net.cpp
sed -i 's/0x1c84bb25, 0x4f163b25, 0x1a017ebc, 0xa5282e4e, 0x8c667e60, 0xc7113b25, 0xf0b44832, 0xf1a134d0,//g' net.cpp
sed -i 's/0x973212d4, 0xd35cbb25, 0xd5123b25, 0x68220254, 0x7ad43e32, 0x9268e32e, 0xdf143b25, 0xaf04c436,//g' net.cpp
sed -i 's/0xaded0051, 0xfa86d454, 0x09db048e, 0x26003b25, 0x58764c90, 0x9a2f555f, 0x0c24ec97, 0x92123b25,//g' net.cpp
sed -i 's/0x0526d35f, 0x17db048e, 0xd2e42f4e, 0x38cca5bc, 0xc6320ab9, 0xe28ac836, 0xc560aa6b, 0xa5c16041,//g' net.cpp
sed -i 's/0x70a6f1c0, 0x011ec8c1, 0xd6e9c332, 0x131263c0, 0xa15a4450, 0xef218abc, 0x2729f948, 0x02835443,//g' net.cpp
sed -i 's/0x5614336c, 0xb12aacb2, 0xe368aa6b, 0x3cc6ffad, 0x36206494, 0x2c90e9c1, 0x32bb53d4, 0xca03de5c,//g' net.cpp
sed -i 's/0x775c1955, 0x19ef1ba3, 0x0b00dc1f, 0x244d0f40, 0x54d9e2bc, 0x25ced152, 0x967b03ad, 0x951c555f,//g' net.cpp
sed -i 's/0x4c3f3b25, 0x13f6f3a2, 0x17fca5bc, 0x0e2d306c, 0xacd8764b, 0xca230bcc, 0x8569d3c6, 0x3264d8a2,//g' net.cpp
sed -i 's/0xe8630905, 0x25e02a64, 0x3aba1fb0, 0x6bbdd25b, 0xee9a4c90, 0xcda25982, 0x8b3e804e, 0xf043fb94,//g' net.cpp

sed -i 's/0x4b05fb94, 0x0c44c052, 0xf403f45c, 0x4333aa6b, 0xc193484d, 0x3fbf5d4c, 0x0bd7f74d, 0x150e3fb2,//g' net.cpp
sed -i 's/0x8e2eddb0, 0x09daf150, 0x8a67c7c6, 0x22a9e52e, 0x05cff476, 0xc99b2f4e, 0x0f183b25, 0xd0358953,//g' net.cpp
sed -i 's/0x20f232c6, 0x0ce9e217, 0x09f55d18, 0x0555795b, 0x5ed2fa59, 0x2ec85917, 0x2bf61fb0, 0x024ef54d,//g' net.cpp
sed -i 's/0x3c53b859, 0x441cbb25, 0x50c8aa6b, 0x1b79175e, 0x3125795b, 0x27fc1fb0, 0xbcd53e32, 0xfc781718,//g' net.cpp
sed -i 's/0x7a8ec345, 0x1da6985d, 0x34bd1f32, 0xcb00edcf, 0xf9a5fdce, 0x21ccdbac, 0xb7730118, 0x6a43f6cc,//g' net.cpp
sed -i 's/0x6e65e262, 0x21ca1f3d, 0x10143b25, 0xc8dea132, 0xaf076693, 0x7e431bc6, 0xaa3df5c6, 0x44f0c536,//g' net.cpp
sed -i 's/0xeea80925, 0x262371d4, 0xc85c895b, 0xa6611bc6, 0x1844e47a, 0x49084c90, 0xf3d95157, 0x63a4a844,//g' net.cpp
sed -i 's/0x00477c70, 0x2934d35f, 0xe8d24465, 0x13df88b7, 0x8fcb7557, 0xa591bd5d, 0xc39453d4, 0xd5c49452,//g' net.cpp
sed -i 's/0xc8de1a56, 0x3cdd0608, 0x3c147a55, 0x49e6cf4a, 0xb38c8705, 0x0bef3479, 0x01540f48, 0xd9c3ec57,//g' net.cpp
sed -i 's/0xed6d4c90, 0xa529fb94, 0xe1c81955, 0xfde617c6, 0x72d18932, 0x9d61bb6a, 0x6d5cb258, 0x27c7d655,//g' net.cpp

sed -i 's/0xc5644c90, 0x31fae3bc, 0x3afaf25e, 0x98efe2bc, 0x91020905, 0xb566795b, 0xaf91bd5d, 0xb164d655,//g' net.cpp
sed -i 's/0x72eb47d4, 0xae62f3a2, 0xb4193b25, 0x0613fb94, 0xa6db048e, 0xf002464b, 0xc15ebb6a, 0x8a51f3a2,//g' net.cpp
sed -i 's/0x485e2ed5, 0x119675a3, 0x1f3f555f, 0x39dbc082, 0x09dea445, 0x74382446, 0x3e836c4e, 0x6e43f6cc,//g' net.cpp
sed -i 's/0x134dd9a2, 0x5876f945, 0x3516f725, 0x670c81d4, 0xaf7f170c, 0xb0e31155, 0xe271894e, 0x615e175e,//g' net.cpp
sed -i 's/0xb3446fd0, 0x13d58ac1, 0x07cff476, 0xe601e405, 0x8321277d, 0x0997548d, 0xdb55336c, 0xa1271d73,//g' net.cpp
sed -i 's/0x582463c0, 0xc2543025, 0xf6851c73, 0xe75d32ae, 0xf916b4dd, 0xf558fb94, 0x52111d73, 0x2bc8615d,//g' net.cpp
sed -i 's/0xd4dcaf42, 0x65e30979, 0x2e1b2360, 0x0da01d73, 0x3f1263c0, 0xd15c735d, 0x9cf2134c, 0x20d0048e,//g' net.cpp
sed -i 's/0x48cf0125, 0xf585bf5d, 0x12d7645e, 0xd5ace2bc, 0x0c6220b2, 0xbe13bb25, 0x88d0a52e, 0x559425b0,//g' net.cpp
sed -i 's/0x24079e3d, 0xfaa37557, 0xf219b96a, 0x07e61e4c, 0x3ea1d295, 0x24e0d852, 0xdde212df, 0x44c37758,//g' net.cpp
sed -i 's/0x55c243a4, 0xe77dd35f, 0x10c19a5f, 0x14d1048e, 0x1d50fbc6, 0x1570456c, 0x567c692e, 0x641d6d5b,//g' net.cpp

sed -i 's/0xab0c0cc6, 0xab6803c0, 0x136f21b2, 0x6a72545d, 0x21d031b2, 0xff8b5fad, 0xfd0096b2, 0x5f469ac3,//g' net.cpp
sed -i 's/0x3f6ffa62, 0x7501f863, 0x48471f60, 0xcccff3a2, 0x7f772e44, 0xc1de7757, 0x0c94c3cb, 0x620ac658,//g' net.cpp
sed -i 's/0x520f1d25, 0x37366c5f, 0x7594b159, 0x3804f23c, 0xb81ff054, 0x96dd32c6, 0x928228bc, 0xf4006e41,//g' net.cpp
sed -i 's/0x0241c244, 0x8dbdf243, 0x26d1b247, 0xd5381c73, 0xf3136e41, 0x4afa9bc0, 0xa3abf8ce, 0x464ce718,//g' net.cpp
sed -i 's/0xbd9d017b, 0xf4f26132, 0x141b32d4, 0x2ec50c18, 0x4df119d9, 0x93f81772, 0xd9607c70, 0x3522b648,//g' net.cpp
sed -i 's/0xf2006e41, 0x761fe550, 0x40104836, 0x55dffe96, 0xc45db158, 0xe75e4836, 0x8dfab7ad, 0xe3eff3a2,//g' net.cpp
sed -i 's/0x6a6eaa6b, 0x2177d9c7, 0x724ce953, 0xafe918b9, 0xf9368a55, 0xdc0a555f, 0xa4b2d35f, 0x4d87b0b8,//g' net.cpp
sed -i 's/0x93496a54, 0x5a5c967b, 0xd47028bc, 0x3c44e47a, 0x11c363c0, 0x28107c70, 0xb756a558, 0xb82bbb6a,//g' net.cpp
sed -i 's/0x285d49ad, 0x3b0ce85c, 0xe53eb45f, 0xa836e23c, 0x409f63c0, 0xc80fbd44, 0x3447f677, 0xe4ca983b,//g' net.cpp
sed -i 's/0x20673774, 0x96471ed9, 0x4c1d09b0, 0x91d5685d, 0x55beec4d, 0x1008be48, 0x660455d0, 0xf8170fda,//g' net.cpp

sed -i 's/0x3c21dd3a, 0x8239bb36, 0x9fe7e2bc, 0x900c47ae, 0x6a355643, 0x03dcb318, 0xefca123d, 0x6af8c4d9,//g' net.cpp
sed -i 's/0x5195e1a5, 0x32e89925, 0x0adc51c0, 0x45d7164c, 0x02495177, 0x8131175e, 0x681b5177, 0x41b6aa6b,//g' net.cpp
sed -i 's/0x55a9603a, 0x1a0c1c1f, 0xdb4da043, 0x3b9b1632, 0x37e08368, 0x8b54e260, 0xcd14d459, 0x82a663c0,//g' net.cpp
sed -i 's/0x05adc7dd, 0xe683f3a2, 0x4cddb150, 0x67a1a62e, 0x8c0acd25, 0x07f01f3e, 0x3111296c, 0x2d0fda2e,//g' net.cpp
sed -i 's/0xa4f163c0, 0xca6db982, 0x78ed2359, 0x7eaa21c1, 0x62e4f3a2, 0x50b81d73, 0xcd074a3a, 0xcb2d904b,//g' net.cpp
sed -i 's/0x9b3735ce, 0xab67f25c, 0xa0eb5036, 0x62ae5344, 0xe2569bb2, 0xc4422e4e, 0xab5ec8d5, 0xaa81e8dd,//g' net.cpp
sed -i 's/0xa39264c6, 0xf391563d, 0xb79bbb25, 0x174a7857, 0x0fd4aa43, 0x3e158c32, 0x3ae8b982, 0xea342225,//g' net.cpp
sed -i 's/0x48d1a842, 0xa52bf0da, 0x4bcb4a4c, 0xa6d3c15b, 0x49a0d35f, 0x97131b4c, 0xf197e252, 0xfe3ebd18,//g' net.cpp
sed -i 's/0x156dacb8, 0xf63328bc, 0x8e95b84c, 0x560455d0, 0xee918c4e, 0x1d3e435f, 0xe1292f50, 0x0f1ec018,//g' net.cpp
sed -i 's/0x7d70c60e, 0x6a29d5be, 0xf5fecb18, 0xd6da1f63, 0xccce1c2e, 0x7a289f5e, 0x2775ae47, 0x696df560,//g' net.cpp

sed -i 's/0x4dbe00ae, 0x474e6c5c, 0x604141d5, 0xaed0c718, 0x8acfd23e, 0x7ff4b84c, 0x4b44fc60, 0xdf58aa4f,//g' net.cpp
sed -i 's/0x9b7440c0, 0xb811c854, 0xd90ec24e, 0xcff75c46, 0xa5a9cc57, 0xb3d21e4c, 0x794779d9, 0xe5613d46,//g' net.cpp
sed -i 's/0x9478be43, 0xc5d11152, 0xe85fbb6a, 0x3e1ed052, 0xf747e418, 0x3b9c61c2, 0xb2532949, 0x43077432,//g' net.cpp
sed -i 's/0xa3db0b68, 0xb3b6e35a, 0x70361b6c, 0x3a8bad3e, 0x23079e3d, 0x09314c32, 0x92f90053, 0x4fc31955,//g' net.cpp
sed -i 's/0xa59b0905, 0x924128bc, 0x4e63c444, 0x344dc236, 0x43055fcb, 0xdc1a1c73, 0x38aaaa6b, 0xa61cf554,//g' net.cpp
sed -i 's/0x6d8f63c0, 0x24800a4c, 0x2406f953, 0x9558bb6a, 0x1d281660, 0x054c4954, 0x2de4d418, 0x5fdaf043,//g' net.cpp
sed -i 's/0xb681356c, 0xf8c3febc, 0x8854f950, 0x55b45d32, 0xde07bcd1, 0x156e4bda, 0x924cf718, 0xc34a0d47,//g' net.cpp
sed -i 's/0xdd5e1c45, 0x4a0d63c0, 0xaf4b88d5, 0x7852b958, 0x6f205fc0, 0x838af043, 0x45ac795b, 0x43bbaa6b,//g' net.cpp
sed -i 's/0x998d1c73, 0x11c1d558, 0x749ec444, 0x9a38c232, 0xad2f8c32, 0x3446c658, 0x8fe7a52e, 0x4e846b61,//g' net.cpp
sed -i 's/0x064b2d05, 0x0fd09740, 0x7a81a743, 0xf1f08e3f, 0x35ca1967, 0x24bdb17d, 0x144c2d05, 0x5505bb46,//g' net.cpp

sed -i 's/0x13fd1bb9, 0x25de2618, 0xc80a8b4b, 0xcec0fd6c, 0xdc30ad4c, 0x4009f3a2, 0x472f3fb2, 0x5e69c936,//g' net.cpp
sed -i 's/0x0380796d, 0xa463f8a2, 0xa46fbdc7, 0x3b0cc547, 0xb6644f46, 0x4b90fc47, 0x39e3f563, 0x72d81e56,//g' net.cpp
sed -i 's/0xe177d9c7, 0x95bff743, 0xea985542, 0xc210ec55, 0xeef70b67, 0xc9eb175e, 0x844d38ad, 0x65afa247,//g' net.cpp
sed -i 's/0x72da6d26, 0xed165dbc, 0xe8c83ad0, 0x9a8f37d8, 0x925adf50, 0x6b6ac162, 0x4b969e32, 0x735e1c45,//g' net.cpp
sed -i 's/0x4423ff60, 0xfa57ec6d, 0xcde2fb65, 0x11093257, 0x4748cd5b, 0x720c03dd, 0x8c7b0905, 0xba8b2e48/0x0/g' net.cpp


cd
cd Desktop/
./script3.sh





















