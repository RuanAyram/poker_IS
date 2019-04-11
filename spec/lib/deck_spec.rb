require 'spec_helper'
require 'game/deck'

describe Deck do
  let(:deck1) { Deck.new('AS 4H AH 4S') }
  let(:deck2) { Deck.new('2H 3C 4C 5D 6H') }
  let(:deck3) { Deck.new('4D 4H 4S KD AH') }
  let(:deck4) { Deck.new('8C 8H 6S 2D TH') }
  let(:deck5) { Deck.new('TS 8S 7S 5S 3S') }
  let(:deck6) { Deck.new('TS TC TH TD KS') }
  let(:deck7) { Deck.new('4H 5H 6H 7H 8H') }

  context 'Creating a card with invalid params' do
    it 'raise invalid deck' do
      expect{ Deck.new('ZL ZZ') }.to raise_error(RuntimeError)
    end
  end

  context 'Verifying auxiliary methods' do
    before(:each) { deck1 }

    it 'show main_rank' do
      rank = deck1.instance_variable_get('@rank')
      expect(deck1.main_rank).to eq(rank)
    end

    it 'show deck_rank' do
      expect(deck1.deck_rank).to be == 122
    end

    it 'get the just_cards method' do
      jc = deck1.instance_variable_get('@hand').join(" ")
      expect(deck1.just_cards).to eq(jc)
    end

    it 'show sort_cards!' do
      sc = deck1.instance_variable_get('@hand').sort! { |a, b| a.index <=> b.index }
      expect(deck1.sort_cards!).to eq(sc)
    end

    it 'get the high_card method' do
      hc = deck1.instance_variable_get('@hand').last.to_s
      expect(deck1.high_card).to eq(hc)
    end
  end

  context 'Verifying winning methods' do
    it 'has_two_pair? method' do
      expect(deck1.has_two_pair?).to be == true
    end

    it 'is_straight? method' do
      expect(deck2.is_straight?).to be == true
    end

    it 'has_two_pair? method' do
      expect(deck3.has_three_of_a_kind?).to be == true
    end

    it 'has_pair? method' do
      expect(deck4.has_pair?).to be == true
    end

    it 'is_flush? method' do
      expect(deck5.is_flush?).to be == true
    end

    it 'has_four_of_a_kind? method' do
      expect(deck6.has_four_of_a_kind?).to be == true
    end

    it 'is_straight_flush? method' do
      expect(deck7.is_straight? && deck7.is_flush?).to be == true
    end
  end

  context 'Verifying winner method' do
    it 'returns the winner_message' do
      win = Deck.winner(deck1, deck2)
      expect(win).to be == 'deck2 win! - straight'
    end
  end
end
