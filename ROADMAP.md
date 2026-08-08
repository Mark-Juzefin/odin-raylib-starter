# Roadmap

## Done

- Window 800×600, 60 FPS, player sprite
- Left/right movement with normalized input vector
- Gravity and jump (SPACE)
- Floor collision
- Static one-way platforms (land from above only), tunneling fix via `prev_feet`
- Run animation (4 frames, horizontal flip on direction change)
- Collision body separated from the sprite rect

## Stopped at

Basic platformer mechanics complete. Cat can jump between platforms and
plays its run animation.

## Planned

- [ ] Sprite animation: idle and jump states (run is done)
- [ ] Camera following the player
- [ ] Tilemap / level
- [ ] Level bounds (player can't walk off screen)
- [ ] Collectibles: animated coins on platforms, picked up by the cat,
      with a counter for collected ones at the top of the screen

## Ideas

- **Parallel layers.** The level generates upward as the main axis. Alongside it,
  several parallel platform layers sit in the background, stacked one behind
  another like discs. Certain platforms act as transition points that move the
  player between layers. Depth stays discrete — a handful of positions, not
  continuous motion — so it is switching between parallel 2D worlds rather than
  real 3D.
