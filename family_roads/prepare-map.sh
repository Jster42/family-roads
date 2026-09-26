#!/bin/sh
# Build one regional map on an empty add-on volume.
# Massachusetts, Connecticut, and Rhode Island are included whole.
# New Hampshire and Vermont are clipped to the southern box.
set -eu

mkdir -p /custom_files/src
cd /custom_files/src

for name in massachusetts connecticut rhode-island new-hampshire vermont; do
  curl -fL --retry 3 -o "$name.osm.pbf" \
    "https://download.geofabrik.de/north-america/us/${name}-latest.osm.pbf"
done

osmium extract --overwrite -b -73.55,40.95,-69.90,43.45 new-hampshire.osm.pbf -o nh-south.osm.pbf
osmium extract --overwrite -b -73.55,40.95,-69.90,43.45 vermont.osm.pbf -o vt-south.osm.pbf
osmium merge \
  massachusetts.osm.pbf \
  connecticut.osm.pbf \
  rhode-island.osm.pbf \
  nh-south.osm.pbf \
  vt-south.osm.pbf \
  -o /custom_files/region.osm.pbf

rm -rf /custom_files/src
ls -lh /custom_files/region.osm.pbf
