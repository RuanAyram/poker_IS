require 'spec_helper'
require 'game/card'

describe Card do
  let(:card1) { Card.new('AS') }

  context 'Creating a card with valid params' do
    before(:each) { card1 }

    it 'has a card_value' do
      expect(card1.card_value).to eq(:'A')
    end

    it 'has a card_suit' do
      expect(card1.card_suit).to eq(:'s')
    end
  end

  context 'Creating a card with invalid params' do
    it 'raise invalid face' do
      expect{ Card.new('YL') }.to raise_error(RuntimeError)
    end

    it 'raise invalid suit' do
      expect{ Card.new('YL') }.to raise_error(RuntimeError)
    end
  end

  context 'Get the card rank method' do
    it 'show the return' do
      rank = card1.index * 4 + Card::SUITs_RANKS[card1.card_suit]
      expect(card1.rank).to eq(rank)
    end
  end

  context 'Get the card to_s method' do
    it 'show the return' do
      toS = card1.card_value.to_s + card1.card_suit.to_s
      expect(card1.to_s).to eq(toS)
    end
  end
end
