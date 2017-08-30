#!/bin/sed -nurf
# -*- coding: UTF-8, tab-width: 2 -*-

s~\a~~g

/KMid2/{
  N
  s~^\s*~\a{ "license": "GPL-2.0+", "extracted_from": "~
  s~\s*\n\s*~", "orig_author": "~
  s~\s*$~", "orig_file": "\
    https://websvn.kde.org/trunk/extragear/multimedia/kmid/\
    #svn_file#\
    ?revision=#svn_rev#\&view=markup\&pathrev=#svn_rev#\
    ", "instruments": [~
  s~\s*\n\s+~~g
  s~<~\\u003C~g
  s~>~\\u003E~g
}

s~^\s*m_names\.insert\(([0-9]+), i18nc\("@item:[^"]+",($\
  |"[^"]+")\)+\;\s*~\1\a\2,~
/^127\a/s~,$~ ]}~

s~^([0-9]+)\a~\a~
s~^\a~~p
