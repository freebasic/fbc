
<h1>{L_LOG}</h1>

<p><span class="genmed">{L_LOG_EXPLAIN}</span></p>

<form method="post" action="{S_MODE_ACTION}">
<table width="100%" cellspacing="0" cellpadding="2" border="0" align="center">
	<tr>
		<td align="right" nowrap="nowrap"><span class="genmed">{L_SELECT_SORT_METHOD}:&nbsp;{S_MODE_SELECT}&nbsp;&nbsp;{L_ORDER}&nbsp;{S_ORDER_SELECT}&nbsp;&nbsp;
		<input type="submit" name="submit" value="{L_SUBMIT}" class="liteoption" />
		</span></td>
	</tr>
</table>

<table border="0" cellpadding="4" cellspacing="1" width="100%" class="forumline">
	<tr>
		<th align="center" height="28" class="thCornerL" nowrap="nowrap">{L_USER}</th>
		<th align="center" class="thTop" nowrap="nowrap">{L_SUBJECT}</th>
		<th align="center" class="thTop" nowrap="nowrap">{L_MESSAGE}</th>
		<th align="center" class="thTop" nowrap="nowrap">{L_FLAGGED}</th>
		<th align="center" class="thTop" nowrap="nowrap">{L_IP}</th>
		<th align="center" class="thTop" nowrap="nowrap">{L_TIME}</th>
		<th align="center" class="thCornerR" nowrap="nowrap">{L_BROWSER}</th>
	</tr>
	<!-- BEGIN no_log -->
	<tr>
		<td class="row1" align="center" colspan="7"><span class="gen">{no_log.L_NO_LOG}</span></td>
	</tr>
	<!-- END no_log -->
	<!-- BEGIN log_row -->
	<tr>
		<td class="{log_row.ROW_CLASS}" align="center" valign="middle" height="28"><span class="genmed">{log_row.USER}</span></td>
		<td class="{log_row.ROW_CLASS}" align="left" valign="middle"><span class="genmed">{log_row.SUBJECT}</span></td>
		<td class="{log_row.ROW_CLASS}" align="left" valign="middle"><span class="genmed">{log_row.MESSAGE}</span></td>
		<td class="{log_row.ROW_CLASS}" align="center" valign="middle"><span class="genmed">{log_row.FLAGGED}</span></td>
		<td class="{log_row.ROW_CLASS}" align="center" valign="middle"><span class="genmed">{log_row.IP}</span></td>
		<td class="{log_row.ROW_CLASS}" align="center" valign="middle" nowrap="nowrap"><span class="genmed">{log_row.TIME}</span></td>
		<td class="{log_row.ROW_CLASS}" align="center" valign="middle"><span class="genmed">{log_row.BROWSER}</span></td>
	</tr>
	<!-- END log_row -->
	</form>
	<tr><form method="post" action="{S_MODE_ACTION}">
		<td colspan="7" class="catBottom" align="center">
		<input class="liteoption" type="submit" name="delete" value="{L_DELETE}">
		</td></form>
	</tr>
</table>
<table width="100%" cellspacing="0" cellpadding="2" border="0" align="center">
	<tr>
		<td align="left" nowrap="nowrap"><span class="nav">{PAGE_NUMBER}</span></td>
		<td align="right" nowrap="nowrap"><span class="nav">{PAGINATION}</span></td>
	</tr>
</table>
