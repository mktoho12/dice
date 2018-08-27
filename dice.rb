require 'sinatra'

class App < Sinatra::Base
  get '/' do
    slim :index
  end

  get %r{/(\d+)d(\d+)} do |dice, face|
    eyes = roll(dice.to_i, face.to_i)
    @source = "#{dice}d#{face}"
    @sum = eyes.inject(&:+)
    cache_control :no_store
    last_modified Time.now
    slim :dice
  end

  helpers do
    def roll(dice, face)
      ([nil] * dice).map{ rand(face) + 1 }
    end
  end
end
