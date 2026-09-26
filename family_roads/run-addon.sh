#!/bin/bash
# Start Valhalla from the add-on data volume, mounted at /custom_files.
# The first start with an empty volume downloads the regional map and builds
# the road graph. Later starts load the tiles that are already there.
set -eu

if [ "$(id -u)" -eq 0 ]; then
  mkdir -p /custom_files
  tiles_ready=false
  if [ -f /custom_files/valhalla_tiles.tar ]; then
    tiles_ready=true
  elif [ -n "$(ls -A /custom_files/valhalla_tiles 2>/dev/null || true)" ]; then
    tiles_ready=true
  fi
  if [ "$tiles_ready" = false ] && [ ! -f /custom_files/region.osm.pbf ]; then
    /usr/local/bin/prepare-map.sh
  fi
  chown -R 59999:59999 /custom_files
  exec su --preserve-environment --shell /bin/bash valhalla -- /valhalla/scripts/run.sh build_tiles
fi

exec /valhalla/scripts/run.sh build_tiles
