#!/bin/bash
​
ID=$1
NUM=10
MAX_POSTS=1000
COUNT=`expr $MAX_POSTS / $NUM`
declare -a OUTPUT=()
AFTER='QVFEQnNidDVCOVBHOEs4dlFNUDdCeWNiNnRWNlFvSndjSk5XTlB1UlFSRUR4N3ctTzE0b2pIQ1NpUTYxTFdDTFMyckNJMmhVVnJndUJ6NTRWVnotaUhOQw%3D%3D'
# echo $COUNT
for itr in {1..50}
do    
    # echo $itr
    URL=$(echo 'https://www.instagram.com/graphql/query/?query_hash=f2405b236d85e8296cf30347c9f08c2a&variables=%7B%22id%22%3A%221757894435%22%2C%22first%22%3A20%2C%22after%22%3A%22'"$AFTER"'%22%7D')
    # echo $URL
    URL=$(echo $URL | tr -d '"')
    # echo $URL
    RESPONSE=$(curl $URL -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:66.0) Gecko/20100101 Firefox/66.0' -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: https://www.instagram.com/bjp4india/?hl=en' -H 'X-Instagram-GIS: c6fdb6766d2de4a17ca69d91f4b09208' -H 'X-IG-App-ID: 936619743392459' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' -H 'Cookie: csrftoken=IxeWDFCoIl5h8zbMuLxgWaCUptTSMvWY; mid=W3ujgwAEAAElC67tndM9xATgTQtb; mcd=3; csrftoken=IxeWDFCoIl5h8zbMuLxgWaCUptTSMvWY; fbm_124024574287414=base_domain=.instagram.com; ds_user_id=12721280434; sessionid=12721280434%3ANFq7nob8q7N6Sc%3A29; shbid=14007; shbts=1555096451.665651; rur=FTW; urlgen="{\"14.139.82.6\": 55824}:1hFGee:COOxwq8H_Q20a0E0VbrWjDhFxWc"' -H 'TE: Trailers')
    # echo $RESPONSE
    # break
    AFTER=$(echo $RESPONSE | jq '.data.user.edge_owner_to_timeline_media.page_info.end_cursor')
    AFTER=${AFTER//'='/'%3D'}
    # echo $AFTER
    for c in {0..19}
    do
        # idx=`expr $c - 1`
        # echo $c
        POST=$(echo $RESPONSE | jq '.data.user.edge_owner_to_timeline_media.edges['"$c"']')
        # echo $POST
        # break
        if [ $c == 0 ] && [ $itr == 1 ]
            then
                OUTPUT+=$(echo $POST)
            else
                # echo $c $itr
                OUTPUT+=', '
                OUTPUT+=$(echo $POST)
        fi
        # echo $OUTPUT
        # break
    done
    # break
done
​
# joined=$( set -- a{b,c,d}; IFS=,; echo "$*" )
OUTPUT=$( set -- $OUTPUT; IFS=,; echo "$OUTPUT" )
# OUTPUT=$(echo  $OUTPUT)
OUTPUT=$(echo "[$OUTPUT]")
echo $OUTPUT