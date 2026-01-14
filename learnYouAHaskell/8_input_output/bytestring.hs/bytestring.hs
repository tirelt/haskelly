import qualified Data.ByteString.Lazy as B  -- lazy by chunk = block of 32 KiB
import qualified Data.ByteString as S  

packExample = B.pack [99,97,110] -- create bytestring form [word8] ie. 0-255. Char in other language. I wraps aroundo

unpackExample = B.unpack packExample

fromChunksExample = B.fromChunks [S.pack [40,41,42], S.pack [43,44,45], S.pack [46,47,48]] -- Strict to lazy
toChunksExample = B.toChunks $ B.pack [40,41,42] -- Lazy to strict


consExample = foldr B.cons B.empty [50..60]  -- like ':' on list, lazy will make a new chunck even 
stricConsExample = foldr B.cons' B.empty [50..60] -- strick version of con, update chunk if not full

emptyExample = B.empty 

-- the usual function of Data.List exist for bystring: head, tail, init, null, length, map, reverse, foldl, foldr, concat, takeWhile, filter