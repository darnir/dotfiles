# Main (Neo)Mutt Configuration File
#
# Here we define the main configuration settings for Mutt

# Set Program and Directory Paths ============================================

## Custom Path Variables -----------------------------------------------------

set my_confdir		=	"$XDG_CONFIG_HOME/neomutt"
set my_cachedir		=	"$XDG_CACHE_HOME/mutt"
set my_attdir		=	"$XDG_DATA_HOME/mail/attachments"
set my_accdir		=	"$my_confdir/accounts"

## Directories and Programs --------------------------------------------------

set folder			=	"$XDG_DATA_HOME/mail"
set mailcap_path	=	$my_confdir/mailcap
set signature		=	$my_confdir/sig
set alias_file		=	$my_confdir/aliases
set header_cache	=	$my_cachedir/hcache
set message_cachedir=	$my_cachedir/bcache
set tmpdir			=	"/tmp"
set editor			=	"nvim -c 'set fo+=a'"
set ispell			=	"aspell -e -c"
lua-source				"$my_confdir/mutt.lua"

# Multi-Account Configuration ================================================

## Source the Mailboxes automatically generated by Offlineimap
source					"$XDG_DATA_HOME/offlineimap/mailboxes"
## Add some Mailboxes that are not synchronized using Offlineimap ------------
mailboxes "+GNU" "+GNU/INBOX" "+GNU/Sent" "+GNU/Archive" "+GNU/Drafts" "+GNU/Trash"

lua init_accounts()

# Alias Configuration ========================================================

set sort_alias		=	alias					# Sort aliases by name
set reverse_alias	=	yes						# Show name from alias when possible
source					$alias_file				# Source the actual alias file
set display_filter	=	$my_confdir/aliasgen.sh
												# Pass all incoming emails to this script
                                                # which generates the alias file based on
												# the sender

# Mail Configuration =========================================================

set realname		=	"Darshit Shah"
set mbox_type		=	Maildir
set sig_dashes		=	yes
set use_envelope_from =	yes						# Derive envelope_from field
set pipe_decode		=	yes						# Decode messages before sending to pipe
set thorough_search	=	yes						# Decode messages before searching

alternates				^darnir@gmail.com$ ^darnir@gnu.org$ ^s8dashah@stud.uni-saarland.de$

## Set common IMAP Settings

set imap_check_subscribed
set imap_idle

# UI Configuration ===========================================================

source					$my_confdir/colorscheme.muttrc
set	timeout			=	10						# Execute routine commands every so often
set charset			=	"utf-8"
set sleep_time		=	0						# Don't pause to show messages
set delete			=	yes						# Delete, don't ask
set quit			=	yes						# Quit, don't ask
set move			=	no						# Move, don't ask
set confirmappend	=	no						# Append messages, don't ask
set allow_ansi		=	yes						# Print ANSI codes as colors
set mark_old		=	yes
set wait_key		=	no						# Don't wait for keypress after external commnds
set beep_new		=	yes
set menu_scroll		=	yes
set sort_browser	=	reverse-date
set mail_check_stats=	yes						# Update Mailbox stats periodically
set mail_check_stats_interval =	30				# Update Mailbox stats every 30s

## Index Page ----------------------------------------------------------------

set index_format	=	"%4C  [%Z] (%3M) %{%d/%m} %-20.20F  %s"
set sort			=	threads
set sort_aux		=	reverse-last-date-received
set reply_regexp	=	"^(([Rr][Ee]?(\[[0-9]+\])?: *)?(\[[^]]+\] *)?)*"
set strict_threads	=	yes			# Use In-Reply-To to identify threads
set collapse_all	=	yes
set uncollapse_jump	=	yes			# Jump to next unread when uncollapsing a thread
set to_chars		=	" »›↯‹L"	# ' ': Mail not to me, '»': Only recipient
									# '›': One of my recipients, '↯': CC'ed
									# '‹': Sent by me, 'L': Mailing List


## Pager Options -------------------------------------------------------------

set pager_index_lines =	9
set pager_context	=	5	# Number of lines to retain for context
set pager_stop		=	yes	# Don't move to next message
set smart_wrap		=	yes	# Wrap at word boundaries
set markers			=	no	# Don't indicate wrapped lines
set tilde			=	yes	# Pad blank lines with ~
set implicit_autoview =	yes	# Autoview attachments when possible
set skip_quoted_offset=	3	# Number of quoted lines to show
set quote_regexp	=	"^( {0,4}[>|:#%]| {0,4}[a-z0-9]+[>|]+)+"
							# Regex to identify quoted part of message

## Mail Display Options ------------------------------------------------------

alternative_order		text/plain text/enriched text/html
ignore					*	# Don't display any headers in mail
unignore				from date subject to cc reply-to
unignore				x-mailer x-mailing-list posted-to
unignore				list-unsubscribe
unhdr_order				*
hdr_order				from to cc date subject

## Compose Email -------------------------------------------------------------

set forward_format	=	"Fwd: %s"
set send_charset	=	"utf-8"
set attribution		=	"* %n <%a> [%(%y%m%d %H:%M)]:"	# Attribution message before quoted part
set recall			=	no
set text_flowed		=	no	# We try to use the format=flowed style
set edit_headers	=	yes
set	fast_reply		=	yes	# Reply, don't ask
set fcc_attach		=	yes	# Save attachments with body
set reply_to		=	yes	# Use the Reply-To: header
set include			=	yes	# Include original message in response
set forward_quote	=	yes	# Quote forwarded messages
set forward_decode	=	yes	# Decode messages before forwarding
set abort_nosubject	=	yes	# Abort messages with no subjects
set followup_to		=	yes	# Create a Mail-Followup-To header on lists
set honor_followup_to=	yes	# Honor the Followup-to Headers.
							# Send mail to mailing list even when using group-reply
set reverse_name	=	yes	# Reply as whomever it was to
set ignore_list_reply_to	# Ignore reply-to lines when sending to a list
set reply_with_xorig=	yes	# Create From: header from X-Original-To
set mime_forward	=	no	# Forward attachments as part of body
set abort_noattach	=	ask-yes
set metoo			=	no	# Remove address from recepients
set reply_self		=	no	# Allow replying to mail sent by me
set rfc2047_parameters = yes

## Status Bar ----------------------------------------------------------------

set status_chars	=	" *%A"	# ' ': Normal, '*': Changed, '%': Read-Only, 'A':Attach Message
set status_format	=	"───[ Folder: %f ]───[%r%m messages%?u? (%u unread)?%?n? (%n new)?%?d? (%d to delete)?%?t? (%t tagged)? ]───%>─%?p?( %p postponed )?───"

## Sidebar -------------------------------------------------------------------

set sidebar_visible           = yes
set sidebar_divider_char      = '  │'
set sidebar_width             = 28
set sidebar_short_path        = yes
set sidebar_folder_indent     = yes
set sidebar_sort_method       = alpha
set sidebar_new_mail_only     = no
set sidebar_format            = "%B%?F? [%F]?%* %?N?%N/?%S"
set mail_check_stats          = yes
set mail_check_stats_interval = 60

# Navigation =================================================================

## Moving Around
bind attach,browser,index		g	noop
bind attach,browser,index		gg	first-entry
bind attach,browser,index       G	last-entry
bind pager						g	noop
bind pager						gg	top
bind pager						G	bottom
bind pager						k	previous-line
bind pager						j	next-line
bind index						n	next-new-then-unread

## Scrolling
bind attach,browser,pager,index	\CF	next-page
bind attach,browser,pager,index	\CB	previous-page
bind attach,browser,pager,index	\Cu	half-up
bind attach,browser,pager,index	\Cd	half-down
bind browser,pager,index		\Ce	next-line
bind browser,pager,index		\Cy previous-line

## Deleting Messages
bind pager,index				d	noop
bind pager,index				D	noop
bind pager,index				dd	delete-message
bind pager,index				DD	purge-message
macro index						dG	"<collapse-all><tag-pattern>all<enter>;<delete-message>"	"Delete all messages"

## Mail & Reply
bind index						\Cg	list-reply
bind pager,index				r	group-reply
bind compose					p	pgp-menu

## Threads
bind browser,pager,index		N	search-opposite
bind pager,index				dt	delete-thread
bind pager,index				dT	delete-subthread
bind pager,index				Dt	purge-thread
bind pager,index				gt	next-thread
bind pager,index				gT	previous-thread
bind index						za	collapse-thread
bind index						zA	collapse-all

## Message Filters
macro index						,n	"<limit>~N\n"	"Show only new messages"
macro index						,f	"<limit>~F\n"	"Show only flagged messages"
macro index						,a	"<limit>all\n"	"Show all messages"

## View attachments properly.
bind attach						<return>	view-mailcap
macro index,pager		\cL		"<pipe-message> urlscan<Enter>"	"call urlscan to extract URLs out of a message"
macro attach,compose	\cL		"<pipe-entry> urlscan<Enter>"	"call urlscan to extract URLs out of a message"

## Saner copy/move dialogs
macro index				C		"<copy-message>?<toggle-mailboxes>" "copy a message to a mailbox"
macro index				M		"<save-message>?<toggle-mailboxes>" "move a message to a mailbox"

## Always save attachments to a constant directory
macro attach			s		"<save-entry><kill-line>$my_attdir<enter>y" "Save attachment"

macro index				AU		"<collapse-all><tag-pattern>~C os-ws17@lists.mpi-sws.org<Enter><tag-prefix><save-message>=UdS/OS.Users<Enter>" "Save users"
macro index				AS		"<collapse-all><tag-pattern>~C os-ws17-staff@lists.mpi-sws.org<Enter><tag-prefix><save-message>=UdS/OS.Staff<Enter>" "Save users"
macro index				AA		"<collapse-all><tag-pattern>~C os17-assignment@mpi-sws.org<Enter><tag-prefix><save-message>=UdS/OS.Assignments<Enter>" "Save users"

## Sidebar Navigation ---------------------------------------------------------
bind index,pager <down>   sidebar-next
bind index,pager <up>     sidebar-prev
bind index,pager <right>  sidebar-open

# Mailing Lists ==============================================================

subscribe	gnu-prog-discuss
subscribe	bug-wget
subscribe	bug-gnulib
subscribe	ghm-discuss
subscribe	neomutt-devel
subscribe	neomutt-users
subscribe	summer-of-code
subscribe	milaman.cs.uni-saarland.de
subscribe	os-ws17-staff
subscribe	os-ws17
subscribe	os17-assignment

# PGP Options ================================================================

set crypt_autopgp	=	yes	# Allow auto-enabling pgp settings
set crypt_autosign	=	yes	# Always sign all outgoing messages
set crypt_autosmime	=	no	# We don't want to create S/MIME messages
set crypt_opportunistic_encrypt = yes
set crypt_replyencrypt =yes
set crypt_replysign	=	yes
set crypt_replysignencrypted = yes
set crypt_use_gpgme	=	yes
set crypt_use_pka	=	yes
set crypt_verify_sig=	yes
set pgp_auto_decode	=	yes
set pgp_check_exit	=	yes
set pgp_long_ids	=	yes
set pgp_use_gpg_agent =	yes
set pgp_encrypt_self=	yes
set pgp_sign_as		=	0x2A1743EDA91A35B6
lua switch_account("UdS")
