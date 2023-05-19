#!/bin/bash

until curl -s -o /dev/null "http://example.com"; do
  continue
done

redshift-gtk -l $(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | awk 'OFS=":" {print $3,$5}' | tr -d ',}') -t 6500:3000
