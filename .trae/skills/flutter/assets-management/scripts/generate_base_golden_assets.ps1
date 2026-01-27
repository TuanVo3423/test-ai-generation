param(
  [Parameter(Mandatory = $true)]
  [string]$Page,

  [string]$Base = "assets/base_image_testing/$Page.png",
  [string]$OutTest = "test/golden/goldens",

  [ValidateSet(
    "fit_width",
    "fit_width_fill",
    "contain",
    "cover",
    "contain_fill"
  )]
  [string]$Mode = "fit_width"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $Base)) {
  throw "Base image not found: $Base"
}

if (-not (Get-Command magick -ErrorAction SilentlyContinue)) {
  throw "ImageMagick (magick) is required."
}

$targets = @(
  @{ platform = "android"; device = "galaxy_s24_ultra";   w = 412; h = 915 },
  @{ platform = "ios";     device = "iphone16_pro_max";  w = 440; h = 956 }
)

foreach ($t in $targets) {
  $w = $t.w
  $h = $t.h
  $platform = $t.platform
  $device = $t.device

  $fileName = "${Page}_page_${device}.png"
  $dest = Join-Path $OutTest "$Page/$platform/$fileName"

  New-Item -ItemType Directory -Force -Path (Split-Path $dest) | Out-Null

  switch ($Mode) {

    # ✅ KHUYẾN NGHỊ – CHUẨN GOLDEN TEST
    "fit_width" {
      magick $Base `
        -resize "${w}x" `
        -background none `
        -gravity north `
        -extent "${w}x${h}" `
        $dest
    }

    # ✅ FIT WIDTH + BLUR BACKGROUND (ĐẸP)
    "fit_width_fill" {
      magick `
        "(" $Base -resize "${w}x${h}^" -gravity center -blur 0x32 ")" `
        "(" $Base -resize "${w}x" ")" `
        -gravity north `
        -compose over -composite `
        -extent "${w}x${h}" `
        $dest
    }

    # ⚠️ CÓ VIỀN
    "contain" {
      magick $Base `
        -resize "${w}x${h}" `
        -background white `
        -gravity center `
        -extent "${w}x${h}" `
        $dest
    }

    # ❌ DỄ CẮT UI
    "cover" {
      magick $Base `
        -resize "${w}x${h}^" `
        -gravity center `
        -extent "${w}x${h}" `
        $dest
    }

    # ⚠️ BLUR NHƯNG UI VẪN SAI TỈ LỆ
    "contain_fill" {
      magick `
        "(" $Base -resize "${w}x${h}^" -gravity center -extent "${w}x${h}" -blur 0x24 ")" `
        "(" $Base -resize "${w}x" -gravity north ")" `
        -compose over -composite `
        $dest
    }
  }
}
