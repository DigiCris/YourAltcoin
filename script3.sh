#!/bin/sh

NombreCrypto="curso"
RecompensaInicial="10"
BloquesParaHalving="5"
RecalculaDificultadEnDias="1"
MinutosParaMinarBloque="1" # tiempo para el halving se calcula -> $MinutosParaMinarBloque x $BloquesParaHalving
Nota="La Inve vuelve a 4 dolares" 
#sacarlas del NY timeshttps://www.nytimes.com/section/business/economy
Periodico="NY Times" 

Dia="19"
Mes="May"
Anio="2022"



MaximumMoney="100" # 2 x $BloquesParaHalving x $RecompensaInicial
Maturity="5"
BloquesRecalcularDificultad="1440" # ($RecalculaDificultadEnDias x 24 x 60)/$MinutosParaMinarBloque


cd
cd Desktop/
cd $NombreCrypto
cd src/


#Cambios en main.cpp
sed -i 's/ 50 / '$RecompensaInicial' /g' main.cpp
sed -i 's/840000/'$BloquesParaHalving'/g' main.cpp
sed -i 's/3.5/'$RecalculaDificultadEnDias'/g' main.cpp
sed -i 's/2.5/'$MinutosParaMinarBloque'/g' main.cpp
sed -i 's/ 05/ '$Dia'/g' main.cpp
sed -i 's/Oct/'$Mes'/g' main.cpp
sed -i "s/Steve Jobs, Apple’s Visionary, Dies at 56/$Nota/g" main.cpp
sed -i "s/NY Times/$Periodico/g" main.cpp

timestamp=$(date +%s)
sed -i 's/1317798646/'$timestamp'/g' main.cpp
timestamp=$(( $timestamp % 16 ))
sleep $timestamp
timestamp=$(date +%s)
sed -i 's/1317972665/'$timestamp'/g' main.cpp

#Cambios en main.cpp
sed -i 's/84000000/'$MaximumMoney'/g' main.h
sed -i 's/COINBASE_MATURITY = 100/COINBASE_MATURITY = '$Maturity'/g' main.h
sed -i "s/ 576 / $BloquesRecalcularDificultad /g" main.h

#Compilar
make -f makefile.unix

#Para que de core dumped y sacar markleroot
./$NombreCrypto'd'
#LLego al core dumped aca 

#Copio el hashMerkleRoot generado por el core dumped anterior en el log a la linea 2907 del main.cpp
cd
cd Desktop/
cd $NombreCrypto
cd src/
rm -rf /opt/lampp/htdocs/CreateCoin/copias
mkdir /opt/lampp/htdocs/CreateCoin/copias
cp /home/ubuntu/.$NombreCrypto/debug.log /opt/lampp/htdocs/CreateCoin/copias/hashMerkleRoot.hex
chmod 777 /opt/lampp/htdocs/CreateCoin/copias/hashMerkleRoot.hex
/usr/bin/firefox http://localhost/CreateCoin/mhash.php?archivo=hashMerkleRoot &
sleep 2
hashMerkleRoot=$(cat /opt/lampp/htdocs/CreateCoin/hashMerkleRoot.txt)
sed -i 's/"0x"/'$hashMerkleRoot'/g' main.cpp
#Habilito el minado genesis
sed -i 's/if (false/if (true/g' main.cpp

#borro main genesis hash
sed -i 's/0x12a765e31ffd4059bada1e25190f6e98c99d9714d334efa41a195a7e7e04bfe2/0x  /g' main.cpp
#para buscarlos luego y completarlos empezar por el main que tiene dos espacios /0x  / y luego por el testnet con solo un espacio /0x /

#Compilar
make -f makefile.unix

#Genero genesis hash y nonce del main
./$NombreCrypto'd'


#Copio el main genesis hash generado por el core dumped anterior en la linea 38 y el nonce en 2796 del main.cpp
	# entro en carpeta
cd
cd Desktop/
cd $NombreCrypto
cd src/
	# Genero mainhash.txt y mainnonce.txt
cp /home/ubuntu/.$NombreCrypto/debug.log /opt/lampp/htdocs/CreateCoin/copias/maingenesishash.hex
chmod 777 /opt/lampp/htdocs/CreateCoin/copias/maingenesishash.hex
/usr/bin/firefox http://localhost/CreateCoin/genesis.php?archivo=maingenesishash &
sleep 2
	# Leo mainhash.txt y mainnonce.txt y los meto en las lineas 38 y 2797 de main.cpp
mainhash=$(cat /opt/lampp/htdocs/CreateCoin/mainhash.txt)
sed -i 's/"0x  "/'$mainhash'/g' main.cpp
mainnonce=$(cat /opt/lampp/htdocs/CreateCoin/mainnonce.txt)
sed -i 's/2084524493/'$mainnonce'/g' main.cpp



#borro testnet genesis hash
sed -i 's/0xf5ae71e26c74beacc88382716aced69cddf3dffff24f384e1808905e0188f68f/0x0/g' main.cpp

#Compilar
make -f makefile.unix

#Copio el test genesis hash generado por el core dumped anterior en la linea 38 y el nonce en 2796 del main.cpp
	# entro en carpeta
cd
cd Desktop/
cd $NombreCrypto
cd src/

	#Genero genesis hash y nonce de testnet
./$NombreCrypto'd' -testnet

	# Genero testhash.txt y testnonce.txt
cp /home/ubuntu/.$NombreCrypto/testnet3/debug.log /opt/lampp/htdocs/CreateCoin/copias/testgenesishash.hex
chmod 777 /opt/lampp/htdocs/CreateCoin/copias/testgenesishash.hex
/usr/bin/firefox http://localhost/CreateCoin/genesis.php?archivo=testgenesishash &
sleep 2
	# Leo testhash.txt y testnonce.txt y los meto en las lineas 38 y 2749 de main.cpp
testhash=$(cat /opt/lampp/htdocs/CreateCoin/testhash.txt)
sed -i 's/"0x0"/'$testhash'/g' main.cpp
testnonce=$(cat /opt/lampp/htdocs/CreateCoin/testnonce.txt)
sed -i 's/0000000000000000000000000000000000000000/'$testnonce'/g' main.cpp


# Modifico nonce y hash en el checkpoint
sed -i 's/"0xa0fea99a6897f531600c8ae53367b126824fd6a847b2b2b73817a95b8e27e602"/'$testhash'/g' checkpoints.cpp
sed -i 's/1365458829/'$testnonce'/g' checkpoints.cpp
sed -i 's/"0x841a2965955dd288cfa707a755d05a54e45f8bd476835ec9af4402a2b59a2967"/'$mainhash'/g' checkpoints.cpp
sed -i 's/1410516073/'$mainnonce'/g' checkpoints.cpp

#cd ..
#qmake
#make

cd
cd Desktop/
./script4.sh











