# Homebrew Tap for High Vibes

Official Homebrew tap for [High Vibes](https://github.com/LightBytes/homebrew-high-vibes) desktop app.

## Installation

```bash
brew tap LightBytes/high-vibes
brew install --cask high-vibes
```

## Available Casks

| Cask | Description |
|------|-------------|
| `high-vibes` | Desktop orchestration service for AI agents |

## Updating

```bash
brew update
brew upgrade --cask high-vibes
```

## Uninstalling

```bash
brew uninstall --cask high-vibes
brew untap LightBytes/high-vibes
```

---

## Release Architecture

Since the main `high-vibes` repo is private, we use a **three-repo model**:

```
┌─────────────────────────────────────────────────────────────────┐
│  LightBytes/high-vibes (private)                                │
│  └── Source code, development                                   │
│      └── apps/desktop/packaging/release.sh → builds DMG         │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼ upload DMG
┌─────────────────────────────────────────────────────────────────┐
│  LightBytes/high-vibes-releases (public)                        │
│  └── GitHub Releases only (no code)                             │
│      └── v0.1.0/HighVibes-0.1.0.dmg                             │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼ references URL
┌─────────────────────────────────────────────────────────────────┐
│  LightBytes/homebrew-high-vibes (public)                        │
│  └── Casks/high-vibes.rb                                        │
│      └── Downloads from high-vibes-releases                     │
└─────────────────────────────────────────────────────────────────┘
```

## Publishing a New Release

### 1. Build the DMG (in private repo)

```bash
cd apps/desktop
./packaging/release.sh 0.2.0
```

Output:
```
Release build complete!
  DMG: dist/HighVibes-0.2.0.dmg
  SHA256: abc123...
```

### 2. Create release in `high-vibes-releases`

```bash
# In high-vibes-releases repo
gh release create v0.2.0 \
  ~/repos/high-vibes/apps/desktop/dist/HighVibes-0.2.0.dmg \
  --title "High Vibes v0.2.0" \
  --notes "Release notes here"
```

### 3. Update the cask formula

Edit `Casks/high-vibes.rb`:
```ruby
version "0.2.0"
sha256 "<sha256-from-step-1>"
```

### 4. Commit and push

```bash
git add Casks/high-vibes.rb
git commit -m "bump: high-vibes 0.2.0"
git push
```

Users can now upgrade:
```bash
brew update && brew upgrade --cask high-vibes
```
