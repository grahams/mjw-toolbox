#!/bin/sh

# wait seconds
limit=30

# get the charging state of the UPS
CHARGING=$(sysctl -n hw.sensors.upd0.indicator1)

# If the UPS is currently charging, do nothing.
if [[ "$CHARGING" = "On (Charging), OK" ]]; then
  logger "power is on, do nothing \($1, $2\)"
  return
fi

# If the UPS is on battery and the threshold is below the setting, shutdown in 2min
if [[ "$2" = "below" ]]; then
  logger "battery below $1, shutting down in ${limit} seconds."
  sleep ${limit}
  logger "battery at $1, shutting down now."

  # shutdown other boxes
  ssh root@host1 "halt -p"
  ssh root@host2 "halt -p"
  ssh root@host3 "halt -p"

  # shutdown myself
  halt -p
fi
