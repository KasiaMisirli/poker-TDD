

RSpec.describe Poker do
 
  context 'valid input' do
    let(:hand) { [
      ['10', 'S'],
      ['J', 'S'],
      ['Q', 'S'],
      ['K', 'S'],
      ['A', 'S']
    ] }

    it 'is valid' do
      expect(Poker.valid?(hand)).to be true
    end
  end

  context 'invalid input' do
    let(:hand) { [
      ['10', 'S'],
      ['J', 'S'],
      ['K', 'S'],
      ['A', 'S']
    ] }

    it 'is invalid' do
      expect(Poker.valid?(hand)).to be false
    end
  end

  describe "royal flush" do
    context "valid royal flush" do
      let(:hand) { [
        ['10', 'S'],
        ['J', 'S'],
        ['Q', 'S'],
        ['K', 'S'],
        ['A', 'S']
      ] }
      it "identifies a valid royal flush" do
        expect(Poker.royal_flush?(hand)).to be true
      end
    end
    context "invalid royal flush" do
      let(:hand) { [
        ['10', 'S'],
        ['J', 'S'],
        ['Q', 'H'],
        ['K', 'S'],
        ['A', 'S']
      ] }
      it "invalid royal flush" do
        expect(Poker.royal_flush?(hand)).to be false
      end
    end
  end

  describe "one pair" do
    context "two cards are same rank" do
      let(:hand) { [
        ['10', 'S'],
        ['10', 'H'],
        ['2', 'S'],
        ['3', 'S'],
        ['Q', 'S']
      ] }
      it "is one pair" do
        expect(Poker.one_pair?(hand)).to eq(1)
      end
    end
    context "two cards are not same rank" do
      let(:hand) { [
        ['10', 'S'],
        ['9', 'H'],
        ['2', 'S'],
        ['3', 'S'],
        ['Q', 'S']
      ] }
      it "is one pair" do
        expect(Poker.one_pair?(hand)).to eq(0)
      end
    end
  end
  describe "two pairs" do
    context "2 x two cards are same rank" do
      let(:hand) { [
        ['10', 'S'],
        ['10', 'H'],
        ['2', 'S'],
        ['2', 'H'],
        ['Q', 'S']
      ] }
      it "two pairs" do
        expect(Poker.two_pairs?(hand)).to be true
      end
    end
    context "two cards are not same rank" do
      let(:hand) { [
        ['10', 'S'],
        ['10', 'H'],
        ['2', 'S'],
        ['3', 'S'],
        ['Q', 'S']
      ] }
      it "not two pairs" do
        expect(Poker.two_pairs?(hand)).to be false
      end
    end
  end
  describe "full house: 2x same rank + 3x same rank" do
    context "full house" do
      let(:hand) { [
        ['10', 'S'],
        ['10', 'H'],
        ['2', 'S'],
        ['2', 'S'],
        ['2', 'S']
      ] }
      it "is a full house" do
        expect(Poker.full_house?(hand)).to be true
      end
    end
    context "invalid full house" do
      let(:hand) { [
        ['10', 'S'],
        ['10', 'H'],
        ['A', 'S'],
        ['K', 'S'],
        ['K', 'S']
      ] }
      it "doesnt have a full house" do
        expect(Poker.full_house?(hand)).to be false
      end
    end
  end
  describe "4 cards of a rank" do
    context "4 of the same rank" do
      let(:hand) { [
        ['10', 'S'],
        ['10', 'H'],
        ['10', 'S'],
        ['10', 'S'],
        ['K', 'S']
      ] }
      it "4 of the same cards" do
        expect(Poker.four_same?(hand)).to be true
      end
    end
    context "not 4 of the same cards" do
      let(:hand) { [
        ['10', 'S'],
        ['10', 'H'],
        ['9', 'S'],
        ['K', 'S'],
        ['K', 'S']
      ] }
      it "not 4 of the same cards" do
        expect(Poker.four_same?(hand)).to be false
      end
    end
  end
  describe "3 of a kind" do
    context "3 of the same rank" do
      let(:hand) { [
        ['10', 'S'],
        ['10', 'H'],
        ['10', 'S'],
        ['9', 'S'],
        ['K', 'S']
      ] }
      it "has a 3 of the same rank" do
        expect(Poker.three_same?(hand)).to be true
      end
    end
  end
  describe "straigh" do
    context "all cards in sequance" do
      let(:hand) { [
        ['A', 'S'],
        ['K', 'H'],
        ['J', 'S'],
        ['Q', 'S'],
        ['10', 'S']
      ] }
      it "all cards in sequance" do
        expect(Poker.straight?(hand)).to be true
      end
    end
    context "not all cards in sequance" do
      let(:hand) { [
        ['8', 'S'],
        ['J', 'H'],
        ['Q', 'S'],
        ['10', 'S'],
        ['A', 'S']
      ] }
      it "not all cards in sequance" do
        expect(Poker.straight?(hand)).to be false
      end
    end
  end
  describe "straigh flush" do
    context "all cards in sequance => straigh flush " do
      let(:hand) { [
        ['K', 'S'],
        ['J', 'S'],
        ['Q', 'S'],
        ['10', 'S'],
        ['A', 'S']
      ] }
      it "all cards in sequance => straigh flush" do
        expect(Poker.straight_flush?(hand)).to be true
      end
    end
    context "not straigh flush " do
      let(:hand) { [
        ['K', 'S'],
        ['2', 'S'],
        ['Q', 'S'],
        ['10', 'S'],
        ['A', 'S']
      ] }
      it "not straigh flush" do
        expect(Poker.straight_flush?(hand)).to be false
      end
    end
  end
end
