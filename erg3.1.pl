#!/usr/bin/perl

#we wanna find and count all the start codons in a dna sequence
$sequence = "ATGCGATGGTATG";
$count = () = $sequence =~ /ATG/g; 
print "start codons found: $count\n";

