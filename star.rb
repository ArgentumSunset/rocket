require "gosu"

class Star
	
	attr_reader :x, :y
	attr_accessor :zoomLevel, :color, :points

	def initialize(animation)
		@animation = animation
		@color = Gosu::Color.new(0xff_000000)
		@color.red = rand_color_component
		@color.green = rand_color_component
		@color.blue = rand_color_component
		@points = 10
		@x = rand * 640
		@y = rand * 480
		@zoomLevel = 1
	end

	def draw
		img = @animation[Gosu::milliseconds / 100 % @animation.size]
		img.draw(
			@x - img.width / 2.0,
			@y - img.height / 2.0,
			ZOrder::STARS,
			zoomLevel, zoomLevel, color, :add)
	end

	private

	def rand_color_component
		rand(256 - 60) + 60 # Not too dark!
	end
end

