.PHONY: minify optimize-images clean validate-html 

# Initiate the build process
dev: build
	$(call header, Starting development server...)
	npx live-server .

build: minify optimize-images validate-html
	$(call header, Build process completed successfully.)
	$(call msg, Build process completed successfully.)

# Minify CSS and JS files
minify:
	$(call header, Minifying CSS and JS files...)
	npx --yes minify assets/css/styles.css > assets/css/styles.min.css
	npx --yes minify assets/js/script.js > assets/js/script.min.js
	$(call msg, CSS and JS files minified successfully.)


# Optimize images to WebP format
SRCS_JPG  := $(wildcard ./assets/img/*/*.jpg)
SRCS_JPEG := $(wildcard ./assets/img/*/*.jpeg)
SRCS_PNG  := $(wildcard ./assets/img/*/*.png)
TARGETS   := $(SRCS_JPG:.jpg=.webp) $(SRCS_JPEG:.jpeg=.webp) $(SRCS_PNG:.png=.webp)

optimize-images: $(TARGETS)
	$(call header, Optimizing images to WebP format...)
	@echo SRCS_JPG: $(SRCS_JPG)
	@echo SRCS_JPEG: $(SRCS_JPEG)
	@echo SRCS_PNG: $(SRCS_PNG)
	@echo TARGETS: $(TARGETS)
	$(call msg, Images optimized to WebP format successfully.)

%.webp: %.jpg
	npx --yes cwebp-cli $< -o $@ -q 80

%.webp: %.jpeg
	npx --yes cwebp-cli $< -o $@ -q 80

%.webp: %.png
	npx --yes cwebp-cli $< -o $@ -q 80

# Clean target to clear generated webp files if needed
clean:
	$(call header, Cleaning up generated WebP files...)
	@echo "Removing generated WebP files..."
	rm -f $(TARGETS)
	$(call msg, Cleaned up generated WebP files successfully.)



# Validate HTML for image references and update them to .webp format
validate-html: index.html
	$(call header, Validating HTML for image references...)
	@sed -i '' -E 's/(src="[^"]+)\.(jpg|jpeg|png)"/\1.webp"/g' index.html
	@echo "HTML validation complete. All image references updated to .webp format."
	$(call msg, HTML validation completed successfully.)

	$(call header, Validating HTML for css and js references that are not already minified...)
	@sed -i '' -E 's/(href="[^"]+)\.min.css"/\1.css"/g' index.html
	@sed -i '' -E 's/(src="[^"]+)\.min.js"/\1.js"/g' index.html
	@sed -i '' -E 's/(href="[^"]+)\.css"/\1.min.css"/g' index.html
	@sed -i '' -E 's/(src="[^"]+)\.js"/\1.min.js"/g' index.html
	@echo "HTML validation complete. All CSS and JS references updated to .min.css and .min.js format."
	$(call msg, HTML validation completed successfully.)


define msg
	@printf "\033[1;32m✓ %s\033[0m\n" "$(1)"
endef

define header
	@printf "\033[1;34m%s\033[0m\n" ""
	@printf "\033[1;34m%s\033[0m\n" "   ,-~~-.___."
	@printf "\033[1;34m%s\033[0m"   "  / |  '     \         " "$(1)"
	@printf "\033[1;34m%s\033[0m\n" ""
	@printf "\033[1;34m%s\033[0m\n" "  \_/-, ,----'"
	@printf "\033[1;34m%s\033[0m\n" "     ====           //"
	@printf "\033[1;34m%s\033[0m\n" "    /  \-'~;    /~~~(O)"
	@printf "\033[1;34m%s\033[0m\n" "   /  __/~|   /       |"
	@printf "\033[1;34m%s\033[0m\n" " =(  _____| (_________|"
endef