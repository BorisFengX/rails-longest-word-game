require 'open-uri'
require 'json'
class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a
    @grid = []
    for i in (1..7)
      @grid << @letters.sample
    end
    @time = Time.now
  end


  def score
    @answer = params[:answer]
    @grid = params[:grid]
    @time = params[:time]
    answer_a = @answer.upcase.split("")
    if answer_a.empty?
      @in_the_grid = false
    else
      answer_a.each do |i|
          @in_the_grid = false unless answer_a.count(i) <= @grid.count(i)
        end
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    json_string = open(url).read
    dictionary = JSON.parse(json_string)
    @time = Time.now - @time.to_time
    if @in_the_grid == false
      @result = "not in the grid"
      @score = 0
    elsif
      dictionary["found"] == false
      @result = "not an English word"
      @score = 0
    else
      @result = "Well done!"
      @score = answer_a.length
    end
    return @result

  end

end
