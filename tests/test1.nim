import unittest, internal/signing
 
test "can convert byte array to byte string and back":
  let someByteArray = [byte 36, 28, 144, 228, 100, 100, 80, 8, 164, 218, 222, 244]
  let someByteString = byteArrToByteString someByteArray
  var decodedByteArray: array[12, byte]
  for i, bt in someByteString:
    decodedByteArray[i] = cast[byte](bt)
  check someByteArray == decodedByteArray

test "can convert string to byte string and back":
  let str = """{"publicKey":[69,217,171,71,50,84,95,34,185,246,155,27,99,245,48,61,245,185,200,94,225,156,54,52,69,1,33,55,190,71,76,170],"privateKey":[128,16,93,20,57,185,233,73,151,164,201,9,126,0,166,135,22,175,91,81,149,90,67,58,34,144,103,113,209,109,211,66,229,9,143,170,243,100,214,183,47,50,218,227,102,101,120,168,73,155,164,28,32,79,196,192,136,69,200,142,61,134,218,22]}"""
  let byteStr = stringToByteString(str)
  let convertedStr = byteStringToString(byteStr)
  check str == convertedStr
