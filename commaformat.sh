#!/bin/zsh -f
# Purpose: format number to have commas properly
#
# From:	Timothy J. Luoma
# Mail:	luomat at gmail dot com
# Date:	2014-12-12

if [ -e "$HOME/.path" ]
then
	source "$HOME/.path"
else
	PATH=/usr/local/scripts:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin
fi

echo "$@" | tr -dc '[0-9]' | LC_ALL=en_US.UTF-8 awk '{printf "%'\''d\n",$0}'

exit 0
#
#EOF
