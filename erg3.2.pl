#!/usr/bin/perl
use strict;
use warnings;

#we wanna calculate all the start codons in a dna sequence from a fasta2.txt
my $sequence = '';
while (<>) {
    chomp; #to remove the new line character cuz u need to be able to find start codons split in 2 lines
    next if /^>/; # skips the FASTA files' headers
    $sequence .= $_; #to get the dna sequenses in one huge ass line
}
my $count = () = $sequence =~ /ATG/g;
print "start codons found: $count\n";