package Ngram::Finder;

use strict;
use warnings;

use List::MoreUtils qw(firstidx);

sub new {
    my $class = shift;
    my %args = @_;
    
    my $self = \%args;

    bless $self, $class;
}

sub get_ngrams {
    my ($self, $words, $n) = @_;
    my $ngrams;
    
    my $sent_len = scalar @{$words};
    my $max_start_idx = $sent_len - $n;
    
    if ( $max_start_idx >= 0 ) {
        for my $start_idx ( 0 .. $max_start_idx ) {
            my $end_idx = $start_idx + $n - 1;
            my @ngrams = @{$words}[$start_idx .. $end_idx];
            if ( $self->{nopunct} ) {
                my $punct = firstidx { $_ =~ /^(,|\.|\:|\"|\?|\!)$/} @ngrams;
                next if $punct != -1;
            }
            my $ngram = join ' ', @ngrams;
            $ngram = lc $ngram if $self->{lc};
            push @{$ngrams}, $ngram;
        }
    }

    return $ngrams;
}

1;
