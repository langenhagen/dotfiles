"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.getWrappingColumn = getWrappingColumn;
exports.maybeChangeWrappingColumn = maybeChangeWrappingColumn;
exports.saveDocState = saveDocState;
exports.languageNameForFile = languageNameForFile;
exports.rewrap = rewrap;
exports.strWidth = strWidth;
exports.maybeAutoWrap = maybeAutoWrap;
exports.languages = void 0;

var _Columns = require("./Columns");

var _Parsing = require("./Parsing.Language");

var _Parsing2 = require("./Parsing.Documents");

var _Prelude = require("./Prelude");

var _Seq = require("./fable-library.2.10.1/Seq");

var _Array = require("./fable-library.2.10.1/Array");

var _Option = require("./fable-library.2.10.1/Option");

var _List = require("./fable-library.2.10.1/List");

var _Nonempty = require("./Nonempty");

var _Selections = require("./Selections");

var _Util = require("./fable-library.2.10.1/Util");

var _Wrapping = require("./Wrapping");

var _Types = require("./Types");

var _String = require("./fable-library.2.10.1/String");

function getWrappingColumn(filePath, rulers) {
  return (0, _Columns.getWrappingColumn)(filePath, rulers);
}

function maybeChangeWrappingColumn(docState, rulers$$1) {
  return (0, _Columns.maybeChangeWrappingColumn)(docState, rulers$$1);
}

function saveDocState(docState$$1) {
  (0, _Columns.saveDocState)(docState$$1);
}

function languageNameForFile(file) {
  return (0, _Prelude.maybe)(null, _Parsing.LanguageModule$$$name, (0, _Parsing2.languageForFile)(file));
}

const languages = (() => {
  const source = (0, _Seq.map)(_Parsing.LanguageModule$$$name, (0, _Parsing2.languages)());
  return (0, _Array.ofSeq)(source, Array);
})();

exports.languages = languages;

function rewrap(file$$1, settings, selections, getLine) {
  const parser = (0, _Parsing2.select)(file$$1);
  let linesList;
  let list;
  const source$$1 = (0, _Seq.unfold)(function (i) {
    const option = getLine(i);
    return (0, _Option.map)(function mapping(l) {
      return [l, i + 1];
    }, option);
  }, 0);
  list = (0, _List.ofSeq)(source$$1);
  linesList = (0, _Nonempty.fromListUnsafe)(list);
  const blocks = parser(settings)(linesList);
  return (0, _Selections.wrapSelected)(linesList, selections, settings, blocks);
}

function strWidth(usTabSize, str) {
  const tabSize = (0, _Util.max)(_Util.comparePrimitives, usTabSize, 1) | 0;

  const loop = function loop($acc$$16, $i$$1$$17) {
    loop: while (true) {
      const acc = $acc$$16,
            i$$1 = $i$$1$$17;

      if (i$$1 >= str.length) {
        return acc | 0;
      } else {
        $acc$$16 = acc + (0, _Wrapping.charWidthEx)(tabSize, i$$1, str[i$$1].charCodeAt(0));
        $i$$1$$17 = i$$1 + 1;
        continue loop;
      }

      break;
    }
  };

  return loop(0, 0) | 0;
}

function maybeAutoWrap(file$$2, settings$$1, newText, pos, getLine$$1) {
  const noEdit = new _Types.Edit(0, 0, [], []);

  if ((0, _String.isNullOrEmpty)(newText)) {
    return noEdit;
  } else if (settings$$1.column < 1) {
    return noEdit;
  } else if (!(0, _String.isNullOrWhiteSpace)(newText)) {
    return noEdit;
  } else {
    let patternInput;
    const matchValue = newText[0];

    switch (matchValue) {
      case "\n":
        {
          patternInput = [true, (0, _String.substring)(newText, 1)];
          break;
        }

      case "\r":
        {
          patternInput = [true, (0, _String.substring)(newText, 2)];
          break;
        }

      default:
        {
          patternInput = [false, ""];
        }
    }

    if (!patternInput[0] ? newText.length > 1 : false) {
      return noEdit;
    } else {
      const patternInput$$1 = [pos.line, pos.character + (patternInput[0] ? 0 : newText.length)];
      const lineText = getLine$$1(patternInput$$1[0]);
      const visualWidth = strWidth(settings$$1.tabWidth, (0, _Prelude.String$$$takeStart)(patternInput$$1[1], lineText)) | 0;

      if (visualWidth <= settings$$1.column) {
        return noEdit;
      } else {
        const fakeSelection = new _Types.Selection(new _Types.Position(patternInput$$1[0], 0), new _Types.Position(patternInput$$1[0], lineText.length));
        const edit = rewrap(file$$2, settings$$1, [fakeSelection], function wrappedGetLine(i$$2) {
          if (i$$2 > patternInput$$1[0]) {
            return null;
          } else {
            return getLine$$1(i$$2);
          }
        });
        const afterPos = patternInput[0] ? new _Types.Position(patternInput$$1[0] + 1, patternInput[1].length) : new _Types.Position(patternInput$$1[0], patternInput$$1[1]);
        const selections$$1 = [new _Types.Selection(afterPos, afterPos)];
        return new _Types.Edit(edit.startLine, edit.endLine, edit.lines, selections$$1);
      }
    }
  }
}