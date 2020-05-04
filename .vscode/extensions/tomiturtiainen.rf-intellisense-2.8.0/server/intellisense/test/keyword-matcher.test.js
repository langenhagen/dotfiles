Object.defineProperty(exports, "__esModule", { value: true });
const chai = require("chai");
const keyword_matcher_1 = require("../keyword-matcher");
const models_1 = require("../../parser/models");
const dummyPos = { line: 0, column: 0 };
const dummyLoc = { start: dummyPos, end: dummyPos };
describe("Keyword matcher", () => {
    describe("identifierMatchesKeyword", () => {
        function shouldMatch(id, kw) {
            const result = keyword_matcher_1.identifierMatchesKeyword(id, kw);
            chai.assert.isTrue(result);
        }
        function shouldNotMatch(id, kw) {
            const result = keyword_matcher_1.identifierMatchesKeyword(id, kw);
            chai.assert.isFalse(result);
        }
        const identifier = (name) => new models_1.Identifier(name, dummyLoc);
        const keyword = (name) => new models_1.UserKeyword(nsIdentifier("", name), dummyPos);
        const nsIdentifier = (namespace, name) => new models_1.NamespacedIdentifier(namespace, name, dummyLoc);
        const nsKeyword = (namespace, name) => new models_1.UserKeyword(nsIdentifier(namespace, name), dummyPos);
        it("should match identifier to user keyword with same name", () => {
            shouldMatch(identifier("Keyword Name"), keyword("Keyword Name"));
        });
        it("should match case-insensitively", () => {
            shouldMatch(identifier("Keyword Name"), keyword("keyword name"));
        });
        it("should ignore spaces when matching", () => {
            shouldMatch(identifier("I shall call you"), keyword("iShallCallYou"));
            shouldMatch(identifier("I shall call you"), keyword("i  ShallCall    You"));
        });
        it("should ignore underscores when matching", () => {
            shouldMatch(identifier("I shall call you"), keyword("i_shall_call_you"));
            shouldMatch(identifier("IShallCallYou"), keyword("i___shall_call_you"));
        });
        it("should not match when identifier is only partial of keyword", () => {
            shouldNotMatch(identifier("Partial of"), keyword("Partial of longer keyword"));
        });
        it("should not match when keyword is only partial of identifier", () => {
            shouldNotMatch(identifier("Partial of longer keyword"), keyword("Partial of"));
        });
        it("should not match when identifier is only partial of keyword with embedded arguments", () => {
            shouldNotMatch(identifier("Partial of"), keyword("Partial of keyword ${with} @{args}"));
        });
        it("should not match when keyword with embedded arguments is only partial of identifier", () => {
            shouldNotMatch(identifier("Partial with ${embedded} args longer keyword"), keyword("Partial with ${embedded} args"));
        });
        it("should match name with embedded arguments", () => {
            shouldMatch(identifier(`Keyword "with" embedded "args"`), keyword("Keyword ${arg1} embedded ${arg2}"));
            shouldMatch(identifier(`Keyword with embedded args`), keyword("Keyword ${arg1} embedded ${arg2}"));
            shouldMatch(identifier(`Keyword \${VAR} embedded \${VAR2}`), keyword("Keyword ${arg1} embedded ${arg2}"));
        });
        it("should work with keywords with reserved regex characters", () => {
            const createMatchTest = (value) => shouldMatch(identifier(value), keyword(value));
            createMatchTest("Keyword ^ $ . * + ? ( ) [ ] { } |");
            createMatchTest("Keyword[a-z|c?d]");
        });
        describe("with explicit keywords", () => {
            it("should match exactly", () => {
                shouldMatch(nsIdentifier("MyLibrary", "Keyword"), nsKeyword("MyLibrary", "Keyword"));
            });
            it("should match case-insensitively", () => {
                shouldMatch(nsIdentifier("mylibrary", "Keyword"), nsKeyword("MyLibrary", "Keyword"));
            });
            describe("should not match if namespace includes the special character", () => {
                it("<space>", () => shouldNotMatch(nsIdentifier("My Library", "Keyword"), nsKeyword("MyLibrary", "Keyword")));
                it("'.'", () => shouldNotMatch(nsIdentifier("My.Library", "Keyword"), nsKeyword("MyLibrary", "Keyword")));
                it("'_'", () => shouldNotMatch(nsIdentifier("My_Library", "Keyword"), nsKeyword("MyLibrary", "Keyword")));
            });
            it("should match any explicit keyword when not fully specified", () => {
                shouldMatch(identifier("The Keyword"), nsKeyword("MyLibrary", "The Keyword"));
                shouldMatch(identifier("The Keyword"), nsKeyword("com.company.Library", "The Keyword"));
            });
        });
    });
});
//# sourceMappingURL=keyword-matcher.test.js.map