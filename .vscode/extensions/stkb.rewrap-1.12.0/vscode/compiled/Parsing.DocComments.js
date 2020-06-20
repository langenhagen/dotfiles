"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.ddoc = ddoc;
exports.godoc = godoc;
exports.xmldoc = exports.psdoc = exports.dartdoc = exports.javadoc = void 0;

var _Nonempty = require("./Nonempty");

var _Util = require("./fable-library.2.10.1/Util");

var _Parsing = require("./Parsing.Markdown");

var _RegExp = require("./fable-library.2.10.1/RegExp");

var _Line = require("./Line");

var _Block = require("./Block");

var _Parsing2 = require("./Parsing.Core");

var _Parsing3 = require("./Parsing.Comments");

var _List = require("./fable-library.2.10.1/List");

var _Parsing4 = require("./Parsing.Sgml");

function splitBeforeTags(regex, sectionParser, settings, _arg1) {
  const prependRev = function prependRev($_arg2$$10, $maybeRest$$11) {
    prependRev: while (true) {
      const _arg2 = $_arg2$$10,
            maybeRest = $maybeRest$$11;
      let nextRest;

      if (maybeRest == null) {
        nextRest = (0, _Nonempty.singleton)(_arg2.fields[0]);
      } else {
        const rest = maybeRest;
        nextRest = (0, _Nonempty.cons)(_arg2.fields[0], rest);
      }

      const matchValue = (0, _Nonempty.fromList)(_arg2.fields[1]);

      if (matchValue == null) {
        return nextRest;
      } else {
        const next = matchValue;
        $_arg2$$10 = next;
        $maybeRest$$11 = nextRest;
        continue prependRev;
      }

      break;
    }
  };

  const loop = function loop($tagMatch$$12, $buffer$$13, $maybeOutput$$14, $lines$$15) {
    loop: while (true) {
      const tagMatch = $tagMatch$$12,
            buffer = $buffer$$13,
            maybeOutput = $maybeOutput$$14,
            lines = $lines$$15;
      const parser = tagMatch != null ? (0, _Util.partialApply)(2, sectionParser, [tagMatch]) : _Parsing.markdown;

      const addBufferToOutput = function addBufferToOutput() {
        return prependRev(parser(settings)((0, _Nonempty.rev)()(buffer)), maybeOutput);
      };

      if (lines.tail == null) {
        return (0, _Nonempty.rev)()(addBufferToOutput());
      } else {
        const m = (0, _RegExp.match)(regex, lines.head);
        const patternInput = m != null ? [m, (0, _Nonempty.singleton)(lines.head), addBufferToOutput()] : [tagMatch, (0, _Nonempty.cons)(lines.head, buffer), maybeOutput];
        $tagMatch$$12 = patternInput[0];
        $buffer$$13 = patternInput[1];
        $maybeOutput$$14 = patternInput[2];
        $lines$$15 = lines.tail;
        continue loop;
      }

      break;
    }
  };

  return loop((0, _RegExp.match)(regex, _arg1.fields[0]), (0, _Nonempty.singleton)(_arg1.fields[0]), undefined, _arg1.fields[1]);
}

const javadoc = (() => {
  const tagRegex = (0, _RegExp.create)("^\\s*@(\\w+)(.*)$");
  return function (settings$$5) {
    return function (arg30$0040) {
      return splitBeforeTags(tagRegex, (0, _Util.uncurry)(3, function sectionParser$$1(m$$1) {
        if ((0, _Line.isBlank)(m$$1[2] || "")) {
          if ((m$$1[1] || "").toLocaleLowerCase() === "example") {
            return function (_arg1$$1) {
              return function ($arg$$1) {
                let head$$1;
                head$$1 = (0, _Block.ignore)($arg$$1);
                return (0, _Nonempty.singleton)(head$$1);
              };
            };
          } else {
            return function (settings$$2) {
              return function (arg20$0040) {
                return (0, _Parsing2.ignoreFirstLine)((0, _Util.uncurry)(2, _Parsing.markdown), settings$$2, arg20$0040);
              };
            };
          }
        } else {
          return _Parsing.markdown;
        }
      }), settings$$5, arg30$0040);
    };
  };
})();

exports.javadoc = javadoc;

const dartdoc = (() => {
  const tagRegex$$1 = (0, _RegExp.create)("^\\s*(@nodoc|{@template|{@endtemplate|{@macro)");
  return function (settings$$8) {
    return function (arg30$0040$$1) {
      return splitBeforeTags(tagRegex$$1, function sectionParser$$2(_arg1$$2, settings$$6, arg20$0040$$1) {
        return (0, _Parsing2.ignoreFirstLine)((0, _Util.uncurry)(2, _Parsing.markdown), settings$$6, arg20$0040$$1);
      }, settings$$8, arg30$0040$$1);
    };
  };
})();

exports.dartdoc = dartdoc;

const psdoc = (() => {
  const tagRegex$$2 = (0, _RegExp.create)("^\\s*\\.([A-Z]+)");
  const codeLineRegex = (0, _RegExp.create)("^\\s*PS C:\\\\>");
  return function (settings$$17) {
    return function (arg30$0040$$3) {
      return splitBeforeTags(tagRegex$$2, (0, _Util.uncurry)(3, function sectionParser$$4(m$$2) {
        if ((m$$2[1] || "") === "EXAMPLE") {
          return function (settings$$14) {
            return function (arg20$0040$$4) {
              return (0, _Parsing2.ignoreFirstLine)(function exampleSection(settings$$9, lines$$2) {
                const trimmedExampleSection = function trimmedExampleSection(settings$$13, arg20$0040$$3) {
                  return (0, _Parsing2.ignoreFirstLine)(function otherParser(settings$$12, arg30$0040$$2) {
                    return splitBeforeTags(codeLineRegex, function sectionParser$$3(_arg1$$3, settings$$10, arg20$0040$$2) {
                      return (0, _Parsing2.ignoreFirstLine)((0, _Util.uncurry)(2, _Parsing.markdown), settings$$10, arg20$0040$$2);
                    }, settings$$12, arg30$0040$$2);
                  }, settings$$13, arg20$0040$$3);
                };

                const matchValue$$1 = (0, _Nonempty.span)(_Line.isBlank)(lines$$2);

                if (matchValue$$1 == null) {
                  return trimmedExampleSection(settings$$9, lines$$2);
                } else if (matchValue$$1[1] != null) {
                  const blankLines$$1 = matchValue$$1[0];
                  const remaining = matchValue$$1[1];
                  return (0, _Nonempty.cons)((0, _Block.ignore)(blankLines$$1), trimmedExampleSection(settings$$9, remaining));
                } else {
                  const blankLines = matchValue$$1[0];
                  return (0, _Nonempty.singleton)((0, _Block.ignore)(blankLines));
                }
              }, settings$$14, arg20$0040$$4);
            };
          };
        } else {
          return function (settings$$16) {
            return function (arg20$0040$$5) {
              return (0, _Parsing2.ignoreFirstLine)(function otherParser$$1(settings$$15, $arg$$2) {
                let tupledArg;
                tupledArg = (0, _Parsing3.extractWrappable)("", false, function reformatPrefix(_arg2$$1) {
                  return "  ";
                }, settings$$15, $arg$$2);
                const parser$$1 = (0, _Parsing.markdown)(settings$$15);
                return (0, _Block.splitUp)(parser$$1, tupledArg[0], tupledArg[1]);
              }, settings$$16, arg20$0040$$5);
            };
          };
        }
      }), settings$$17, arg30$0040$$3);
    };
  };
})();

exports.psdoc = psdoc;

function ddoc(settings$$18) {
  return (0, _Parsing.markdown)(settings$$18);
}

function godoc(settings$$19) {
  const indentedLines = (0, _Parsing2.ignoreParser)((0, _Nonempty.span)(function (line) {
    return line[0] === " " ? true : line[0] === "\t";
  }));
  let partialParser;
  let otherParser$$2;
  const parsers = (0, _List.ofArray)([_Parsing2.blankLines, indentedLines]);

  otherParser$$2 = function (lines$$6) {
    return (0, _Parsing2.tryMany)(parsers, lines$$6);
  };

  partialParser = (0, _Parsing2.takeUntil)(otherParser$$2, function textLines($arg$$4) {
    const arg10$0040$$1 = (0, _Parsing2.splitIntoChunks)((0, _Parsing2.afterRegex)((0, _RegExp.create)("  $")))($arg$$4);
    return (0, _Nonempty.map)(function fn($arg$$3) {
      let arg0;
      arg0 = (0, _Block.WrappableModule$$$fromLines)(["", ""], $arg$$3);
      return new _Block.Block(1, "Wrap", arg0);
    }, arg10$0040$$1);
  });
  return (0, _Parsing2.repeatToEnd)(partialParser);
}

const xmldoc = (() => {
  const blank = function blank(_arg1$$4, $arg$$5) {
    let head$$2;
    head$$2 = (0, _Block.ignore)($arg$$5);
    return (0, _Nonempty.singleton)(head$$2);
  };

  const blockTags = ["code", "description", "example", "exception", "include", "inheritdoc", "list", "listheader", "item", "para", "param", "permission", "remarks", "seealso", "summary", "term", "typeparam", "typeparamref", "returns", "value"];
  return function (settings$$20) {
    const clo4 = (0, _Parsing4.sgml)(blank, blank, blockTags, settings$$20);
    return function (arg40) {
      return clo4(arg40);
    };
  };
})();

exports.xmldoc = xmldoc;