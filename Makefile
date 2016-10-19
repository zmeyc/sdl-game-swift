
all: ThirdParty/SDL

ThirdParty/SDL:
	mkdir -p ThirdParty
	(cd ThirdParta; hg clone http://hg.libsdl.org/SDL)

.PHONY: 
