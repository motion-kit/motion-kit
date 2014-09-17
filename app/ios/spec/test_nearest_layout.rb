class TestNearestLayout < MK::Layout
  attr :start_here
  attr :expected_to_find

  def self_search
    create(UIView) do
      add UIView, :self_search do
        @expected_to_find = @start_here = add(UIView, :self_search)
        add UIView, :self_search
      end
      add UIView, :self_search
    end
  end

  def child_search
    create(UIView) do
      add UIView, :child_search do
        @start_here = add UIView do
          add UIView do
            @expected_to_find = add(UIView, :child_search)
          end
        end
        add UIView, :child_search
      end
      add UIView, :child_search
    end
  end

  def sibling_search
    create(UIView) do
      add UIView, :sibling_search do
        @start_here = add UIView
        @expected_to_find = add(UIView, :sibling_search)
      end
      add UIView, :sibling_search
    end
  end

  def siblings_child_search
    create(UIView) do
      add UIView, :siblings_child_search do
        @start_here = add UIView
        add UIView do
          @expected_to_find = add UIView, :siblings_child_search
        end
      end
      add UIView, :siblings_child_search
    end
  end

  def parent_search
    create(UIView) do
      add UIView, :parent_search do
        @expected_to_find = add(UIView, :parent_search) do
          @start_here = add UIView
          add UIView
        end
        add UIView, :parent_search
      end
    end
  end

  def distant_search
    create(UIView) do
      add UIView do
        add UIView do
          @start_here = add UIView
          add UIView
        end
        add UIView
      end
      add UIView do
        @expected_to_find = add(UIView, :distant_search) do
          add UIView, :distant_search
        end
        add UIView, :distant_search do
          add UIView, :distant_search
        end
      end
    end
  end

end
