class Laser

	SPEED = 10
	attr_reader :x, :y
	attr_accessor :x, :y

	def initialize(x,y,angle)
		@img = Gosu::Image.new("media/laser.png")
		@time = (rand * 3).round + 4
		@x = x
		@y = y
		@x_vel, @y_vel = 0.0
		@angle = angle
		@shot_time = Gosu::milliseconds
	end

	def draw
		@img.draw(
			@x - @img.width / 2.0,
			@y - @img.height / 2.0,
			ZOrder::PLAYER)
	end

	def move
		@shot_time -= @shot_time
		if @shot_time > 50
		@x += Gosu::offset_x(@angle, SPEED)
		@y += Gosu::offset_y(@angle, SPEED)
		end
	end
end