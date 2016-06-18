#!/bin/awk

BEGIN {

}
{
    # Empty the first field of the input. This should eliminate "FROM" from the
	# input line
	$1 = ""
	if (NF == 3) {
		print "alias" $0;
	} else if (NF == 2) {
		print "alias" $0 $0;
	} else if (NF > 3) {
		print "alias", tolower($2)"-"tolower($(NF-1)) $0;
	}
}
END {

}
