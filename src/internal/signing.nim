import ed25519

type # KeyPair from ed25519 is a tuple, and Json.decode() requires an object
  KPair* = object
    privateKey: PrivateKey
    publicKey: PublicKey

var userKeyPair*: KeyPair

const fsigner_key_pair: KeyPair =
    (publicKey: 
        [byte 216, 213, 238, 19, 8, 70, 237, 138, 100, 21, 92, 150, 254, 70, 44, 41, 142, 195, 60, 37, 194, 9, 122, 230, 145, 153, 95, 154, 46, 234, 65, 232],
     privateKey:
        [byte 0, 102, 254, 141, 145, 31, 49, 241, 227, 169, 151, 5, 114, 173, 114, 42, 207, 58, 106, 4, 173, 164, 22, 132, 122, 153, 4, 157, 79, 194, 208, 105, 62, 204, 155, 111, 171, 21, 1, 114, 30, 101, 22, 254, 77, 105, 40, 191, 47, 121, 134, 73, 173, 48, 87, 18, 22, 170, 77, 22, 102, 223, 217, 153])

proc createKeyPair*(): KeyPair =
  let seed: Seed = seed()
  let keyPair: KeyPair = createKeypair seed
  return keyPair

proc signMessage*(message: string, keyPair: KeyPair): Signature =
  return message.sign keyPair

proc signMessage*(message: string): Signature =
  return message.sign fsigner_key_pair

proc verifyMessage*(message: string, signature: Signature): bool =
  return message.verify(signature, fsigner_key_pair.publicKey)

proc byteArrToByteString*(bytes: openarray[byte]): string =
  result = newString(bytes.len)
  copyMem(result[0].addr, bytes[0].unsafeAddr, bytes.len)

proc string2ToByteString*(str: string): string =
  result = newString(str.len)
  copyMem(result[0].addr, str[0].unsafeAddr, str.len)

proc stringToByteString*(str: string): string =
  var byteArr: seq[byte]
  for s in str:
    byteArr.add cast[byte](s)
  return byteArrToByteString byteArr

proc byteStringToString*(byteStr: string): string =
  var byteArr: seq[char]
  for s in byteStr:
    byteArr.add cast[char](s)
  for c in byteArr:
    result.add c
  return result