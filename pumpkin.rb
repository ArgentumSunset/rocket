require "gosu"

class Pumpkin
	
	attr_reader :x, :y
	attr_accessor :zoomLevel, :color, :points

	def initialize
		@img = Gosu::Image.new('media/pumpkin.bmp')
		@color = Gosu::Color.new(0xff_ff0000)
		@points = 10
		@x = rand * 640
		@y = rand * 480
		@zoomLevel = 1
	end

	def draw
		@img.draw(
			@x - @img.width / 2.0,
			@y - @img.height / 2.0,
			ZOrder::STARS)
	end
end