#!/usr/bin/perl

#find the lines from uniprot files that contain the word "PubMed"
#then prints all PubMed IDs, the file i used is "P05067.txt"
while (<>) {
    if (/PubMed=(\d+)/) { 
        print "PubMed ID: $1\n";

}
}