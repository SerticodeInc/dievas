import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  site: 'https://docs.dievas.serticode.com',
  trailingSlash: 'always',
  integrations: [starlight({
    title: 'Dievas',
    description: 'Build branded Flutter interfaces with Dievas. Learn tokens, themes, components, and production patterns.',
    logo: { src: './src/assets/dievas-logo.svg', alt: 'Dievas' },
    favicon: '/favicon.svg',
    customCss: ['./src/styles/custom.css'],
    editLink: { baseUrl: 'https://github.com/SerticodeInc/dievas/edit/master/documentation/' },
    social: [
      { icon: 'github', label: 'GitHub', href: 'https://github.com/SerticodeInc/dievas' },
    ],
    head: [{ tag: 'meta', attrs: { name: 'theme-color', content: '#5C33CF' } }],
    sidebar: [
      { label: 'Start Here', items: [
        { label: 'Introduction', slug: 'index' },
        { label: 'Install Dievas', slug: 'start/install' },
        { label: 'Your First Screen', slug: 'start/first-screen' },
      ] },
      { label: 'Foundations', autogenerate: { directory: 'foundations' } },
      { label: 'Theming', autogenerate: { directory: 'theming' } },
      { label: 'Components', autogenerate: { directory: 'components' } },
      { label: 'Recipes', autogenerate: { directory: 'recipes' } },
      { label: 'Maintain & Upgrade', autogenerate: { directory: 'maintain' } },
      { label: 'Interactive Gallery ↗', link: 'https://master.dievas-gallery.pages.dev' },
      { label: 'Dievas Website ↗', link: 'https://dievas.serticode.com' },
    ],
  })],
});
