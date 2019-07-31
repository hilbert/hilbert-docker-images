#!/bin/sh
#
# Some content (images, ...) unfortunately cannot be made public
# and hence is only is available for ESO locally (password-protected)
# Replace free image alternatives with the non-free version here.
# This needs credentials in environment variable $DP_CREDENTIALS

#set -x 

try_replace_file () {
    local url="$1"
    local destfile="$2"
    local tmp_file=/tmp/dp_download

    if [ -z "$DP_CREDENTIALS" ] ; then
        echo "[+] No DP_CREDENTIALS present. Using default free version."
        exit 0
    fi

    echo "[+] Checking if non-free image can be retrieved from $url ..."
    curl --fail --user "$DP_CREDENTIALS" "$url" --output "$tmp_file"

    if [ "$?" -eq 0 ] ; then
	echo "[+] Successful. Replacing image at location $destfile."
	mv "$tmp_file" "$destfile"
        if [ "$?" -eq 0 ] ; then
            echo "$destfile was replaced with content from $url" >"$destfile".info
        else
            echo "ERROR: $destfile could not be replaced with content from $url."
            exit 1
        fi
    else
	echo "[+] Could not retrieve non-free images. Using default free version."
    fi
}

### MAIN

script=$( basename $0 )
url="$1"
destfile="$2"

if [ "$url" -a "$destfile" ] ; then
    echo "[+] Script: $script '$url' '$destfile' ..."
    try_replace_file "$url" "$destfile"
    echo "[+] Done."
else
    echo "Usage:"
    echo "$script SOURCE_URL DEST_FILEPATH"
fi

