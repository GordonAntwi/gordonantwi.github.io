<!-- .github/copilot-instructions.md — concise, project-specific guidance for AI coding agents -->

# Antwi VA Max — AI agent instructions (concise)

- Project type: single-page static site hosted on GitHub Pages. No build system. Tailwind and Three.js are loaded from CDNs in `index.html`.
- Primary files:
  - `index.html` — canonical single-file site (content, styles, small inline scripts). Edit this for layout/content changes.
  - `scripts/chatbot.js` — client-side chat form that POSTs JSON { message } to Formspree (https://formspree.io/f/mblzeovd).
  - `automation/` — local Python helpers (e.g., `command_bot.py`, `send_email.py`). These run locally and are not part of deployment.

Key patterns and constraints
- Keep changes lightweight: prefer editing `index.html` and small standalone JS files; avoid introducing build tooling or heavy packages without owner approval.
- UI is mobile-first Tailwind. When adding sections, copy the structure used by '#services' or '#insights' and use the 'section-padding' utility.
- Use existing DOM IDs for dynamic values (examples to reuse):
  - `#hero-canvas` — Three.js hero container (leave in place if you keep 3D visuals)
  - `#hero-accra-time`, `#hero-client-time`, `#site-speed-score`, `#chatBox` — targets used by scripts.
- JS pattern: scripts attach on DOMContentLoaded (follow same pattern in new client scripts).

Integrations & external flows
- Chat: `scripts/chatbot.js` → POST to Formspree. If you change the endpoint, preserve the POST JSON shape: JSON.stringify({ message }).
- Contact/booking: mailto links and Calendly are external — don't attempt server-side workflows in this repo.

Developer workflows (quick)
- Preview locally (PowerShell):
  ```powershell
  python -m http.server 8000
  # open http://localhost:8000
  ```
- Run automation scripts locally (set env vars for secrets):
  ```powershell
  $env:SENDER_EMAIL = 'you@example.com'
  $env:SENDER_PASSWORD = 'your-password'
  python .\automation\send_email.py
  ```

Security
- Never commit credentials. `automation/send_email.py` expects env vars. If secrets are found in the repo, flag them and notify the owner.

When unsure
- Ask the owner before adding build steps, server components, or new external services. Propose small PRs that keep the repo deployable on GitHub Pages.

If you update this doc, keep it short and include exact file paths and IDs changed (helps quick owner review).

Last updated: 2025-11-01
