
<h1>{L_CONFIGURATION_TITLE}</h1>

<p>{L_CONFIGURATION_EXPLAIN}</p>

<form action="{S_CONFIG_ACTION}" method="post"><table width="99%" cellpadding="4" cellspacing="1" border="0" align="center" class="forumline">
	<tr>
	  <th class="thHead" colspan="2">{L_GENERAL_SETTINGS}</th>
	</tr>
	<tr>
		<td class="row2"><span class="nav">{L_CURRENT_WORDS}: </span><span class="gensmall">{L_NO_WORDS}
		<!-- BEGIN words -->
		{words.WORDS}
		<!-- END words -->
		</span></td>
		<td class="row2" align="center">{L_MORE_WORDS}</td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_DISABLE_MOD}</span><br /><span class="gensmall">{L_DISABLE_MOD_EXPLAIN}</span></td>
		<td class="row2" nowrap="nowrap"><input type="radio" name="enable_spam_words" value="0" {S_DISABLE_MOD_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="enable_spam_words" value="1" {S_DISABLE_MOD_NO} /> {L_NO}</td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_HANDLE_SPAM}</span><br /><span class="gensmall">{L_HANDLE_SPAM_EXPLAIN}</span></td>
		<td class="row2" nowrap="nowrap"><input type="radio" name="flag_posts" value="1" {S_FLAG_POSTS} /> {L_FLAG_POSTS}<br /><input type="radio" name="flag_posts" value="0" {S_ERROR_MESSAGE} /> {L_ERROR_MESSAGE}</td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_OFFENSES}</span><br /><span class="gensmall">{L_OFFENSES_EXPLAIN}</span></td>
		<td class="row2"><input class="post" type="text" size="3" maxlength="4" name="user_warnings" value="{OFFENSES}" /></td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_BAN_IP}</span></td>
		<td class="row2" nowrap="nowrap"><input type="radio" name="ban_ip" value="1" {S_BAN_IP_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="ban_ip" value="0" {S_BAN_IP_NO} /> {L_NO}</td>
	</tr>
	<tr>
		<th class="thHead" colspan="2">{L_EXCEPTIONS}</th>
	</tr>
	<tr>
		<td class="row2" colspan="2"><span class="gensmall">{L_EXCEPTIONS_EXPLAIN}</span></td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_ALLOW_ADMIN}</span></td>
		<td class="row2" nowrap="nowrap"><input type="radio" name="allow_admin" value="1" {S_ALLOW_ADMIN_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="allow_admin" value="0" {S_ALLOW_ADMIN_NO} /> {L_NO}</td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_ALLOW_MOD}</span></td>
		<td class="row2" nowrap="nowrap"><input type="radio" name="allow_moderator" value="1" {S_ALLOW_MOD_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="allow_moderator" value="0" {S_ALLOW_MOD_NO} /> {L_NO}</td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_ALLOW_REG}</span></td>
		<td class="row2" nowrap="nowrap"><input type="radio" name="allow_reg" value="1" {S_ALLOW_REG_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="allow_reg" value="0" {S_ALLOW_REG_NO} /> {L_NO}</td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_USER_POST_COUNT}</span></td>
		<td class="row2"><input class="post" type="text" size="3" maxlength="4" name="allow_user_posts" value="{USER_POST_COUNT}" />&nbsp; {L_POSTS}</td>
	</tr>
	<tr>
	  <th class="thHead" colspan="2">{L_PM_MESSAGES}</th>
	</tr>
	<tr>
		<td class="row2" colspan="2"><span class="gensmall">{L_PM_MESSAGES_EXPLAIN}</span></td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_WARN_USER_PM}</span></td>
		<td class="row2" nowrap="nowrap"><input type="radio" name="warn_user_pm" value="1" {S_WARN_USER_PM_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="warn_user_pm" value="0" {S_WARN_USER_PM_NO} /> {L_NO}</td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_PM_SUBJECT}</span></td>
		<td class="row2"><textarea name="warn_user_pm_subject" rows="2" cols="30">{PM_SUBJECT}</textarea></td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_PM_MESSAGE}</span></td>
		<td class="row2"><textarea name="warn_user_pm_message" rows="4" cols="30">{PM_MESSAGE}</textarea></td>
	</tr>
	<tr>
	  <th class="thHead" colspan="2">{L_ERROR_MESSAGES}</th>
	</tr>
	<tr>
		<td class="row2" colspan="2"><span class="gensmall">{L_ERROR_MESSAGES_EXPLAIN}</span></td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_ERROR_TEXT}</span></td>
		<td class="row2"><textarea name="error_message" rows="2" cols="30">{ERROR_TEXT}</textarea></td>
	</tr>
	<tr>
		<td class="row1"><span class="gen">{L_ERROR_SIG}</span></td>
		<td class="row2"><textarea name="error_message_sig" rows="2" cols="30">{ERROR_SIG}</textarea></td>
	</tr>
	<tr>
		<td class="catBottom" colspan="2" align="center">{S_HIDDEN_FIELDS}<input type="submit" name="submit" value="{L_SUBMIT}" class="mainoption" />&nbsp;&nbsp;<input type="reset" value="{L_RESET}" class="liteoption" />
		</td>
	</tr>
</table></form>

<br clear="all" />
