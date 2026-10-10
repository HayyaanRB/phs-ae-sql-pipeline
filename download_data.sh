#!/usr/bin/env bash
# Downloads the three Public Health Scotland open data files into ./data.
# Source: https://www.opendata.nhs.scot (UK Open Government Licence v3.0)
#
# PHS republishes the A&E file monthly and the file name in the link can
# change. If the A&E download fails, open the resource page below, copy
# the current "Download" link and paste it into AE_URL.
#   https://www.opendata.nhs.scot/dataset/997acaa5-afe0-49d9-b333-dcf84584603d/resource/37ba17b1-c323-492c-87d5-e986aae9ab59
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p data

HB_URL="https://www.opendata.nhs.scot/dataset/9f942fdb-e59e-44f5-b534-d6e17229cc7b/resource/652ff726-e676-4a20-abda-435b98dd7bdc/download/hb14_hb19.csv"
HOSP_URL="https://www.opendata.nhs.scot/dataset/cbd1802e-0e04-4282-88eb-d7bdcfb120f0/resource/c698f450-eeed-41a0-88f7-c1e40a568acc/download/hospitals.csv"
AE_URL="https://www.opendata.nhs.scot/dataset/997acaa5-afe0-49d9-b333-dcf84584603d/resource/37ba17b1-c323-492c-87d5-e986aae9ab59/download/monthly_ae_activity_202606.csv"

curl -fL -o data/hb14_hb19.csv          "$HB_URL"
curl -fL -o data/hospitals.csv          "$HOSP_URL"
curl -fL -o data/monthly_ae_activity.csv "$AE_URL"

echo
echo "Downloaded:"
wc -l data/*.csv
echo
echo "First line of each file (check the column names):"
for f in data/*.csv; do echo "--- $f"; head -n 1 "$f"; done
