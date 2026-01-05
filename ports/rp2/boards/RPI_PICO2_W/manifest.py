include("$(PORT_DIR)/boards/manifest.py")

include("$(MPY_LIB_DIR)/python-stdlib/base64")

include("$(MPY_DIR)/lib/pico-lcd")

require("bundle-networking")

# Bluetooth
require("aioble")
