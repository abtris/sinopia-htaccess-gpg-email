openpgp = require 'openpgp'
fs = require 'fs'

# key = fs.readFileSync("#{__dirname}/../assets/public_key")
# publicKey = openpgp.key.readArmored(key.toString())

# openpgp.encryptMessage(publicKey.keys, 'Hello, World!').then((pgpMessage) ->
#   console.log pgpMessage
#   return
# ).catch (error) ->
#   # failure
#   return


key = fs.readFileSync("#{__dirname}/../assets/private_key")
privateKey = openpgp.key.readArmored(key.toString()).keys[0]
privateKey.decrypt('123456')
pgpMessage = """
-----BEGIN PGP MESSAGE-----
Version: OpenPGP.js VERSION
Comment: http://openpgpjs.org

wcFMAy0EL5nz2W6ZARAAuKCNyyu47gFQCg9Zmxcpo3fWlt6/vAZsycfF42Wy
3x4y5bnnSIN7EHcNgKBZEtN9LCkbCdbjzxtZHjUz8KdS3yjj1uPnZWii1B38
27Ok58r87OOLXNZyuKl109zrCUJuO/RwfLmS6iMAIzXtok9mBaymgaijRjC9
EVV/WX/ySNPXvOAI735sadMV/eZ+EjtIgjy2XAtkxZGfahnnqB1cunckKeb2
nom5F68vxNuOWPrq8E2t2Xit29UHfYCZpdu6/MuhUkYA+Jw2fg+8aFVPXUF6
HRyIVbtCdFYXlxZ2Jiz5/dXozHVUiQY0anylCqhgOSnk2F6eA+H9Q20pAGop
paMRjj03Is7tPRF5I7EhqGCp3mf4zXlEnBG/hfLWeyqXU5WQYe/8EOCmAX0s
+pQeF1ER2Kl1EHJkQuNfQ8FRsmx4hoO1513XTiGFXZyXNirUDasxNE1pq/+s
b0LYRvsixp2C3HMOZA3wYDwV7EXnVHhOvT3q9kB5ErPQiEbcBu80aVxB66fV
DLRpajT5PFJjQWYzb6t3YOYcdV55z20zMSYUqmReFI8s/djMpCZ4uAJ7JgwR
HLlpMtLR8n2E/O3yAI+yytKRItg7/enN/cHc5yKe2ahKFzPonLothXbpGmiR
iyN1tKHlXHeVHH5Ben2BpMyIvKjSUMlwoT7+QUPRpNbSRQH5X8Ip6yPm5ETN
eGkYVdlCl1Sob9uB2HI848nwGV46SvDd+0mj5/RIEUycuuW2/CP/mlijuvUM
+uzVr5cKDyt/xzzNIg==
=DKvL
-----END PGP MESSAGE-----
"""
pgpMessage = openpgp.message.readArmored(pgpMessage)
openpgp.decryptMessage(privateKey, pgpMessage).then((plaintext) ->
  console.log plaintext
  return
).catch (error) ->
  # failure
  return
