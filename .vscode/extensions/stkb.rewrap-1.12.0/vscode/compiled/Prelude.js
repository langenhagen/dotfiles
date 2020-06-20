"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Nonempty$00601$reflection = Nonempty$00601$reflection;
exports.Nonempty$00601$$$op_Addition$$Z6CA0D220 = Nonempty$00601$$$op_Addition$$Z6CA0D220;
exports.These$00602$reflection = These$00602$reflection;
exports.These$00602$$$maybeThis = These$00602$$$maybeThis;
exports.These$00602$$$maybeThat = These$00602$$$maybeThat;
exports.These$00602$$$mapThis = These$00602$$$mapThis;
exports.maybe = maybe;
exports.Tuple$$$map = Tuple$$$map;
exports.Tuple$$$mapFirst = Tuple$$$mapFirst;
exports.Tuple$$$mapSecond = Tuple$$$mapSecond;
exports.Tuple$$$replaceFirst = Tuple$$$replaceFirst;
exports.Tuple$$$replaceSecond = Tuple$$$replaceSecond;
exports.List$$$safeSkip = List$$$safeSkip;
exports.List$$$span = List$$$span;
exports.List$$$safeSplitAt = List$$$safeSplitAt;
exports.List$$$tryTail = List$$$tryTail;
exports.List$$$tryInit = List$$$tryInit;
exports.String$$$dropStart = String$$$dropStart;
exports.String$$$takeStart = String$$$takeStart;
exports.String$$$trim = String$$$trim;
exports.String$$$trimStart = String$$$trimStart;
exports.String$$$trimEnd = String$$$trimEnd;
exports.These$00602 = exports.Nonempty$00601 = void 0;

var _Types = require("./fable-library.2.10.1/Types");

var _Reflection = require("./fable-library.2.10.1/Reflection");

var _List = require("./fable-library.2.10.1/List");

var _Seq = require("./fable-library.2.10.1/Seq");

var _Option = require("./fable-library.2.10.1/Option");

var _Util = require("./fable-library.2.10.1/Util");

var _String = require("./fable-library.2.10.1/String");

const Nonempty$00601 = (0, _Types.declare)(function Prelude_Nonempty(tag, name, ...fields) {
  this.tag = tag | 0;
  this.name = name;
  this.fields = fields;
}, _Types.Union);
exports.Nonempty$00601 = Nonempty$00601;

function Nonempty$00601$reflection($gen$$5) {
  return (0, _Reflection.union_type)("Prelude.Nonempty`1", [$gen$$5], Nonempty$00601, () => [["Nonempty", [["Item1", $gen$$5], ["Item2", (0, _Reflection.list_type)($gen$$5)]]]]);
}

function Nonempty$00601$$$op_Addition$$Z6CA0D220(_arg1, _arg2) {
  return new Nonempty$00601(0, "Nonempty", _arg1.fields[0], (0, _List.append)(_arg1.fields[1], new _Types.List(_arg2.fields[0], _arg2.fields[1])));
}

Nonempty$00601.prototype[Symbol.iterator] = function () {
  var source;
  const self$ = this;
  return (0, _Seq.toIterator)((0, _Seq.getEnumerator)((source = new _Types.List(self$.fields[0], self$.fields[1]), (source))));
};

const These$00602 = (0, _Types.declare)(function Prelude_These(tag, name, ...fields) {
  this.tag = tag | 0;
  this.name = name;
  this.fields = fields;
}, _Types.Union);
exports.These$00602 = These$00602;

function These$00602$reflection($gen$$8, $gen$$9) {
  return (0, _Reflection.union_type)("Prelude.These`2", [$gen$$8, $gen$$9], These$00602, () => [["This", [["Item", $gen$$8]]], ["That", [["Item", $gen$$9]]], ["These", [["Item1", $gen$$8], ["Item2", $gen$$9]]]]);
}

function These$00602$$$maybeThis(maybeA, b) {
  if (maybeA == null) {
    return new These$00602(1, "That", b);
  } else {
    const a = (0, _Option.value)(maybeA);
    return new These$00602(2, "These", a, b);
  }
}

function These$00602$$$maybeThat(a$$1, maybeB) {
  if (maybeB == null) {
    return new These$00602(0, "This", a$$1);
  } else {
    const b$$1 = (0, _Option.value)(maybeB);
    return new These$00602(2, "These", a$$1, b$$1);
  }
}

function These$00602$$$mapThis(f, these) {
  switch (these.tag) {
    case 1:
      {
        return new These$00602(1, "That", these.fields[0]);
      }

    case 2:
      {
        return new These$00602(2, "These", f(these.fields[0]), these.fields[1]);
      }

    default:
      {
        return new These$00602(0, "This", f(these.fields[0]));
      }
  }
}

function maybe(def, f$$1, x) {
  let option$$1;
  option$$1 = (0, _Option.map)(f$$1, x);
  return (0, _Option.defaultArg)(option$$1, def);
}

function Tuple$$$map(f$$2, a$$4, b$$4) {
  return [f$$2(a$$4), f$$2(b$$4)];
}

function Tuple$$$mapFirst(f$$3, a$$5, b$$5) {
  return [f$$3(a$$5), b$$5];
}

function Tuple$$$mapSecond(f$$4, a$$6, b$$6) {
  return [a$$6, f$$4(b$$6)];
}

function Tuple$$$replaceFirst(x$$1, a$$7, b$$7) {
  return [x$$1, b$$7];
}

function Tuple$$$replaceSecond(x$$2, a$$8, b$$8) {
  return [a$$8, x$$2];
}

function List$$$safeSkip($n$$34, $list$$35) {
  List$$$safeSkip: while (true) {
    const n = $n$$34,
          list = $list$$35;

    if (n > 0) {
      if (list.tail != null) {
        $n$$34 = n - 1;
        $list$$35 = list.tail;
        continue List$$$safeSkip;
      } else {
        return new _Types.List();
      }
    } else {
      return list;
    }

    break;
  }
}

function List$$$span(predicate) {
  const loop = function loop($output$$37, $remaining$$38) {
    loop: while (true) {
      const output = $output$$37,
            remaining = $remaining$$38;

      if (remaining.tail != null) {
        if (predicate(remaining.head)) {
          $output$$37 = new _Types.List(remaining.head, output);
          $remaining$$38 = remaining.tail;
          continue loop;
        } else {
          return [(0, _List.reverse)(output), remaining];
        }
      } else {
        return [(0, _List.reverse)(output), new _Types.List()];
      }

      break;
    }
  };

  return (0, _Util.partialApply)(1, loop, [new _Types.List()]);
}

function List$$$safeSplitAt(n$$1, list$$1) {
  return [(0, _List.truncate)(n$$1, list$$1), List$$$safeSkip(n$$1, list$$1)];
}

function List$$$tryTail(list$$2) {
  if (list$$2.tail == null) {
    return undefined;
  } else {
    return list$$2.tail;
  }
}

function List$$$tryInit(list$$3) {
  let option$$2;
  let list$$5;
  list$$5 = (0, _List.reverse)(list$$3);
  option$$2 = List$$$tryTail(list$$5);
  return (0, _Option.map)(_List.reverse, option$$2);
}

function String$$$dropStart(n$$2, str) {
  if (n$$2 > str.length) {
    return "";
  } else {
    return (0, _String.substring)(str, (0, _Util.max)(_Util.comparePrimitives, n$$2, 0));
  }
}

function String$$$takeStart(n$$3, str$$1) {
  if (n$$3 > str$$1.length) {
    return str$$1;
  } else {
    return (0, _String.substring)(str$$1, 0, (0, _Util.max)(_Util.comparePrimitives, n$$3, 0));
  }
}

function String$$$trim(str$$2) {
  return str$$2.trim();
}

function String$$$trimStart(str$$3) {
  return (0, _String.trimStart)(str$$3);
}

function String$$$trimEnd(str$$4) {
  return (0, _String.trimEnd)(str$$4);
}