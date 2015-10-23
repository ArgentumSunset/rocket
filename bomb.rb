class Bomb

	EXPLODE_TIME = 1000
	COLLISION_DISTANCE = 35

	attr_reader :x, :y
	attr_accessor :x, :y

	def initialize(player, window)
		@img = Gosu::Image.new("media/bomb.png")
		@x = rand * 640
		@y = rand * 480
		@player = player
		@explode_time = Gosu::milliseconds + EXPLODE_TIME
		@window = window
		@exploded = false
		@hitting_lasers = hitting_lasers
	end

	def draw
		@img.draw(
			@x - @img.width / 2.0,
			@y - @img.height / 2.0,
			ZOrder::STARS)
	end

	def get_pos
		[@x, @y]
	end

	def explode_timer
		if Gosu::milliseconds > @explode_time
			@exploded = true
			@img = Gosu::Image.new("media/explosion3.png")
		end
		if @exploded == true && Gosu::milliseconds > @explode_time + 200
		true
		end
	end
	

end