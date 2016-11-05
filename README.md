# sdl-game-swift

A template project for making games with SDL and Swift on the following platforms:
 * Mac OS X (console)
 * Mac OS X (Xcode)
 * iOS (Xcode)
 * Windows (Cygwin)

## Building on different platforms

### MacOS (console)

Prerequisites: Xcode 8.

```bash
make sdl-macos
make sdl-gpu-macos
make
```

### MacOS (Xcode)

```bash
make sdl-macos
make sdl-gpu-macos
make xcodeproj
open Game.xcodeproj
```

Select Scheme `Game` -> `My Mac`. There are two schemes with the same name, you need the bottom one (with black icon).

Select `Targets` -> `Game` -> `Build Settings`.

Add to `Header Search Paths`:
 * $(SRCROOT)/ThirdParty/SDL/include

Add to `Import Paths`:
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

Select `Targets` -> `Game-ios` -> `General`.

Add to `Linked Frameworks and Libraries`:
  * libSDL2.a from 'libSDL' target in 'SDL' project
  * AVFoundation.framework
  * AudioToolbox.framework
  * CoreMotion.framework
  * GameController.framework

Select `Targets` -> `Game-ios` -> `Build Settings`.

Add to `Header Search Paths`:
 * $(SRCROOT)/ThirdParty/SDL/include

Add to `Import Paths`:
 * $(SRCROOT)/Sources/CSDL2

Select `Game-ios/AppDelegate.swift` -> Target Membership. Uncheck `Game-ios` target or simply delete this file, it won't be used.

Add `Sources/Game/*.swift` except `main.swift` to `Game-ios` target. `main.swift` is not needed on iOS because SDL implements it's own main() on this platform.

### Windows (Cygwin)

Install Cygwin 64-bit by running `cygwin_setup.bat`. Choose default packages and default destination directory: `C:\cygwin64`.

Install development tools by running `cygwin_install_tools.bat`.

Install Swift prerequisites by running `cygwin_install_swift_prerequisites.bat`.

In `Computer` -> `Advanced System Settings` -> `Environment Variables`, add Cygwin to PATH and restart the shell:

```bash
set PATH=%PATH%;C:\cygwin64\bin
```

Now `make` should become available. Install Swift:

```bash
make install-swift
```

Add Swift to PATH, then restart the shell. Replace `User` with your system account name and verify that this directory actually exists.

```bash
set PATH=%PATH%;C:\cygwin64\bin;C:\cygwin64\home\User\swift\bin
```

Build SDL and game:

```bash
make sdl-cygwin
make
```

## Customization

By default, latest SDL2 version from default branch of official repository will be used. You can use a custom version of SDL by putting it into `ThirdParty/SDL/` directory prior to calling `make sdl-platformname`.

Calling `make` without arguments defaults to debug build: `make build-debug`. To produce a release build, call `make build-release`.

## License

Code in this template project except third-party libraries and tools is in public domain, feel free to copy-paste.

If your company requires a license, attached is an optional MIT license.

## Contributing

If you improve this template, please contribute your changes back.


