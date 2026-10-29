import { readdir, readFile, stat } from 'node:fs/promises';
import { join, resolve } from 'node:path';

const root = resolve('dist');
const entries = await readdir(root, { recursive: true });
const pages = entries.filter((entry) => entry.endsWith('.html'));
const failures = [];
let checked = 0;

for (const page of pages) {
  const html = await readFile(join(root, page), 'utf8');
  const references = html.matchAll(/(?:href|src)="([^"]+)"/g);
  for (const [, reference] of references) {
    if (/^(?:[a-z][a-z\d+.-]*:|\/\/)/i.test(reference)) continue;
    const url = new URL(reference.replaceAll('&amp;', '&'), `https://docs.example/${page}`);
    const pathname = decodeURIComponent(url.pathname);
    const target = join(root, pathname);
    let destination = target;
    try {
      const info = await stat(destination);
      if (info.isDirectory()) destination = join(destination, 'index.html');
      const content = await readFile(destination, 'utf8');
      if (url.hash && destination.endsWith('.html')) {
        const anchor = decodeURIComponent(url.hash.slice(1));
        if (!content.includes(`id="${anchor}"`)) {
          failures.push(`${page}: missing anchor ${reference}`);
        }
      }
      checked++;
    } catch (error) {
      failures.push(`${page}: missing target ${reference} (${error.code})`);
    }
  }
}

if (failures.length > 0) {
  console.error(failures.join('\n'));
  process.exitCode = 1;
} else {
  console.log(`Verified ${checked} local references across ${pages.length} generated HTML pages.`);
}
