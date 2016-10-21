
UNAME = ${shell uname}
ifneq ($(findstring CYGWIN,$(UNAME)),)  
  UNAME := CYGWIN
endif

ifeq ($(UNAME), Darwin)
SDL_PREFIX = $(shell pwd)/libroot/macos
SWIFT_FLAGS = -Xcc -I"$(SDL_PREFIX)/include/SDL2" -Xcc -I/usr/X11R6/include -Xcc -D_THREAD_SAFE \
			  -Xlinker -L"$(SDL_PREFIX)/lib" -Xlinker -lSDL2
endif


all: build

build:
	@echo Compiling for $(UNAME)
	swift build $(SWIFT_FLAGS)

sdl-macos: ThirdParty/SDL
	rm -rf ThirdParty/SDL/build-macos
	mkdir -p ThirdParty/SDL/build-macos
	(cd ThirdParty/SDL/build-macos; ../configure --prefix="$(SDL_PREFIX)"; make; make install)

xcodeproj:
	mkdir -p "$(SDL_PREFIX)"
	swift package generate-xcodeproj $(SWIFT_FLAGS)

ThirdParty/SDL:
	mkdir -p ThirdParty
	(cd ThirdParty; hg clone http://hg.libsdl.org/SDL)

clean:
	swift build --clean

distclean: clean
	rm -rf libroot ThirdParty/SDL

.PHONY:  build sdl-macos xcodeproj clean distclean

