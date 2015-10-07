require "gosu"

class Player

	TURN_INCREMENT = 4.5
	ACCELERATION = 1.5
	
	def initialize
		@x = @x_vel = @y = @y_vel = @angle = 0.0
		@score = 0
		@image = Gosu::Image.new("media/starfighter.bmp")
	end

	def warp(x, y)
		@x, @y = x, y
	end

	def turn_left
		@angle -= TURN_INCREMENT
	end

	def turn_right
		@angle += TURN_INCREMENT
	end

	def accelerate
		@x_vel += Gosu:offset_x(@angle, ACCELERATION)
		@y_vel += Gosu:offset_x(@angle, ACCELERATION)
	end

	def move
		@x += @x_vel
		@y += @y_vel

		@x %= 640
		@y %= 480

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def draw
		@image.draw_rot(@x, @y, 1, @angle)
	end

end