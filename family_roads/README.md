# Family Roads

Local road router for the family map on Home Assistant.

It covers Massachusetts, Connecticut, Rhode Island, and New Hampshire and Vermont south of 43.45°N. The family map calls port 8002. A point outside that box uses the public road service.

The first start on an empty volume downloads the map and builds the road graph. That can take a while and use several gigabytes of memory. After the tiles exist, the add-on only serves them.

Raise the version in `family_roads/config.yaml` and push this repository. Home Assistant then offers the update in the add-on store. Turn on auto-update on the add-on page if you want that to happen by itself.
