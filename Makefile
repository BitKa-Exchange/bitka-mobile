# ================================
# Config
# ================================

FLUTTER := flutter
ENV ?= development

ENV_FILE := .env.$(ENV)

# Load env file if it exists
ifneq (,$(wildcard $(ENV_FILE)))
	include $(ENV_FILE)
	export
endif

# ================================
# Dart defines
# ================================

DART_DEFINES := \
	--dart-define=ENVIRONMENT=$(ENV) \
	--dart-define=API_BASE_URL=$(API_BASE_URL)

# ================================
# Targets
# ================================

.PHONY: web-dev web-prod android-dev android-prod ios-dev ios-prod

web-dev:
	$(FLUTTER) run -d web-server $(DART_DEFINES)

web-prod:
	$(FLUTTER) build web $(DART_DEFINES)

android-dev:
	$(FLUTTER) run $(DART_DEFINES)

android-prod:
	$(FLUTTER) build apk $(DART_DEFINES)

ios-dev:
	$(FLUTTER) run -d ios $(DART_DEFINES)

ios-prod:
	$(FLUTTER) build ios $(DART_DEFINES)

.PHONY: clean
clean:
	$(FLUTTER) clean
