-- Get a password using pass password manager
function get_pass(name)
	acc_name = "pass Offlineimap/"..name.."/password"
	fd = io.popen(acc_name)
	pass = fd:read('*l')
	fd:close()
	return pass
end

accounts = { "gmail", "GNU", "UdS", "darnirmlist" }

function init_accounts()
	switch_account("gmail")
	for i, acc in ipairs(accounts) do
		mutt.enter("folder-hook "..acc.."/* 'lua switch_account(\""..acc.."\")")
		mutt.enter("folder-hook "..acc.."/* macro index,pager AA <save-message>="..acc.."/Archive<Enter>")
		mutt.enter("folder-hook "..acc.."/* macro index,pager At <untag-pattern>all<Enter><tag-thread><tag-prefix><save-message>="..acc.."/Archive<Enter>")
	end
end


-- Switch Mutt accounts
function switch_account(name)
	if name == "gmail" then
		user = "darnir@gmail.com"
		acc_type = "Gmail"
	elseif name == "GNU" then
		user = "darnir@gnu.org"
		acc_type = "POP"
	elseif name == "UdS" then
		user = "s8dashah@stud.uni-saarland.de"
		acc_type = "IMAP"
	elseif name == "darnirmlist" then
		user = "darnirmlist@gmail.com"
		acc_type = "IMAP"
	else
		exit(1)
	end

	_switch_account {
		name = name,
		user = user,
		acc_type = acc_type
	}
end

function _switch_account(opt)
	mutt.set("from", opt.user)
	mutt.set("sendmail", opt.sendmail or "msmtp -a "..opt.name)
	mutt.set("postponed", opt.drafts or "+"..opt.name.."/Drafts")
	mutt.set("trash", opt.trash or "+"..opt.name.."/Trash")
	mutt.set("spoolfile", opt.inbox or "+"..opt.name.."/Inbox")
	mutt.set("record", opt.record or "+"..opt.name.."/Sent")

	if opt.acc_type == "Gmail" then
		mutt.enter("unset record")
	end

end
