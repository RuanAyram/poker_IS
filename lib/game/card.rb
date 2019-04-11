#!/usr/bin/env ruby -w

class Card
  attr_reader :face, :suit

  CARDs_RANKS = {
    :A =>   12,
    :K =>   11,
    :Q =>   10,
    :J =>    9,
    :T =>    8,
    :"9" =>  7,
    :"8" =>  6,
    :"7" =>  5,
    :"6" =>  4,
    :"5" =>  3,
    :"4" =>  2,
    :"3" =>  1,
    :"2" =>  0
  }

  SUITs_RANKS = {
    :s => 3,
    :h => 2,
    :d => 1,
    :c => 0
  }

  def initialize(values)
    @face = values[0].chr.to_sym
    raise "Invalid: Face \"#{@face}\"" unless CARDs_RANKS.has_key?(@face)
    @suit = values[1].downcase.chr.to_sym
    raise "Invalid: Suit \"#{@suit}\"" unless SUITs_RANKS.has_key?(@suit)
    freeze
  end

  # Ranking by card
  def rank
    index * 4 + SUITs_RANKS[@suit]
  end

  # Get index according constant
  def index
    CARDs_RANKS[@face]
  end

  def card_value
    @face
  end

  def card_suit
    @suit
  end

  def to_s
    @face.to_s + @suit.to_s
  end
end
