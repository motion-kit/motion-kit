describe 'NSTabView helpers' do
  class TestTabViewLayout < MK::Layout
    def layout
      add NSTabView, :tab_view do
        add_tab "tab_identifier", "tab_label" do
          wantsLayer true
          backgroundColor NSColor.redColor
        end
      end
    end
  end

  it 'should support `add_tab` method' do
    @layout = TestTabViewLayout.new

    view = NSView.alloc.initWithFrame([[0, 0], [500, 500]])
    view.addSubview(@layout.view)

    @tab_view = @layout.get(:tab_view)

    @tab_view.numberOfTabViewItems.should == 1
    @tab_view.tabViewItems.first.identifier.should == "tab_identifier"
    @tab_view.tabViewItems.first.label.should == "tab_label"
    @tab_view.tabViewItems.first.view.wantsLayer.should == true
    @tab_view.tabViewItems.first.view.backgroundColor.should == NSColor.redColor
  end
end
