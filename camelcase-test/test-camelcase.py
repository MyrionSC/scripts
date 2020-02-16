#!/usr/bin/env python3

import os

out = [l.strip() for l in open("out.txt", "r").readlines()]
correct = [l.strip() for l in open("correct.txt", "r").readlines()]

# check if correct number of lines
if len(out) != len(correct):
    print("out.txt is " + str(len(out)) + " lines but correct.txt is " + str(len(correct)) + " lines. Something is funky!")
    for i in range(181):
        print(str(i+1) + ": " + out[i] + " " + correct[i])
    exit()

matches = 0
print("Out Correct Equal?")
print("=================")
for i in range(len(out)):
    print(out[i], correct[i], str(out[i] == correct[i]))
    if out[i] == correct[i]:
        matches = matches + 1
print("=================")
print(str(matches) + " out of " + str(len(out)) + " correct guesses")
print("Percent: " + str(matches / len(out)))

