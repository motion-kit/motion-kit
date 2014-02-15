module TutorialModule

  def setup_nav(title, options={})
    self.title = title

    is_first = options.fetch(:first, false)
    unless is_first
      left_nav_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRewind, target: self, action: 'go_back')
      self.navigationItem.leftBarButtonItem = left_nav_button
    end

    is_last = options.fetch(:last, false)
    unless is_last
      right_nav_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemFastForward, target: self, action: 'go_forward')
      self.navigationItem.rightBarButtonItem = right_nav_button
    end
  end

  def go_back
    self.navigationController.popViewControllerAnimated(true)
  end

end
