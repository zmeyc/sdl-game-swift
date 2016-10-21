
UNAME = ${shell uname}
ifneq ($(findstring CYGWIN,$(UNAME)),)  
  UNAME := CYGWIN
endif

ifeq ($(UNAME), Darwin)
SDL_PREFIX = $(shell pwd)/libroot/macos
SWIFT_FLAGS = -Xcc -I"$(SDL_PREFIX)/include/SDL2" -Xcc -I/usr/X11R6/include -Xcc -D_THREAD_SAFE \
			  -Xlinker -L"$(SDL_PREFIX)/lib" -Xlinker -lSDL2
endif

ifeq ($(UNAME), CYGWIN)
SDL_PREFIX = $(shell pwd)/libroot/cygwin
SWIFT_FLAGS = -Xcc -I"$(SDL_PREFIX)/include/SDL2" \
			  -Xlinker -L"$(SDL_PREFIX)/lib" -Xlinker -lSDL2
endif

all: build-debug

build-debug: copy-sdl-debug
	@echo "Compiling for $(UNAME) (DEBUG)"
	swift build -c debug $(SWIFT_FLAGS)

build-release: copy-sdl-release
	@echo "Compiling for $(UNAME) (RELEASE)"
	swift build -c release $(SWIFT_FLAGS)

xcodeproj:
	mkdir -p "$(SDL_PREFIX)"
	swift package generate-xcodeproj $(SWIFT_FLAGS)

ThirdParty/SDL:
	mkdir -p ThirdParty
	(cd ThirdParty; hg clone http://hg.libsdl.org/SDL)

ifeq ($(UNAME), Darwin)
sdl-macos: ThirdParty/SDL
	rm -rf ThirdParty/SDL/build-macos
	mkdir -p ThirdParty/SDL/build-macos
	(cd ThirdParty/SDL/build-macos; ../configure --prefix="$(SDL_PREFIX)"; make; make install)
endif

ifeq ($(UNAME), CYGWIN)
install-swift:
	wget -P ~ https://github.com/tinysun212/swift-windows/releases/download/swift-cygwin-20160913/swift-cygwin-20160913-bin.tar.gz
	(cd ~; tar xzf swift-cygwin-20160913-bin.tar.gz)

sdl-cygwin: ThirdParty/SDL
	rm -rf ThirdParty/SDL/build-cygwin
	mkdir -p ThirdParty/SDL/build-cygwin
	(cd ThirdParty/SDL/build-cygwin; ../configure --prefix="$(SDL_PREFIX)"; make; make install)

copy-sdl-debug: .build/debug/SDL2.dll
.build/debug/SDL2.dll:
	mkdir -p .build/debug
	cp "$(SDL_PREFIX)/bin/SDL2.dll" .build/debug/

copy-sdl-release: .build/release/SDL2.dll
.build/release/SDL2.dll:
	mkdir -p .build/release
	cp "$(SDL_PREFIX)/bin/SDL2.dll" .build/release/
endif

clean:
	swift build --clean

distclean: clean
	rm -rf libroot ThirdParty/SDL

.PHONY: all build-debug build-release copy-sdl-debug copy-sdl-release sdl-macos sdl-cygwin xcodeproj clean distclean
