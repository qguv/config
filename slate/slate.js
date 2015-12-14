var MARGIN = 22;

slate.config("keyboardLayout", "colemak");

function center(w, xmin, xsize, ymin, ysize) {
  w.move({
    'x': '(' + xmin + ') + ((' + xsize + ') - (' + w.size().width + ')) / 2',
    'y': '(' + ymin + ') + ((' + ysize + ') - (' + w.size().height + ')) / 2',
  });
}

// try fullscreen with gaps
slate.bind('return:cmd,alt', function(w) {
  w.doOperation(S.op('move', {
		'x': 'screenOriginX + ' + MARGIN,
		'y': 'screenOriginY + ' + MARGIN,
		'width': 'screenSizeX - ' + (MARGIN * 2),
		'height': 'screenSizeY - ' + (MARGIN * 2),
	}));

  // put whatever size remains in the middle of the screen
  center(w, 'screenOriginX', 'screenSizeX', 'screenOriginY', 'screenSizeY');
});

// try fullscreen without gaps
slate.bind('return:cmd,alt,shift', function(w) {
	w.doOperation(S.op('move', {
		'x': 'screenOriginX',
		'y': 'screenOriginY',
		'width': 'screenSizeX',
		'height': 'screenSizeY',
	}));

  // put whatever size remains in the middle of the screen
  center(w, 'screenOriginX', 'screenSizeX', 'screenOriginY', 'screenSizeY');
});

// try to fill the right panel
slate.bind('right:cmd,alt', function(w) {
	w.doOperation(S.op('move', {
		'x': 'screenSizeX / 2 + ' + (MARGIN / 2),
		'y': 'screenOriginY + ' + MARGIN,
		'width': 'screenSizeX / 2 - ' + (MARGIN * 3 / 2),
		'height': 'screenSizeY - ' + (MARGIN * 2),
	}));

  // put whatever size remains in the middle of the right panel
  center(w, 'screenOriginX + screenSizeX / 2', 'screenSizeX / 2', 'screenOriginY', 'screenSizeY');
});

// try to fill the left panel
slate.bind('left:cmd,alt', function(w) {
	w.doOperation(S.op('move', {
		'x': 'screenOriginX + ' + MARGIN,
		'y': 'screenOriginY + ' + MARGIN,
		'width': 'screenSizeX / 2 - ' + (MARGIN * 3 / 2),
		'height': 'screenSizeY - ' + (MARGIN * 2),
	}));

  // put whatever size remains in the middle of the left panel
  center(w, 'screenOriginX', 'screenSizeX / 2', 'screenOriginY', 'screenSizeY');
});

// push to the bottom half of the current panel/screen
slate.bind('down:cmd,alt', function(w) {
	w.doOperation(S.op('move', {
		'x': 'windowTopLeftX',
		'y': 'screenSizeY / 2 + ' + MARGIN / 2,
		'height': 'screenSizeY / 2 -' + 3 * MARGIN / 2,
		'width': 'windowSizeX'
	}));
});

// push to the top half of the current panel/screen
slate.bind('up:cmd,alt', function(w) {
	w.doOperation(S.op('move', {
		'x': 'windowTopLeftX',
		'y': MARGIN,
		'height': 'screenSizeY / 2 -' + 3 * MARGIN / 2,
		'width': 'windowSizeX'
	}));
});

// show window hints
slate.bind('/:cmd,alt', function(w) {
  w.doOperation(S.op('hint', {
    'characters': 'tsradpfwq'
  }));
});

// relaunch slate and reload configuration
slate.bind('1:cmd,alt,shift', function(w) {
	w.doOperation(S.op('relaunch'));
});

// adapted from https://gist.github.com/leb2/5af57cd4b011937dc6e0
/* vi: set et sw=2 sts=2 nolist nornu: */
