# sdl-game-swift

A template project for making games with SDL and Swift on the following platforms:
 * Mac OS X (console)
 * Mac OS X (Xcode)
 * iOS (Xcode)

## Building on different platforms

### MacOS (console)

Prerequisites: Xcode 8.

```bash
make sdl-macos
make
```

### MacOS (Xcode)

```bash
make sdl-macos
make xcodeproj
open Game.xcodeproj
```

Select Scheme `Main` -> `My Mac`.

Select `Targets` -> `Game` -> `Build Settings`.<br />
Add to `Header Search Paths`:
 * $(SRCROOT)/ThirdParty/SDL/include
Add to 'Import Paths':
 * $(SRCROOT)/Sources/CSDL2

Select `Targets` -> `Main` -> `Build Settings`.<br />
Add to 'Import Paths':
 * $(SRCROOT)/Sources/CSDL2

### iOS (Xcode)

Generate OS X project and add iOS target manually:

```bash
make ThirdParty/SDL
make xcodeproj
```

`File` -> `New` -> `Target` -> `iOS` -> `Single View Application`.
 * Choose a product name, for example: `Game-ios`
 * Leave everything else as is.

Select Scheme `Game-ios` -> `iPhone 5` (or any other simulator).

In Finder, locate `ThirdParty/SDL/Xcode-iOS/SDL/SDL.xcodeproj` and drag it into Game-ios folder in your Xcode project.

Select `Targets` -> `Game-ios` -> `General`.<br />
Add to `Linked Frameworks and Libraries`:
  * libSDL2.a from 'libSDL' target in 'SDL' project
  * AVFoundation.framework
  * AudioToolbox.framework
  * CoreMotion.framework
  * GameController.framework

Select `Targets` -> `Game-ios` -> `Build Settings`.<br />
Add to `Header Search Paths`:
 * $(SRCROOT)/ThirdParty/SDL/include
Add to 'Import Paths':
 * $(SRCROOT)/Sources/CSDL2

Select `Game-ios/AppDelegate.swift` -> Target Membership. Uncheck `Game-ios` target.

Select `Sources/Game/Game.swift` -> Target Membership. Check `Game-ios` target.

## Customization

By default, latest SDL2 version from default branch of official repository will be used. You can use a custom version of SDL by putting it into `ThirdParty/SDL/` directory prior to calling `make sdl-platformname`.

## License

Code in this template project except third-party libraries and tools is in public domain, feel free to copy-paste.

If your company requires a license, attached is an optional MIT license.

## Contributing

If you improve this template, please contribute your changes back.


