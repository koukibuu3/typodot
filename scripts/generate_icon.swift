#!/usr/bin/env swift

import AppKit
import Foundation

// macOSアイコンの標準設定
let canvasSize: CGFloat = 1024
let iconSize: CGFloat = 824  // キャンバスの約80%
let cornerRadius: CGFloat = 185  // 約22%の角丸

let inputPath = CommandLine.arguments[1]
let outputDir = CommandLine.arguments[2]

guard let inputImage = NSImage(contentsOfFile: inputPath) else {
    print("Error: Could not load image from \(inputPath)")
    exit(1)
}

func createIcon(size: Int) -> NSImage {
    let canvas = CGFloat(size)
    let icon = canvas * (iconSize / canvasSize)
    let radius = canvas * (cornerRadius / canvasSize)
    let padding = (canvas - icon) / 2

    let image = NSImage(size: NSSize(width: canvas, height: canvas))
    image.lockFocus()

    // 背景を透明に
    NSColor.clear.setFill()
    NSRect(x: 0, y: 0, width: canvas, height: canvas).fill()

    // 角丸の白背景
    let iconRect = NSRect(x: padding, y: padding, width: icon, height: icon)
    let path = NSBezierPath(roundedRect: iconRect, xRadius: radius, yRadius: radius)
    NSColor.white.setFill()
    path.fill()

    // クリッピングして元画像を描画（アイコンサイズの70%程度に）
    path.addClip()
    let logoSize = icon * 0.7
    let logoOffset = padding + (icon - logoSize) / 2
    let logoRect = NSRect(x: logoOffset, y: logoOffset, width: logoSize, height: logoSize)
    inputImage.draw(in: logoRect)

    image.unlockFocus()
    return image
}

func saveIcon(image: NSImage, size: Int, filename: String) {
    guard let tiffData = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiffData),
          let pngData = bitmap.representation(using: .png, properties: [:]) else {
        print("Error: Could not create PNG data")
        return
    }

    let outputPath = "\(outputDir)/\(filename)"
    do {
        try pngData.write(to: URL(fileURLWithPath: outputPath))
        print("Created: \(outputPath)")
    } catch {
        print("Error writing \(outputPath): \(error)")
    }
}

// 各サイズを生成
let sizes = [16, 32, 64, 128, 256, 512, 1024]
for size in sizes {
    let icon = createIcon(size: size)
    saveIcon(image: icon, size: size, filename: "icon_\(size)x\(size).png")
}

print("Done!")
