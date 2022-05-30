# Package

version       = "0.1.0"
author        = "hc0re"
description   = "File signer. Sign and verify the ownership of a file."
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @["fsigner"]

# Dependencies

requires "nim >= 1.6.6", "ed25519 >= 0.1.1", "json_serialization", "stew"
