/*jslint indent: 2, maxlen: 80, node: true */
/* -*- tab-width: 2 -*- */
'use strict';

var same = require('assert').deepStrictEqual, pkg = require('./package.json');

(function readmeDemo() {
  //#u
  var kmidInst = require('kmid-instruments-kde-svnrev1097325');

  // verify some differences from the GM1 patch table:
  same(kmidInst.slice(4, 7),
    [ 'Honky-Tonk', 'Rhodes Piano', 'Chorused Piano' ]);
  same(kmidInst[17], 'Hammond Organ');
  same(kmidInst[125], 'Telephone');
  //#r

  same(pkg.license, kmidInst[0].license);
  same(pkg.author,
    kmidInst[0].orig_author.replace(/^Copyright \(C\) \d+-\d+ /, ''));
}());









console.log("+OK tests passed.");   //= "+OK tests passed."
