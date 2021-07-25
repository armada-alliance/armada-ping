#!/bin/bash

# Armada Ping - Config
# ======================
ARMADA_TOKEN=
ARMADA_ENDPOINT=https://api.sublayer.io/armada-api/ping
PROMETHEUS_JOB="prometheus"
PROMETHEUS_ALIAS="block-producer-node"
PROMETHEUS_INSTANCE="localhost:12798"
PROMETHEUS_TYPE="cardano-node"

# Don't edit below this line
# ==========================

NODE_VERSION=$(cardano-node version | cut -d ' ' -f 2 | awk '/1/ {print}')
SLOT_HEIGHT=$(curl -gs 'http://127.0.0.1:9090/api/v1/query?query=cardano_node_metrics_slotNum_int{alias="'$PROMETHEUS_ALIAS'",instance="'$PROMETHEUS_INSTANCE'",job="'$PROMETHEUS_JOB'",type="'$PROMETHEUS_TYPE'"}' | jq -r '.data.result[].value[1]')
REMAINING_KES_PERIODS=$(curl -gs 'http://127.0.0.1:9090/api/v1/query?query=cardano_node_metrics_remainingKESPeriods_int{alias="'$PROMETHEUS_ALIAS'",instance="'$PROMETHEUS_INSTANCE'",job="'$PROMETHEUS_JOB'",type="'$PROMETHEUS_TYPE'"}' | jq -r '.data.result[].value[1]')

JSON_STRING=$( jq -n \
                  --arg node_version "$NODE_VERSION" \
                  --arg slot_height "$SLOT_HEIGHT" \
                  --arg remaining_kes_periods "$REMAINING_KES_PERIODS" \
                  '{ node_version: $node_version, slot_height: $slot_height, remaining_kes_periods: $remaining_kes_periods }' )

echo $(date) $JSON_STRING

curl --header "Authorization: Bearer $ARMADA_TOKEN" \
  --header "Content-Type: application/json" \
  --silent \
  --output /dev/null \
  --request POST \
  --data "$JSON_STRING" \
  $ARMADA_ENDPOINT