require_relative "star"

class SuperStar < Star

	SCORE_ADD = 50

	attr_accessor :points

	def initialize(animation)
		super(animation)
		self.zoomLevel = 2
		c = Gosu::Color.new(0xff_000000)
		c.red = 256
		c.green = 0
		c.blue = 0
		self.color = c
		self.points = 30
	end
	
end