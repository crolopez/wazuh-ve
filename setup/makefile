# Params
TYPE = manager
THREADS = 4
BRANCH = 3.9
OS = ubuntu
OS_VERSION = 16.04
OS_TYPE = "deb"
SOURCES_LOCATION = "/"

# Build params
IMAGE = $(OS)$(OS_VERSION)-$@:$(BRANCH)
DOCKERFILE = ./dockerfiles/$(OS)-$(OS_VERSION)

.PHONY: $(TYPE)

$(TYPE):
	docker build -t $(IMAGE) --build-arg TYPE=$(TYPE) 	--build-arg OS_TYPE=$(OS_TYPE) --build-arg BRANCH=$(BRANCH) \
	--build-arg THREADS=$(THREADS) --build-arg SOURCES_LOCATION=$(SOURCES_LOCATION) -f $(DOCKERFILE) ./
