#!/bin/sh
set -e

while true; do
	cid="$(swaymsg --type subscribe '["window"]' | jq '
		if (
			.change == "new"
			and .container.window_properties.class == "Slack"
			and .container.geometry.width == 300
			and .container.geometry.height == 56
		) then
			.container.id
		else
			empty
		end
	')"

	[ -z "$cid" ] && continue
	swaymsg '[con_id='"$cid"']' kill
done
