"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.markdown = markdown;

var _Types = require("./fable-library.2.10.1/Types");

var _Reflection = require("./fable-library.2.10.1/Reflection");

var _Line = require("./Line");

var _Prelude = require("./Prelude");

var _String = require("./fable-library.2.10.1/String");

var _Nonempty = require("./Nonempty");

var _List = require("./fable-library.2.10.1/List");

var _Util = require("./fable-library.2.10.1/Util");

var _Block = require("./Block");

var _RegExp = require("./fable-library.2.10.1/RegExp");

var _Parsing = require("./Parsing.Core");

var _Option = require("./fable-library.2.10.1/Option");

const MarkdownState = (0, _Types.declare)(function Parsing_Markdown_MarkdownState(tag, name, ...fields) {
  this.tag = tag | 0;
  this.name = name;
  this.fields = fields;
}, _Types.Union);

function MarkdownState$reflection() {
  return (0, _Reflection.union_type)("Parsing.Markdown.MarkdownState", [], MarkdownState, () => ["FencedCodeBlock", "Paragraph", "NonParagraph"]);
}

function markdown(settings) {
  var startRegex, endRegex, startRegex$$1, endRegex$$1, startRegex$$2, endRegex$$2, startRegex$$3, endRegex$$3, startRegex$$4, endRegex$$4, startRegex$$5, endRegex$$5, regex$$1;

  const fencedCodeBlock = function fencedCodeBlock(_arg1) {
    const patternInput$$2 = (0, _Line.split)(fencedCodeBlockRegex, _arg1.fields[0]);
    const hasStartMarker = patternInput$$2[0].length > 0;

    if (hasStartMarker) {
      const marker$$1 = (0, _Prelude.String$$$trimStart)(patternInput$$2[0]);
      const markerChar = (0, _String.getCharAtIndex)(marker$$1, 0);

      if (patternInput$$2[1].indexOf(markerChar) >= 0) {
        return undefined;
      } else {
        let arg0$$1;
        let tupledArg;
        const startLineIndent = patternInput$$2[0].length - marker$$1.length | 0;
        const patternInput = (0, _Prelude.List$$$span)(function ($arg$$3) {
          const value = lineStartsWith(marker$$1)($arg$$3);
          return !value;
        })(_arg1.fields[1]);
        const patternInput$$1 = patternInput[1].tail != null ? [new _Types.List(patternInput[1].head, new _Types.List()), (0, _Nonempty.fromList)(patternInput[1].tail)] : [new _Types.List(), undefined];
        let outputLines;

        if (settings.reformat) {
          let contentIndentShift;
          let e2;
          let list$$3;
          list$$3 = (0, _List.map)(function mapping$$1(l) {
            return l.length;
          }, patternInput[0]);
          e2 = (0, _List.min)(list$$3, {
            Compare: _Util.comparePrimitives
          });
          contentIndentShift = (0, _Util.min)(_Util.comparePrimitives, startLineIndent, e2);
          outputLines = new _Prelude.Nonempty$00601(0, "Nonempty", (0, _Prelude.String$$$trimStart)(_arg1.fields[0]), (0, _List.append)((0, _List.map)(function (str$$1) {
            return (0, _Prelude.String$$$dropStart)(contentIndentShift, str$$1);
          }, patternInput[0]), (0, _List.map)(_Prelude.String$$$trimStart, patternInput$$1[0])));
        } else {
          outputLines = new _Prelude.Nonempty$00601(0, "Nonempty", _arg1.fields[0], (0, _List.append)(patternInput[0], patternInput$$1[0]));
        }

        tupledArg = [outputLines, patternInput$$1[1]];
        arg0$$1 = (0, _Prelude.Tuple$$$mapFirst)(function f($arg$$8) {
          let head;
          head = new _Block.Block(2, "NoWrap", $arg$$8);
          return (0, _Nonempty.singleton)(head);
        }, tupledArg[0], tupledArg[1]);
        return arg0$$1;
      }
    } else {
      return undefined;
    }
  };

  let htmlType1to6;
  let parsers;
  const list$$4 = (0, _List.ofArray)([(startRegex = mdMarker("<(script|pre|style)( |>|$)"), (endRegex = (0, _RegExp.create)("</(script|pre|style)>", 1), function (arg10$0040$$1) {
    return (0, _Parsing.takeLinesBetweenMarkers)(startRegex, endRegex, arg10$0040$$1);
  })), (startRegex$$1 = mdMarker("<!--"), (endRegex$$1 = (0, _RegExp.create)("-->"), function (arg10$0040$$2) {
    return (0, _Parsing.takeLinesBetweenMarkers)(startRegex$$1, endRegex$$1, arg10$0040$$2);
  })), (startRegex$$2 = mdMarker("<\\?"), (endRegex$$2 = (0, _RegExp.create)("\\?>"), function (arg10$0040$$3) {
    return (0, _Parsing.takeLinesBetweenMarkers)(startRegex$$2, endRegex$$2, arg10$0040$$3);
  })), (startRegex$$3 = mdMarker("<![A-Z]"), (endRegex$$3 = (0, _RegExp.create)(">"), function (arg10$0040$$4) {
    return (0, _Parsing.takeLinesBetweenMarkers)(startRegex$$3, endRegex$$3, arg10$0040$$4);
  })), (startRegex$$4 = mdMarker("<!\\[CDATA\\["), (endRegex$$4 = (0, _RegExp.create)("]]>"), function (arg10$0040$$5) {
    return (0, _Parsing.takeLinesBetweenMarkers)(startRegex$$4, endRegex$$4, arg10$0040$$5);
  })), (startRegex$$5 = mdMarker("</?(address|article|aside|base|basefont|blockquote|body|caption|center|col|colgroup|dd|details|dialog|dir|div|dl|dt|fieldset|figcaption|figure|footer|form|frame|frameset|h1|h2|h3|h4|h5|h6|head|header|hr|html|iframe|legend|li|link|main|menu|menuitem|meta|nav|noframes|ol|optgroup|option|p|param|section|source|summary|table|tbody|td|tfoot|th|thead|title|tr|track|ul)(\\s|/?>|$)"), (endRegex$$5 = (0, _RegExp.create)("^\\s*$"), function (arg10$0040$$6) {
    return (0, _Parsing.takeLinesBetweenMarkers)(startRegex$$5, endRegex$$5, arg10$0040$$6);
  }))]);
  parsers = (0, _List.map)(_Parsing.ignoreParser, list$$4);

  htmlType1to6 = function (lines$$2) {
    return (0, _Parsing.tryMany)(parsers, lines$$2);
  };

  let table;
  const cellsRowRegex = (0, _RegExp.create)("\\S\\s*\\|\\s*\\S");
  const dividerRowRegex = (0, _RegExp.create)(":?-+:?\\s*\\|\\s*:?-+:?");
  table = (0, _Parsing.ignoreParser)(function splitter$$1(lines$$3) {
    const matchValue = (0, _Nonempty.toList)(lines$$3);
    var $target$$21, firstLine, rest, secondLine;

    if (matchValue.tail != null) {
      if (matchValue.tail.tail != null) {
        $target$$21 = 0;
        firstLine = matchValue.head;
        rest = matchValue.tail.tail;
        secondLine = matchValue.tail.head;
      } else {
        $target$$21 = 1;
      }
    } else {
      $target$$21 = 1;
    }

    switch ($target$$21) {
      case 0:
        {
          if ((0, _Line.contains)(cellsRowRegex, firstLine) ? (0, _Line.contains)(dividerRowRegex, secondLine) : false) {
            let arg0$$2;
            let tupledArg$$2;
            const tupledArg$$1 = (0, _Prelude.List$$$span)(function (line) {
              return (0, _Line.contains)(cellsRowRegex, line);
            })(rest);
            tupledArg$$2 = (0, _Prelude.Tuple$$$mapFirst)(function f$$1(rows) {
              return new _Prelude.Nonempty$00601(0, "Nonempty", firstLine, new _Types.List(secondLine, rows));
            }, tupledArg$$1[0], tupledArg$$1[1]);
            arg0$$2 = (0, _Prelude.Tuple$$$mapSecond)(_Nonempty.fromList, tupledArg$$2[0], tupledArg$$2[1]);
            return arg0$$2;
          } else {
            return undefined;
          }
        }

      case 1:
        {
          return undefined;
        }
    }
  });
  const nonText = (0, _Parsing.ignoreParser)((0, _Nonempty.span)(function (s$$1) {
    return !((0, _Line.containsText)(s$$1) ? true : (0, _Line.isBlank)(s$$1));
  }));
  const atxHeading = (0, _Parsing.ignoreParser)((0, _Nonempty.span)(lineStartsWith("#{1,6} ")));
  const blockQuote = (0, _Parsing.optionParser)(function splitter$$2(lines$$4) {
    let option$$1;
    const option = lines$$4;
    option$$1 = (0, _Option.filter)(function predicate($arg$$9) {
      return lineStartsWith(">")(((0, _Nonempty.head)($arg$$9)));
    }, option);
    const binder = (0, _Nonempty.span)(function (s$$2) {
      return !(0, _Line.isBlank)(s$$2);
    });
    return (0, _Option.bind)(binder, option$$1);
  }, function mapper(lines$$5) {
    var regex, s$$3;
    const tuples = (0, _Nonempty.map)((regex = (0, _RegExp.create)(" {0,3}>? ?"), function (line$$1) {
      return (0, _Line.split)(regex, line$$1);
    }), lines$$5);
    let prefixes;

    if (settings.reformat) {
      prefixes = ["> ", "> "];
    } else {
      const matchValue$$1 = (0, _List.tryHead)(tuples.fields[1]);
      var $target$$26, s$$4;

      if (matchValue$$1 != null) {
        if (s$$3 = matchValue$$1[0], !(s$$3.indexOf(">") >= 0)) {
          $target$$26 = 0;
          s$$4 = matchValue$$1[0];
        } else {
          $target$$26 = 1;
        }
      } else {
        $target$$26 = 1;
      }

      switch ($target$$26) {
        case 0:
          {
            prefixes = [tuples.fields[0][0], s$$4];
            break;
          }

        case 1:
          {
            prefixes = [tuples.fields[0][0], tuples.fields[0][0]];
            break;
          }
      }
    }

    const tupledArg$$3 = [prefixes, ((0, _Nonempty.map)(function fn$$1(tuple) {
      return tuple[1];
    }, tuples))];
    const parser = markdown(settings);
    return (0, _Block.splitUp)(parser, tupledArg$$3[0], tupledArg$$3[1]);
  });
  let indentedCodeBlock;
  const takeLines = (0, _Nonempty.span)((regex$$1 = (0, _RegExp.create)("^(\\s{4}|\\t)"), function (line$$2) {
    return (0, _Line.contains)(regex$$1, line$$2);
  }));
  indentedCodeBlock = (0, _Parsing.optionParser)(takeLines, function toBlocks($arg$$11) {
    let head$$1;
    const arg0$$3 = (settings.reformat ? function (lines) {
      let minIndent;
      let list$$1;
      const list = (0, _Nonempty.toList)(lines);
      list$$1 = (0, _List.map)(function mapping(s) {
        return s.length - (0, _String.trimStart)(s).length;
      }, list);
      minIndent = (0, _List.min)(list$$1, {
        Compare: _Util.comparePrimitives
      });
      let fn;
      const n$$1 = minIndent - 4 | 0;

      fn = function (str) {
        return (0, _Prelude.String$$$dropStart)(n$$1, str);
      };

      return (0, _Nonempty.map)(fn, lines);
    } : function (x$$1) {
      return x$$1;
    })($arg$$11);
    head$$1 = new _Block.Block(2, "NoWrap", arg0$$3);
    return (0, _Nonempty.singleton)(head$$1);
  });

  const listItem = function listItem(_arg2) {
    const option$$2 = (0, _Line.tryMatch)(listItemRegex, _arg2.fields[0]);
    return (0, _Option.map)(function doStuff(listItemPrefix) {
      var tupledArg$$4, parser$$1;
      const strippedFirstLine = (0, _Prelude.String$$$dropStart)(listItemPrefix.length, _arg2.fields[0]);
      const prefixWithSpace = (0, _String.endsWith)(listItemPrefix, " ") ? listItemPrefix : listItemPrefix + " ";
      const indent = prefixWithSpace.length | 0;
      const patternInput$$3 = strippedFirstLine === "" ? findListItemEnd(indent)(new MarkdownState(2, "NonParagraph"))(_arg2.fields[1]) : findListItemEnd(indent)(new MarkdownState(1, "Paragraph"))(_arg2.fields[1]);
      const tailRegex = (0, _RegExp.create)("^ {0," + (0, _Util.int32ToString)(indent) + "}");
      const headPrefix = settings.reformat ? (0, _Prelude.String$$$trim)(prefixWithSpace) + " " : prefixWithSpace;
      return [(tupledArg$$4 = [[headPrefix, (0, _String.replicate)(headPrefix.length, " ")], new _Prelude.Nonempty$00601(0, "Nonempty", strippedFirstLine, (0, _List.map)(function ($arg$$12) {
        let tuple$$1;
        tuple$$1 = (0, _Line.split)(tailRegex, $arg$$12);
        return tuple$$1[1];
      }, patternInput$$3[0]))], (parser$$1 = markdown(settings), (0, _Block.splitUp)(parser$$1, tupledArg$$4[0], tupledArg$$4[1]))), patternInput$$3[1]];
    }, option$$2);
  };

  let paragraphTerminator;
  const parsers$$1 = (0, _List.ofArray)([_Parsing.blankLines, fencedCodeBlock, nonText, listItem, blockQuote, atxHeading, htmlType1to6]);

  paragraphTerminator = function (lines$$8) {
    return (0, _Parsing.tryMany)(parsers$$1, lines$$8);
  };

  return function ($arg$$14) {
    return (0, _Parsing.repeatToEnd)(function allParsers(lines$$9) {
      const option$$3 = (0, _Parsing.tryMany)((0, _List.ofArray)([_Parsing.blankLines, fencedCodeBlock, table, nonText, atxHeading, indentedCodeBlock, listItem, blockQuote]), lines$$9);
      return (0, _Option.defaultArgWith)(option$$3, function defThunk() {
        return (0, _Parsing.takeUntil)(paragraphTerminator, function paragraph($arg$$13) {
          const arg10$0040$$11 = (0, _Parsing.splitIntoChunks)((0, _Parsing.afterRegex)((0, _RegExp.create)("(\\\\|\\s{2})$")))($arg$$13);
          return (0, _Nonempty.map)(function fn$$2(arg10$0040$$10) {
            return (0, _Parsing.firstLineIndentParagraphBlock)(settings.reformat, arg10$0040$$10);
          }, arg10$0040$$11);
        })(lines$$9);
      });
    })(((0, _Nonempty.map)(function fn$$3(str$$3) {
      return (0, _Line.tabsToSpaces)(settings.tabWidth, str$$3);
    }, $arg$$14)));
  };
}

function mdMarker(marker$$2) {
  return (0, _RegExp.create)("^ {0,3}" + marker$$2, 1);
}

const listItemRegex = mdMarker("([-+*]|[0-9]+[.)])(\\s+|$)");
const blockQuoteRegex = mdMarker(">");
const fencedCodeBlockRegex = mdMarker("(`{3,}|~{3,})");

function lineStartsWith($arg$$15) {
  let regex$$2;
  regex$$2 = mdMarker($arg$$15);
  return function (line$$4) {
    return (0, _Line.contains)(regex$$2, line$$4);
  };
}

function findListItemEnd(indent$$1) {
  const loop = function loop(output, state$$1, lines$$10) {
    const exitLoop = function exitLoop() {
      return [(0, _List.reverse)(output), (0, _Nonempty.fromList)(lines$$10)];
    };

    if (lines$$10.tail == null) {
      return exitLoop();
    } else {
      let trimmedLine;
      let p = 0;

      while ((p < indent$$1 ? p < lines$$10.head.length : false) ? lines$$10.head[p] === " " : false) {
        p = p + 1;
      }

      trimmedLine = (0, _String.substring)(lines$$10.head, p);

      const continueLoop = function continueLoop() {
        return loop(new _Types.List(lines$$10.head, output), (state$$1.tag === 1 ? lineStartsWith("(```|~~~)")(trimmedLine) ? new MarkdownState(0, "FencedCodeBlock") : (!(0, _Line.containsText)(trimmedLine) ? true : lineStartsWith("#{1,6} ")(trimmedLine)) ? new MarkdownState(2, "NonParagraph") : new MarkdownState(1, "Paragraph") : state$$1.tag === 2 ? lineStartsWith("(```|~~~)")(trimmedLine) ? new MarkdownState(0, "FencedCodeBlock") : (!(0, _Line.containsText)(trimmedLine) ? true : lineStartsWith("#{1,6} ")(trimmedLine)) ? new MarkdownState(2, "NonParagraph") : (0, _Line.contains)((0, _RegExp.create)("^ {4,}"), trimmedLine) ? new MarkdownState(2, "NonParagraph") : new MarkdownState(1, "Paragraph") : lineStartsWith("(```|~~~)")(trimmedLine) ? new MarkdownState(2, "NonParagraph") : new MarkdownState(0, "FencedCodeBlock")), lines$$10.tail);
      };

      if ((0, _Line.isBlank)(lines$$10.head)) {
        return continueLoop();
      } else {
        const indentIsLess = lines$$10.head.length - trimmedLine.length < indent$$1;

        if (indentIsLess) {
          switch (state$$1.tag) {
            case 1:
              {
                if (((0, _Line.contains)(blockQuoteRegex, lines$$10.head) ? true : (0, _Line.contains)(listItemRegex, lines$$10.head)) ? true : (0, _Line.contains)(fencedCodeBlockRegex, lines$$10.head)) {
                  return exitLoop();
                } else {
                  return continueLoop();
                }
              }

            case 2:
              {
                return exitLoop();
              }

            default:
              {
                return continueLoop();
              }
          }
        } else {
          return continueLoop();
        }
      }
    }
  };

  return (0, _Util.partialApply)(2, loop, [new _Types.List()]);
}