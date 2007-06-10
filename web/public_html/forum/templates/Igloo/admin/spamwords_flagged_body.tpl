
<h1>{L_FLAGGED_POSTS}</h1>
<P>{L_FLAGGED_POSTS_EXPLAIN}</p>

<form method="post" action="{S_FLAGGED_ACTION}">
<table width="100%" cellspacing="2" cellpadding="0" border="0">
	<tr>
		<td><span class="nav">{PAGE_NUMBER}</span></td>
		<td align="right"><span class="nav">{PAGINATION}</span></td>
	</tr>
</table>
<table cellspacing="1" cellpadding="4" border="0" align="center" class="forumline" width="100%">
	<tr>
		<th class="thTop" nowrap="nowrap">{L_USERNAME}</th>
		<th class="thTop" nowrap="nowrap">{L_SUBJECT}</th>
		<th class="thTop" nowrap="nowrap">{L_MESSAGE}</th>
		<th class="thTop" nowrap="nowrap">{L_TIME}</th>
		<th colspan="2" class="thCornerR" width="15%">{L_ACTION}</th>
	</tr>
	<!-- BEGIN flagged -->
	<tr>
		<td class="{flagged.ROW_CLASS}" align="center" nowrap="nowrap" height="28">{flagged.USERNAME}</td>
		<td class="{flagged.ROW_CLASS}" align="left">{flagged.SUBJECT}</td>
		<td class="{flagged.ROW_CLASS}" align="left">{flagged.MESSAGE}</td>
		<td class="{flagged.ROW_CLASS}" align="center" nowrap="nowrap">{flagged.TIME}</td>
		<td class="{flagged.ROW_CLASS}" align="center"><a href="{flagged.U_EDIT}">{L_EDIT}</a></td>
		<td class="{flagged.ROW_CLASS}" align="center"><a href="{flagged.U_DELETE}">{L_DELETE}</a></td>
	</tr>
	<!-- END flagged -->
	<!-- BEGIN no_flagged -->
	<tr>
		<td class="row1" colspan="5" align="center" height="28"><span class="gen">{no_flagged.L_NO_FLAGGED_POSTS}</span></td>
	</tr>
	<!-- END no_flagged -->
	<tr>
		<td colspan="7" align="center" class="catBottom">&nbsp;</td>
	</tr>
</table>
<table width="100%" cellspacing="2" cellpadding="0" border="0">
	<tr>
		<td><span class="nav">{PAGE_NUMBER}</span></td>
		<td align="right"><span class="nav">{PAGINATION}</span></td>
	</tr>
</table>
</form>