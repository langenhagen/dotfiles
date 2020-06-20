"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.Block$reflection = Block$reflection;
exports.WrappableModule$$$mapPrefixes = WrappableModule$$$mapPrefixes;
exports.WrappableModule$$$mapLines = WrappableModule$$$mapLines;
exports.WrappableModule$$$fromLines = WrappableModule$$$fromLines;
exports.WrappableModule$$$toLines = WrappableModule$$$toLines;
exports.comment = comment;
exports.text = text;
exports.ignore = ignore;
exports.length = length;
exports.splitUp = splitUp;
exports.Block = void 0;

var _Types = require("./fable-library.2.10.1/Types");

var _Prelude = require("./Prelude");

var _Reflection = require("./fable-library.2.10.1/Reflection");

var _Nonempty = require("./Nonempty");

var _List = require("./fable-library.2.10.1/List");

var _Line = require("./Line");

var _String = require("./fable-library.2.10.1/String");

var _Util = require("./fable-library.2.10.1/Util");

const Block = (0, _Types.declare)(function Block_Block(tag, name, ...fields) {
  this.tag = tag | 0;
  this.name = name;
  this.fields = fields;
}, _Types.Union);
exports.Block = Block;

function Block$reflection() {
  return (0, _Reflection.union_type)("Block.Block", [], Block, () => [["Comment", [["Item", (0, _Prelude.Nonempty$00601$reflection)(Block$reflection())]]], ["Wrap", [["Item", (0, _Reflection.tuple_type)((0, _Reflection.tuple_type)(_Reflection.string_type, _Reflection.string_type), (0, _Prelude.Nonempty$00601$reflection)(_Reflection.string_type))]]], ["NoWrap", [["Item", (0, _Prelude.Nonempty$00601$reflection)(_Reflection.string_type)]]]]);
}

function WrappableModule$$$mapPrefixes() {
  return function (f) {
    return function (tupledArg) {
      return (0, _Prelude.Tuple$$$mapFirst)(f, tupledArg[0], tupledArg[1]);
    };
  };
}

function WrappableModule$$$mapLines() {
  return function (f$$1) {
    return function (tupledArg$$1) {
      return (0, _Prelude.Tuple$$$mapSecond)(f$$1, tupledArg$$1[0], tupledArg$$1[1]);
    };
  };
}

function WrappableModule$$$fromLines(prefixes, lines) {
  return [prefixes, lines];
}

function WrappableModule$$$toLines(_arg1, lines$$1) {
  let arg10$0040$$1;
  arg10$0040$$1 = (0, _Nonempty.mapHead)(function fn(y) {
    return _arg1[0] + y;
  }, lines$$1);
  return (0, _Nonempty.mapTail)(function fn$$1(y$$1) {
    return _arg1[1] + y$$1;
  }, arg10$0040$$1);
}

function comment(parser, wrappable_0, wrappable_1) {
  return new Block(0, "Comment", splitUp(parser, wrappable_0, wrappable_1));
}

function text(wrappable_0$$1, wrappable_1$$1) {
  return new Block(1, "Wrap", [wrappable_0$$1, wrappable_1$$1]);
}

function ignore(lines$$3) {
  return new Block(2, "NoWrap", lines$$3);
}

function length(block) {
  switch (block.tag) {
    case 1:
      {
        return (0, _Nonempty.length)()(block.fields[0][1]) | 0;
      }

    case 2:
      {
        return (0, _Nonempty.length)()(block.fields[0]) | 0;
      }

    default:
      {
        const list = (0, _Nonempty.toList)(block.fields[0]);
        return (0, _List.sumBy)(length, list, {
          GetZero() {
            return 0;
          },

          Add($x$$1, $y$$2) {
            return $x$$1 + $y$$2;
          }

        }) | 0;
      }
  }
}

function splitUp(parser$$1, _arg2, lines$$6) {
  const prependPrefixTrimEndOfBlankLine = function prependPrefixTrimEndOfBlankLine(p, s) {
    if ((0, _Line.isBlank)(s)) {
      return (0, _String.trimEnd)(p);
    } else {
      return p + s;
    }
  };

  const prependPrefixes = function prependPrefixes(p$$1, block$$2) {
    switch (block$$2.tag) {
      case 1:
        {
          return new Block(1, "Wrap", WrappableModule$$$mapPrefixes()(function (tupledArg$$3) {
            return [p$$1[0] + tupledArg$$3[0], p$$1[1] + tupledArg$$3[1]];
          })(block$$2.fields[0]));
        }

      case 2:
        {
          let arg0;
          let arg10$0040$$4;
          const fn$$2 = (0, _Util.partialApply)(1, prependPrefixTrimEndOfBlankLine, [p$$1[0]]);
          arg10$0040$$4 = (0, _Nonempty.mapHead)(fn$$2, block$$2.fields[0]);
          const fn$$3 = (0, _Util.partialApply)(1, prependPrefixTrimEndOfBlankLine, [p$$1[1]]);
          arg0 = (0, _Nonempty.mapTail)(fn$$3, arg10$0040$$4);
          return new Block(2, "NoWrap", arg0);
        }

      default:
        {
          return block$$2;
        }
    }
  };

  let arg10$0040$$6;
  const arg10$0040$$5 = parser$$1(lines$$6);
  const fn$$4 = (0, _Util.partialApply)(1, prependPrefixes, [[_arg2[0], _arg2[1]]]);
  arg10$0040$$6 = (0, _Nonempty.mapHead)(fn$$4, arg10$0040$$5);
  const fn$$5 = (0, _Util.partialApply)(1, prependPrefixes, [[_arg2[1], _arg2[1]]]);
  return (0, _Nonempty.mapTail)(fn$$5, arg10$0040$$6);
}