"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.isBlank = isBlank;
exports.contains = contains;
exports.startsWith = startsWith;
exports.tryMatch = tryMatch;
exports.leadingWhitespace = leadingWhitespace;
exports.containsText = containsText;
exports.split = split;
exports.tabsToSpaces = tabsToSpaces;

var _String = require("./fable-library.2.10.1/String");

var _RegExp = require("./fable-library.2.10.1/RegExp");

var _Prelude = require("./Prelude");

var _Option = require("./fable-library.2.10.1/Option");

var _List = require("./fable-library.2.10.1/List");

var _Types = require("./fable-library.2.10.1/Types");

function isBlank(l) {
  return (0, _String.isNullOrWhiteSpace)(l);
}

function contains(regex, line) {
  return (0, _RegExp.isMatch)(regex, line);
}

function startsWith(marker, line$$1) {
  return (0, _RegExp.isMatch)((0, _RegExp.create)("^\\s*" + marker), line$$1);
}

function tryMatch(regex$$1, line$$2) {
  const m = (0, _RegExp.match)(regex$$1, line$$2);

  if (m != null) {
    return (0, _Prelude.String$$$takeStart)(m.index + m[0].length, line$$2);
  } else {
    return undefined;
  }
}

function leadingWhitespace(line$$3) {
  return (0, _RegExp.match)(leadingWhitespaceRegex, line$$3)[0];
}

function containsText(line$$4) {
  if (contains((0, _RegExp.create)("[A-Za-z0-9À-￿]"), line$$4)) {
    return !contains((0, _RegExp.create)("^=(begin|end)\\s*$"), line$$4);
  } else {
    return false;
  }
}

function split(regex$$2, line$$5) {
  let prefix;
  const option = tryMatch(regex$$2, line$$5);
  prefix = (0, _Option.defaultArg)(option, "");
  return [prefix, (0, _Prelude.String$$$dropStart)(prefix.length, line$$5)];
}

function tabsToSpaces(tabSize, str) {
  let matchValue;
  let list;
  const array = str.split("\t");
  list = (0, _List.ofArray)(array);
  matchValue = (0, _List.reverse)(list);

  if (matchValue.tail != null) {
    let strings;
    let list$$2;
    let tail;
    tail = (0, _List.map)(function mapping(s) {
      return (0, _String.padRight)(s, (~~(s.length / tabSize) + 1) * tabSize);
    }, matchValue.tail);
    list$$2 = new _Types.List(matchValue.head, tail);
    strings = (0, _List.reverse)(list$$2);
    return (0, _String.join)("", strings);
  } else {
    return str;
  }
}

const leadingWhitespaceRegex = (0, _RegExp.create)("^\\s*");