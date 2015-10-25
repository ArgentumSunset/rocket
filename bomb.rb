class Bomb

	EXPLODE_TIME = 3000
	COLLISION_DISTANCE = 35

    attr_reader :x, :y, :exploded

    def initialize(player, window)
		@img = Gosu::Image.new("media/bomb.png")
		@x = rand * 640
		@y = rand * 480
		@player = player
		@explode_time = Gosu::milliseconds + EXPLODE_TIME
		@window = window
		@exploded = false
	end

	def draw
		@img.draw(
			@x - @img.width / 2.0,
			@y - @img.height / 2.0,
			ZOrder::STARS)
	end
    
    def colliding?(obj, distance)
        Gosu::distance(@x, @y, obj.x, obj.y) < distance ? true : false
	end
    
    def hit_lasers(lasers)
        if lasers.reject! {|laser| colliding?(laser, COLLISION_DISTANCE) }
            @explode_time = Gosu::milliseconds
		end
        if @exploded == true && Gosu::milliseconds > @explode_time + 200
		    true
		end
	end

    def exploded?
		if Gosu::milliseconds > @explode_time
			@exploded = true
            true
			@img = Gosu::Image.new("media/explosion3.png")
		end
		if @exploded == true && Gosu::milliseconds > @explode_time + 200
		  true
		end
	end
	

end