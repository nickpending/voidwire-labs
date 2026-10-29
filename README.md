# Voidwire Labs

Personal blog and security research site built with Hugo and a theme drawn from the voidwire design system.

## Local Development

```bash
hugo server -D
```

## Deployment

Cloudflare Workers, static assets from `public/` (see `wrangler.jsonc`).
Workers Builds runs `hugo --minify` on push to main. Hugo 0.146 or newer;
PaperMod refuses older builds.

## Theme

`themes/voidwire/` is the site's own theme. Its CSS under `assets/css/vw/` is a copy of the
voidwire design system's tokens, base, atoms and article shape, recorded by `VOIDWIRE_REV`.
Edit colours, spacing and parts in the voidwire repo, then re-sync:

```bash
./scripts/sync-voidwire.sh      # VOIDWIRE=/path/to/voidwire to override the checkout
```

`assets/css/site.css` is the site's structure (chrome, post index, projects) and reads every colour
through a voidwire token. `data/now.yaml` feeds the home page's "Building now" column and
`data/projects.yaml` the Projects page. A post with `superseded:` in its frontmatter renders that
text as a note above the body.

## Links

- Live site: https://labs.voidwire.info
- Design system: [voidwire](https://github.com/nickpending/voidwire)
