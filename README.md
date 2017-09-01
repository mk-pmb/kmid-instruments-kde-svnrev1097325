
<!--#echo json="package.json" key="name" underline="=" -->
kmid-instruments-kde-svnrev1097325
==================================
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
Instrument list for KMid from KDE SVN revision 1097325.
<!--/#echo -->

If you prefer the GM1 (General MIDI Level 1) patch names,
check package [`midi-instrument-names-gm1-pmb`][gm1-pkg].

  [gm1-pkg]: https://www.npmjs.com/package/midi-instrument-names-gm1-pmb


Files
-----

* `build/`
  * `build.sh`: Bash script to download the original files from the KDE
    WebSVN ([show r1097325][websvn-rev]) and generate the other files.
  * `r1097325/`
    * `COPYING`: original license file.
    * `src-instrumentset.cpp`: original source code.
* `dist/`
  * `kmid-inst.json`: Instrument list as JSON data.
  * `kmid-inst.amd.js`: Same JSON, wrapped in `define(…)` for AMD.
    [GitHub pages link.][ghp-amd]

  [websvn-rev]: https://websvn.kde.org/?view=revision&revision=1097325
  [ghp-amd]: https://mk-pmb.github.io/kmid-instruments-kde-svnrev1097325/dist/kmid-inst.amd.js



Usage
-----

from [test.js](test.js):

<!--#include file="test.js" start="  //#u" stop="  //#r"
  outdent="  " code="javascript" -->
<!--#verbatim lncnt="9" -->
```javascript
var kmidInst = require('kmid-instruments-kde-svnrev1097325');

// verify some differences from the GM1 patch table:
same(kmidInst.slice(4, 7),
  [ 'Honky-Tonk', 'Rhodes Piano', 'Chorused Piano' ]);
same(kmidInst[17], 'Hammond Organ');
same(kmidInst[125], 'Telephone');
```
<!--/include-->



<!--#toc stop="scan" -->



&nbsp;


License
-------
<!--#echo json="package.json" key=".license" -->
GPL-2.0+
<!--/#echo -->
<!--#echo json="dist/kmid-inst.json" key=".0.orig_author" -->
Copyright (C) 2009-2010 Pedro Lopez-Cabanillas &lt;plcl@users.sf.net&gt;
<!--/#echo -->
Packaged for npm by @mk-pmb
