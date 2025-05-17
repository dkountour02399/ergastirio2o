#!/usr/bin/perl
use strict;
use warnings;

#to check if the sequence  only contains A,T,C,G
# I used the fasta2.txt from NCBI cuz the fasta1.txt contains protein sequences
while (<>) {
    if (/^[ATCG]+$/i) {
        print "valid dna sequence\n";

    }
    else {
        print "invalid dna sequence\n";
        #it's gonna check all the lines (including the header lines, which will be invalid)
        # and it's gonna give the results for each line individually
    }
}