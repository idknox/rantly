class RantDashboard
  def initialize(rant)
    @rant = rant
  end

  attr_reader :rant

  def new_comment
    @comment ||= Comment.new
  end
end