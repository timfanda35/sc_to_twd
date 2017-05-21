#!/bin/bash

# This script is estimate Siacoin value with NTD
#
# Usage:
#
#     ./sctwd.sh SC_AMOUNT [TWD_COST]
#
# Requirement: jq
# https://stedolan.github.io/jq/
#
# Recommond installation:
#
#     brew install jq
#
# Yunbi API:
# https://yunbi.zendesk.com/hc/zh-cn/articles/115005892327-API-%E5%BC%80%E5%8F%91%E8%80%85%E6%8E%A5%E5%8F%A3
#
# Google Finance API
# https://www.google.com/finance/info?q=CURRENCY:CNYTWD
# http://blog.xuite.net/stuart_lin/nbxtour/481423434

# Check requirement
r=`which jq`
if [ -z "$r" ]
then
  echo "Requirement:"
  echo "    jq is required, see https://stedolan.github.io/jq/ for more information"
  echo
  exit 1
fi

# Check the parameter number
if [ $# -lt 1 ]
then
  echo "Usage: sctwd.sh SC_AMOUNT [TWD_COST]"
  echo
  exit 0
fi

echo "== Siacoin to TWD =="

# Check API health Status
YUNBI_API_STATUS=`curl -s -I https://yunbi.com//api/v2/tickers.json | head -n 1 | cut -d$' ' -f2`
GOOGLE_FINANCE_API_STATUS=`curl -s -I https://www.google.com/finance/info?q=CURRENCY:CNYTWD | head -n 1 | cut -d$' ' -f2`

if [ $YUNBI_API_STATUS -ne "200" ]
then
  echo "Yunbi API Status: $YUNBI_API_STATUS"
  echo "Wait for minutes to rety..."
  exit 1
fi

if [ $GOOGLE_FINANCE_API_STATUS -ne "200" ]
then
  echo "Google Finance API Status: $GOOGLE_FINANCE_API_STATUS"
  echo "Wait for minutes to rety..."
  exit 1
fi

# Get finance data
SCCNY=`curl -s -X GET --header 'Accept: application/json' 'https://yunbi.com//api/v2/tickers.json' | jq .sccny.ticker.sell | sed 's/"//g'`
CNYTWD=`curl -s https://www.google.com/finance/info?q=CURRENCY:CNYTWD | sed 's/\/\///' | jq .[0].l | sed 's/"//g'`
TWD=`echo "$1 * $SCCNY * $CNYTWD" | bc`

echo "SC Amount: $1"
echo "SC/CNY   : $SCCNY"
echo "CNY/TWD  : $CNYTWD"
echo "TWD      : $TWD"

# Show cost and earn
if [ $# -gt 1 ]
then
  echo "--------------------"
  echo "TWD COST : $2"
  echo "Earn TWD : `echo "$TWD - $2" | bc`"
  echo "%        : `echo "scale = 3; ($TWD - $2) / $2 * 100" | bc -l`%"
  echo
fi
