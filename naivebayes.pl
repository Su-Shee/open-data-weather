#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';

use Algorithm::NaiveBayes;
use Data::Dumper;
use Data::Printer;

my $nb = Algorithm::NaiveBayes->new;

my $post1 = 'Dieser Hund jagt die Katze und einen Hund';
my $post2 = 'Der Vogel hat Angst vor der Katze und der anderen Katze';

my $post3 = 'Der Hund und der andere Hund haben das Eis gefressen';
my $post4 = 'Vogel, Katze und Maus mögen nicht im Flugzeug fliegen';

my $post5 = 'Das Kind wollte das Eis haben';
my $post6 = 'Das Flugzeug ist schnell weggeflogen';

# A "training set" of postings we declare as animal-related
my $animals_only = word_count($post1, $post2);
$nb->add_instance(attributes => $animals_only, label => 'animal');

# Another "training set" of postings we state as "could be food or animals"
my $food_or_animals = word_count($post3, $post4);
$nb->add_instance(attributes => $food_or_animals, label => ['animal', 'food']);

# Now we're training the filter
$nb->train;

# And ask for a prediction of what it possible could be: animals-related or food?
my $what_is_it = word_count($post5, $post6);
my $result = $nb->predict(attributes => $what_is_it);

# How about complete nonsense? What does it make of that?
my $foobar = word_count('Glibberi fibb Foobar nonsense', 'Tralalala Jolla Hollidriho');
my $nonsense = $nb->predict(attributes => $foobar);

# Looks like post 5 and post 6 are recognized as mostly food related - but on
# the other hand it sees a certain relation between animals and utter nonsense..
p $result;
p $nonsense;

# we're counting both - words actually included and words not existing
sub word_count {
  my @posts = @_;

  my %wc;

  for my $post (@posts) {
    $wc{$_} ++  for map  { $post =~ m/$_/g } split(' ', $post);
    $wc{$_} = 0 for grep { $post !~ m/$_/g } split(' ', $post);
  }

  return \%wc;
}
