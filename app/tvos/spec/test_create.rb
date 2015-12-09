class TestCreateLayout < MotionKit::Layout

  def create_view
    create UIView, :view do
      add UILabel, :label
      create UIImageView, :image
    end
  end

  def create_and_context
    view = UIView.new
    context(view) do
      add UILabel, :label
    end
  end

end
