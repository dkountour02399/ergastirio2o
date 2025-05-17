#!/usr/bin/perl

#extract all the amino acids from a protein sequence
$protein_line = "MNVEHE _123! LLVEE \$"; #i think thats an example of a protein sequence
$protein_line =~ s/[^A-Z]/1/g;
print "cleaned sequence: $protein_line\n";