#!/usr/bin/env ruby -w

require 'rubygems'
require '../lib/game'

deck1 = Deck.new("8H 9C TC JD QH")
deck2 = Deck.new(["3D", "3C", "3S", "KD", "AH"])
puts deck1.main_rank
puts deck2.main_rank
puts Deck.winner(deck1, deck2)
