IFS=$':'
grpcol="$inactive_col"
echo "$input" >&2
for i in $input ; do
	tagfgcol=""
	tagstr=""
	first=false
	if [[ ${i:0:1} == 'W' ]]; then
		i=${i:1:-1}
		first=true
	fi
	case ${i:0:1} in
		'F')
			tagfgcol="$inactive_col"
			tagstr=" + "
			;;
		'f')
			tagfgcol="$inactive_col"
			tagstr=" - "
			;;
		'o')
			tagfgcol="$active_col"
			tagstr=" - "
			;;
		'O')
			tagfgcol="$active_col"
			tagstr=" + "
			;;
		'm')
			[ $first = false ] && echo -n " "
			tagfgcol="$inactive_col"
			tagstr="["
			grpcol="$inactive_col"
			;;
		'M')
			[ $first = false ] && echo -n " "
			tagfgcol="$sep_col"
			tagstr="["
			grpcol="$sep_col"
			;;
		'L')
			echo -n "%{F$grpcol}]"
			;;
		*)
			continue
			;;
	esac
	if [[ ! -z $tagstr ]] ; then
		echo -en "%{F$tagfgcol}"
		# clickable tags
		echo -en "$tagstr" #${i:1} to get the text
	fi
done
