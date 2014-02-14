class TestCreateLayout < MotionKit::Layout
  def foo
    create UIView, :view do
      add UILabel, :label
      create UIImageView, :image
    end
  end
end
