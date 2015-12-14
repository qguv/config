var MARGIN = 22;

slate.config("keyboardLayout", "colemak");

// Fullscreen
slate.bind('return:cmd,alt', function(w) {
  w.doOperation(S.op('move', {
		'x': 'screenOriginX + ' + MARGIN,
		'y': 'screenOriginY + ' + MARGIN,
		'width': 'screenSizeX - ' + (MARGIN * 2),
		'height': 'screenSizeY - ' + (MARGIN * 2),
	}));
});

// Fullscreen without gap
slate.bind('return:cmd,alt,shift', function(w) {
	w.doOperation(S.op('move', {
		'x': 'screenOriginX',
		'y': 'screenOriginY',
		'width': 'screenSizeX',
		'height': 'screenSizeY',
	}));
});

// Push Right
slate.bind('right:cmd,alt', function(w) {
	w.doOperation(S.op('move', {
		'x': 'screenSizeX / 2 + ' + (MARGIN / 2),
		'y': 'screenOriginY + ' + MARGIN,
		'width': 'screenSizeX / 2 - ' + (MARGIN * 3 / 2),
		'height': 'screenSizeY - ' + (MARGIN * 2),
	}));
});

// Push Left
slate.bind('left:cmd,alt', function(w) {
	w.doOperation(S.op('move', {
		'x': 'screenOriginX + ' + MARGIN,
		'y': 'screenOriginY + ' + MARGIN,
		'width': 'screenSizeX / 2 - ' + (MARGIN * 3 / 2),
		'height': 'screenSizeY - ' + (MARGIN * 2),
	}));
});

// Push Down
slate.bind('down:cmd,alt', function(w) {
	w.doOperation(S.op('move', {
		'x': 'windowTopLeftX',
		'y': 'screenSizeY / 2 + ' + MARGIN / 2,
		'height': 'screenSizeY / 2 -' + 3 * MARGIN / 2,
		'width': 'windowSizeX'
	}));
});

// Push Up
slate.bind('up:cmd,alt', function(w) {
	w.doOperation(S.op('move', {
		'x': 'windowTopLeftX',
		'y': MARGIN,
		'height': 'screenSizeY / 2 -' + 3 * MARGIN / 2,
		'width': 'windowSizeX'
	}));
});

// Find
slate.bind('/:cmd,alt', function(w) {
    w.doOperation(S.op('hint', {
        'characters': 'fdsagrewq',
        'display': 'tsradpfwq'
    }));
});

// Reload Slate
slate.bind('1:cmd,alt,shift', function(w) {
	w.doOperation(S.op('relaunch'));
});

// adapted from https://gist.github.com/leb2/5af57cd4b011937dc6e0
/* vi: set et sw=2 sts=2 nolist nornu: */
