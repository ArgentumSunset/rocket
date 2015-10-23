require "gosu"
require_relative "player"
require_relative "z_order"
require_relative "star"
require_relative "bomb"

class GameWindow < Gosu::Window

	def initialize
		super 640, 400
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
				@player.shoot if Gosu::button_down? Gosu::KbSpace
			end

			@player.move
			@player.collect_stars(@stars)
			@player.hit_bombs(@bombs)

			if rand(100) < 4 && @stars.size < 25
				@stars.push(Star.new(@star_anim))
			end

			if rand(75) < 4 && @bombs.size < 3
				@bombs.push(Bomb.new(@lasers, @player, self))
			end

			@bombs.each {|bomb| 
				if bomb.explode_timer == true 
				@bombs.delete(bomb)
				end}

			if @player.health <= 0
				@lost = true
				@stars.clear
				@bombs.clear
			end
	end

	def draw
		@player.draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		@stars.each {|star| star.draw }
		@bombs.each {|bomb| bomb.draw }
		@font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
		@font.draw("Health: #{@player.health}", 10, 70, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

end

window = GameWindow.new
window.show