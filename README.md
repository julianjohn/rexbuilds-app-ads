# rexbuilds.com app-ads.txt

Serves `https://rexbuilds.com/app-ads.txt` for AdMob verification via GitHub Pages.

## Why this exists

- The portfolio lives on Google Sites at `www.rexbuilds.com`. Google Sites cannot host arbitrary files like `app-ads.txt`.
- The AdMob crawler strips `www.` from the developer website, so it fetches `rexbuilds.com/app-ads.txt` (the bare domain).
- This repo serves the bare domain from GitHub Pages. It hosts `app-ads.txt`, and every other path redirects to `https://www.rexbuilds.com`.

## Files

| File | Purpose |
| --- | --- |
| `app-ads.txt` | The authorized sellers line from AdMob |
| `CNAME` | Tells GitHub Pages to serve `rexbuilds.com` |
| `index.html`, `404.html` | Redirect visitors to the Google Sites portfolio at `www` |
| `.nojekyll` | Serves the files as-is, without Jekyll processing |
| `check.sh` | Checks the live file the way the crawler would |

## Setup

1. **Set the publisher ID.** In AdMob, go to Apps → View all apps → app-ads.txt (or Settings → Account information) and copy your line. Replace the placeholder in `app-ads.txt`:
   ```
   google.com, pub-XXXXXXXXXXXXXXXX, DIRECT, f08c47fec0942fa0
   ```
2. **Push to GitHub and enable Pages.** Use the `main` branch, root folder, with the custom domain `rexbuilds.com`.
3. **Namecheap DNS** (Domain List → Manage → Advanced DNS). Add four `A` records with host `@`:
   ```
   185.199.108.153
   185.199.109.153
   185.199.110.153
   185.199.111.153
   ```
   Remove any existing `@` URL Redirect record, because it conflicts with these. Leave the `www` CNAME → `ghs.googlehosted.com` unchanged, so Google Sites keeps working.
4. **Enforce HTTPS.** Once the certificate is issued (usually minutes, up to about 24h), tick "Enforce HTTPS" in the repo's Pages settings.
5. **Check the store listing.** The developer website in Play Console and/or App Store Connect must be `https://www.rexbuilds.com` or `https://rexbuilds.com`.
6. **Verify locally.** Run `./check.sh`.
7. **Re-check in AdMob.** Go to Apps → View all apps → app-ads.txt tab → "Check for updates". Verification can take up to about 24h.
