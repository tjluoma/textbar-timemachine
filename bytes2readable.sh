#!/bin/zsh -f
# Purpose: Given a size, in bytes, output a readable size

if [ -e "$HOME/.path" ]
then
	source "$HOME/.path"
else
	PATH=/usr/local/scripts:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin
fi

	# assume 1 MB = 1000 bytes, unless told otherwise
MBYTES=1000

case "$1" in
	--1024|--old)
				MBYTES=1024
				shift
	;;

	--*)
				MBYTES=1000
				shift
	;;
esac

PRECISION="scale=2"												# change this numeric value to increase decimal precision

if [ "$MBYTES" = "1000" ]
then
	METRIC=('KB' 'MB' 'GB' 'TB' 'XB' 'PB') 						# Array of suffixes
else
	METRIC=('KiB' 'MiB' 'GiB' 'TiB' 'XiB' 'PiB') 				# Array of suffixes
fi

for BYTES in "$@"
do

		# (re)initialize MAGNITUDE variable
	MAGNITUDE=0  												# magnitude of 2^10

	UNITS=$(echo "$BYTES" | tr -dc '[0-9]')  					# numeric arg val (in bytes) to be converted

	if [[ "$UNITS" != "" ]]
	then

		while [ ${UNITS/.*} -ge $MBYTES ] 						# compares integers (b/c no floats in bash)
		do

			UNITS=$(echo "$PRECISION; $UNITS/$MBYTES" | bc)		# floating point math via `bc`

			((MAGNITUDE++)) 									# increments counter for array pointer

		done

		echo "$UNITS ${METRIC[$MAGNITUDE]}"

	fi

done

exit 0
#EOF
