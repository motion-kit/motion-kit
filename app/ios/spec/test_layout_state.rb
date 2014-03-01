class TestLayoutState < MK::Layout

  def layout
    root UILabel, :root
  end

  def root_style
    initial do
      text 'initial'
    end
    reapply do
      text 'reapply'
    end
  end

  def any_view
    create UILabel, :any_view
  end

  def any_view_style
    initial do
      text 'initial'
    end
    reapply do
      text 'reapply'
    end
  end

end
