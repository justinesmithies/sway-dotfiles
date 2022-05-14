#!/bin/bash

updates="$(checkupdates;paru -Qum)"
arch="$(checkupdates | wc -l)"
aur="$(paru -Qum | wc -l)"
number=$((arch+aur))

if [ "$number" -gt 0 ]; then
    text=" $number"
else
    text=""
fi

if (( "$number" > 20 ))
then
    tooltip="$(echo "$updates" | head -n 20 | sed -z 's/\n/\\n/g')"
    tooltip+='...'
else
    tooltip="$(echo "$updates" | sed -z 's/\n/\\n/g')"
    tooltip=${tooltip::-2}
fi

echo "{\"text\":\""$text"\", \"tooltip\":\""$tooltip"\"}"
exit 0
