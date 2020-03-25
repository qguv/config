GRIM="$HOME/build/grim/build/grim"
SLURP="$HOME/build/slurp/build/slurp"

case "$1" in
	region)
		exec "$GRIM" -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | "$SLURP")"
		;;
	monitor)
		exec "$GRIM" -o "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')"
		;;
esac
