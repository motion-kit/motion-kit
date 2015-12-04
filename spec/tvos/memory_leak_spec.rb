describe 'MemoryLeaks' do

  before do
    window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @controller = UINavigationController.new
    @controller.viewControllers = [UIViewController.new, TestMemoryLeakController.new]
    window.rootViewController = @controller
    window.makeKeyAndVisible

    @did_dealloc_controller = false
    @did_dealloc_layout = false
    @did_dealloc_cell = false
    @did_dealloc_cell_layout = false

    @observe_controller = NSNotificationCenter.defaultCenter.addObserverForName('TestMemoryLeakController dealloc', object: nil, queue: nil, usingBlock: -> notification do
      @did_dealloc_controller = true
    end)
    @observe_layout = NSNotificationCenter.defaultCenter.addObserverForName('TestMemoryLeakLayout dealloc', object: nil, queue: nil, usingBlock: -> notification do
      @did_dealloc_layout = true
    end)
    @observe_cell = NSNotificationCenter.defaultCenter.addObserverForName('TestMemoryLeakCell dealloc', object: nil, queue: nil, usingBlock: -> notification do
      @did_dealloc_cell = true
    end)
    @observe_cell_layout = NSNotificationCenter.defaultCenter.addObserverForName('TestMemoryLeakCellLayout dealloc', object: nil, queue: nil, usingBlock: -> notification do
      @did_dealloc_cell_layout = true
    end)
  end

  after do
    NSNotificationCenter.defaultCenter.removeObserver(@observe_controller)
    NSNotificationCenter.defaultCenter.removeObserver(@observe_layout)
    NSNotificationCenter.defaultCenter.removeObserver(@observe_cell)
    NSNotificationCenter.defaultCenter.removeObserver(@observe_cell_layout)
  end

  describe 'When popping a controller' do

    before do
      wait 0.1 do
        @controller.popViewControllerAnimated(false)

        # window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
        # window.rootViewController = @controller
        # window.makeKeyAndVisible
      end
    end

    it 'should release the TestMemoryLeakController' do
      wait 0.1 do
        @did_dealloc_controller.should == true
      end
    end

    it 'should release the TestMemoryLeakLayout' do
      wait 0.1 do
        @did_dealloc_layout.should == true
      end
    end

    it 'should release the TestMemoryLeakCell' do
      wait 0.1 do
        @did_dealloc_cell.should == true
      end
    end

    it 'should release the TestMemoryLeakCellLayout' do
      wait 0.1 do
        @did_dealloc_cell_layout.should == true
      end
    end

  end

end
