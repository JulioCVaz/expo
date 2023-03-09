import { getRewriteRequestUrl } from '../rewriteRequestUrl';
import { vol } from 'memfs';

describe(getRewriteRequestUrl, () => {
  it(`rewrites expo request url to entry point`, () => {
    vol.fromJSON(
      {
        '/package.json': JSON.stringify({}),
        '/index.js': 'console.log("lol")',
      },
      '/'
    );

    const rewrite = getRewriteRequestUrl('/');

    expect(
      rewrite(
        '/.expo/.virtual-metro-entry.bundle?platform=ios&dev=true&minify=false&modulesOnly=false&runModule=true&app=com.bacon.test-custom-entry'
      )
    ).toBe(
      '/index.bundle?platform=ios&dev=true&minify=false&modulesOnly=false&runModule=true&app=com.bacon.test-custom-entry'
    );
  });
});
