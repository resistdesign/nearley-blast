import expect from 'expect.js';
import Path from 'path';
import FS from 'fs';
import {Parser, Grammar} from 'nearley';
import compile from "nearley/lib/compile";
import generate from "nearley/lib/generate";
import nearleyGrammar from "nearley/lib/nearley-language-bootstrapped";

function compileGrammar(sourceCode) {
  // Parse the grammar source into an AST
  const grammarParser = new Parser(nearleyGrammar);
  grammarParser.feed(sourceCode);
  const grammarAst = grammarParser.results[0];

  // Compile the AST into a set of rules
  const grammarInfoObject = compile(grammarAst, {});
  // Generate JavaScript code from the rules
  const grammarJs = generate(grammarInfoObject, "grammar");

  // Pretend this is a CommonJS environment to catch exports from the grammar.
  const module = {exports: {}};
  eval(grammarJs);

  return module.exports;
}

const BlastDef = FS.readFileSync(
  Path.join(__dirname, 'blast.ne'),
  {
    encoding: 'utf8'
  }
);
const DemoBlast = FS.readFileSync(
  Path.join(__dirname, 'demo.blast'),
  {
    encoding: 'utf8'
  }
);

export const BlastLang = {
  'should compile Blast Lang syntax': () => {
    const grammar = compileGrammar(BlastDef);
    const parser = new Parser(Grammar.fromCompiled(grammar));

    parser.feed(DemoBlast);

    const results = parser.results;

    console.log(JSON.stringify(results, null, '  '));

    expect(results.length).to.be.greaterThan(0);
  }
};
