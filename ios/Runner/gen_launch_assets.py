#!/usr/bin/env python3
"""生成与 Android 一致的启动页资源：渐变背景 + 中心圆环（仅用标准库）
运行: python3 gen_launch_assets.py（在 ios/Runner 或项目根目录）
"""
import zlib
import struct
import math
import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
ASSETS = os.path.join(SCRIPT_DIR, "Assets.xcassets")
BG_TOP = (10, 14, 39)
BG_MID = (8, 12, 32)
BG_BOTTOM = (6, 9, 24)
RING_COLOR = (51, 136, 170)

def png_chunk(tag, data):
    return struct.pack(">I", len(data)) + tag + data + struct.pack(">I", zlib.crc32(tag + data) & 0xffffffff)

def write_png_rgb(path, w, h, pixel_fn):
    raw = b""
    for y in range(h):
        raw += b"\x00"
        for x in range(w):
            r, g, b = pixel_fn(x, y)
            raw += bytes((r, g, b))
    compressed = zlib.compress(raw, 9)
    signature = b"\x89PNG\r\n\x1a\n"
    ihdr = struct.pack(">IIBBBBB", w, h, 8, 2, 0, 0, 0)
    with open(path, "wb") as f:
        f.write(signature + png_chunk(b"IHDR", ihdr) + png_chunk(b"IDAT", compressed) + png_chunk(b"IEND", b""))

def write_png_rgba(path, w, h, pixel_fn):
    raw = b""
    for y in range(h):
        raw += b"\x00"
        for x in range(w):
            raw += bytes(pixel_fn(x, y))
    compressed = zlib.compress(raw, 9)
    signature = b"\x89PNG\r\n\x1a\n"
    ihdr = struct.pack(">IIBBBBB", w, h, 8, 6, 0, 0, 0)
    with open(path, "wb") as f:
        f.write(signature + png_chunk(b"IHDR", ihdr) + png_chunk(b"IDAT", compressed) + png_chunk(b"IEND", b""))

def gen_gradient():
    w, h = 4, 800
    def pixel(x, y):
        t = y / (h - 1) if h > 1 else 0
        if t < 0.5:
            u = t * 2
            r = int(BG_TOP[0] + (BG_MID[0] - BG_TOP[0]) * u)
            g = int(BG_TOP[1] + (BG_MID[1] - BG_TOP[1]) * u)
            b = int(BG_TOP[2] + (BG_MID[2] - BG_TOP[2]) * u)
        else:
            u = (t - 0.5) * 2
            r = int(BG_MID[0] + (BG_BOTTOM[0] - BG_MID[0]) * u)
            g = int(BG_MID[1] + (BG_BOTTOM[1] - BG_MID[1]) * u)
            b = int(BG_MID[2] + (BG_BOTTOM[2] - BG_MID[2]) * u)
        return (r, g, b)
    out = os.path.join(ASSETS, "LaunchGradient.imageset", "LaunchGradient.png")
    os.makedirs(os.path.dirname(out), exist_ok=True)
    write_png_rgb(out, w, h, pixel)
    print("Generated", out)

def gen_ring(size, stroke_px, path):
    cx = cy = size // 2
    r_outer = cx - 1
    r_inner = max(0, r_outer - stroke_px)
    def pixel(x, y):
        d = math.sqrt((x - cx) ** 2 + (y - cy) ** 2)
        if r_inner <= d <= r_outer:
            return (*RING_COLOR, 255)
        return (0, 0, 0, 0)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    write_png_rgba(path, size, size, pixel)
    print("Generated", path)

def main():
    gen_gradient()
    ring_dir = os.path.join(ASSETS, "LaunchRing.imageset")
    gen_ring(80, 2, os.path.join(ring_dir, "LaunchRing.png"))
    gen_ring(160, 4, os.path.join(ring_dir, "LaunchRing@2x.png"))
    gen_ring(240, 6, os.path.join(ring_dir, "LaunchRing@3x.png"))

if __name__ == "__main__":
    main()
