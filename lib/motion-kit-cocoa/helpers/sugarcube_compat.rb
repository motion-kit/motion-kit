# These methods are defined in SugarCube's REPL helpers, but we want them to be
# delegated to either `UIViewHelpers#frame` or `CALayer#setFrame`
#
# @requires MotionKit::BaseLayout
module MotionKit
  class BaseLayout

    delegate_method_fix :adjust
    delegate_method_fix :frame
    delegate_method_fix :left
    delegate_method_fix :right
    delegate_method_fix :up
    delegate_method_fix :down
    delegate_method_fix :origin
    delegate_method_fix :thinner
    delegate_method_fix :wider
    delegate_method_fix :shorter
    delegate_method_fix :taller
    delegate_method_fix :size
    delegate_method_fix :center
    delegate_method_fix :shadow
    delegate_method_fix :tree
    delegate_method_fix :root
    delegate_method_fix :restore
    delegate_method_fix :blink

  end
end
