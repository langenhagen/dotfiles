Object.defineProperty(exports, "__esModule", { value: true });
const _ = require("lodash");
var VisitorOption;
(function (VisitorOption) {
    VisitorOption["Skip"] = "skip";
    VisitorOption["Break"] = "break";
    VisitorOption["Continue"] = "continue";
})(VisitorOption = exports.VisitorOption || (exports.VisitorOption = {}));
const NodeSettings = {
    TestSuite: {
        orderEnsured: false,
        children: [
            "settingsTable",
            "variablesTable",
            "keywordsTable",
            "testCasesTable",
        ],
    },
    KeywordsTable: {
        orderEnsured: true,
        children: ["keywords"],
    },
    UserKeyword: {
        orderEnsured: false,
        children: [
            "id",
            "steps",
            "arguments",
            "return",
            "documentation",
            "timeout",
            "teardown",
            "tags",
        ],
    },
    SettingsTable: {
        orderEnsured: false,
        children: [
            "suiteSetup",
            "suiteTeardown",
            "testSetup",
            "testTeardown",
            "libraryImports",
            "resourceImports",
            "variableImports",
            "documentation",
        ],
    },
    SuiteSetting: {
        orderEnsured: true,
        children: ["name", "value"],
    },
    LibraryImport: {
        orderEnsured: true,
        children: ["target", "args"],
    },
    ResourceImport: {
        orderEnsured: true,
        children: ["target"],
    },
    VariableImport: {
        orderEnsured: true,
        children: ["target"],
    },
    VariablesTable: {
        orderEnsured: true,
        children: ["variables"],
    },
    ScalarDeclaration: {
        orderEnsured: true,
        children: ["id", "value"],
    },
    ListDeclaration: {
        orderEnsured: true,
        children: ["id", "values"],
    },
    DictionaryDeclaration: {
        orderEnsured: true,
        children: ["id", "values"],
    },
    TestCasesTable: {
        orderEnsured: true,
        children: ["testCases"],
    },
    TestCase: {
        orderEnsured: false,
        children: [
            "id",
            "steps",
            "documentation",
            "timeout",
            "setup",
            "teardown",
            "tags",
        ],
    },
    Step: {
        orderEnsured: true,
        children: ["body"],
    },
    CallExpression: {
        orderEnsured: true,
        children: ["callee", "args"],
    },
    VariableExpression: {
        orderEnsured: true,
        children: ["id"],
    },
    Literal: {
        orderEnsured: true,
        children: [],
    },
    TemplateLiteral: {
        orderEnsured: false,
        children: ["quasis", "expressions"],
    },
    Documentation: {
        orderEnsured: true,
        children: ["id", "value"],
    },
    Arguments: {
        orderEnsured: true,
        children: ["id", "values"],
    },
    Return: {
        orderEnsured: true,
        children: ["id", "values"],
    },
    Timeout: {
        orderEnsured: true,
        children: ["id", "value", "message"],
    },
    Tags: {
        orderEnsured: true,
        children: ["id", "values"],
    },
    Setup: {
        orderEnsured: true,
        children: ["id", "keyword"],
    },
    Teardown: {
        orderEnsured: true,
        children: ["id", "keyword"],
    },
};
function visit(node, parent, visitor) {
    if (visitor.enter) {
        return visitor.enter(node, parent);
    }
    else {
        return null;
    }
}
function leave(node, parent, visitor) {
    if (visitor.leave) {
        return visitor.leave(node, parent);
    }
    else {
        return null;
    }
}
function internalTraverse(node, parent, visitor) {
    // Naive recursive implementation
    // TODO: Remove recursivity
    if (!node) {
        return;
    }
    let visitResult = visit(node, parent, visitor);
    if (visitResult === VisitorOption.Break) {
        return VisitorOption.Break;
    }
    if (visitResult !== VisitorOption.Skip) {
        const nodeSettings = NodeSettings[node.type];
        if (nodeSettings && !_.isEmpty(nodeSettings.children)) {
            // TODO: Check order
            nodeSettings.children.forEach(propertyName => {
                const childNode = node[propertyName];
                if (Array.isArray(childNode)) {
                    for (const item of childNode) {
                        visitResult = internalTraverse(item, node, visitor);
                        if (visitResult === VisitorOption.Break) {
                            return VisitorOption.Break;
                        }
                    }
                }
                else {
                    visitResult = internalTraverse(childNode, node, visitor);
                    if (visitResult === VisitorOption.Break) {
                        return VisitorOption.Break;
                    }
                }
                return VisitorOption.Continue;
            });
        }
    }
    return leave(node, parent, visitor);
}
function traverse(node, visitor) {
    internalTraverse(node, null, visitor);
}
exports.traverse = traverse;
//# sourceMappingURL=traverse.js.map