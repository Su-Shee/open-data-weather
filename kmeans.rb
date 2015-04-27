#!/usr/bin/env ruby

require 'kmeans/pair'
require 'kmeans/pearson'
require 'kmeans/cluster'
require 'ap'

# fictional blog postings containing words in different variations and
# combinations - "how similar are they?"
posts = {
  "post01" => 'Dieser Hund jagt die Katze und einen Hund',
  "post02" => 'Der Vogel hat Angst vor der Katze und der anderen Katze',
  "post03" => 'Der Hund und der andere Hund und die Katze sind zufrieden',
  "post04" => 'Vogel, Katze und Maus passen nicht zusammen',
  "post05" => 'Die Katze hat den einen Vogel oder anderen Vogel gefressen',
  "post06" => 'Der Vogel ist schnell weggeflogen',
  "post07" => 'Das Auto ist wirklich irre schnell gefahren',
  "post08" => 'Hund, Hund und Hund gesellen sich gern mit einem Hund',
  "post09" => 'Heute ist wirklich extrem sonniges Wetter gewesen',
}

postcount = Hash.new

# go over every post, create a word count for every posting. Or, create a
# wordlist first (e.g. removing stop words) and count those only.
posts.each { |key, val|
  wc = Hash.new(0)
  val.split.each { |word|
    wc[word] += 1
  }
  postcount[key] = wc
}

# now we actually use the module giving us the kmeans clustering ready-made,
# starting with three points and going over it at most 10 times.
kmeans = Kmeans::Cluster.new(postcount, {
  :centroids => 3,
  :loop_max  => 10,
})

# this runs the entire thing
kmeans.make_cluster

# this gives us the results which posting is similar to which other posting
# based on our keywords centering around the 3 centroids.
ap kmeans.cluster.values
