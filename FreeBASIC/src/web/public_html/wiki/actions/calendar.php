<?php
/**
 * Display a calendar face for a specified or the current month.
 *
 * Specifying a month and/or year in the action itself results in a "static" calendar face without
 * navigation; conversely, providing no parameters in the action results in a calendar face with
 * navigation links to previous, current and next month, with URL parameters determining which
 * month is shown (with the current month as default).
 *
 * You can have one "dynamic" (navigable) calendar on a page (multiple ones would just be the same)
 * and any number of "static" calendars.
 *
 * The current date (if visible) gets a special class to allow a different styling with CSS.
 *
 * Credit:
 * This action was inspired mainly by the "Calendar Menu" code written by
 * {@link http://www.blazonry.com/about.php Marcus Kazmierczak}
 * (© 1998-2002 Astonish Inc.) which we traced back as being the ultimate origin of this code
 * although our starting point was actually a (probably second-hand) variant found on the web which
 * did not contain any attribution.
 * However, not much of the original code is left in this version. Nevertheless, credit to
 * Marcus Kazmierczak for the original that inspired this, however indirectly: Thanks!
 *
 * @package		Actions
 * @subpackage	Date and Time
 * @name		Calendar
 *
 * @author		{@link http://wikka.jsnx.com/GmBowen GmBowen} (first draft)
 * @author		{@link http://wikka.jsnx.com/JavaWoman JavaWoman} (more modifications)
 * @version		0.8
 * @since		Wikka 1.1.6.0
 *
 * @input		integer  $year  optional: 4-digit year of the month to be displayed;
 *				default: current year
 *				the default can be overridden by providing a URL parameter 'year'
 * @input		integer  $month  optional: number of month (1 or 2 digits) to be displayed;
 *				default: current month
 *				the default can be overridden by providing a URL parameter 'month'
 * @output		data table for specified or current month
 *
 * @todo		- take care we don't go over date limits for PHP with navigation links
 *				- configurable first day of week
 */

// ***** CONSTANTS section *****
define('MIN_DATETIME', strtotime('1970-01-01 00:00:00 GMT'));		# earliest timestamp PHP can handle (Windows and some others - to be safe)
define('MAX_DATETIME', strtotime('2038-01-19 03:04:07 GMT'));		# latest timestamp PHP can handle
define('MIN_YEAR', date('Y',MIN_DATETIME));
define('MAX_YEAR', date('Y',MAX_DATETIME)-1);						# don't include partial January 2038
// not-quite-constants
$daysInMonth = array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
define('CUR_YEAR', date('Y',mktime()));
define('CUR_MONTH', date('n',mktime()));
// format string for locale-specific month (%B) + 4-digit year (%Y) used for caption and title attributes
// NOTE: monthname is locale-specific but order of month and year may need to be switched: hence the double quotes!
define('LOC_MON_YEAR', "%B %Y");																	# i18n
define('FMT_SUMMARY', "Calendar for %s");															# i18n
define('TODAY', "today");																			# i18n
// ***** END CONSTANTS section *****

// ***** (ACTION) PARAMETERS Interface *****
// set parameter defaults: current year and month
$year	= CUR_YEAR;
$month	= CUR_MONTH;

// get and interpret parameters
// 1) overrride defaults with parameters provided in URL (accept only valid values)
if (isset($_GET['year']))
{
	$uYear = (int)$_GET['year'];
	if ($uYear >= MIN_YEAR && $uYear <= MAX_YEAR) $year = $uYear;
}
if (isset($_GET['month']))
{
	$uMonth = (int)$_GET['month'];
	if ($uMonth >= 1 && $uMonth <= 12) $month = $uMonth;
}
// 2) override with parameters provided in action itself (accept only valid values)
$hasActionParams = FALSE;
if (is_array($vars))
{
	foreach ($vars as $param => $value)
	{
		switch ($param)
		{
			case 'year':
				$uYear = (int)trim($value);
				if ($uYear >= MIN_YEAR && $uYear <= MAX_YEAR)
				{
					$year = $uYear;
					$hasActionParams = TRUE;
				}
				break;
			case 'month':
				$uMonth = (int)trim($value);
				if ($uMonth >= 1 && $uMonth <= 12)
				{
					$month = $uMonth;
					$hasActionParams = TRUE;
				}
				break;
		}
	}
}
// ***** (ACTION) PARAMETERS Interface *****

// ***** DERIVED VARIABLES *****
// derive which weekday the first is on
$datemonthfirst = sprintf('%4d-%02d-%02d',$year,$month,1);
$firstwday = strftime('%w',strtotime($datemonthfirst));												# i18n

// derive (locale-specific) caption text
$monthYear	= strftime(LOC_MON_YEAR,strtotime($datemonthfirst));									# i18n
$summary	= sprintf(FMT_SUMMARY, $monthYear);														# i18n

// derive last day of month
$lastmday = $daysInMonth[$month - 1];
if (2 == $month)													# correct for leap year if necessary
{
	if (1 == date('L',strtotime(sprintf('%4d-%02d-%02d',$year,1,1)))) $lastmday++;
}

// derive "today" to detect when to mark this up in the calendar face
$today = date("Y:m:d",mktime());

// build navigation variables - locale-specific (%B gets full month name)
// FIXME: @@@ take care we don't go over date limits for PHP
if (!$hasActionParams)
{
	// previous month
	$monthPrev	= ($month-1 < 1) ? 12 : $month-1;
	$yearPrev	= ($month-1 < 1) ? $year-1 : $year;
	$parPrev	= "month=$monthPrev&amp;year=$yearPrev";
	$urlPrev	= $this->Href('', '', $parPrev);
	$titlePrev	= strftime(LOC_MON_YEAR,strtotime(sprintf('%4d-%02d-%02d',$yearPrev,$monthPrev,1)));# i18n
	// current month
	$parCur		= 'month='.CUR_MONTH.'&amp;year='.CUR_YEAR;
	$urlCur		= $this->Href('', '', $parCur);
	$titleCur	= strftime(LOC_MON_YEAR,strtotime(sprintf('%4d-%02d-%02d',CUR_YEAR,CUR_MONTH,1)));	# i18n
	// next month
	$monthNext	= ($month+1 > 12) ? 1 : $month+1;
	$yearNext	= ($month+1 > 12) ? $year+1 : $year;
	$parNext	= "month=$monthNext&amp;year=$yearNext";
	$urlNext	= $this->Href('', '', $parNext);
	$titleNext	= strftime(LOC_MON_YEAR,strtotime(sprintf('%4d-%02d-%02d',$yearNext,$monthNext,1)));# i18n
}

// build array with names of weekdays (locale-specific)
$tmpTime	= strtotime("this Sunday");			# get a starting date that is a Sunday
$tmpDate	= date('d',$tmpTime);
$tmpMonth	= date('m',$tmpTime);
$tmpYear	= date('Y',$tmpTime);
for ($i=0; $i<=6; $i++)
{
	$aWeekdaysShort[$i]	= strftime('%a',mktime(0,0,0,$tmpMonth,$tmpDate+$i,$tmpYear));
	$aWeekdaysLong[$i]	= strftime('%A',mktime(0,0,0,$tmpMonth,$tmpDate+$i,$tmpYear));
}
// ***** END DERIVED VARIABLES *****

// ***** OUTPUT SECTION *****
?>

<table cellpadding="2" cellspacing="1" class="calendar" summary="<?php echo $summary;?>">
<caption><?php echo $monthYear;?></caption>
<thead>
	<tr>
<?php
for ($i=0; $i<=6; $i++)
{
?>
		<th scope="col" width="26" abbr="<?php echo $aWeekdaysLong[$i];?>"><?php echo $aWeekdaysShort[$i];?></th>
<?php
}
?>
	</tr>
</thead>
<tbody class="face">
<?php
	// start row for first week (if it doesn't start on Sunday)
	if ($firstwday > 0)
	{
		echo "	<tr>\n";
	}
	// fill start of first week with blank cells before start of month
	for ($i=1; $i<=$firstwday; $i++)
	{
		echo '		<td>&nbsp;</td>'."\n";
	}

	// loop through all the days of the month
	$day = 1;
	$wday = $firstwday;
	while ($day <= $lastmday)
	{
		// start week row
		if ($wday == 0)
		{
			echo "	<tr>\n";
		}
		// handle markup for current day or any other day
		$calday	= sprintf('%4d:%02d:%02d',$year,$month,$day);
		if ($calday == $today)
		{
			echo '		<td title="'.TODAY.'" class="currentday">'.$day."</td>\n";
		}
		else
		{
			echo '		<td>'.$day."</td>\n";
		}
		// end week row
		if ($wday == 6)
		{
			echo "	</tr>\n";
		}
		// next day
		$wday = ++$wday % 7;
		$day++;

	}

	// fill week with blank cells after end of month
	if ($wday > 0)
	{
		for ($i=$wday; $i<=6; $i++)
		{
			echo '		<td>&nbsp;</td>'."\n";
		}
	}
	// end row for last week
	if ($wday < 6)
	{
		echo "	</tr>\n";
	}
?>
</tbody>
<?php
// generate navigation only for calendar without (valid) action parameters!
// FIXME: @@@ take care we don't go over date limits for PHP
if ($hasActionParams === FALSE)
{
?>
<tbody class="calnav">
	<tr>
		<td colspan="3" align="left" class="prevmonth"><a href="<?php echo $urlPrev;?>" title="<?php echo $titlePrev;?>">&lt;&lt;</a></td>
		<td align="center" class="curmonth"><a href="<?php echo $urlCur;?>" title="<?php echo $titleCur;?>">=</a></td>
		<td colspan="3" align="right" class="nextmonth"><a href="<?php echo $urlNext;?>" title="<?php echo $titleNext;?>">&gt;&gt;</a></td>
	</tr>
</tbody>
<?php
}
?>
</table>
<?php
// ***** END OUTPUT SECTION *****
?>