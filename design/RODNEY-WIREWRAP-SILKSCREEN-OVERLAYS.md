# Rodney Wire-Wrap Silkscreen Overlays

These overlays place the Rodney board partitions directly onto the actual `Vector 8801-6` board image from [design/vector-8801-6.gif](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/vector-8801-6.gif:1).

Use this set when you want a **silkscreen-like placement aid** for laying out wire-wrap sockets on the real board format.

## Files

- [Blank placement reference JPG](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/diagrams/Vector8801-6-placement-reference.jpg)
- [Board A silkscreen JPG](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/diagrams/RodneyBoardA-silkscreen.jpg)
- [Board B silkscreen JPG](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/diagrams/RodneyBoardB-silkscreen.jpg)
- [Board C silkscreen JPG](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/diagrams/RodneyBoardC-silkscreen.jpg)

## Legend

- White rounded outline: socket or placement body
- Yellow dot: `pin 1`
- Top numeric labels: `X` hole coordinates
- Left labels: `Y` hole coordinates
- Labels inside each block: part name and `pin1 X/Y`

## Notes

- These overlays use the same placement coordinates as [RODNEY-WIREWRAP-COORDINATE-WORKSHEET.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-COORDINATE-WORKSHEET.md:1).
- The mapping is tuned to the actual board photo in the repo, not to a fresh vector trace.
- It is intended for fast socket placement and visual sanity-checking, not for archival-faithful reconstruction of factory legends.
- For the current memory-board plan, treat `Board B U1`, `U7`, and `U8` as **ZIF clearance zones** if using `3 x 28-pin ZIFs`.

## Regeneration

Run:

```bash
python3 diagrams/render_rodney_silkscreen_overlays.py
```
