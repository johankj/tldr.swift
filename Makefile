TARGET=tldr
all:
	swift build

install:
	cp .build/debug/$(TARGET) .

clean :
	rm -rf Packages
	rm -rf .build
	rm -rf *~ Sources/*~ $(TARGET)