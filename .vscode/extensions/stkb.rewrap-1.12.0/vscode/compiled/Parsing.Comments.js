"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.extractWrappable = extractWrappable;
exports.decorationLinesParser = decorationLinesParser;
exports.lineComment = lineComment;
exports.blockComment = blockComment;

var _RegExp = require("./fable-library.2.10.1/RegExp");

var _Line = require("./Line");

var _List = require("./fable-library.2.10.1/List");

var _Option = require("./fable-library.2.10.1/Option");

var _String = require("./fable-library.2.10.1/String");

var _Prelude = require("./Prelude");

var _Nonempty = require("./Nonempty");

var _Types = require("./fable-library.2.10.1/Types");

var _Block = require("./Block");

var _Parsing = require("./Parsing.Core");

var _Util = require("./fable-library.2.10.1/Util");

function markerRegex(marker) {
  return (0, _RegExp.create)("^\\s*" + marker + "\\s*");
}

function extractPrefix(prefixRegex, defaultPrefix, tabWidth, lines) {
  let p;
  let option$$2;
  let option$$1;
  const option = (0, _List.tryFind)(_Line.containsText, lines);
  const ifNone = (0, _List.tryHead)(lines);
  option$$1 = (0, _Option.defaultArg)(option, ifNone);
  option$$2 = (0, _Option.map)(function mapping($arg$$1) {
    let tuple;
    tuple = (0, _Line.split)(prefixRegex, $arg$$1);
    return tuple[0];
  }, option$$1);
  p = (0, _Option.defaultArg)(option$$2, defaultPrefix);
  return [p, (0, _Line.tabsToSpaces)(tabWidth, p).length];
}

function stripLines(prefixRegex$$1, prefixLength, tabWidth$$1, eraseIndentedMarker) {
  return function (arg10$0040) {
    return (0, _Nonempty.map)(function stripLine($arg$$4) {
      let tupledArg$$1;
      let tupledArg;
      let line$$2;
      line$$2 = (0, _Line.tabsToSpaces)(tabWidth$$1, $arg$$4);
      tupledArg = (0, _Line.split)(prefixRegex$$1, line$$2);
      tupledArg$$1 = (0, _Prelude.Tuple$$$mapFirst)(function f(pre) {
        if (eraseIndentedMarker) {
          const str$$1 = (0, _String.replicate)(pre.length, " ");
          return (0, _Prelude.String$$$dropStart)(prefixLength, str$$1);
        } else {
          return (0, _Prelude.String$$$dropStart)(prefixLength, pre);
        }
      }, tupledArg[0], tupledArg[1]);
      return tupledArg$$1[0] + tupledArg$$1[1];
    }, arg10$0040);
  };
}

function maybeReformat(settings, prefix) {
  if (prefix !== "" ? settings.reformat : false) {
    return (0, _String.trimEnd)(prefix) + " ";
  } else {
    return prefix;
  }
}

function extractWrappable(marker$$1, eraseIndentedMarker$$1, reformatPrefix, settings$$1, lines$$1) {
  const regex = markerRegex(marker$$1);
  const patternInput = extractPrefix(regex, "", settings$$1.tabWidth, (0, _Nonempty.toList)(lines$$1));
  const newPrefix = settings$$1.reformat ? reformatPrefix(patternInput[0]) : patternInput[0];
  return [[newPrefix, newPrefix], stripLines(regex, patternInput[1], settings$$1.tabWidth, eraseIndentedMarker$$1)(lines$$1)];
}

function decorationLinesParser(fn, lines$$2) {
  const loop = function loop($output$$37, $_arg1$$38) {
    loop: while (true) {
      const output = $output$$37,
            _arg1 = $_arg1$$38;
      const matchValue = fn(_arg1.fields[0]);

      if (matchValue == null) {
        return output;
      } else {
        const newLine = matchValue;
        const matchValue$$1 = (0, _Nonempty.fromList)(_arg1.fields[1]);

        if (matchValue$$1 == null) {
          return new _Types.List(newLine, output);
        } else {
          const nextLines = matchValue$$1;
          $output$$37 = new _Types.List(newLine, output);
          $_arg1$$38 = nextLines;
          continue loop;
        }
      }

      break;
    }
  };

  const option$$3 = (0, _Nonempty.fromList)(loop(new _Types.List(), lines$$2));
  return (0, _Option.map)(function mapping$$1(newLinesRev) {
    return [(0, _Nonempty.singleton)(new _Block.Block(2, "NoWrap", (0, _Nonempty.rev)()(newLinesRev))), (0, _Nonempty.fromList)((0, _Prelude.List$$$safeSkip)((0, _Nonempty.length)()(newLinesRev), (0, _Nonempty.toList)(lines$$2)))];
  }, option$$3);
}

function lineComment(contentParser, marker$$2, settings$$2) {
  const prefixRegex$$2 = markerRegex(marker$$2);
  return (0, _Parsing.optionParser)((0, _Nonempty.span)(function (line$$4) {
    return (0, _Line.contains)(prefixRegex$$2, line$$4);
  }), function linesToComment(lines$$3) {
    const patternInput$$1 = extractPrefix(prefixRegex$$2, "", settings$$2.tabWidth, (0, _Nonempty.toList)(lines$$3));
    let otherLinesParser;
    const newPrefix$$1 = maybeReformat(settings$$2, patternInput$$1[0]);

    otherLinesParser = function ($arg$$6) {
      let tupledArg$$2;
      tupledArg$$2 = (0, _Block.WrappableModule$$$fromLines)([newPrefix$$1, newPrefix$$1], $arg$$6);
      return (0, _Block.splitUp)(function parser($arg$$5) {
        return contentParser(settings$$2, stripLines(prefixRegex$$2, patternInput$$1[1], settings$$2.tabWidth, true)($arg$$5));
      }, tupledArg$$2[0], tupledArg$$2[1]);
    };

    let combinedParser;
    let partialParser;
    partialParser = (0, _Parsing.takeUntil)(function otherParser(lines$$6) {
      return decorationLinesParser(function maybeMakeDecLine(line$$3) {
        const patternInput$$2 = (0, _Line.split)(prefixRegex$$2, line$$3);

        if ((patternInput$$2[0] === (0, _String.trimEnd)(patternInput$$2[0]) ? patternInput$$2[1] !== "" : false) ? !(0, _Line.containsText)(patternInput$$2[1]) : false) {
          return (0, _String.trimEnd)(patternInput$$1[0]) + patternInput$$2[1];
        } else {
          return undefined;
        }
      }, lines$$6);
    }, otherLinesParser);
    combinedParser = (0, _Parsing.repeatToEnd)(partialParser);
    const $arg$$7 = combinedParser(lines$$3);
    let head;
    head = new _Block.Block(0, "Comment", $arg$$7);
    return (0, _Nonempty.singleton)(head);
  });
}

function blockComment(contentParser$$1, tailMarker, defaultTailMarker, startMarker, endMarker, settings$$3) {
  const startRegex = markerRegex(startMarker);
  const endRegex = (0, _RegExp.create)(endMarker);
  return (0, _Parsing.optionParser)(function (arg10$0040$$7) {
    return (0, _Parsing.takeLinesBetweenMarkers)(startRegex, endRegex, arg10$0040$$7);
  }, function linesToComment$$1(lines$$7) {
    const patternInput$$3 = (0, _Line.split)(startRegex, (0, _Nonempty.head)(lines$$7));
    const prefixRegex$$3 = markerRegex(tailMarker);
    const defaultPrefix$$1 = (0, _Line.leadingWhitespace)(patternInput$$3[0]) + defaultTailMarker;
    let patternInput$$4;
    const lines$$8 = (0, _Nonempty.tail)(lines$$7);
    patternInput$$4 = extractPrefix(prefixRegex$$3, defaultPrefix$$1, settings$$3.tabWidth, lines$$8);
    const newPrefix$$2 = settings$$3.reformat ? defaultPrefix$$1 : patternInput$$4[0];

    const stripLine$$1 = function stripLine$$1($arg$$10) {
      let tupledArg$$3;
      let line$$9;
      line$$9 = (0, _Line.tabsToSpaces)(settings$$3.tabWidth, $arg$$10);
      tupledArg$$3 = (0, _Line.split)(prefixRegex$$3, line$$9);
      return (0, _Prelude.String$$$dropStart)(patternInput$$4[1], tupledArg$$3[0]) + tupledArg$$3[1];
    };

    let stdDecLineParser;
    const parsers = (0, _List.ofArray)([function (lines$$9) {
      return decorationLinesParser(function maybeMakeEndDecLine(line$$7) {
        let option$$5;
        const option$$4 = (0, _Line.tryMatch)(endRegex, line$$7);
        option$$5 = (0, _Option.filter)(function predicate($arg$$8) {
          let value;
          value = (0, _Line.containsText)($arg$$8);
          return !value;
        }, option$$4);
        return (0, _Option.map)(function mapping$$2(_arg1$$1) {
          return line$$7;
        }, option$$5);
      }, lines$$9);
    }, function (lines$$10) {
      return decorationLinesParser(function maybeMakeDecLine$$1(line$$6) {
        const patternInput$$5 = (0, _Line.split)(prefixRegex$$3, line$$6);
        const leadingWhitespace = (0, _Line.leadingWhitespace)(patternInput$$5[0]);
        const indent = (0, _Line.tabsToSpaces)(settings$$3.tabWidth, leadingWhitespace).length | 0;
        const noMarkerWithSpaceAfter = patternInput$$5[0] === leadingWhitespace ? true : patternInput$$5[0] === (0, _String.trimEnd)(patternInput$$5[0]);

        if ((!(0, _Line.containsText)(line$$6) ? line$$6.trim().length > 1 : false) ? noMarkerWithSpaceAfter ? indent < patternInput$$4[1] : false : false) {
          return line$$6;
        } else {
          return undefined;
        }
      }, lines$$10);
    }]);

    stdDecLineParser = function (lines$$11) {
      return (0, _Parsing.tryMany)(parsers, lines$$11);
    };

    let stdParser;
    let partialParser$$1;
    partialParser$$1 = (0, _Parsing.takeUntil)(stdDecLineParser, function otherLinesParser$$1($arg$$12) {
      let tupledArg$$4;
      let lines$$12;
      lines$$12 = (0, _Nonempty.map)(stripLine$$1, $arg$$12);
      tupledArg$$4 = (0, _Block.WrappableModule$$$fromLines)([newPrefix$$2, newPrefix$$2], lines$$12);
      const parser$$1 = (0, _Util.partialApply)(1, contentParser$$1, [settings$$3]);
      return (0, _Block.splitUp)(parser$$1, tupledArg$$4[0], tupledArg$$4[1]);
    });
    stdParser = (0, _Parsing.repeatToEnd)(partialParser$$1);
    let blocks;
    let matchValue$$2;
    const option$$6 = decorationLinesParser(function maybeMakeHeadDecLine(line$$5) {
      if ((line$$5 === (0, _Nonempty.head)(lines$$7) ? patternInput$$3[0] === (0, _String.trimEnd)(patternInput$$3[0]) : false) ? !(0, _Line.containsText)(patternInput$$3[1]) : false) {
        return line$$5;
      } else {
        return undefined;
      }
    }, lines$$7);
    matchValue$$2 = (0, _Option.defaultArgWith)(option$$6, function defThunk() {
      return (0, _Parsing.takeUntil)(stdDecLineParser, function otherLinesParser$$2($arg$$15) {
        let tupledArg$$5;
        let lines$$15;
        let arg10$0040$$5;
        arg10$0040$$5 = (0, _Nonempty.mapHead)(function fn$$1(_arg2) {
          return patternInput$$3[1];
        }, $arg$$15);
        lines$$15 = (0, _Nonempty.mapTail)(stripLine$$1, arg10$0040$$5);
        const prefixes$$2 = [maybeReformat(settings$$3, patternInput$$3[0]), newPrefix$$2];
        tupledArg$$5 = (0, _Block.WrappableModule$$$fromLines)(prefixes$$2, lines$$15);
        const parser$$2 = (0, _Util.partialApply)(1, contentParser$$1, [settings$$3]);
        return (0, _Block.splitUp)(parser$$2, tupledArg$$5[0], tupledArg$$5[1]);
      })(lines$$7);
    });

    if (matchValue$$2[1] == null) {
      blocks = matchValue$$2[0];
    } else {
      const remainingLines = matchValue$$2[1];
      blocks = (0, _Prelude.Nonempty$00601$$$op_Addition$$Z6CA0D220)(matchValue$$2[0], stdParser(remainingLines));
    }

    return (0, _Nonempty.singleton)(new _Block.Block(0, "Comment", blocks));
  });
}