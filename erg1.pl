#!/usr/bin/perl

#to extract the accession number from our fasta downloaded from uniprot
while (<>) {
    if (/^>\S+\|(\w+)\|/) {
        print "Found accession: $1\n";
        #fasta1.txt is the file we use in that excercise
    }
}