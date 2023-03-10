#!/bin/sh

EVENT=${1:-short-press}

LONG_PRESS_TIMEOUT=3 # s
DEBOUNCE=2 # s
PIDFILE="/tmp/$(basename $0).pid"
LOCKFILE=/tmp/.power_key

short_press()
{
	logger -t $(basename $0) "[$$]: Power key short press..."

	if which systemctl >/dev/null; then
		SUSPEND_CMD="systemctl suspend"
	elif which pm-suspend >/dev/null; then
		SUSPEND_CMD="pm-suspend"
	else
		SUSPEND_CMD="echo -n mem > /sys/power/state"
	fi

	if [ ! -f $LOCKFILE ]; then
		logger -t $(basename $0) "[$$]: Prepare to suspend..."

		touch $LOCKFILE
		sh -c "$SUSPEND_CMD"
		{ sleep $DEBOUNCE && rm $LOCKFILE; }&
	fi
}

long_press()
{
	logger -t $(basename $0) "[$$]: Power key long press (${LONG_PRESS_TIMEOUT}s)..."

	logger -t $(basename $0) "[$$]: Prepare to power off..."

	poweroff
}

logger -t $(basename $0) "[$$]: Received power key event: $@..."

case "$EVENT" in
	press)
		# Lock it
		exec 3<$0
		flock -x 3

		start-stop-daemon -K -q -p $PIDFILE || true
		start-stop-daemon -S -q -b -m -p $PIDFILE -x /bin/sh -- \
			-c "sleep $LONG_PRESS_TIMEOUT; $0 long-press"

		# Unlock
		flock -u 3
		;;
	release)
		# Avoid race with press event
		sleep .5

		start-stop-daemon -K -q -p $PIDFILE && short_press
		;;
	short-press)
		short_press
		;;
	long-press)
		long_press
		;;
esac
