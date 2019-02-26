require "poker/card"
require "poker/version"
require 'pry'

module Poker
  def self.valid?(hand)
    hand.length == 5
  end

  def self.ranks(hand)
    hand.map(&:rank)
  end

  def self.suits(hand)
    hand.map(&:suit)
  end

  def self.royal_flush?(hand)
    ranks = ['10', 'J', 'Q', 'K', 'A']
    (ranks(hand) - ranks).empty? && self.flush?(hand)
  end

  def self.flush?(hand)
    suits(hand).uniq.count == 1
  end

  def self.transform_hand(hand)
    @a = ranks(hand).group_by(&:itself).transform_values(&:count)
  end
  
  def self.one_pair?(hand)
    transform_hand(hand)
    @a.values.count { |count| count == 2 } 
  end
 
  def self.two_pairs?(hand)
    transform_hand(hand)
    @a.values.count { |count| count == 2 } == 2
  end

  def self.full_house?(hand)
    transform_hand(hand)
    @a.values == [2,3] || @a.values == [3,2]
  end
    
  def self.same_rank?(hand, number)
    transform_hand(hand)
    @a.values.any? { |x| x == number }
  end

  def self.four_same?(hand)
    same_rank?(hand, 4)
  end

  def self.three_same?(hand)
    same_rank?(hand, 3) 
  end

  def self.straight?(hand)
    index = []
    @straight = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']

    rank_indexes = ranks(hand).map { |rank| @straight.index(rank) }.sort
    exception = ['A','2','3','4','5']
    if (exception & rank_indexes).size == exception.size 
      true
    else
      ((rank_indexes.first)..(rank_indexes.last)).size == 5
    end
  end

  def self.straight_flush?(hand)
    straight?(hand) && flush?(hand) 
  end

  def self.check_cards(hand)
    passed = []
    passed << "Royal flush" if royal_flush?(hand)
    passed << "Straight flush" if straight_flush?(hand)
    passed << "Straight" if straight?(hand)
    passed << "Flush" if flush?(hand)

    passed
  end
end

