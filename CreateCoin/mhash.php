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
//echo $contenido;

//echo $contenido;

$contenido=explode( ' ', $contenido );

//print_r($contenido);
$result=trim($contenido[count($contenido)-1]);

$result='"0x'.$result.'"';
echo $result;

$file= $_GET['archivo'].".txt";
$fp= fopen($file,"w");
fwrite($fp,$result);
fclose($fp);
?>


