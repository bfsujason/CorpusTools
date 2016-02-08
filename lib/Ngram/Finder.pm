package Ngram::Finder;

use strict;
use warnings;

use List::MoreUtils qw(firstidx);

our $VERSION = "0.01";

=head1 NAME

Ngram::Finder - A very simple ngram extractor for doing corpus linguistics

=head1 SYNOPSIS

  use Ngram::Finder;

  my $ngram_finder = new Ngram::Finder->new(nopunct => 1, lc => 1);
  my @words = qw(This is a test .);
  my $ngrams = $ngram_finder->get_ngrams(\@words, 2);
  foreach my $ngram ( @{$ngrams} ) {
      print $ngram, "\n";
  }

=cut

=head1 METHODS

=over

=item C<new(arg =E<gt> expr, ...)>

Creates an object of Ngram::Finder. Parameters are:

=over

=item nopunct

Decide whether to exclude punctuations in the ngram lists (nopunct => 1) or not (nopunct => 0).
Default is (nopunct => 0)

=item lc

Decide whether to ingore case in the ngram lists (lc => 1) or not (lc => 0).
Default is (lc => 0)

=back

=cut

sub new {
    my $class = shift;
    my %args = @_;
    
    my $self = \%args;

    bless $self, $class;
}

=item C<get_ngrams(tokens, len)>

Get the ngram lists given the tokens.
I<tokens> is the array ref of tokenized words.
I<len> is the length of ngram lists.
The I<Returned ngram lists> is an array ref.

=cut

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

=back

=head1 TO DO

=over

=item *

Add more parameters when needed in practice

=item *

Support more languages, especially Chinese

=back

=head1 SEE ALSO

There are a handful of modules for extracting Ngrams on CPAN. For example:

L<Text::Ngram>

L<Lingua::EN::Ngram>

=cut

1;
