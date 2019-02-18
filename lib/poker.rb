require "poker/version"
require 'pry'

module Poker
  
  def self.valid?(hand)
    hand.length == 5
  end

  def self.rank(hand)
    hand.map { |rank, _suit| rank }
  end

  def self.suit(hand)
    hand.map { |_rank, suit| suit }
    # hand.map(&:suit)
  end

  def self.royal_flush?(hand)
    ranks = ['10', 'J', 'Q', 'K', 'A']
    (hand.map { |rank, _suit| rank } - ranks).empty? && self.flush?(hand)
  end

  def self.flush?(hand)
    suit(hand).uniq.count == 1
  end

  # The one_pair? method makes sense to me. I can change it as per your instructions. I just think that if there are 4 unique cards, there must be one pair.
  # def self.one_pair?(hand)
  #   rank(hand).uniq.count == 4
  # end

  
  def self.transform_hand(hand)
    @a = rank(hand).group_by(&:itself).transform_values(&:count)
  end
  
  def self.one_pair?(hand)
    transform_hand(hand)
    @a.values.count { |count| count == 2 } 
  end
  # The two_pairs? method was originally incorrect eg(cards:[3,5,5,5,2]) and I have refactored  it as per your instruction.
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

  def self.test_straight?(hand)
    hand_rank = []
    index = []
    @straight = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']

    hand.select { |rank, _suit| hand_rank.push(rank) }
    exception = ['A','2','3','4','5']
    if (exception & hand_rank).size == exception.size # I added exception as that seemed pretty reasnable. I could have written more complicated logic, but since thats the only exceptions, more code seemed redundant. 
      true
    else
      hand_rank.map { |u| @straight.each_with_index.map { |s, i| index.push(@straight.index(s)) if u == s } }
      sorted = index.sort
      check = sorted.each_with_index.map do |e, i| 
        if i == 0
          true
        else
          (e - 1) == sorted[i-1] 
        end
      end
      check.map { |a| a == true }.uniq.count == 1
    end
  end

  def self.straight?(hand)
    test_straight?(hand)
  end

  def self.straight_flush?(hand)
    if flush?(hand) 
      test_straight?(hand)
    else 
      false
    end
  end

  # def self.check_cards(hand)
  #   @passed = []
  #   if  valid?(hand)
  #     two_pairs?(hand)
  #     same_rank?(hand, 3)
  #     one_pair?(hand)
  #     # straight?(hand)
  #     # flush?(hand)
  #     # full_house?(hand)
  #     # same_rank?(hand, 4)
  #     # straight_flush?(hand)
  #     # royal_flush?(hand)
  #   end
  #   p @passed
  # end
end

