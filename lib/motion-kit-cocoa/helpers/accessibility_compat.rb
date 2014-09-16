# These methods are defined on NSObject, and so we need to fix em.
#
# @requires MotionKit::BaseLayout
module MotionKit
  class BaseLayout

    delegate_method_fix :accessibilityActivationPoint
    delegate_method_fix :accessibilityElementsHidden
    delegate_method_fix :accessibilityFrame
    delegate_method_fix :accessibilityHint
    delegate_method_fix :accessibilityLabel
    delegate_method_fix :accessibilityLanguage
    delegate_method_fix :accessibilityPath
    delegate_method_fix :accessibilityTraits
    delegate_method_fix :accessibilityValue
    delegate_method_fix :accessibilityViewIsModal
    delegate_method_fix :isAccessibilityElement
    delegate_method_fix :shouldGroupAccessibilityChildren

  end
end
