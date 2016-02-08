#!/usr/bin/perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Ngram::Finder;

my $ngram_finder = Ngram::Finder->new();
my @words = qw(This is a test .);

my $ngrams = $ngram_finder->get_ngrams(\@words, 2);

foreach my $ngram ( @{$ngrams} ) {
    print $ngram, "\n";
}

__END__
