#!/usr/bin/env ruby -w

class Deck
  attr_reader :hand, :pairs

  ROYAL_FLUSH = { name: "royal_flush", rank: 10}
  STRAIGHT_FLUSH = { name: "straight_flush", rank: 9}
  FOUR_OF_A_KIND = { name: "four_of_a_kind", rank: 8}
  FULL_HOUSE = { name: "full_house", rank: 7}
  FLUSH = { name: "flush", rank: 6}
  STRAIGHT = { name: "straight", rank: 5}
  THREE_OF_A_KIND = { name: "three_of_a_kind", rank: 4}
  TWO_PAIR = { name: "two_pair", rank: 3}
  ONE_PAIR = { name: "one_pair", rank: 2}
  HIGH_CARD = { name: "high_card", rank: 1}
  HAND_RANKINGS = [ ROYAL_FLUSH, STRAIGHT_FLUSH, FOUR_OF_A_KIND, FULL_HOUSE, FLUSH, STRAIGHT, THREE_OF_A_KIND, TWO_PAIR, ONE_PAIR, HIGH_CARD ]

  def initialize(cards = [])
    hand(cards)
    sort_cards!
    @rank = get_rank
  end

  def main_rank
    @rank
  end

  def deck_rank
    aux = []
    @hand.each do |h1|
      aux << h1.rank
    end

    aux.inject(0, :+)
  end

  def just_cards
    @hand.join(" ")
  end

  def find_pairs
    @pairs = Hash.new(0)
    @hand.each { |c| @pairs[c.card_value] += 1 }
    @pairs.select! {|k,v| v > 1}
  end

  def sort_cards!
    @hand.sort! { |a, b| a.index <=> b.index }
  end

  def high_card
    @hand.last.to_s
  end

  def n_of_a_kind?(number)
    @pairs.any? { |k, count| count > number - 1 }
  end

  def has_pair?
    n_of_a_kind?(2)
  end

  def has_three_of_a_kind?
    n_of_a_kind?(3)
  end

  def has_four_of_a_kind?
    n_of_a_kind?(4)
  end

  def has_two_pair?
    pairs_counted = @pairs.count { |_, pair| pair > 1 }
    pairs_counted > 1
  end

  def is_straight?
    consecutive_card_count == 4
  end

  def card_by_suit
    @hand.map { |card| card.card_suit }
  end

  def card_by_value
    @hand.map { |card| card.card_value }
  end

  def is_flush?
    card_by_suit.uniq.length == 1
  end

  def consecutive_card_count
    consecutive_count = 0
    @hand.each_cons(2) { |card, next_card| consecutive_count += 1 if are_consecutive_cards?(card, next_card) }
    consecutive_count
  end

  def are_consecutive_cards?(card, next_card)
    card.index.succ == next_card.index
  end

  def get_rank
    find_pairs
    return "straight_flush" if is_flush? && is_straight?
    return "flush" if is_flush? && @hand.size > 1
    return "straight" if is_straight?
    return "four_of_a_kind" if has_four_of_a_kind?
    return "three_of_a_kind" if has_three_of_a_kind?
    return "two_pair" if has_two_pair?
    return "one_pair" if has_pair?
    :high_card
  end

  def self.find_rank(hand_rank)
    HAND_RANKINGS.each do |value|
      if value[:name] == hand_rank
        return value[:rank]
      end
    end
    return 'Tipo desconhecido'
  end

  def self.winner(deck1, deck2)
    h1 = Deck.find_rank(deck1.main_rank)
    h2 = Deck.find_rank(deck2.main_rank)

    h1 > h2 ? 'deck1 win! - '"#{deck1.main_rank}" : 'deck2 win! - '"#{deck2.main_rank}"
  end

  private
    def hand(cards)
      @hand = case cards
      when Array
        cards.map do |card|
          if card.is_a? Card
            card
          else
            Card.new(card.to_s)
          end
        end
      when String
        cards.scan(/\S{2}/).map { |str| Card.new(str) }
      else
        cards
      end
    end
end
