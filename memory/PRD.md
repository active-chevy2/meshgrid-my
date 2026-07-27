# MeshGrid MY — PRD

## Problem Statement
Ultra-lightweight, fully responsive, bilingual (English + Bahasa Melayu) single self-contained HTML page to coordinate decentralized mesh networks (BitChat & Meshtastic). Cyber-minimalist dark theme (#121212 charcoal, slate grey, #00FF66 neon). Instant language toggle (no reload). Four sections: hero (off-grid infra), simulated interactive node map canvas, 919–923 MHz hardware flashing guide, secure download vault. Must load instantly on old/low-bandwidth phones.

## Architecture
- Delivered as ONE self-contained file: /app/frontend/public/index.html (embedded CSS in <style>, vanilla JS in <script>). No frameworks in the page itself.
- React app renders nothing (App.js returns null); src/index.css & App.css intentionally emptied so the embedded dark theme wins over Tailwind base.
- No backend, no auth, no MongoDB. Pure static frontend served at root.

## Design
- Fonts: Unbounded (display) + IBM Plex Mono (body). Colors: bg #121212, neon #00FF66. Grain overlay, 1px hairline grid, HUD/tactical aesthetic, asymmetric left-aligned.
- Motion (vanilla): masked line-by-line hero reveal, IntersectionObserver scroll reveals, slow CSS marquee, hero parallax (pointer:fine only), rAF canvas node map (DPR-capped, pauses off-screen), hover micro-interactions. prefers-reduced-motion respected.

## Implemented (2026-12)
- Fixed glass header + EN/MS language toggle (data-i18n dictionary, localStorage persist).
- Kinetic hero, editorial marquee.
- Simulated node map on <canvas> (20 nodes, coverage zones, relay packets, live UTC+8 clock).
- 4-step flashing guide with 919–923 MHz legal band callout + tactical imagery.
- Download vault: BitChat Google Play, GitHub APK releases, iOS App Store, Whitepaper PDF (real links from bitchat.free).
- Footer with MCMC/SKMM legal notice.
- Tested: testing_agent iteration_1 = 100% frontend pass, no bugs.

## Backlog / Next
- P1: Add a genuine "Download this page for offline use" (Blob) card so the whole HTML works offline.
- P2: Add a real geolocated node-registry (backend) if community wants live nodes.
- P2: Add PWA manifest + service worker for installable offline access.
- P2: Add more languages (Tamil, Mandarin) — dictionary is extensible.
