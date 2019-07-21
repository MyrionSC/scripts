#!/usr/bin/env python3

import os
import sys

if len(sys.argv) < 2:
    print("Finds english words containing a given substring")
    print("first arg should be a string")
    exit()

term = sys.argv[1]

wordsfile = open("words.txt", "r")
words = wordsfile.readlines()

matches = [w.strip() for w in words if w.lower().find(term) != -1]
print(", ".join(matches))

