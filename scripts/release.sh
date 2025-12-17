#!/bin/bash
set -e

VERSION=$1
TEAM_ID="49C69XB328"
APP_NAME="typo."
APP_PATH="build/Build/Products/Release/${APP_NAME}.app"
DMG_NAME="${APP_NAME}.dmg"

if [ -z "$VERSION" ]; then
  echo "使い方: ./scripts/release.sh v1.0.0"
  exit 1
fi

echo "==> ビルド中..."
xcodebuild -project typodot.xcodeproj -scheme "$APP_NAME" -configuration Release -derivedDataPath build -quiet

echo "==> 署名中..."
codesign --force --deep --options runtime \
  --sign "Developer ID Application: kouki akasaka ($TEAM_ID)" \
  "$APP_PATH"

echo "==> 署名を検証中..."
codesign --verify --verbose "$APP_PATH"

echo "==> 公証用にzip作成中..."
ditto -c -k --keepParent "$APP_PATH" "${APP_NAME}.zip"

echo "==> 公証を申請中..."
xcrun notarytool submit "${APP_NAME}.zip" \
  --keychain-profile "notarytool-profile" \
  --wait

echo "==> Staple中..."
xcrun stapler staple "$APP_PATH"

echo "==> dmg作成中..."
rm -f "$DMG_NAME"
create-dmg \
  --volname "$APP_NAME" \
  --window-size 600 400 \
  --icon-size 100 \
  --icon "${APP_NAME}.app" 150 200 \
  --app-drop-link 450 200 \
  "$DMG_NAME" \
  "$APP_PATH"

echo "==> dmgを公証中..."
xcrun notarytool submit "$DMG_NAME" \
  --keychain-profile "notarytool-profile" \
  --wait

xcrun stapler staple "$DMG_NAME"

echo "==> クリーンアップ..."
rm -f "${APP_NAME}.zip"

echo "==> GitHub Releasesにアップロード中..."
gh release create "$VERSION" "$DMG_NAME" --title "$VERSION" --notes "リリース $VERSION"

echo "==> 完了: https://github.com/koukibuu3/typodot/releases/tag/$VERSION"
