part of virtual_keyboard;

/// Keys for Virtual Keyboard's rows.
final List<List<KeyDescription>> full = [
  // Row 1
  [
    KeyDescription(keyLayouts: [
      ['ESC']
    ], value: 'escape', keyCode: 27),
    KeyDescription(keyLayouts: [
      ['F1']
    ], value: 'f1', keyCode: 112),
    KeyDescription(keyLayouts: [
      ['F2']
    ], value: 'f2', keyCode: 113),
    KeyDescription(keyLayouts: [
      ['F3']
    ], value: 'f3', keyCode: 114),
    KeyDescription(keyLayouts: [
      ['F4']
    ], value: 'f4', keyCode: 115),
    KeyDescription(keyLayouts: [
      ['F5']
    ], value: 'f5', keyCode: 116),
    KeyDescription(keyLayouts: [
      ['F6']
    ], value: 'f6', keyCode: 117),
    KeyDescription(keyLayouts: [
      ['F7']
    ], value: 'f7', keyCode: 118),
    KeyDescription(keyLayouts: [
      ['F8']
    ], value: 'f8', keyCode: 119),
    KeyDescription(keyLayouts: [
      ['F9']
    ], value: 'f9', keyCode: 120),
    KeyDescription(keyLayouts: [
      ['F10']
    ], value: 'f10', keyCode: 121),
    KeyDescription(keyLayouts: [
      ['F11']
    ], value: 'f11', keyCode: 122),
    KeyDescription(keyLayouts: [
      ['F12']
    ], value: 'f12', keyCode: 123),
    KeyDescription(keyLayouts: [
      ['del']
    ], value: 'delete', keyCode: 46),
  ],
  [
    KeyDescription(keyLayouts: [
      ['1', '!']
    ], value: '1', keyCode: 49),
    KeyDescription(keyLayouts: [
      ['2', '@']
    ], value: '2', keyCode: 50),
    KeyDescription(keyLayouts: [
      ['3', '#'],
      ['3', '#']
    ], value: '3', keyCode: 51),
    KeyDescription(keyLayouts: [
      ['4', '\$'],
      ['4', ';']
    ], value: '4', keyCode: 52),
    KeyDescription(keyLayouts: [
      ['5', '%']
    ], value: '5', keyCode: 53),
    KeyDescription(keyLayouts: [
      ['6', '^'],
      ['6', ':']
    ], value: '6', keyCode: 54),
    KeyDescription(keyLayouts: [
      ['7', '&'],
      ['7', '?']
    ], value: '7', keyCode: 55),
    KeyDescription(keyLayouts: [
      ['8', '*']
    ], value: '8', keyCode: 56),
    KeyDescription(keyLayouts: [
      ['9', '(']
    ], value: '9', keyCode: 57),
    KeyDescription(keyLayouts: [
      ['0', ')']
    ], value: '0', keyCode: 48),
    KeyDescription(keyLayouts: [
      ['-', '_']
    ], value: '-', keyCode: 189),
    KeyDescription(keyLayouts: [
      ['=', '+']
    ], value: '=', keyCode: 187),
    KeyDescription(keyLayouts: [
      ['\\', '|'],
      ['\\', '/']
    ], value: '=', keyCode: 220),
    KeyDescription(keyLayouts: [
      [Icons.backspace]
    ], value: 'backspace', size: 12, keyCode: 8),
  ],
  // Row 2
  [
    KeyDescription(keyLayouts: [
      [Icons.keyboard_tab]
    ], value: 'tab', size: 14, keyCode: 9),
    KeyDescription(keyLayouts: [
      ['q', 'Q'],
      ['й', 'Й'],
    ], value: 'q', keyCode: 81),
    KeyDescription(keyLayouts: [
      ['w', 'W'],
      ['ц', 'Ц'],
    ], value: 'w', keyCode: 87),
    KeyDescription(keyLayouts: [
      ['e', 'E'],
      ['у', 'У'],
    ], value: 'e', keyCode: 69),
    KeyDescription(keyLayouts: [
      ['r', 'R'],
      ['к', 'К'],
    ], value: 'r', keyCode: 82),
    KeyDescription(keyLayouts: [
      ['t', 'T'],
      ['е', 'Е'],
    ], value: 't', keyCode: 84),
    KeyDescription(keyLayouts: [
      ['y', 'Y'],
      ['н', 'Н'],
    ], value: 'y', keyCode: 89),
    KeyDescription(keyLayouts: [
      ['u', 'U'],
      ['г', 'Г'],
    ], value: 'u', keyCode: 85),
    KeyDescription(keyLayouts: [
      ['i', 'I'],
      ['ш', 'Ш'],
    ], value: 'i', keyCode: 73),
    KeyDescription(keyLayouts: [
      ['o', 'O'],
      ['щ', 'Щ'],
    ], value: 'o', keyCode: 79),
    KeyDescription(keyLayouts: [
      ['p', 'P'],
      ['з', 'З'],
    ], value: 'p', keyCode: 80),
    KeyDescription(keyLayouts: [
      ['[', '{'],
      ['х', 'Х'],
    ], value: '[', keyCode: 219),
    KeyDescription(keyLayouts: [
      [']', '}'],
      ['ъ', 'Ъ'],
    ], value: ']', keyCode: 221),
    KeyDescription(keyLayouts: [
      [Icons.keyboard_return]
    ], value: 'enter', size: 16, keyCode: 13),
  ],
  // Row 3
  [
    KeyDescription(keyLayouts: [
      [Icons.keyboard_capslock]
    ], value: 'shift', size: 17, allowRepeat: false, sticky: true, keyCode: 16),
    KeyDescription(keyLayouts: [
      ['a', 'A'],
      ['ф', 'Ф']
    ], value: 'a', keyCode: 65),
    KeyDescription(keyLayouts: [
      ['s', 'S'],
      ['ы', 'Ы']
    ], value: 's', keyCode: 83),
    KeyDescription(keyLayouts: [
      ['d', 'D'],
      ['в', 'В']
    ], value: 'd', keyCode: 68),
    KeyDescription(keyLayouts: [
      ['f', 'F'],
      ['а', 'А']
    ], value: 'f', keyCode: 70),
    KeyDescription(keyLayouts: [
      ['g', 'G'],
      ['п', 'П']
    ], value: 'g', keyCode: 71),
    KeyDescription(keyLayouts: [
      ['h', 'H'],
      ['р', 'Р'],
    ], value: 'h', keyCode: 72),
    KeyDescription(keyLayouts: [
      ['j', 'J'],
      ['о', 'О']
    ], value: 'j', keyCode: 74),
    KeyDescription(keyLayouts: [
      ['k', 'K'],
      ['л', 'Л']
    ], value: 'k', keyCode: 75),
    KeyDescription(keyLayouts: [
      ['l', 'L'],
      ['д', 'Д']
    ], value: 'l', keyCode: 76),
    KeyDescription(keyLayouts: [
      [';', ':'],
      ['ж', 'Ж']
    ], value: ';', keyCode: 186),
    KeyDescription(keyLayouts: [
      ['\'', '"'],
      ['э', 'Э']
    ], value: '\'', keyCode: 222),
  ],
  // Row 4
  [
    KeyDescription(keyLayouts: [
      [Icons.file_upload]
    ], value: 'shift', size: 20, allowRepeat: false, sticky: false, keyCode: 16),
    KeyDescription(keyLayouts: [
      ['z', 'Z'],
      ['я', 'Я']
    ], value: 'z', keyCode: 90),
    KeyDescription(keyLayouts: [
      ['x', 'X'],
      ['ч', 'Ч']
    ], value: 'x', keyCode: 88),
    KeyDescription(keyLayouts: [
      ['c', 'C'],
      ['с', 'С']
    ], value: 'c', keyCode: 67),
    KeyDescription(keyLayouts: [
      ['v', 'V'],
      ['м', 'М']
    ], value: 'v', keyCode: 86),
    KeyDescription(keyLayouts: [
      ['b', 'B'],
      ['и', 'И']
    ], value: 'b', keyCode: 66),
    KeyDescription(keyLayouts: [
      ['n', 'N'],
      ['т', 'Т']
    ], value: 'n', keyCode: 78),
    KeyDescription(keyLayouts: [
      ['m', 'M'],
      ['ь', 'Ь']
    ], value: 'm', keyCode: 77),
    KeyDescription(keyLayouts: [
      [Icons.keyboard_arrow_up]
    ], value: 'up', keyCode: 38),
    KeyDescription(keyLayouts: [
      [',', '<'],
      ['б', 'Б']
    ], value: ',', keyCode: 188),
    KeyDescription(keyLayouts: [
      ['.', '>'],
      ['ю', 'Ю']
    ], value: '.', keyCode: 190),
    KeyDescription(keyLayouts: [
      ['/', '?'],
      ['.', ',']
    ], value: '/', keyCode: 191),
  ],
  // Row 5
  [
    KeyDescription(keyLayouts: [
      ['CTRL']
    ], value: 'control', allowRepeat: false, sticky: true, keyCode: 17),
    KeyDescription(keyLayouts: [
      [SvgPicture.asset('assets/images/win.svg', width: 24, height: 24)]
    ], value: 'command', allowRepeat: false, sticky: true, keyCode: 91),
    KeyDescription(keyLayouts: [
      ['ALT']
    ], value: 'alt', allowRepeat: false, sticky: true, keyCode: 18),
    KeyDescription(keyLayouts: [
      [Icons.space_bar]
    ], value: 'space', size: 20, keyCode: 32),
    KeyDescription(keyLayouts: [
      ['EN'],
      ['RU']
    ], value: 'layout_change', allowRepeat: false),
    KeyDescription(keyLayouts: [
      [Icons.keyboard_arrow_left]
    ], value: 'left', keyCode: 37),
    KeyDescription(keyLayouts: [
      [Icons.keyboard_arrow_down]
    ], value: 'down', keyCode: 40),
    KeyDescription(keyLayouts: [
      [Icons.keyboard_arrow_right]
    ], value: 'right', keyCode: 39),
    KeyDescription(keyLayouts: [
      [Icons.keyboard_hide]
    ], value: 'hide', allowRepeat: false),
  ]
];

final List<List<KeyDescription>> numbers = [
  [
    KeyDescription(keyLayouts: [
      ['1']
    ], value: '1', keyCode: 49),
    KeyDescription(keyLayouts: [
      ['2']
    ], value: '2', keyCode: 50),
    KeyDescription(keyLayouts: [
      ['3']
    ], value: '3', keyCode: 51),
  ],
  [
    KeyDescription(keyLayouts: [
      ['4']
    ], value: '4', keyCode: 52),
    KeyDescription(keyLayouts: [
      ['5']
    ], value: '5', keyCode: 53),
    KeyDescription(keyLayouts: [
      ['6']
    ], value: '6', keyCode: 54),
  ],
  [
    KeyDescription(keyLayouts: [
      ['7']
    ], value: '7', keyCode: 55),
    KeyDescription(keyLayouts: [
      ['8']
    ], value: '8', keyCode: 56),
    KeyDescription(keyLayouts: [
      ['9']
    ], value: '9', keyCode: 57),
  ],
  [
    KeyDescription(keyLayouts: [
      ['.'],
    ], value: '.', keyCode: 19),
    KeyDescription(keyLayouts: [
      ['0']
    ], value: '0', keyCode: 48),
    KeyDescription(keyLayouts: [
      [Icons.backspace]
    ], value: 'backspace', keyCode: 8),
  ],
  [
    KeyDescription(keyLayouts: [
      [',']
    ], value: ',', keyCode: 188),
    KeyDescription(keyLayouts: [
      [Icons.keyboard_arrow_up]
    ], value: 'up', keyCode: 37),
    KeyDescription(keyLayouts: [
      [Icons.keyboard_hide]
    ], value: 'hide', allowRepeat: false),
  ],
  [
    KeyDescription(keyLayouts: [
      [Icons.keyboard_arrow_left]
    ], value: 'left', keyCode: 37),
    KeyDescription(keyLayouts: [
      [Icons.keyboard_arrow_down]
    ], value: 'down', keyCode: 40),
    KeyDescription(keyLayouts: [
      [Icons.keyboard_arrow_right]
    ], value: 'right', keyCode: 39)
  ],
];
