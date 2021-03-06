require "gosu"
require_relative "z_order"
require_relative "star"
require_relative "bomb"
require_relative "laser"

class Player

	TURN_INCREMENT = 4.5
	ACCELERATION = 0.5
	COLLISION_DISTANCE = 35
	DAMAGE_DISTANCE = 50
  LASER_LIMIT = 300

    attr_reader :score, :image
    attr_accessor :score, :image
	
	def initialize
		@x = @x_vel = @y = @y_vel = @angle = 0.0
		@health = 100
		@score = 0
		@image = Gosu::Image.new("media/starfighter.bmp")
		@beep = Gosu::Sample.new("media/beep.wav")
    @time = Gosu::milliseconds
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
		@x_vel += Gosu::offset_x(@angle, ACCELERATION)
		@y_vel += Gosu::offset_y(@angle, ACCELERATION)
	end

	def move
		@x += @x_vel
		@y += @y_vel

		@x %= 640
		@y %= 480

		@x_vel *= 0.95
		@y_vel *= 0.95
	end

	def draw
		@image.draw_rot(@x, @y, ZOrder::PLAYER, @angle)
	end

	def score
		@score
	end

	def health
		@health
	end

	def collect_stars?(stars)
			stars.each {|star| 
			if colliding?(star, COLLISION_DISTANCE) 
					@score += star.points
					stars.delete(star)
			end
			}
	end

	def hit_bombs(bombs)
		if bombs.reject! {|bomb| colliding?(bomb, DAMAGE_DISTANCE)}
			@health -= 25
		end
	end

    def shoot(lasers)
     if(Gosu::milliseconds > @time)
       lasers.push(Laser.new(@x, @y, @angle))
       @time = Gosu::milliseconds + LASER_LIMIT
     end
	end

	private

	def colliding?(obj, distance)
		if Gosu::distance(@x, @y, obj.x, obj.y) < distance
		 @beep.play
		 true
		else
		 false
		end

	end

end