A brief look into the code design
--> evaluate() is the function that is divided into 2 sections:
        --> build hashTable -> a 2 hour process for 500 song database; .mat files have been attached for your convenience
        --> evaluate        -> input all the songs and see if you are getting the right song ID. This is 100% accurate

--> afterEval.m is a script that is used to test excerpts/recordings from the database
        --> we presume that the comments in the code should be self explanatory

--> Attached functions are:
        --> mySpectrogram.m -> to get the spectrogram
        --> getLandMarks.m  -> get landmarks from the spectrogram
        --> getHashStruct.m -> to convert landMarks to hashes
        --> storeHashes.m   -> to store the hash into the hashTable
        --> getSongId.m     -> to look up from the hashTable and return the best matching songId/ the best 10 matching songIds
