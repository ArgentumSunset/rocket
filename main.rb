require "gosu"

class GameWindow < Gosu::Window

	def initialize
		super 640, 400
		self.caption = "Starry Night"

		@background_image = Gosu::Image.new("media/space.png",
																				:tileable => true)
	end

	def update

	end

	def draw
		@background_image.draw(0, 0, 0)
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

end

window = GameWindow.new
window.show