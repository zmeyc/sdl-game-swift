
UNAME = ${shell uname}
ifneq ($(findstring CYGWIN,$(UNAME)),)  
  UNAME := CYGWIN
endif

ifeq ($(UNAME), Darwin)
# 10.10 is hardcoded in SPM
export MACOSX_DEPLOYMENT_TARGET=10.10
PREFIX = $(shell pwd)/libroot/macos
SWIFT_FLAGS = -Xcc -I"$(PREFIX)/include/SDL2" -Xcc -I"$(PREFIX)/include/SDL" -Xcc -I/usr/X11R6/include -Xcc -D_THREAD_SAFE \
			  -Xlinker -L"$(PREFIX)/lib" -Xlinker -lSDL2 -Xlinker -lSDL2_gpu -Xlinker -framework -Xlinker OpenGL
endif

ifeq ($(UNAME), CYGWIN)
PREFIX = $(shell pwd)/libroot/cygwin
SWIFT_FLAGS = -Xcc -I"$(PREFIX)/include/SDL2" -Xcc -I"$(PREFIX)/include/SDL" \
			  -Xlinker -L"$(PREFIX)/lib" -Xlinker -lSDL2 -Xlinker -lSDL2_gpu
endif

all: build-debug

build-debug: copy-sdl-debug copy-sdl-gpu-debug
	@echo "Compiling for $(UNAME) (DEBUG)"
	swift build -c debug $(SWIFT_FLAGS)

build-release: copy-sdl-release copy-sdl-gpu-release
	@echo "Compiling for $(UNAME) (RELEASE)"
	swift build -c release $(SWIFT_FLAGS)

xcodeproj:
	mkdir -p "$(PREFIX)"
	swift package generate-xcodeproj $(SWIFT_FLAGS)

ThirdParty/SDL:
	mkdir -p ThirdParty
	(cd ThirdParty; hg clone http://hg.libsdl.org/SDL)

ThirdParty/sdl-gpu:
	mkdir -p ThirdParty
	(cd ThirdParty; git clone https://github.com/grimfang4/sdl-gpu.git)

ifeq ($(UNAME), Darwin)
sdl-macos: ThirdParty/SDL
	rm -rf ThirdParty/SDL/build-macos
	mkdir -p ThirdParty/SDL/build-macos
	(cd ThirdParty/SDL/build-macos; ../configure --prefix="$(PREFIX)"; make; make install)

sdl-gpu-macos: ThirdParty/sdl-gpu
	rm -rf ThirdParty/sdl-gpu/build-macos
	mkdir -p ThirdParty/sdl-gpu/build-macos
	(cd ThirdParty/sdl-gpu/build-macos; cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$(PREFIX)" ..; make; make install)
endif

ifeq ($(UNAME), CYGWIN)
install-swift:
	wget -P ~ https://github.com/tinysun212/swift-windows/releases/download/swift-cygwin-20160913/swift-cygwin-20160913-bin.tar.gz
	(cd ~; tar xzf swift-cygwin-20160913-bin.tar.gz)

sdl-cygwin: ThirdParty/SDL
	rm -rf ThirdParty/SDL/build-cygwin
	mkdir -p ThirdParty/SDL/build-cygwin
	(cd ThirdParty/SDL/build-cygwin; ../configure --prefix="$(PREFIX)"; make; make install)

sdl-gpu-cygwin: ThirdParty/sdl-gpu
	rm -rf ThirdParty/sdl-gpu/build-cygwin
	mkdir -p ThirdParty/sdl-gpu/build-cygwin
	(cd ThirdParty/sdl-gpu/build-cygwin; cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$(PREFIX)" -DCMAKE_LEGACY_CYGWIN_WIN32=1 -DCMAKE_C_FLAGS="-D_WIN32" -DSDL_gpu_BUILD_DEMOS=OFF ..; make; make install)

copy-sdl-debug: .build/debug/SDL2.dll
.build/debug/SDL2.dll:
	mkdir -p .build/debug
	cp "$(PREFIX)/bin/SDL2.dll" .build/debug/

copy-sdl-release: .build/release/SDL2.dll
.build/release/SDL2.dll:
	mkdir -p .build/release
	cp "$(PREFIX)/bin/SDL2.dll" .build/release/

copy-sdl-gpu-debug: .build/debug/cygSDL2_gpu.dll
.build/debug/cygSDL2_gpu.dll:
	mkdir -p .build/debug
	cp "$(PREFIX)/lib/cygSDL2_gpu.dll" .build/debug/

copy-sdl-gpu-release: .build/release/cygSDL2_gpu.dll
.build/release/cygSDL2_gpu.dll:
	mkdir -p .build/release
	cp "$(PREFIX)/lib/cygSDL2_gpu.dll" .build/release/
endif

clean:
	swift build --clean

distclean: clean
	rm -rf libroot ThirdParty/SDL

.PHONY: all build-debug build-release copy-sdl-debug copy-sdl-release copy-sdl-gpu-debug copy-sdl-gpu-release sdl-macos sdl-gpu-macos sdl-cygwin sdl-gpu-cygwin xcodeproj clean distclean
