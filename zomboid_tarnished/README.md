# Zomboid: Tarnished — v0.1.0

A solo Project Zomboid mashup prototype: **scavenge a house → gather supplies → fight → return to a safehouse → spend runes → push farther**.

## Prototype systems

- Stamina resource with regeneration.
- Space-bar dodge state with a short prototype invulnerability window.
- Melee attacks consume stamina.
- Zombie kills award runes based on a small base reward plus target health.
- Persistent player ModData stores runes, stamina, and combat state.
- Designed for Project Zomboid Build 42.20.x.

## What is intentionally NOT in v0.1.0

- No Elden Ring game files or assets.
- No Elden Ring executable integration.
- No multiplayer.
- No custom animation pack.
- No boss/map replacement yet.
- No Melty-specific manifest is included because the authenticated Melty creator schema/tooling is not available in this session; guessing one would make the package less reliable.

## Next implementation pass

1. Validate event signatures and key handling in a real Build 42.20.4 installation.
2. Add a real dodge movement/animation layer.
3. Add poise/stagger handling and weapon-class tuning.
4. Add a safehouse interaction that converts runes into upgrades.
5. Add a Souls-style elite enemy encounter outside the first scavenged house.
6. Package and test through Melty's actual creator workflow, then capture a real gameplay screenshot/clip.

## Licensing / content note

This prototype contains original Lua logic only. It does not redistribute Project Zomboid or Elden Ring game files or assets. Elden Ring is treated as inspiration for mechanics/theme rather than a source of copied game assets.
