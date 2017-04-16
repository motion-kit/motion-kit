# @provides MotionKit::Appearance
# @requires MotionKit::BaseAppearance
# @requires module:MotionKit::UIViewAppearance
# @requires module:MotionKit::UIToolbarAppearance
# @requires module:MotionKit::UITableViewCellAppearance
# @requires module:MotionKit::UITableViewAppearance
# @requires module:MotionKit::UILabelAppearance
module MotionKit
  class Appearance < MotionKit::BaseAppearance

    include UIViewAppearance
    include UIToolbarAppearance
    include UITableViewCellAppearance
    include UITableViewAppearance
    include UILabelAppearance

  end
end
