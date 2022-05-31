import signing, json_serialization, ed25519
from os import dirExists, fileExists, createDir, getEnv

const home = getEnv "HOME"
const configDirPath = home & "/.config/fsigner/"
const configFileName = "fsigner.bin"

proc initializeConfiguration() =
  userKeyPair = createKeyPair()
  let json = Json.encode(value = userKeyPair, pretty = false)
  let signature = signMessage json
  try:
    var file = open(configDirPath & configFileName, fmWrite)
    defer: file.close()
    file.write byteArrToByteString signature, "\n"
    file.writeLine string2ToByteString json
    echo "Successfully created configuration file!"
  except IOError as err:
    echo("Falied to create configuration file: " & err.msg)

proc readAndVerifyConfiguration() =  
  var file = open(configDirPath & configFileName, fmRead)
  var signatureString = byteStringToString file.readLine
  var signature: Signature
  for i, ch in signatureString:
    signature[i] = cast[byte](ch)
  let message = file.readLine
  if not verifyMessage(message, signature): 
    stderr.writeLine "mesydz sie nie zgadza"
    quit(1)
  echo "chyba mesydz sie zgadza"

proc verifyConfiguration*() =
  if dirExists(configDirPath):
    if fileExists(configDirPath & configFileName):
      readAndVerifyConfiguration()
    else:
      initializeConfiguration()
      readAndVerifyConfiguration()
  else:
    createDir(configDirPath)
    initializeConfiguration()
    readAndVerifyConfiguration()
