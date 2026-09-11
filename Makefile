minify:
	npx minify assets/css/styles.css > assets/css/styles.min.css
	npx minify assets/js/script.js > assets/js/script.min.js


# Find all source images in the current directory
SRCS_JPG  := $(wildcard ./assets/img/*/*.jpg)
SRCS_JPEG := $(wildcard ./assets/img/*/*.jpeg)
SRCS_PNG  := $(wildcard ./assets/img/*/*.png)

# Map original filenames to their corresponding .webp filenames
TARGETS   := $(SRCS_JPG:.jpg=.webp) $(SRCS_JPEG:.jpeg=.webp) $(SRCS_PNG:.png=.webp)

# The main command you want to run
optimize-images: $(TARGETS)
	@echo "Optimizing images to WebP format..."
	@echo SRCS_JPG: $(SRCS_JPG)
	@echo SRCS_JPEG: $(SRCS_JPEG)
	@echo SRCS_PNG: $(SRCS_PNG)
	@echo TARGETS: $(TARGETS)
	

%.webp: %.jpg
	npx cwebp-cli $< -o $@ -q 80

%.webp: %.jpeg
	npx cwebp-cli $< -o $@ -q 80

%.webp: %.png
	npx cwebp-cli $< -o $@ -q 80

# Clean target to clear generated webp files if needed
clean:
	rm -f $(TARGETS)

.PHONY: optimize-images clean