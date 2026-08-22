#!/usr/bin/env python3

from pathlib import Path
from PIL import Image, ImageDraw, ImageFont, ImageSequence


ROOT = Path(__file__).resolve().parent.parent
BOARD_GIF = ROOT / "design" / "vector-8801-6.gif"
OUT_DIR = ROOT / "diagrams"


GEOM = {
    "x0": 31,
    "y0": 44,
    "pitch_x": 6.72,
    "pitch_y": 6.72,
    "scale": 2,
}


PACKAGE_SPANS = {
    "DIP-14": (7, 4),
    "DIP-16": (8, 4),
    "DIP-20": (10, 4),
    "DIP-28": (14, 7),
    "DIP-40": (20, 7),
    "SW8": (12, 4),
    "LEDROW": (8, 10),
    "HEADER2R": (8, 8),
    "TESTROW6": (34, 2),
    "TESTROW8": (42, 2),
    "TESTROW4": (20, 2),
    "JUMPER3": (14, 2),
    "CRYSTAL": (6, 2),
    "PBUTTON": (6, 3),
    "CBULK": (6, 6),
}


COLORS = {
    "cpu": (244, 196, 48, 90),
    "memory": (72, 187, 120, 90),
    "logic": (66, 153, 225, 90),
    "decode": (159, 122, 234, 90),
    "service": (237, 137, 54, 75),
    "io": (236, 72, 153, 85),
    "switch": (45, 212, 191, 90),
    "led": (239, 68, 68, 85),
    "outline": (255, 255, 255, 220),
    "text": (255, 255, 255, 255),
    "shadow": (0, 0, 0, 180),
    "pin1": (255, 245, 157, 255),
    "grid": (255, 255, 255, 150),
}


BOARDS = {
    "A": {
        "title": "Board A: CPU / Bus Silkscreen Overlay",
        "placements": [
            {"name": "TP1-TP6", "x": 10, "y": 3, "pkg": "TESTROW6", "color": "service", "label": "TP CLK ALE RD WR IO/M RST"},
            {"name": "SW1", "x": 54, "y": 8, "pkg": "PBUTTON", "color": "service", "label": "RESET"},
            {"name": "Y1", "x": 61, "y": 8, "pkg": "CRYSTAL", "color": "service", "label": "XTAL"},
            {"name": "U5", "x": 73, "y": 8, "pkg": "DIP-14", "color": "logic", "label": "U5 74LS04"},
            {"name": "U2", "x": 17, "y": 16, "pkg": "DIP-20", "color": "logic", "label": "U2 74LS373"},
            {"name": "U1", "x": 39, "y": 16, "pkg": "DIP-40", "color": "cpu", "label": "U1 8085A"},
            {"name": "U3", "x": 70, "y": 16, "pkg": "DIP-20", "color": "logic", "label": "U3 74LS245"},
            {"name": "U4", "x": 72, "y": 24, "pkg": "DIP-16", "color": "decode", "label": "U4 74LS138"},
            {"name": "J1", "x": 84, "y": 26, "pkg": "HEADER2R", "color": "service", "label": "J1 BUS"},
            {"name": "Cbulk", "x": 4, "y": 31, "pkg": "CBULK", "color": "service", "label": "Cbulk"},
        ],
    },
    "B": {
        "title": "Board B: Memory / Decode Silkscreen Overlay",
        "placements": [
            {"name": "TP1-TP8", "x": 10, "y": 3, "pkg": "TESTROW8", "color": "service", "label": "TP PRG ROM MMA-L MMA-H MMD MMA0 MMA8 D0"},
            {"name": "U1", "x": 37, "y": 10, "pkg": "DIP-28", "color": "memory", "label": "U1 62256 MAIN"},
            {"name": "U2", "x": 13, "y": 20, "pkg": "DIP-16", "color": "decode", "label": "U2 74LS138"},
            {"name": "U3", "x": 24, "y": 20, "pkg": "DIP-16", "color": "decode", "label": "U3 74LS139"},
            {"name": "U4", "x": 48, "y": 20, "pkg": "DIP-20", "color": "logic", "label": "U4 MMA LOW"},
            {"name": "U5", "x": 60, "y": 20, "pkg": "DIP-20", "color": "logic", "label": "U5 MMA HIGH"},
            {"name": "U6", "x": 73, "y": 20, "pkg": "DIP-20", "color": "logic", "label": "U6 MMD PATH"},
            {"name": "U7", "x": 12, "y": 28, "pkg": "DIP-28", "color": "memory", "label": "U7 6264 PRG"},
            {"name": "U8", "x": 61, "y": 28, "pkg": "DIP-28", "color": "memory", "label": "U8 EEPROM"},
            {"name": "J1", "x": 84, "y": 26, "pkg": "HEADER2R", "color": "service", "label": "J1 BUS"},
            {"name": "Cbulk", "x": 4, "y": 31, "pkg": "CBULK", "color": "service", "label": "Cbulk"},
        ],
    },
    "C": {
        "title": "Board C: Bench I/O Silkscreen Overlay",
        "placements": [
            {"name": "TP1-TP4", "x": 10, "y": 3, "pkg": "TESTROW4", "color": "service", "label": "TP ENVL TSWR ACTL SPARE"},
            {"name": "JP1-JP3", "x": 74, "y": 3, "pkg": "JUMPER3", "color": "service", "label": "JP MODE"},
            {"name": "U4", "x": 49, "y": 9, "pkg": "DIP-14", "color": "decode", "label": "U4 TSWR"},
            {"name": "SW1", "x": 8, "y": 17, "pkg": "SW8", "color": "switch", "label": "SW1 ENVL"},
            {"name": "U1", "x": 29, "y": 17, "pkg": "DIP-20", "color": "logic", "label": "U1 IN BUF"},
            {"name": "U2", "x": 49, "y": 17, "pkg": "DIP-20", "color": "logic", "label": "U2 ACTL LAT"},
            {"name": "LED1-8", "x": 73, "y": 17, "pkg": "LEDROW", "color": "led", "label": "ACTL LEDs"},
            {"name": "SW2", "x": 8, "y": 27, "pkg": "SW8", "color": "switch", "label": "SW2 ENVH"},
            {"name": "U3", "x": 29, "y": 27, "pkg": "DIP-16", "color": "decode", "label": "U3 DECODE"},
            {"name": "LED9-16", "x": 73, "y": 27, "pkg": "LEDROW", "color": "led", "label": "DBG / ACTH"},
            {"name": "J1", "x": 84, "y": 31, "pkg": "HEADER2R", "color": "service", "label": "J1 BUS"},
            {"name": "Cbulk", "x": 4, "y": 31, "pkg": "CBULK", "color": "service", "label": "Cbulk"},
        ],
    },
}


def load_board_image() -> Image.Image:
    img = Image.open(BOARD_GIF)
    frame = next(ImageSequence.Iterator(img)).convert("RGBA")
    return frame


def load_font(size: int, bold: bool = False) -> ImageFont.FreeTypeFont:
    candidates = [
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf" if bold else "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
        "/usr/share/fonts/TTF/DejaVuSans-Bold.ttf" if bold else "/usr/share/fonts/TTF/DejaVuSans.ttf",
    ]
    for candidate in candidates:
        path = Path(candidate)
        if path.exists():
            return ImageFont.truetype(str(path), size=size)
    return ImageFont.load_default()


def hole_to_px(x: float, y: float) -> tuple[float, float]:
    return (
        GEOM["x0"] + (x - 1) * GEOM["pitch_x"],
        GEOM["y0"] + (y - 1) * GEOM["pitch_y"],
    )


def scaled(value: float) -> int:
    return int(round(value * GEOM["scale"]))


def draw_label(draw: ImageDraw.ImageDraw, xy: tuple[int, int], text: str, font, fill, anchor="la"):
    x, y = xy
    for dx, dy in ((1, 1), (1, 0), (0, 1)):
        draw.text((x + dx, y + dy), text, font=font, fill=COLORS["shadow"], anchor=anchor)
    draw.text((x, y), text, font=font, fill=fill, anchor=anchor)


def draw_grid_labels(draw: ImageDraw.ImageDraw, font):
    for col in range(1, 97):
        if col == 1 or col % 5 == 0:
            x, _ = hole_to_px(col, 1)
            sx = scaled(x)
            draw.line((sx, scaled(GEOM["y0"] - 7), sx, scaled(GEOM["y0"] - 1)), fill=COLORS["grid"], width=1)
            draw_label(draw, (sx, scaled(GEOM["y0"] - 10)), str(col), font, COLORS["text"], anchor="ms")

    for row in range(1, 41):
        if row == 1 or row % 5 == 0:
            _, y = hole_to_px(1, row)
            sy = scaled(y)
            draw.line((scaled(GEOM["x0"] - 7), sy, scaled(GEOM["x0"] - 1), sy), fill=COLORS["grid"], width=1)
            draw_label(draw, (scaled(GEOM["x0"] - 10), sy), f"Y{row}", font, COLORS["text"], anchor="rm")


def draw_package(draw: ImageDraw.ImageDraw, placement: dict, body_font, small_font):
    span_x, span_y = PACKAGE_SPANS[placement["pkg"]]
    x0, y0 = hole_to_px(placement["x"], placement["y"])
    x1, y1 = hole_to_px(placement["x"] + span_x - 1, placement["y"] + span_y - 1)

    rect = (
        scaled(x0 - 3),
        scaled(y0 - 3),
        scaled(x1 + 3),
        scaled(y1 + 3),
    )
    overlay_fill = COLORS[placement["color"]]
    draw.rounded_rectangle(rect, radius=scaled(4), fill=overlay_fill, outline=COLORS["outline"], width=scaled(1))

    pin1_x = scaled(x0)
    pin1_y = scaled(y0)
    radius = scaled(2.3)
    draw.ellipse((pin1_x - radius, pin1_y - radius, pin1_x + radius, pin1_y + radius), fill=COLORS["pin1"], outline=COLORS["shadow"])

    notch_left = scaled(x0 + (span_x * GEOM["pitch_x"] * 0.28))
    notch_right = scaled(x0 + (span_x * GEOM["pitch_x"] * 0.72))
    notch_y = scaled(y0 - 4)
    draw.arc((notch_left, notch_y, notch_right, notch_y + scaled(8)), start=0, end=180, fill=COLORS["outline"], width=scaled(1))

    label_x = (rect[0] + rect[2]) // 2
    label_y = (rect[1] + rect[3]) // 2 - scaled(6)
    coord_y = label_y + scaled(14)
    draw_label(draw, (label_x, label_y), placement["label"], body_font, COLORS["text"], anchor="mm")
    draw_label(draw, (label_x, coord_y), f"pin1 X{placement['x']} Y{placement['y']}", small_font, COLORS["text"], anchor="mm")


def render_board(board_key: str, spec: dict):
    base = load_board_image()
    scaled_size = (scaled(base.width), scaled(base.height))
    img = base.resize(scaled_size, Image.Resampling.BICUBIC)
    draw = ImageDraw.Draw(img, "RGBA")

    title_font = load_font(22, bold=True)
    body_font = load_font(16, bold=True)
    small_font = load_font(12)
    grid_font = load_font(11, bold=True)

    title_bar_h = 34
    draw.rounded_rectangle((10, 10, scaled_size[0] - 10, 10 + title_bar_h), radius=10, fill=(0, 0, 0, 170), outline=COLORS["outline"], width=1)
    draw_label(draw, (20, 18), spec["title"], title_font, COLORS["text"], anchor="la")

    legend_y = 10 + title_bar_h + 8
    draw.rounded_rectangle((10, legend_y, 430, legend_y + 52), radius=10, fill=(0, 0, 0, 150), outline=COLORS["outline"], width=1)
    draw_label(draw, (20, legend_y + 10), "White outline = socket body, yellow dot = pin 1, labels use planning coordinates on actual board image", small_font, COLORS["text"], anchor="la")
    draw_label(draw, (20, legend_y + 28), "Top and left legends mark the placement grid every 5 holes", small_font, COLORS["text"], anchor="la")

    draw_grid_labels(draw, grid_font)

    for placement in spec["placements"]:
        draw_package(draw, placement, body_font, small_font)

    out_png = OUT_DIR / f"RodneyBoard{board_key}-silkscreen.png"
    out_jpg = OUT_DIR / f"RodneyBoard{board_key}-silkscreen.jpg"
    img.save(out_png)
    img.convert("RGB").save(out_jpg, quality=95)


def render_blank_reference():
    base = load_board_image()
    scaled_size = (scaled(base.width), scaled(base.height))
    img = base.resize(scaled_size, Image.Resampling.BICUBIC)
    draw = ImageDraw.Draw(img, "RGBA")
    title_font = load_font(22, bold=True)
    small_font = load_font(12)
    grid_font = load_font(11, bold=True)

    draw.rounded_rectangle((10, 10, scaled_size[0] - 10, 44), radius=10, fill=(0, 0, 0, 170), outline=COLORS["outline"], width=1)
    draw_label(draw, (20, 18), "Vector 8801-6 Placement Reference Overlay", title_font, COLORS["text"], anchor="la")
    draw_grid_labels(draw, grid_font)
    draw.rounded_rectangle((10, 52, 360, 92), radius=10, fill=(0, 0, 0, 150), outline=COLORS["outline"], width=1)
    draw_label(draw, (20, 62), "Use this as the blank hole-grid reference.", small_font, COLORS["text"], anchor="la")
    draw_label(draw, (20, 78), "Board-specific overlays share the same X/Y mapping.", small_font, COLORS["text"], anchor="la")

    out_png = OUT_DIR / "Vector8801-6-placement-reference.png"
    out_jpg = OUT_DIR / "Vector8801-6-placement-reference.jpg"
    img.save(out_png)
    img.convert("RGB").save(out_jpg, quality=95)


def main():
    render_blank_reference()
    for board_key, spec in BOARDS.items():
        render_board(board_key, spec)


if __name__ == "__main__":
    main()
