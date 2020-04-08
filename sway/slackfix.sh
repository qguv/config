#!/bin/sh
set -e

while sleep 1; do
	ev="$(swaymsg --type subscribe '["window"]' | jq --raw-output '
		if (
			(.change == "new" or .change == "focus")
			and .container.window_properties.class == "Slack"
		) then
			(.container.id | tostring)
			+ ":" + (.container.geometry.width | tostring)
			+ "x" + (.container.geometry.height | tostring)
		else
			empty
		end
	')"

	[ -z "$ev" ] && continue

	cid="${ev%:*}"
	wh="${ev#*:}"
	w="${wh%x*}"
	h="${wh#*x}"

	echo "$wh" >> ~/.config/sway/slack_windows.log

	# 300 x 56 is the traditional "bad" size, but this was failing earlier and I don't know why. so we're gonna log more.
	{ [ "$w" -ne 300 ] || [ "$h" -ne 56 ]; } && continue

	swaymsg '[con_id='"$cid"']' kill
	notify-send slackfix.sh "I killed a slack window ($ev) that looked like it was bugging out. If this is a problem, kill the shell running the 'slackfix.sh' script."
done
