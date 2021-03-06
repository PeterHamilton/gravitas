#!/usr/bin/env python


ROOT_DIR = '.'

STATICS = {
	'client/js/lib/jasmine.js': 'https://raw.github.com/pivotal/jasmine/master/lib/jasmine-core/jasmine.js',
	'client/js/lib/jasmine-html.js': 'https://raw.github.com/pivotal/jasmine/master/lib/jasmine-core/jasmine-html.js',
	'client/css/lib/jasmine.css': 'https://raw.github.com/pivotal/jasmine/master/lib/jasmine-core/jasmine.css',

	'client/js/lib/CoffeeScript.js': 'https://raw.github.com/jashkenas/coffee-script/master/extras/coffee-script.js',

	'client/js/lib/run_jasmine_test.coffee': 'https://raw.github.com/nh2/phantom-jasmine/fix-long-running-tests/lib/run_jasmine_test.coffee',

	'client/js/lib/knockout.js': 'http://cloud.github.com/downloads/SteveSanderson/knockout/knockout-2.1.0.js',
	'client/js/lib/knockout.mapping.js': 'https://raw.github.com/SteveSanderson/knockout.mapping/master/build/output/knockout.mapping-latest.js',

	'client/js/lib/sonic.js': 'https://raw.github.com/padolsey/Sonic/master/src/sonic.js',

	# 'lib/jsschema.js': 'https://raw.github.com/nh2/jsschema/schemafields/jsschema.js',
	# 'runtogether.py': 'https://raw.github.com/nh2/runtogether/master/runtogether.py',

	'client/js/lib/jquery.js': 'http://code.jquery.com/jquery.min.js',
	'client/js/lib/jquery.cookie.js': 'https://raw.github.com/carhartl/jquery-cookie/master/jquery.cookie.js',

	# Raphael for simple graphics manipulation
	'client/js/lib/raphael.js': 'https://raw.github.com/DmitryBaranovskiy/g.raphael/master/raphael-min.js',
	'client/js/lib/g.raphael.js': 'https://raw.github.com/DmitryBaranovskiy/g.raphael/master/min/g.raphael-min.js',
	'client/js/lib/g.pie.js': 'https://raw.github.com/DmitryBaranovskiy/g.raphael/master/min/g.pie-min.js',
	'client/js/lib/g.line.js': 'https://raw.github.com/DmitryBaranovskiy/g.raphael/master/g.line.js',
	'client/js/lib/date.format.1.2.3.min.js': 'http://www.exratione.com/assets/date.format.1.2.3.min.js',


	# Runtogether to run multiple daemons in parallel
	'runtogether.py': 'https://raw.github.com/nh2/runtogether/master/runtogether.py',

	'server/lib/underscore.js': 'http://underscorejs.org/underscore.js',

	# Browser testing
	'client/css/lib/mocha.css': 'https://raw.github.com/visionmedia/mocha/master/mocha.css',
	'client/js/lib/mocha.js': 'https://raw.github.com/visionmedia/mocha/master/mocha.js',
	'client/js/lib/chai.js': 'http://chaijs.com/chai.js',

	# require.js
	'server/lib/r.js': 'http://requirejs.org/docs/release/2.0.1/r.js',
	'client/js/lib/require.js': 'http://requirejs.org/docs/release/2.0.1/minified/require.js',
	'client/js/lib/cs.js': 'https://raw.github.com/jrburke/require-cs/latest/cs.js',
}


if __name__ == '__main__':
	import staticfetcher
	staticfetcher.Staticfetcher(STATICS, ROOT_DIR).run()
