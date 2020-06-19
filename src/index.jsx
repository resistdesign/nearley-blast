import React from 'react';
import {render} from 'react-dom';
import {Parser, Grammar} from 'nearley';
import BlastGrammar from 'nearley!./blast.ne';
import DemoBlast from 'raw!./demo.blast';

const grammar = Grammar.fromCompiled(BlastGrammar);
const parser = new Parser(grammar);

parser.feed(DemoBlast);

const appDiv = document.getElementById('app');

render(
  <pre>
    {JSON.stringify(parser.results[0], null, '  ')}
  </pre>,
  appDiv
);
