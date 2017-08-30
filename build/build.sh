#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function build () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m "$BASH_SOURCE"/..)"
  cd "$SELFPATH" || return $?

  local SVN_REV=1097325
  local CPP_PATH='src/instrumentset.cpp'
  mkdir -p "r$SVN_REV" || return $?
  svn_dl '7c203dee3a03037da436df03c4b25b659c073976' COPYING || return $?
  svn_dl '8b60b7b26743c7c6fefb41fe8ecf7f3c61776b90' "$CPP_PATH" || return $?

  echo -n 'Generating dist files... '
  mkdir -p "../dist" || return $?
  local INST_LIST="$(sed -nurf cpp2json.sed -- "r$SVN_REV/${CPP_PATH//\//-}")"
  [ -n "$INST_LIST" ] || return 4$(
    echo 'E: failed to extract instrument list' >&2)
  INST_LIST="${INST_LIST//##svn_rev##/$SVN_REV}"
  INST_LIST="${INST_LIST//##svn_file##/$CPP_PATH}"

  echo "$INST_LIST" >../dist/kmid-inst.json || return $?
  echo "define($INST_LIST);" >../dist/kmid-inst.amd.js || return $?

  echo 'done.'
  return 0
}


function svn_dl () {
  local SHA1_WANT="$1"; shift
  local ORIG_FN="$1"; shift
  local URL="
    https://websvn.kde.org/%2Acheckout%2A/trunk/extragear/multimedia/kmid/
    $ORIG_FN
    ?revision=$SVN_REV
    "
  URL="${URL// /}"
  URL="${URL//$'\n'/}"
  local SAVE_FN="$ORIG_FN"
  SAVE_FN="${SAVE_FN//\//-}"
  SAVE_FN="r$SVN_REV/$SAVE_FN"
  echo -n "$FUNCNAME: $SAVE_FN"
  if [ -s "$SAVE_FN" ]; then
    echo ': already in cache.'
  else
    echo " <- $URL :"; echo
    local UAGENT='Mozilla/5.0 (actually, wget) Gecko/19700101 Firefox/0.0'
    wget --user-agent="$UAGENT" -O "$SAVE_FN.part" -c "$URL" || return $?
    mv --verbose --no-target-directory -- "$SAVE_FN"{.part,} || return $?
    echo
  fi

  local SHA1_HAVE="$(sha1sum --binary <"$SAVE_FN" | tr -d ' \t*-')"
  [ "$SHA1_HAVE" == "$SHA1_WANT" ] || return 4$(
    echo "E: bad checksum: $SHA1_HAVE, expected $SHA1_WANT for $SAVE_FN" >&2)
  return 0
}










[ "$1" == --lib ] && return 0; build "$@"; exit $?
