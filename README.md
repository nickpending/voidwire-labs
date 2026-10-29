# Voidwire Labs

Personal blog and security research site built with Hugo and PaperMod theme.

## Local Development

```bash
hugo server -D
```

## Deployment

Cloudflare Workers, static assets from `public/` (see `wrangler.jsonc`).
Workers Builds runs `hugo --minify` on push to main. Hugo 0.146 or newer;
PaperMod refuses older builds.

## Links

- Live site: https://labs.voidwire.info
- Theme: [PaperMod](https://github.com/adityatelange/hugo-PaperMod)
