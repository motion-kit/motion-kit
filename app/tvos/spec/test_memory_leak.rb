class TestMemoryLeakController < UIViewController

  def viewDidLoad
    @layout = TestMemoryLeakLayout.new(root: self.view).build
    @cell = TestMemoryLeakCell.new
  end

  def dealloc
    NSNotificationCenter.defaultCenter.postNotificationName('TestMemoryLeakController dealloc', object: nil)
    super
  end

end


class TestMemoryLeakCell < UITableViewCell

  def init
    super.tap do
      @layout = TestMemoryLeakCellLayout.new(root: self).build
    end
  end

  def dealloc
    NSNotificationCenter.defaultCenter.postNotificationName('TestMemoryLeakCell dealloc', object: nil)
    super
  end

end


class TestMemoryLeakLayout < MK::Layout

  def layout
    add UILabel, :label
  end

  def label_style
    text 'label'

    constraints do
      top.equals(:superview)
    end
  end

  def dealloc
    NSNotificationCenter.defaultCenter.postNotificationName('TestMemoryLeakLayout dealloc', object: nil)
    super
  end
end


class TestMemoryLeakCellLayout < MK::Layout

  def layout
    context(contentView) do
      add UILabel, :label
    end
  end

  def label_style
    text 'label'

    constraints do
      top.equals(:superview)
    end
  end

  def dealloc
    NSNotificationCenter.defaultCenter.postNotificationName('TestMemoryLeakCellLayout dealloc', object: nil)
    super
  end

end
