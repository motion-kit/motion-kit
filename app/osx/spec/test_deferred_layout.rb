class TestDeferredLayout < MK::Layout
  attr :layout_test, :create_view_test, :nested_blocks_test
  attr :layout_test_ran, :create_view_test_ran, :nested_blocks_test_ran, :apply_layouts_test_ran
  attr :layout_test_is_0, :create_view_test_is_0, :nested_blocks_test_is_0, :nested_blocks_test_is_1
  attr :apply_layouts_view, :apply_layouts_label, :apply_layouts_button, :apply_layouts_layer

  def layout
    @layout_test = 0
    deferred do
      @layout_test = 1
      @layout_test_ran = true
    end
    @layout_test_is_0 = @layout_test == 0
  end

  def create_view
    context(NSView.new) do
      @create_view_test = 0
      deferred do
        @create_view_test = 1
        @create_view_test_ran = true
      end
      @create_view_test_is_0 = @create_view_test == 0
    end
  end

  def error_no_context
    deferred do
    end
  end

  def nested_blocks
    context(NSView.new) do
      @nested_blocks_test = 0
      deferred do
        @nested_blocks_test = 1
        deferred do
          @nested_blocks_test = 2
          @nested_blocks_test_ran = true
        end
        @nested_blocks_test_is_1 = @nested_blocks_test == 1
      end
      @nested_blocks_test_is_0 = @nested_blocks_test == 0
    end
  end

  def apply_layouts
    @apply_layouts_test_ran = 0

    @apply_layouts_view = context(NSView.new) do
      @apply_layouts_label = add(NSTextField.new) do
        stringValue 'before'
        deferred do
          stringValue 'after'
          @apply_layouts_test_ran += 1
        end
      end

      layer CALayer.layer
      @apply_layouts_layer = context(layer) do
        opacity 1.0
        deferred do
          opacity 0.5
          @apply_layouts_test_ran += 1
        end
      end

    end
  end

end
