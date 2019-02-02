require "poker/version"
require 'pry'

module Poker
  def self.valid?(hand)
    hand.length == 5
  end
  def self.royal_flush?(hand)
    ranks = ['10', 'J', 'Q', 'K', 'A']
    (hand.map { |rank, _suit| rank } - ranks).empty? && self.flush?(hand)
  end

  def self.flush?(hand)
    hand.map { |_rank, suit| suit }.uniq.count == 1
  end

  def self.one_pair?(hand)
    hand.map { |rank, _suit| rank }.uniq.count == 4
  end

  def self.two_pairs?(hand)
    hand.map { |rank, _suit| rank }.uniq.count == 3
  end

  def self.full_house?(hand)
    kings = []
    tens = []
    hand.map do |rank, _suit| 
      if rank == 'K' 
        kings.push(rank) 
      elsif rank == '10'
        tens.push(rank)
      end
    end
    kings.length == 3 && tens.length == 2
  end
    
  def self.same_rank?(hand, nr)
    hand_rank = []
    outcome = []
    hand.select { |rank, _suit| hand_rank.push(rank) }
    on_hand = hand_rank.group_by(&:itself).transform_values(&:count)
    b = on_hand.reject do |rank, _suit|
      # {"10"=>4, "K"=>1}
      # if on_hand[rank] == nr
      # binding.pry 
      return true if on_hand[rank] == nr
      return false if on_hand[rank] != nr 
    end
    # on_hand[rank] == nr
  end

  def self.four_same?(hand)
    self.same_rank?(hand, 4)
  end

  def self.three_same?(hand)
    self.same_rank?(hand, 3)
  end

  def self.test_straight?(hand)
    hand_rank = []
    index = []
    @straight = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']

    hand.select { |rank, _suit| hand_rank.push(rank) }
    hand_rank.map { |u| @straight.each_with_index.map { |s, i| index.push(@straight.index(s)) if u == s } }
    @sorted = index.sort
    check = @sorted.each_with_index.map do |e, i| 
      if i == 0
        true
      else
        (e-1) == @sorted[i-1] 
      end
    end
    check.map { |a| a == true }.uniq.count == 1
  end

  def self.straight?(hand)
    self.test_straight?(hand)
  end

  def self.straight_flush?(hand)
    if self.flush?(hand) 
      self.test_straight?(hand)
    else 
      false
    end
  end
  def self.high_card?(hand)
    "you go a high card!"
    # if self.valid?(hand)
    #   self.same_rank?(hand, 4)
    #   self.same_rank?(hand, 3)
    #   self.two_pairs?(hand)
    #   self.one_pair?(hand)
    #   self.flush?(hand)
    #   self.royal_flush?(hand)
    #   self.full_house?(hand)
    #   self.straight?(hand)
    #   self.straight_flush?(hand)
    # else
    #   "you go a high card!"
    # end
  end
end

# any hand that doesnt fit under above is High Card
