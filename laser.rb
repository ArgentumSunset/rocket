class Laser

	SPEED = 30
	attr_reader :x, :y
	attr_accessor :x, :y

    def initialize(x,y,angle)
		@img = Gosu::Image.new("media/laser.png")
		@time = (rand * 3).round + 4
        @x = x
        @y = y
		@angle = angle
	end

	def draw
		@img.draw_rot(
            @x,
            @y, 
			ZOrder::STARS,
            @angle, 0.5, 0.5, 0.2, 0.2)
	end

	def move
		@x += Gosu::offset_x(@angle, SPEED)
		@y += Gosu::offset_y(@angle, SPEED)
		
	end
end