#!/bin/sh

NombreCrypto="curso"





# Cambio la interfaz grafica con las imagenes contenidas en la carpeta Desktop/img
cd
cd  Desktop/
cd  img/
rm -rf pixmap
rm -rf icons
rm -rf images

Imagen=$(echo logo.*)
echo $Imagen

mkdir pixmap

convert $Imagen -resize "16x16^!" pixmap/bitcoin16.png
convert $Imagen -resize "32x32^!" pixmap/bitcoin32.png
convert $Imagen -resize "64x64^!" pixmap/bitcoin64.png
convert $Imagen -resize "128x128^!" pixmap/bitcoin128.png
convert $Imagen -resize "256x256^!" pixmap/bitcoin256.png

convert $Imagen -resize "16x16^!" pixmap/bitcoin16.xpm
convert $Imagen -resize "32x32^!" pixmap/bitcoin32.xpm
convert $Imagen -resize "64x64^!" pixmap/bitcoin64.xpm
convert $Imagen -resize "128x128^!" pixmap/bitcoin128.xpm
convert $Imagen -resize "256x256^!" pixmap/bitcoin256.xpm

convert $Imagen -resize "48x48^!" pixmap/bitcoin-bc.ico
convert $Imagen -resize "32x32^!" pixmap/favicon.ico
convert $Imagen -resize "64x64^!" pixmap/bitcoin.ico

num='2'
Imagen2=$(echo cripto.*)
echo $Imagen2

convert $Imagen -resize "164x314^!" pixmap/nsis-wizard.bmp
convert $Imagen2 -resize "150x57^!" pixmap/nsis-header.bmp

mkdir icons

cp pixmap/bitcoin.ico icons/bitcoin.ico
cp pixmap/bitcoin256.png icons/bitcoin.png
cp pixmap/bitcoin16.png icons/toolbar.png
cp logo.icns icons/litecoin.icns
cd icons
convert bitcoin.ico -charcoal 2 bitcoin_testnet.ico
convert bitcoin.png -charcoal 2 bitcoin_testnet.png
convert toolbar.png -charcoal 2 toolbar_testnet.png

cd ..
mkdir images
Imagen3=$(echo billetera.*)
echo $Imagen3
convert $Imagen3 -resize "440x480^!" images/splash.png
convert $Imagen2 -rotate -90 aboutaux.png
convert aboutaux.png -resize "96x564^!" images/about.png
rm -f aboutaux.png
cd images
convert splash.png -charcoal 2 splash_testnet.png

cd
cd  Desktop/
cp -f ./img/pixmap/* /home/ubuntu/Desktop/$NombreCrypto/share/pixmaps
cp -f ./img/icons/* /home/ubuntu/Desktop/$NombreCrypto/src/qt/res/icons
cp -f ./img/images/* /home/ubuntu/Desktop/$NombreCrypto/src/qt/res/images





# Cambio el texto del splash cuando se inicia la billetera
cd
cd  Desktop/
cd  $NombreCrypto
cd  src/
cd  qt/

anio=$(echo $(date +%Y))
NombreCryptoM=$(echo $NombreCrypto | sed 's/\w\+/\L\u&/g')

sed -i "s/$NombreCryptoM/Litecoin/g" aboutdialog.cpp
sleep 2
sed -i "s/3333/$anio/g" aboutdialog.cpp
sed -i "s/MyCripto/$NombreCryptoM/g" aboutdialog.cpp

sed -i "s/$NombreCryptoM/Litecoin/g" splashscreen.cpp
sed -i "s/5555/$anio/g" splashscreen.cpp
sed -i "s/MyCripto/$NombreCryptoM/g" splashscreen.cpp
echo $anio

TheName=$(echo The $NombreCryptoM)

cd  res/
sed -i "s/$TheName/The Litecoin/g" bitcoin-qt.rc
sed -i "s/7777/$anio/g" bitcoin-qt.rc
sed -i "s/MyCripto/$NombreCryptoM/g" bitcoin-qt.rc

cd ..
cd  forms/
sed -i "s/$TheName/The Litecoin/g" aboutdialog.ui
sed -i "s/5555/$anio/g" aboutdialog.ui
sed -i "s/MyCripto/$NombreCryptoM/g" aboutdialog.ui



# Agrego la ip de los nodos hardcodeados. por ahora solo agregue el 127.0.0.1 que para hacerlo lo agregue en mi listaIn.txt dentro de otherScripts
cd
cd  Desktop/
cd otherScripts/
./test.sh &
IPs=$(cat listaOut.txt)
cd
cd  Desktop/
cd  $NombreCrypto
cd  src/
sed -i "s/0x0/$IPs/g" net.cpp



# Compilo
cd
cd  Desktop/
cd $NombreCrypto
qmake
make






















