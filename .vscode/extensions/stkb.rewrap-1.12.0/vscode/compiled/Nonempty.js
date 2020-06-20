"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.fromList = fromList;
exports.fromListUnsafe = fromListUnsafe;
exports.singleton = singleton;
exports.cons = cons;
exports.snoc = snoc;
exports.append = append;
exports.appendToList = appendToList;
exports.head = head;
exports.tail = tail;
exports.last = last;
exports.length = length;
exports.tryFind = tryFind;
exports.toList = toList;
exports.rev = rev;
exports.map = map;
exports.mapHead = mapHead;
exports.mapTail = mapTail;
exports.mapInit = mapInit;
exports.mapLast = mapLast;
exports.replaceHead = replaceHead;
exports.collect = collect;
exports.splitAt = splitAt;
exports.span = span;
exports.splitAfter = splitAfter;
exports.unfold = unfold;

var _Prelude = require("./Prelude");

var _List = require("./fable-library.2.10.1/List");

var _Types = require("./fable-library.2.10.1/Types");

var _Option = require("./fable-library.2.10.1/Option");

function fromList(list) {
  if (list.tail != null) {
    return new _Prelude.Nonempty$00601(0, "Nonempty", list.head, list.tail);
  } else {
    return undefined;
  }
}

function fromListUnsafe(list$$1) {
  return new _Prelude.Nonempty$00601(0, "Nonempty", (0, _List.head)(list$$1), (0, _List.tail)(list$$1));
}

function singleton(head$$1) {
  return new _Prelude.Nonempty$00601(0, "Nonempty", head$$1, new _Types.List());
}

function cons(head$$2, neList) {
  return new _Prelude.Nonempty$00601(0, "Nonempty", head$$2, toList(neList));
}

function snoc(last$$1, _arg1) {
  return new _Prelude.Nonempty$00601(0, "Nonempty", _arg1.fields[0], (0, _List.append)(_arg1.fields[1], new _Types.List(last$$1, new _Types.List())));
}

function append(_arg2, b) {
  return new _Prelude.Nonempty$00601(0, "Nonempty", _arg2.fields[0], (0, _List.append)(_arg2.fields[1], toList(b)));
}

function appendToList(listA, neListB) {
  const matchValue = fromList(listA);

  if (matchValue == null) {
    return neListB;
  } else {
    const neListA = matchValue;
    return append(neListA, neListB);
  }
}

function head(_arg3) {
  return _arg3.fields[0];
}

function tail(_arg4) {
  return _arg4.fields[1];
}

function last(_arg5) {
  const option = (0, _List.tryLast)(_arg5.fields[1]);
  return (0, _Option.defaultArg)(option, _arg5.fields[0]);
}

function length() {
  return function ($arg$$2) {
    let y;
    let list$$2;
    list$$2 = tail($arg$$2);
    y = (0, _List.length)(list$$2);
    return 1 + y | 0;
  };
}

function tryFind(predicate) {
  return function ($arg$$3) {
    let list$$3;
    list$$3 = toList($arg$$3);
    return (0, _List.tryFind)(predicate, list$$3);
  };
}

function toList(_arg6) {
  return new _Types.List(_arg6.fields[0], _arg6.fields[1]);
}

function rev() {
  return function ($arg$$5) {
    let list$$5;
    let list$$4;
    list$$4 = toList($arg$$5);
    list$$5 = (0, _List.reverse)(list$$4);
    return fromListUnsafe(list$$5);
  };
}

function map(fn, _arg7) {
  return new _Prelude.Nonempty$00601(0, "Nonempty", fn(_arg7.fields[0]), (0, _List.map)(fn, _arg7.fields[1]));
}

function mapHead(fn$$1, _arg8) {
  return new _Prelude.Nonempty$00601(0, "Nonempty", fn$$1(_arg8.fields[0]), _arg8.fields[1]);
}

function mapTail(fn$$2, _arg9) {
  return new _Prelude.Nonempty$00601(0, "Nonempty", _arg9.fields[0], (0, _List.map)(fn$$2, _arg9.fields[1]));
}

function mapInit(fn$$3) {
  return function ($arg$$7) {
    var arg10$0040;
    return rev()((arg10$0040 = rev()($arg$$7), mapTail(fn$$3, arg10$0040)));
  };
}

function mapLast(fn$$4) {
  return function ($arg$$9) {
    var arg10$0040$$1;
    return rev()((arg10$0040$$1 = rev()($arg$$9), mapHead(fn$$4, arg10$0040$$1)));
  };
}

function replaceHead(newHead) {
  return function (arg10$0040$$2) {
    return mapHead(function fn$$5(_arg1$$1) {
      return newHead;
    }, arg10$0040$$2);
  };
}

function collect(fn$$6, neList$$1) {
  const loop = function loop($output$$41, $input$$42) {
    loop: while (true) {
      const output = $output$$41,
            input = $input$$42;

      if (input.tail == null) {
        return output;
      } else {
        $output$$41 = (0, _Prelude.Nonempty$00601$$$op_Addition$$Z6CA0D220)(fn$$6(input.head), output);
        $input$$42 = input.tail;
        continue loop;
      }

      break;
    }
  };

  const _arg1$$2 = rev()(neList$$1);

  return loop(fn$$6(_arg1$$2.fields[0]), _arg1$$2.fields[1]);
}

function splitAt(n, _arg10) {
  const loop$$1 = function loop$$1($count$$45, $left$$46, $maybeRight$$47) {
    loop$$1: while (true) {
      const count = $count$$45,
            left = $left$$46,
            maybeRight = $maybeRight$$47;

      if (maybeRight != null) {
        const xs$$2 = maybeRight.fields[1];
        const x$$3 = maybeRight.fields[0];

        if (count < 1) {
          return [left, maybeRight];
        } else {
          $count$$45 = count - 1;
          $left$$46 = cons(x$$3, left);
          $maybeRight$$47 = fromList(xs$$2);
          continue loop$$1;
        }
      } else {
        return [left, undefined];
      }

      break;
    }
  };

  const tupledArg = loop$$1(n - 1, singleton(_arg10.fields[0]), fromList(_arg10.fields[1]));
  const f = rev();
  return (0, _Prelude.Tuple$$$mapFirst)(f, tupledArg[0], tupledArg[1]);
}

function span(predicate$$1) {
  const loop$$2 = function loop$$2($output$$1$$49, $maybeRemaining$$50) {
    loop$$2: while (true) {
      const output$$1 = $output$$1$$49,
            maybeRemaining = $maybeRemaining$$50;

      if (maybeRemaining != null) {
        const tail$$12 = maybeRemaining.fields[1];
        const head$$14 = maybeRemaining.fields[0];

        if (predicate$$1(head$$14)) {
          $output$$1$$49 = new _Types.List(head$$14, output$$1);
          $maybeRemaining$$50 = fromList(tail$$12);
          continue loop$$2;
        } else {
          const option$$2 = fromList((0, _List.reverse)(output$$1));
          return (0, _Option.map)(function mapping$$1(o$$1) {
            return [o$$1, maybeRemaining];
          }, option$$2);
        }
      } else {
        const option$$1 = fromList((0, _List.reverse)(output$$1));
        return (0, _Option.map)(function mapping(o) {
          return [o, maybeRemaining];
        }, option$$1);
      }

      break;
    }
  };

  return function ($arg$$10) {
    return loop$$2(new _Types.List(), ($arg$$10));
  };
}

function splitAfter(predicate$$2) {
  const loop$$3 = function loop$$3($output$$2$$54, $_arg11$$55) {
    loop$$3: while (true) {
      const output$$2 = $output$$2$$54,
            _arg11 = $_arg11$$55;
      const maybeNextList = fromList(_arg11.fields[1]);

      if (predicate$$2(_arg11.fields[0])) {
        return [new _Prelude.Nonempty$00601(0, "Nonempty", _arg11.fields[0], output$$2), maybeNextList];
      } else {
        if (maybeNextList == null) {
          return [new _Prelude.Nonempty$00601(0, "Nonempty", _arg11.fields[0], output$$2), undefined];
        } else {
          const nextList = maybeNextList;
          $output$$2$$54 = new _Types.List(_arg11.fields[0], output$$2);
          $_arg11$$55 = nextList;
          continue loop$$3;
        }
      }

      break;
    }
  };

  return function ($arg$$11) {
    const tupledArg$$1 = loop$$3(new _Types.List(), $arg$$11);
    const f$$1 = rev();
    return (0, _Prelude.Tuple$$$mapFirst)(f$$1, tupledArg$$1[0], tupledArg$$1[1]);
  };
}

function unfold(fn$$7) {
  const loop$$4 = function loop$$4($output$$3$$57, $input$$1$$58) {
    loop$$4: while (true) {
      const output$$3 = $output$$3$$57,
            input$$1 = $input$$1$$58;
      const matchValue$$1 = fn$$7(input$$1);

      if (matchValue$$1[1] == null) {
        return new _Prelude.Nonempty$00601(0, "Nonempty", matchValue$$1[0], output$$3);
      } else {
        const nextInput = (0, _Option.value)(matchValue$$1[1]);
        $output$$3$$57 = new _Types.List(matchValue$$1[0], output$$3);
        $input$$1$$58 = nextInput;
        continue loop$$4;
      }

      break;
    }
  };

  return function ($arg$$12) {
    return rev()(loop$$4(new _Types.List(), $arg$$12));
  };
}