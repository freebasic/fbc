<?php
/***************************************************************************
 *                                   zip.php
 *                            -------------------
 *   begin                : Saturday', Mar 08', 2003
 *   copyright            : ('C) 2002-03 Bugada Andrea
 *   email                : phpATM@free.fr
 *
 *   $Id$
 *
 *
 ***************************************************************************/

/***************************************************************************
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License', or
 *   ('at your option) any later version.
 *
 ***************************************************************************/

//
// VIEWER VARIABLES SET
// ------------------------------------------------------------------------------------------
// $current_dir: contains the directory (absolute path) of the file to be showed
// $directory:   contains the directory (relative to upload folder) of the file to be showed
// $filename:    contains the filename to be showed
//


//
// Converte il formato della data da dos a unix
//
function msdos_time_to_unix($DOSdate, $DOStime)
{
	$year = (($DOSdate & 65024) >> 9) + 1980;
	$month = ($DOSdate & 480) >> 5;
	$day = ($DOSdate & 31);
	$hours = ($DOStime & 63488) >> 11;
	$minutes = ($DOStime & 2016) >> 5;
	$seconds = ($DOStime & 31) * 2;
	return mktime($hours, $minutes, $seconds, $month, $day, $year);
}

//
// Elenca il contenuto di un file zip
//
function list_zip($filename)
{
	global $bordercolor, $headercolor, $tablecolor, $font, $headerfontcolor;
	global $normalfontcolor, $datetimeformat, $mess;

	$fp = @fopen($filename,'rb');
	if (!$fp)
	{
		return;
	}
	fseek($fp, -22, SEEK_END);

	// Get central directory field values
	$headersignature = 0;
	do
	{
		// Search header
		$data = fread($fp, 22);
		list($headersignature,$numberentries, $centraldirsize, $centraldiroffset) =
			array_values(unpack('Vheadersignature/x6/vnumberentries/Vcentraldirsize/Vcentraldiroffset', $data));

		fseek($fp, -23, SEEK_CUR);
	} while (($headersignature != 0x06054b50) && (ftell($fp) > 0));

	if ($headersignature != 0x06054b50)
	{
		echo "<p><font face=\"$font\" size=\"3\" color=\"$normalfontcolor\">$mess[45]</font></p>";
		fclose($fp);
		return;
	}

	// Go to start of central directory
	fseek($fp, $centraldiroffset, SEEK_SET);

	// Read central dir entries
	echo "<p><font face=\"$font\" size=\"3\" color=\"$normalfontcolor\">$mess[46]</font></p>";
	echo "<p><table border=\"0\" width=\"90%\" bgcolor=\"$bordercolor\" cellpadding=\"4\" cellspacing=\"1\">";
	echo "<tr bgcolor=\"$headercolor\">
	<td>
		<b><font face=\"$font\" size=\"2\" color=\"$headerfontcolor\">$mess[15]</font></b>
	</td>
	<td>
		<b><font face=\"$font\" size=\"2\" color=\"$headerfontcolor\">$mess[17]</font></b>
	</td>
	<td>
		<b><font face=\"$font\" size=\"2\" color=\"$headerfontcolor\">$mess[47]</font></b>
	</td>
	</tr>";

	for ($i = 1; $i <= $numberentries; $i++)
	{
		// Read central dir entry
		$data = fread($fp, 46);
		list($arcfiletime,$arcfiledate,$arcfilesize,$arcfilenamelen,$arcfileattr) =
			array_values(unpack("x12/varcfiletime/varcfiledate/x8/Varcfilesize/Varcfilenamelen/x6/varcfileattr", $data));
		$filenamelen = fread($fp, $arcfilenamelen);

		$arcfiledatetime = msdos_time_to_unix($arcfiledate, $arcfiletime);

		echo "<tr bgcolor=\"$tablecolor\">";

		// Print FileName
		echo '<td>';
		echo "<font face=\"$font\" size=\"1\" color=\"$normalfontcolor\">";
		if ($arcfileattr == 16)
		{
			echo "<b>$filenamelen</b>";
		}
		else
		{
			echo $filenamelen;
		}

		echo '</font>';
		echo '</td>';

		// Print FileSize column
		echo "<td><font face=\"$font\" size=\"1\" color=\"$normalfontcolor\">";

		if ($arcfileattr == 16)
			echo $mess[48];
		else
			echo $arcfilesize . ' bytes';

		echo '</td></font>';

		// Print FileDate column
		echo "<td><font face=\"$font\" size=\"1\" color=\"$normalfontcolor\">";
		echo date($datetimeformat, $arcfiledatetime);
		echo '</td></font>';
		echo '</tr>';
	}
	echo '</table></p>';
	fclose($fp);
	return;
}


//
// START OF VIEWER MAIN CODE
//
echo "<html>\n";
echo "<head><title></title></head>\n";
echo "<body>\n";
echo "<center>\n";
list_zip("$current_dir/$filename");
echo "</center>\n";
echo "</body>\n";
echo "</html>\n";

?>