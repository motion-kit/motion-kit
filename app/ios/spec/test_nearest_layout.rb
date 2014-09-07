class ViewClass1  < UIView ; end
class ViewClass2  < UIView ; end
class ViewClass3  < UIView ; end
class ViewClass4  < UIView ; end
class ViewClass5  < UIView ; end
class ViewClass6  < UIView ; end
class ViewClass7  < UIView ; end
class ViewClass8  < UIView ; end
class ViewClass9  < UIView ; end
class ViewClass10 < UIView ; end
class ViewClass11 < UIView ; end

class TestNearestLayout < MK::Layout
  attr :start_here
  attr :expected_to_find

  def self_search
    create(ViewClass1) do
      add ViewClass2, :self_search do
        @expected_to_find = @start_here = add(ViewClass3, :self_search)
        add ViewClass4, :self_search
      end
      add ViewClass5, :self_search
    end
  end

  def child_search
    create(ViewClass1) do
      add ViewClass2, :child_search do
        @start_here = add ViewClass3 do
          add ViewClass4 do
            @expected_to_find = add(ViewClass5, :child_search)
          end
        end
        add ViewClass6, :child_search
      end
      add ViewClass7, :child_search
    end
  end

  def sibling_search
    create(ViewClass1) do
      add ViewClass2, :sibling_search do
        @start_here = add ViewClass3
        @expected_to_find = add(ViewClass4, :sibling_search)
      end
      add ViewClass5, :sibling_search
    end
  end

  def siblings_child_search
    create(ViewClass1) do
      add ViewClass2, :siblings_child_search do
        @start_here = add ViewClass3
        add ViewClass4 do
          @expected_to_find = add ViewClass5, :siblings_child_search
        end
      end
      add ViewClass6, :siblings_child_search
    end
  end

  def parent_search
    create(ViewClass1) do
      add ViewClass2, :parent_search do
        @expected_to_find = add(ViewClass3, :parent_search) do
          @start_here = add ViewClass4
          add ViewClass5
        end
        add ViewClass6, :parent_search
      end
    end
  end

  def distant_search
    create(ViewClass1) do
      add ViewClass2 do
        add ViewClass3 do
          @start_here = add ViewClass4
          add ViewClass5
        end
        add ViewClass6
      end
      add ViewClass7 do
        @expected_to_find = add(ViewClass8, :distant_search) do
          add ViewClass9, :distant_search
        end
        add ViewClass10, :distant_search do
          add ViewClass11, :distant_search
        end
      end
    end
  end

end
