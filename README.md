Alloy preformatter
==================

Simple alloy tasks to precompile files :

1. .jade to .xml
2. .coffee to .js
3. .tss.coffee to .tss

Requirements
------------

    npm install -g glob jade coffee-script

Installation
------------
Download alloy.jmk + put it into your app folder, create .jade or .tss.coffee or .coffee files, enjoy.

    wget https://raw.github.com/vbrajon/alloy-preformatter/master/alloy.jmk

Developpement
-------------
Modify coffee file and recompile it with

    coffee -pb alloy.jmk.coffee 1> alloy.jmk
Then you can retry compilation :)

    alloy compile

-------------

Thanks a lot for the following ressources :

* http://www.yydigital.com/blog/2012/11/8/Alloy_With_Jade
* https://github.com/brantyoung/coffee-alloy
* https://github.com/vastness/lazy-alloy
* https://npmjs.org/package/lazy-alloy
