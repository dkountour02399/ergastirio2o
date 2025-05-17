# homework : write code in perl that will translate a dna sequence into a protein sequence,
# keep in mind that there are two complementary dna sequences (forward and reverse complement).
# The program should be capable of finding and translating (ORFs) that start with the start codon (ATG)
# and end with one of the stop codons (TAA, TAG, TGA).

#!/usr/bin/perl

use strict;
use warnings;

# Genetic codon table
my %codon_table = (
    TTT=>'Phe', TTC=>'Phe', TTA=>'Leu', TTG=>'Leu', TCT=>'Ser', TCC=>'Ser', TCA=>'Ser', TCG=>'Ser',
    TAT=>'Tyr', TAC=>'Tyr', TAA=>'Stop', TAG=>'Stop', TGT=>'Cys', TGC=>'Cys', TGA=>'Stop', TGG=>'Trp',
    CTT=>'Leu', CTC=>'Leu', CTA=>'Leu', CTG=>'Leu', CCT=>'Pro', CCC=>'Pro', CCA=>'Pro', CCG=>'Pro',
    CAT=>'His', CAC=>'His', CAA=>'Gln', CAG=>'Gln', CGT=>'Arg', CGC=>'Arg', CGA=>'Arg', CGG=>'Arg',
    ATT=>'Ile', ATC=>'Ile', ATA=>'Ile', ATG=>'Met', ACT=>'Thr', ACC=>'Thr', ACA=>'Thr', ACG=>'Thr',
    AAT=>'Asn', AAC=>'Asn', AAA=>'Lys', AAG=>'Lys', AGT=>'Ser', AGC=>'Ser', AGA=>'Arg', AGG=>'Arg',
    GTT=>'Val', GTC=>'Val', GTA=>'Val', GTG=>'Val', GCT=>'Ala', GCC=>'Ala', GCA=>'Ala', GCG=>'Ala',
    GAT=>'Asp', GAC=>'Asp', GAA=>'Glu', GAG=>'Glu', GGT=>'Gly', GGC=>'Gly', GGA=>'Gly', GGG=>'Gly'
);

# Read and clean sequence from FASTA
my $seq = '';
while (<>) {
    chomp; #to remove the new line character cuz u need to be able to find start codons split in 2 lines
    next if /^>/; # skips the FASTA files' headers
    $seq .= uc($_); #to get the dna sequenses with capitals in one line
}

# Get reverse complement
my $reversecomp = reverse $seq;
$reversecomp =~ tr/ACGT/TGCA/;

#it should work with fasta2.txt
for my $strand (['+', $seq], ['-', $reversecomp]) {
    my ($label, $dna) = @$strand;
    my $orf = '';
    my $in_orf = 0;
    for (my $i = 0; $i < length($dna) - 2; $i += 3) {
        my $codon = substr($dna, $i, 3);
        if (!$in_orf && $codon eq 'ATG') {
            $in_orf = 1;
            $orf .= $codon;
        } elsif ($in_orf) {
            $orf .= $codon;
            if ($codon eq 'TAA' || $codon eq 'TAG' || $codon eq 'TGA') {
                last;
            }
        }
    }
       if ($orf) {
        my $protein = '';
        for (my $i = 0; $i < length($orf); $i += 3) {
            my $codon = substr($orf, $i, 3);
            $protein .= $codon_table{$codon} // 'X';
            $protein .= '-';
        }
        $protein =~ s/-$//; # Remove trailing dash
        print ">$label-frame0 ORF: $orf\n$protein\n";
    } else {
        print "No ORF found in $label strand.\n";
    }
}