<?php

if(isset($_GET['archivo']))
{
$archivo="/opt/lampp/htdocs/CreateCoin/copias/".$_GET['archivo'].".hex";	
}
else
{
	exit;
}

$contenido=file_get_contents($archivo);
$nonce=explode( 'block.nNonce = ', $contenido );
$nonce=explode( ' ', $nonce[1] );
$nonce=trim($nonce[0]);

$contenido= str_replace("\s+"," ",$contenido);
$contenido= str_replace("\s"," ",$contenido);
$contenido= str_replace("\n"," ",$contenido);
$contenido= str_replace("\t"," ",$contenido);

$hash=explode( 'block.GetHash = ', $contenido );
$hash=explode( ' ', $hash[1] );
$hash=trim($hash[0]);

$hash='"0x'.$hash.'"';

echo $nonce;
echo "<br>";
echo $hash;


$mystring = $_GET['archivo'];
$findme   = 'main';
$pos = strpos($mystring, $findme);
if ($pos === false) 
{
    //es el testnet
	echo "<br><br>es el testnet";
	$filen= "testnonce.txt";
	$fileh= "testhash.txt";
} 
else 
{
	echo "<br><br>es main net";
	$filen= "mainnonce.txt";
	$fileh= "mainhash.txt";
}


$fp= fopen($filen,"w");
fwrite($fp,$nonce);
fclose($fp);

$fp= fopen($fileh,"w");
fwrite($fp,$hash);
fclose($fp);

?>


