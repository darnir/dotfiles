#!/bin/bash

set -e
set -u
set -o pipefail

ALIASFILE="$HOME/.mutt/aliases"

MSG=$(cat)

FROM=$(grep ^"From: " <<< "$MSG")
ALIASLINE=$(awk -f $HOME/.mutt/printalias.awk <<< "$FROM")
MAIL=$(awk '{print $(NF)}' <<< "$ALIASLINE" | tr -d '<>')
# ALIAS=$(awk '{print $2}' <<< "$ALIASLINE")

# We never want to create some aliases
NOALIAS_PAT="facebook|twitter|emirates|amazon|gnu|github|sofort|paypal| \
	notebooksbilliger|online.net|noreply|no-reply|meetup|jetprivilege| \
	stackexchange|shopping|airbnb|aur.archlinux.org|printer@cs.fs| \
    quora|coverity|bits2msphd|do-not-reply|flixbus|piazza|debbugs|contact@| \
	gitter|googlegroups|keybase|linkedin|mailman|neomutt|travis| \
	guerrillamail|webmaster|buildbot|arch-general|arch-dev-public|payoneer"

if grep -Eq "$NOALIAS_PAT" <<< "$ALIASLINE"; then
	:
elif grep -Fq "$MAIL" "$ALIASFILE"; then
	:
else
	echo "$ALIASLINE" >> "$ALIASFILE"
fi

sort -d -i -o "$ALIASFILE" "$ALIASFILE"

echo "$MSG"
