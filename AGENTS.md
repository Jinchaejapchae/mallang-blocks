# mallang-blocks — Agent Team Rules

> Keep this top rules block stable so implicit prompt caching applies across runs.

## Never (Hard Rules)
- Never run `publish.bat` or push directly to `main` (always use a feature/fix branch and PR after explicit user approval).
- Never modify `index.html` without bumping `CACHE` in `sw.js:2`.
- Never break existing `localStorage` saved high scores or custom keybind storage (`index.html:174-175`).
- Never install packages, deploy, delete files, or spend money without explicit user approval.
- Never ask for API keys or secrets in chat; never send `thinking_budget`.
- Never pretend a check ran; paste the last 20 lines of actual command output and 1-based `path:line` citations.

## Project
- **Stack**: Zero-build GitHub Pages single-HTML block puzzle PWA (`index.html:1-645`, `sw.js:1-29`, `manifest.json`, icons).
- **Riskiest Files**: `index.html` (`L234-336` collision/rotation/lock/clear/gameOver, `L594-638` loop & SW registration), `sw.js` (`L2` `CACHE = 'mallang-v1'`).

## Commands
- **Service Worker syntax check**: `node --check sw.js`
- **Inline HTML `<script>` syntax check**:
  `node -e "const fs=require('fs'),vm=require('vm');const h=fs.readFileSync('index.html','utf8');let i=0;for(const m of h.matchAll(/<script(?![^>]*\bsrc=)[^>]*>([\s\S]*?)<\/script>/gi)){new vm.Script(m[1],{filename:'index.html#'+(++i)});}console.log('OK scripts:',i);"`
- **Manifest JSON check**: `node -e "JSON.parse(require('fs').readFileSync('manifest.json','utf8'));console.log('OK manifest.json');"`

## Ownership
- `@coordinator` (`gemini-4-neon`, thinking `high`; `xhigh` only for 1 deep bug): Sole user interface; plans, assigns ownership, reviews verifier output, prepares PRs.
- `@game-dev` (`gemini-4-hydrogen`): Owns `index.html`. Must not touch `sw.js`, `manifest.json`, `publish.bat`, icons, `AGENTS.md`.
- `@pwa-sw` (`gemini-4-hydrogen`): Owns `sw.js`, `manifest.json`. Must not touch `index.html`, `publish.bat`, icons, `AGENTS.md`.
- `@verifier` (**must run on a different model than workers**, read-only): Owns no files; never edits. Reports to `@coordinator`.

## Done Means
1. Every worker changed only files inside its `OWNS` paths.
2. `node --check sw.js`, inline `<script>` syntax check on `index.html`, and `manifest.json` JSON parse check all pass.
3. If `index.html` changed, `CACHE` in `sw.js:2` was bumped.
4. `@verifier` opened all cited files/lines, re-ran commands, pasted the last 20 lines, and approved within at most 2 reject rounds.
5. Changes land on a branch and open a PR (never direct push to `main`).
