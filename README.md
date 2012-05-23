Building
--------

Use the toplevel makefile. Have a look at the targets.

There also a staticfetcher called by the Makefile that allows pulling in external resources (e.g. jQuery). They are defined in `statics.py`. Don't add the fetched files to Git!


Code Review
-----------

Let's do semi-proper code review: Everyone can just commit, but make sure every commit is reviewed by somebody else shortly after.


Testing
-------

Make sure you know how to write jasmine tests. Commit the tests with the code.


Links
-----

* [Jasmine](https://github.com/pivotal/jasmine/wiki) for testing. Especially [Matchers](https://github.com/pivotal/jasmine/wiki/Matchers) and [Suites and Specs](https://github.com/pivotal/jasmine/wiki/Suites-and-specs)
* [CoffeeScript](http://js2coffee.org) and [js2coffee](http://js2coffee.org)
* [git ready](http://gitready.com)
* [Raphael](http://raphaeljs.com/reference.html)
* [knockout](http://knockoutjs.com/) for everything outside the canvas. Work through the [tutorial](http://learn.knockoutjs.com/)

Installing on OS X
==================

Basic setup
------------------
* install [homebrew] (https://github.com/mxcl/homebrew)
* run ```brew install node``` to install node.js
* run ```curl http://npmjs.org/install.sh | sh```
* run ```npm install -g coffee-script``` to install coffeescript
* run ```brew install wget``` to ensure the make file can download the libraries
* run ```make``` inside the project root to install all the library files


Installing Sublime
---------------
* Download [sublime] (http://www.sublimetext.com/2)
* Add Package manager
  * Visit [package manager](http://wbond.net/sublime_packages/package_control/installation) and copy the huge chunk of text
  * Press ctrl+(the plus/minus key thignn top left of keyboard), copy in the chunk and press enter
* Now install coffeescript package
  * cmd+shift+p
  * type install, enter
  * start typing coffeescript, enter
* Install git package
  * Same as Coffeescript but typing git

Setting up server
-----------------

* Go to the server directory ```cd server```
* run ```sudo npm link``` to install dependencies



Running the server(s)
------------------

* From top level server
 * ```make server```, this starts the main node server
 * ```make dev```, this starts the second python server to serve assets