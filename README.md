# sdl-game-swift

Work in progress, do not use!

A template project for making games with SDL and Swift on all supported platforms.

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

Select Scheme `Main`.

Select `Targets` -> `Game` -> `Build Settings`.
Add to `Header Search Paths`:
 * $(SRCROOT)/ThirdParty/SDL/include
Add to 'Import Paths':
 * $(SRCROOT)/Sources/CSDL2

Select `Targets` -> `Main` -> `Build Settings`.
Add to 'Import Paths':
 * $(SRCROOT)/Sources/CSDL2

## Customization

By default, latest SDL2 version from default branch of official repository will be used. You can use a custom version of SDL by putting it into `ThirdParty/SDL/` directory prior to calling `make sdl-platformname`.

## License

Code in this template project except third-party libraries and tools is in public domain, feel free to copy-paste.
If your company requires a license, attached is an optional MIT license.

## Contributing

If you improve this template, please contribute your changes back.


