#!/bin/python

import time
import sys
text = sys.argv[1]

while True:
    with open(text, "r") as f:
        output = f.readlines()

    rewrite = output[1:]
    rewrite.append(output[0])

    with open(text, "w") as f:
        f.writelines(rewrite)
    
    time.sleep(.25)