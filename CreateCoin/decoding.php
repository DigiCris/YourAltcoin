<?php

if(isset($_GET['archivo']))
{
$archivo="/home/ubuntu/Desktop/".$_GET['archivo'].".hex";	
}
else
{
	exit;
}

$contenido=file_get_contents($archivo);
//echo $contenido;

$contenido= str_replace("\s+","",$contenido);
$contenido= str_replace("\s","",$contenido);
$contenido= str_replace("\n","",$contenido);
$contenido= str_replace("\t","",$contenido);
$contenido= str_replace(" ","",$contenido);
$contenido= str_replace(":","",$contenido);
$contenido= str_replace("-","",$contenido);
$contenido= str_replace("(","",$contenido);
$contenido= str_replace(")","",$contenido);
$contenido= str_replace("=","",$contenido);
//echo "<br>";
preg_match_all("!pub(.*?)ASN!",$contenido,$match);
$result=trim($match[1][0]);
//print_r($match[1]);
echo $result;

echo "antes";
$file= $_GET['archivo'].".txt";
$fp= fopen($file,"w");
fwrite($fp,$result);
fclose($fp);
echo "hecho";
?>


