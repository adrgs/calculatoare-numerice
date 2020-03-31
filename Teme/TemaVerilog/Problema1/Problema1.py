#!/usr/bin/python

for A in [0, 1]:
    for B in [0, 1]:
        for C in [0, 1]:
            outA = int( ((A and B) or (not C)) ^ ((not B) or C) )
            outB = int( ((A or B or C) and (A^C)) or (not B) )
            outCustom = int( (((A^B) and C) or (A and (B or C))) ^ (not B) )

            print("Time=%d A=%d B=%d C=%d outA=%d outB=%d outCustom=%d" % (A*4+B*2+C, A, B, C, outA, outB, outCustom))