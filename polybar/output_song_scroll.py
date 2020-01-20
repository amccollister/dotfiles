#!/bin/python

MAX_LENGTH=25
song = input("Give the song title: ") + "        "
output = []

for i in range(len(song)):
    output.append((song[i:]+song[:i])[:MAX_LENGTH])
    
with open("song.txt", "w") as f:
    for line in output:
        f.write(line+"\n")