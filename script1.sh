#!/bin/sh


NombreCrypto="curso"
NombreCryptoPrimeraMayuscula="Curso"
NombreCryptoTodoMayuscula="CURSO"
Diminutivo="CB"

sudo /opt/lampp/lampp start
cd
exit
rm -rf \.$NombreCrypto
cd Desktop/
rm -f *.hex
rm -f *.pem
rm -rf $NombreCrypto
cp -r litecoin/ ./$NombreCrypto
cd $NombreCrypto/src/
sed -i 's/0x97ddfbbae6be97fd6cdf3e7ca13232a3afff2353e29badfab7f73011edd4ced9/0x/g' main.cpp 	# linea 45 script3 pero aca para que sea mas efectivo
sed -i 's/<const CScriptID&>/<CScriptID>/g' rpcrawtransaction.cpp
cd ..
find . -type f -print0 | xargs -0 sed -i 's/litecoin/'$NombreCrypto'/g'
find . -type f -print0 | xargs -0 sed -i 's/Litecoin/'$NombreCryptoPrimeraMayuscula'/g'
find . -type f -print0 | xargs -0 sed -i 's/LiteCoin/'$NombreCryptoPrimeraMayuscula'/g'
find . -type f -print0 | xargs -0 sed -i 's/LITECOIN/'$NombreCryptoTodoMayuscula'/g'
find . -type f -print0 | xargs -0 sed -i 's/LTC/'$Diminutivo'/g'
cd src
#make -f makefile.unix

cd
cd Desktop/
./script2.sh


