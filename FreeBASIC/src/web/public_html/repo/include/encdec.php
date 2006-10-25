<?
/***********************************************************
* Class:        Encrypt                                    *
* Version:      1.1                                        *
* Date:         September 2004                             *
* Author:       Agus Hariyanto                             *
* Copyright:    © Agus H                                   *
* Licence :     Free for non-commercial use                *
* email :       iam_emc2@yahoo.com  					   *
* Modified by:  Andrea Bugada (phpatm@free.fr)             *
************************************************************/


function decrypt($data,$key)
{
	$char = "";
	$charx = "";
	
	$key=md5($key);
	$x=0;
	for ($i=0;$i<strlen($data);$i++)
	{
		if ($x==strlen($key)) $x=0;
		$char.=substr($key,$x,1);
		$x++;	
	}
	for ($i=0;$i<strlen($data);$i++)
	{
		if (ord(substr($data,$i,1))<ord(substr($char,$i,1)))
		{
			$charx.=chr((ord(substr($data,$i,1))+256)-ord(substr($char,$i,1)));	
		}
		else 
		{
			$charx.=chr(ord(substr($data,$i,1))-ord(substr($char,$i,1)));
		}
	}
	return($charx);
}

function encrypt($data,$key)
{
	$char = "";
	$charx = "";
	
	$key=md5($key);
	$x=0;
	for ($i=0;$i<strlen($data);$i++)
	{
		if ($x==strlen($key)) $x=0;
		$char.=substr($key,$x,1);
		$x++;	
	}
	for ($i=0;$i<strlen($data);$i++)
	{
		$charx.=chr(ord(substr($data,$i,1))+(ord(substr($char,$i,1)))%256);	
	}
	return $charx;
}
?>