require "gosu"

class GameWindow < Gosu::Window

	def initialize
		super 640, 400
		self.caption = "Starry Night"
	end

	def update

	end

	def draw

	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

end

window = GameWindow.new
window.show