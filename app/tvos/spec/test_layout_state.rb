class TestLayoutState < MK::Layout

  def layout
    root UILabel, :root
  end

  def root_style
    text 'initial'

    reapply do
      text 'reapply'
    end
  end

  def any_view
    create UILabel, :any_view
  end

  def any_view_style
    text 'initial'

    reapply do
      text 'reapply'
    end
  end

end
