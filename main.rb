require "gosu"
require_relative "player"
require_relative "z_order"
require_relative "star"
require_relative "bomb"

    WIDTH = 640
    HEIGHT = 400

class GameWindow < Gosu::Window

	def initialize
        super WIDTH, HEIGHT
		self.caption = "SPACE MURDER"

		@lost = false

		@background_image = Gosu::Image.new("media/space.png",
																				:tileable => true)
		@player = Player.new
		@player.warp(width/2, height/2)

		@star_anim = Gosu::Image::load_tiles("media/star.png", 25, 25)
		@stars = []
		@bombs = []
		@doomed_bombs = []
		@lasers = []

		@font = Gosu::Font.new(20)
		@font2 = Gosu::Font.new(50)
	end

	def update
        if !@lost
            @player.turn_left if Gosu::button_down? Gosu::KbLeft
            @player.turn_right if Gosu::button_down? Gosu::KbRight
            @player.accelerate if Gosu::button_down? Gosu::KbUp
            @player.shoot(@lasers) if Gosu::button_down? Gosu::KbSpace

			@player.move
			@player.collect_stars(@stars)
			@player.hit_bombs(@bombs)

			if rand(100) < 4 && @stars.size < 25
				@stars.push(Star.new(@star_anim))
			end

			if rand(75) < 4 && @bombs.size < 3
				@bombs.push(Bomb.new(@player, self))
			end

			@bombs.each {|bomb| 
                if bomb.exploded? || bomb.hit_lasers(@lasers)
				    @bombs.delete(bomb)
                end
            }
        
            @lasers.each {|laser|
                laser.move
            }

			if @player.health <= 0
				@lost = true
			end
        end
	end

	def draw
		@player.draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		@stars.each {|star| star.draw }
		@bombs.each {|bomb| bomb.draw }
        @lasers.each {|laser| laser.draw}
		@font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
		@font.draw("Health: #{@player.health}", 10, 70, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
        if @lost
            @font.draw("GAME OVER", 70, 150, ZOrder::UI, 5.0, 5.0, 0xff_ffff00)
        end
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

end

window = GameWindow.new
window.show