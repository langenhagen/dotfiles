"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.charWidthEx = charWidthEx;
exports.isCJK = isCJK;
exports.CanBreak$reflection = CanBreak$reflection;
exports.canBreak = canBreak;
exports.canBreakBetweenChars = canBreakBetweenChars;
exports.wrap = wrap;
exports.CanBreak = void 0;

var _Types = require("./fable-library.2.10.1/Types");

var _Reflection = require("./fable-library.2.10.1/Reflection");

var _Array = require("./fable-library.2.10.1/Array");

var _Prelude = require("./Prelude");

var _Util = require("./fable-library.2.10.1/Util");

var _Nonempty = require("./Nonempty");

var _List = require("./fable-library.2.10.1/List");

var _String = require("./fable-library.2.10.1/String");

var _RegExp = require("./fable-library.2.10.1/RegExp");

var _Line = require("./Line");

function charWidthEx(tabSize, index, charCode) {
  if (charCode === 0) {
    return 1;
  } else if (charCode === 9) {
    return tabSize - index % tabSize | 0;
  } else if (charCode < 32) {
    return 0;
  } else {
    if (charCode < 11904) {
      return 1;
    } else if (charCode >= 11904 ? charCode <= 55215 : false) {
      return 2;
    } else if (charCode >= 63744 ? charCode <= 64255 : false) {
      return 2;
    } else if (charCode >= 65281 ? charCode <= 65374 : false) {
      return 2;
    } else {
      return 1;
    }
  }
}

function charWidth(charCode$$1) {
  return charWidthEx(1, 0, charCode$$1);
}

function isWhitespace(cc) {
  if (cc !== 0 ? cc <= 32 : false) {
    return true;
  } else {
    return cc === 12288;
  }
}

function isCJK(charCode$$2) {
  if ((charCode$$2 >= 12352 ? charCode$$2 <= 12543 : false) ? true : charCode$$2 >= 13312 ? charCode$$2 <= 19903 : false) {
    return true;
  } else if (charCode$$2 >= 19968) {
    return charCode$$2 <= 40959;
  } else {
    return false;
  }
}

const CanBreak = (0, _Types.declare)(function Wrapping_CanBreak(tag, name, ...fields) {
  this.tag = tag | 0;
  this.name = name;
  this.fields = fields;
}, _Types.Union);
exports.CanBreak = CanBreak;

function CanBreak$reflection() {
  return (0, _Reflection.union_type)("Wrapping.CanBreak", [], CanBreak, () => ["Always", "Sometimes", "Never"]);
}

const specialChars = (() => {
  const array$$1 = [[[new CanBreak(2, "Never"), new CanBreak(1, "Sometimes")], "})]?,;¢°′″‰℃"], [[new CanBreak(2, "Never"), new CanBreak(0, "Always")], "、。｡､￠，．：；？！％・･ゝゞヽヾーァィゥェォッャュョヮヵヶぁぃぅぇぉっゃゅょゎゕゖㇰㇱㇲㇳㇴㇵㇶㇷㇸㇹㇺㇻㇼㇽㇾㇿ々〻ｧｨｩｪｫｬｭｮｯｰ”〉》」』】〕）］｝｣"], [[new CanBreak(1, "Sometimes"), new CanBreak(2, "Never")], "([{"], [[new CanBreak(0, "Always"), new CanBreak(2, "Never")], "‘“〈《「『【〔（［｛｢£¥＄￡￥＋"]];
  return (0, _Array.map)(function mapping$$1(tupledArg) {
    return (0, _Prelude.Tuple$$$mapSecond)(function f(s) {
      const array = s.split("");
      return (0, _Array.map)(function mapping(value) {
        return value.charCodeAt(0);
      }, array, Uint16Array);
    }, tupledArg[0], tupledArg[1]);
  }, array$$1, Array);
})();

function canBreak(charCode$$3) {
  if (isWhitespace(charCode$$3)) {
    return [new CanBreak(0, "Always"), new CanBreak(0, "Always")];
  } else {
    const matchValue = (0, _Array.tryFind)(function ($arg$$3) {
      let array$$2;
      array$$2 = $arg$$3[1];
      return (0, _Array.contains)(charCode$$3, array$$2, {
        Equals($x$$1, $y$$2) {
          return $x$$1 === $y$$2;
        },

        GetHashCode: _Util.structuralHash
      });
    }, specialChars);

    if (matchValue == null) {
      if (isCJK(charCode$$3)) {
        return [new CanBreak(0, "Always"), new CanBreak(0, "Always")];
      } else {
        return [new CanBreak(1, "Sometimes"), new CanBreak(1, "Sometimes")];
      }
    } else {
      const res = matchValue[0];
      return res;
    }
  }
}

function canBreakBefore($arg$$4) {
  let tuple$$1;
  tuple$$1 = canBreak($arg$$4);
  return tuple$$1[0];
}

function canBreakAfter($arg$$5) {
  let tuple$$2;
  tuple$$2 = canBreak($arg$$5);
  return tuple$$2[1];
}

function canBreakBetweenChars(c1, c2) {
  const matchValue$$1 = [canBreakAfter(c1), canBreakBefore(c2)];
  var $target$$19;

  if (matchValue$$1[0].tag === 1) {
    if (matchValue$$1[1].tag === 1) {
      $target$$19 = 0;
    } else if (matchValue$$1[1].tag === 2) {
      $target$$19 = 2;
    } else {
      $target$$19 = 3;
    }
  } else if (matchValue$$1[0].tag === 2) {
    $target$$19 = 1;
  } else if (matchValue$$1[1].tag === 2) {
    $target$$19 = 2;
  } else {
    $target$$19 = 3;
  }

  switch ($target$$19) {
    case 0:
      {
        return false;
      }

    case 1:
      {
        return false;
      }

    case 2:
      {
        return false;
      }

    case 3:
      {
        return true;
      }
  }
}

function wrapLines(headWidth, tailWidth, lines) {
  let str;
  let strings;
  const list = (0, _List.fold)(function addEolSpacesWhereNeeded(ls, l) {
    if (ls.tail != null) {
      const matchValue$$2 = [canBreakAfter(ls.head[ls.head.length - 1].charCodeAt(0)), canBreakBefore(l[0].charCodeAt(0))];
      var $target$$25;

      if (matchValue$$2[0].tag === 1) {
        if (matchValue$$2[1].tag === 1) {
          $target$$25 = 0;
        } else {
          $target$$25 = 1;
        }
      } else {
        $target$$25 = 1;
      }

      switch ($target$$25) {
        case 0:
          {
            return new _Types.List(l, new _Types.List(" ", ls));
          }

        case 1:
          {
            return new _Types.List(l, ls);
          }
      }
    } else {
      return new _Types.List(l, new _Types.List());
    }
  }, new _Types.List(), (0, _Nonempty.toList)(lines));
  strings = (0, _List.reverse)(list);
  str = (0, _String.join)("", strings);

  const findBreakPos = function findBreakPos($min$$26, $p$$27) {
    findBreakPos: while (true) {
      const min = $min$$26,
            p = $p$$27;

      if (p === min) {
        return min | 0;
      } else if (canBreakBetweenChars(str[p - 1].charCodeAt(0), str[p].charCodeAt(0))) {
        return p | 0;
      } else {
        $min$$26 = min;
        $p$$27 = p - 1;
        continue findBreakPos;
      }

      break;
    }
  };

  const loop = function loop($acc$$28, $mw$$29, $s$$1$$30, $p$$1$$31, $w$$32) {
    loop: while (true) {
      const acc = $acc$$28,
            mw = $mw$$29,
            s$$1 = $s$$1$$30,
            p$$1 = $p$$1$$31,
            w = $w$$32;

      if (p$$1 >= str.length) {
        return new _Prelude.Nonempty$00601(0, "Nonempty", (0, _String.substring)(str, s$$1), acc);
      } else {
        const cc$$1 = str[p$$1].charCodeAt(0);

        if (p$$1 === s$$1 ? isWhitespace(cc$$1) : false) {
          $acc$$28 = acc;
          $mw$$29 = mw;
          $s$$1$$30 = s$$1 + 1;
          $p$$1$$31 = p$$1 + 1;
          $w$$32 = w;
          continue loop;
        } else {
          const w$0027 = w + charWidth(cc$$1) | 0;

          if (w$0027 <= mw) {
            $acc$$28 = acc;
            $mw$$29 = mw;
            $s$$1$$30 = s$$1;
            $p$$1$$31 = p$$1 + 1;
            $w$$32 = w$0027;
            continue loop;
          } else {
            const bP = findBreakPos(s$$1, p$$1) | 0;

            if (bP === s$$1) {
              $acc$$28 = acc;
              $mw$$29 = mw;
              $s$$1$$30 = s$$1;
              $p$$1$$31 = p$$1 + 1;
              $w$$32 = w$0027;
              continue loop;
            } else {
              const line = (0, _String.trimEnd)((0, _String.substring)(str, s$$1, bP - s$$1));
              $acc$$28 = new _Types.List(line, acc);
              $mw$$29 = tailWidth;
              $s$$1$$30 = bP;
              $p$$1$$31 = bP;
              $w$$32 = 0;
              continue loop;
            }
          }
        }
      }

      break;
    }
  };

  return (0, _Nonempty.rev)()(loop(new _Types.List(), headWidth, 0, 0, 0));
}

const inlineTagRegex = (0, _RegExp.create)("{@[a-z]+.*?[^\\\\]}", 1);

function addPrefixes(prefixes_0, prefixes_1) {
  return function ($arg$$6) {
    let arg10$0040$$1;
    arg10$0040$$1 = (0, _Nonempty.mapHead)(function fn(y) {
      return prefixes_0 + y;
    }, $arg$$6);
    return (0, _Nonempty.mapTail)(function fn$$1(y$$1) {
      return prefixes_1 + y$$1;
    }, arg10$0040$$1);
  };
}

function wrap(settings, prefixes$$1, lines$$1) {
  var arg10$0040$$3, lines$$2, arg10$0040$$2;
  const addDoubleSpaces = (0, _Nonempty.mapInit)(function (s$$2) {
    const t = (0, _String.trimEnd)(s$$2);
    return (settings.doubleSentenceSpacing ? [".", "?", "!"].some(function (c) {
      return (0, _String.endsWith)(t, c);
    }) : false) ? t + "  " : t;
  });
  const column = (settings.column < 1 ? 2147483647 : settings.column) | 0;
  let lineWidths;
  lineWidths = (0, _Prelude.Tuple$$$map)(function f$$1($arg$$7) {
    let s$$3;
    s$$3 = (0, _Line.tabsToSpaces)(settings.tabWidth, $arg$$7);
    return column - s$$3.length | 0;
  }, prefixes$$1[0], prefixes$$1[1]);
  return addPrefixes(prefixes$$1[0], prefixes$$1[1])((arg10$0040$$3 = (lines$$2 = (arg10$0040$$2 = addDoubleSpaces(lines$$1), ((0, _Nonempty.map)(function freezeInlineTags(str$$1) {
    return (0, _RegExp.replace)(inlineTagRegex, str$$1, function (m) {
      return (0, _String.replace)(m[0], " ", "\u0000");
    });
  }, arg10$0040$$2))), (wrapLines(lineWidths[0], lineWidths[1], lines$$2))), ((0, _Nonempty.map)(function unfreezeInlineTags(str$$2) {
    return (0, _String.replace)(str$$2, "\u0000", " ");
  }, arg10$0040$$3))));
}