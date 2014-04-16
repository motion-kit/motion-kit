# MotionKit

*The RubyMotion layout and styling gem.*

1. Non-polluting
2. Simple, easy to remember syntax
3. ProMotion/RMQ/SugarCube-compatible
4. Styles and layouts are compiled
5. Crossplatform compatibility: iOS, OSX
6. Crossframework compatibility:
   - [UIKit][readmore-uikit]
   - [ApplicationKit][readmore-applicationkit]
   - [Joybox][readmore-joybox]
   - [SpriteKit][readmore-spritekit]
   - [CoreAnimation][readmore-coreanimation]
   - [NSMenu/NSMenuItem][readmore-nsmenu]
7. Written by [the authors][authors] of [ProMotion][] and [Teacup][]

[authors]: CONTRIBUTORS.md
[Colin]: https://github.com/colinta
[Jamon]: https://github.com/jamonholmgren
[ProMotion]: https://github.com/clearsightstudio/ProMotion
[RMQ]: https://github.com/infinitered/rmq
[Teacup]: https://github.com/rubymotion/teacup

[readmore-uikit]:          https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#uikit
[readmore-applicationkit]: https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#applicationkit
[readmore-joybox]:         https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#joybox
[readmore-spritekit]:      https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#spritekit
[readmore-coreanimation]:  https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#coreanimation
[readmore-nsmenu]:         https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#nsmenu

## What happened to Teacup??

You can [read all about](#goodbye-teacup) why Colin decided that Teacup needed to
be replaced with a new project, rather than upgraded or refactored.


## Usage

From your controller you will instantiate a `MotionKit::Layout` instance, and
request views from it.  `layout.view` is the root view, and it's common to
assign this to `self.view` in your `loadView` method.  You'll also want to hook
up your instance variables, using `layout.get(:id)`.

```ruby
class LoginController < UIViewController
  def loadView
    @layout = LoginLayout.new
    self.view = @layout.view

    @button = @layout.get(:button)  # This will be created in our layout (below)
  end

  def viewDidLoad
    @button.on(:touch) { my_code } # Mix with some SugarCube for sweetness!
    rmq(@button).on(:touch) { my_code } # and of course RMQ works just as well
  end
end
```


### Lay out your subviews with a clean DSL

In a layout class, the `layout` method is expected to create the view hierarchy,
and it should also take care of frames and styling.  You can apply styles here,
and it's handy to do so when you are creating a quick mock-up, or a very small
app.  But in a real application, you'll want to include a Stylesheet module, so
your layout isn't cluttered with all your styling code.

Here's a layout that just puts a label and a button in the middle of the screen:

```ruby
class SimpleLayout < MotionKit::Layout

  def layout
    add UILabel, :label
    add UIButton, :button
  end

  def label_style
    text 'Hi there! Welcome to MotionKit'
    font UIFont.fontWithName('Comic Sans', size: 24)
    sizeToFit
    center [CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds)]
    text_alignment UITextAlignmentCenter
    text_color UIColor.whiteColor
    # if you prefer to use shorthands from another gem, you certainly can!
    background_color rmq.color.white  # from RMQ
    background_color :white.uicolor   # from SugarCube
  end

  def button_style
    # this will call 'setTitle(forState:)' via a styling method
    title 'Press it!'
    center [CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds) + 50]
  end

end
```

Nice, that should be pretty easy to follow, right?  M'kay, in this next, more
complicated layout we'll create a login page, with a 'Login' button and inputs
for username and password.  In this example, I will assign the frame in the
`layout` method, instead of in the `_style` methods.  This is purely an
aesthetic choice.  Some people like to have their frame code in the layout
method, others like to put it in the _style methods.  I point it out only as an
available feature.

```ruby
class LoginLayout < MotionKit::Layout
  # we write our `_style` methods in a module
  include LoginStyles

  def layout
    # we know it's easy to add a subview, with a stylename...
    add UIImageView, :logo

    # but even better, pass the 'frame' in, too:
    add UIImageView, :logo do
      frame [[0, 0], [320, 568]]
    end
    # hardcoded dimensions!? there's got to be a better way...

    # This frame argument will be handed to the 'MotionKit::Layout#frame'
    # method, which can accept lots of shorthands.  Let's use one to scale the
    # imageview so that it fills the width, but keeps its aspect ratio.
    add UIImageView, :logo do
      frame [[0, 0], ['100%', :scale]]
    end
    # 'scale' uses sizeToFit and the other width/height property to keep the
    # aspect ratio the same. Neat, huh?

    add UIView, :button_container do
      # Like I said, the frame method is very powerful, there are lots of
      # ways it can help with laying out your rects, and it will even try to
      # apply the correct autoresizingMask for you; the from_bottom method will
      # set the UIAutoresizingMask to "FlexibleTop", and using '100%' in the
      # width will ensure the frame stays the width of its parent.
      frame from_bottom(height: 50, width: '100%')
      frame from_bottom(h: 50, w: '100%')  # is fine, too

      # same as above; assumes full width
      frame from_bottom(height: 50)

      # similar to Teacup, views added inside a block are added to that
      # container.  You can reference the container with 'superview' or
      # 'parent'.
      add UIButton, :login_button do
        background_color superview.background_color

        # 'parent' is not instance of a view, it's a special object that
        # acts like a placeholder for various values; if you want to assign
        # *any* superview property, use 'superview' instead.  'parent' is mostly
        # useful for setting the frame.
        frame [[ 10, 5 ], [ 50, parent.height - 10 ]]
      end
    end

    # 'container' is a generic view method, and will return 'UIView' on iOS and
    # 'NSView' on OS X.  Totally optional, but it helps keep your layout files
    # consistent across multiple platforms.
    add container, :inputs do
      frame x: 0, y: 0, width: '100%', height: '100% - 50'

      # setting autoresizing_mask should handle rotation events; this overrides
      # any automatic mask settings that occurred in 'frame'
      autoresizing_mask :pin_to_top, :flexible_height, :flexible_width

      # we'll use 'sizeToFit' to calculate the height
      add text_field, :username_input do
        frame [[10, 10], ['100% - 10', :auto]]
      end
      add text_field, :password_input do
        frame below(:username_input, margin: 8)
      end
    end
  end
end
```


### Styles are compiled, simple, and clean

In MotionKit, when you define a method that has the same name as a view
stylename with the suffix "_style", that method is called and is expected to
style that view.

```ruby
class LoginLayout < MK::Layout

  def layout
    add UIImageView, :logo do
      frame [[0, 0], ['100%', :scale]]
    end
    add UIView, :button_container do
      # ...
    end
  end

  def logo_style
    image UIImage.imageNamed('logo')
  end

  def button_container_style
    background_color UIColor.clearColor
  end

end
```

So as an additional code-cleanup step, why not put those methods in a module,
and include them in your layout! Sounds clean and organized to me! You can
include multiple stylesheets this way, just be careful around name collisions.

```ruby
module LoginStyles

  def login_button_style
    background_color "51A8E7"
    title "Log In"
    layer do
      corner_radius 7.0
      shadow_color "000000"
      shadow_opacity 0.9
      shadow_radius 2.0
      shadow_offset [0, 0]
    end
  end

end

# back in our LoginLayout class
class LoginLayout
  include LoginStyles

  def layout
    # ...
  end

end
```


### How do styles get applied?

If you've used RMQ's Stylers, you'll recognize a very similar pattern here. In
RMQ the 'style' methods are handed a 'Styler' instance, which wraps access to
the view.  In MotionKit we make use of `method_missing` to call these methods
indirectly.  But other than that, the design is very similar.

```ruby
  def login_button_style
    title 'Press me'  # this gets delegated to UIButtonLayout#title(view, title)
  end
```

There's an additional step where any un-handled methods are sent to the view
directly, using the appropriate setter method. This step also takes care of
converting methods from `snake_case` to the Objective-C style `camelCase`, and
takes care of discrepencies like `setFoo(value)` vs `foo=(value)`.

```ruby
  def login_button_style
    background_color UIColor.clearColor  # this gets converted to `self.target.backgroundColor = ...`
  end
```

You can easily add new helpers to MotionKit's existing Layout classes. They are
all named consistenly, e.g. `UIViewLayout`, e.g. `UILabelLayout`.  Just open up
these classes and hack away.

```ruby
# these helpers will only be applied to instances of UILabel and UILabel
# subclasses
class UILabelLayout

  # style methods can accept any number of arguments, and a block. The current
  # view should be referred to via the method `target`
  def color(color)
    target.textColor = color
  end

  # If a block is passed it is your responsibility to call `context(val,
  # &block)`, if that is appropriate.  Other handlers can use the block to
  # conditionally call code; on iOS there are orientation helpers `portrait`,
  # `landscape`, etc that apply styles based on the current orientation.
  def layer(&block)
    context(target.layer, &block)
  end

  # Sure, you can add flow-control mechanisms if that's your thing!
  def sometimes(&block)
    if rand > 0.5
      yield
    end
  end

end
```

For your own custom classes, you can provide a Layout class by calling the
`targets` method in your class body.

```ruby
# Be sure to extend an existing Layout class, otherwise you'll lose a lot of
# functionality.  Often this will be `MK::UIViewLayout` on iOS and
# `MK::NSViewLayout` on OS X.
class CustomLayout < MK::UIViewLayout
  targets CustomView

  def fore_color(value)
    target.foregroundColor = value
  end

end
```


### Some handy tricks

#### Orientation specific styles

These are available on iOS.

```ruby
add UIView, :container
  portrait do
    frame from_top(width: '100%', height: 100)
  end
  landscape do
    frame from_top_left(width: 300, height: 100)
  end
end
```

#### Update views via 'initial', 'reapply'

If you call 'layout.reapply!', your style methods will be called again (but
NOT the `layout` method). You very well might want to control what methods get
called on later invocations, or only on the *initial* layout.

This is more for being able to initialize values, or to handle orientation, than
anything else.  There is not much performance increase/decrease if you just
reapply styles every time, but you might not want to have your frame or colors
reset, if you've done some animation.

```ruby
def login_button_style
  # only once, when the `layout` is created
  initial do
  end

  # on later invocations
  reapply do
  end

  # style every time
  title 'Press Me'
end
```

#### Apply styles via module

```ruby
module AppStyles

  def rounded_button
    layer do
      corner_radius 7
      masks_to_bounds true
    end
  end

end

class LoginLayout < MotionKit::Layout
  include AppStyles

  def layout
    add button, :login_button
  end

  def login_button_style
    self.rounded_button
    title 'Login'
  end

end
```

#### Use 'container' classes

You saw the `container` method above, right?  Well those are easy to create.  So
if you've got a 'button' subclass that you just love, you can assign it to a
layout class method.

```ruby
module AppViews

  def button
    MySpecialButton
  end

end

class MyLayout < MotionKit::Layout
  extend AppViews

  def layout
    add button  # adds MySpecialButton instance
  end

end
```


# Contributing

We welcome your contributions! Please be sure to run the specs before you do,
and consider adding support for both iOS and OS X.

To run the specs for both platforms, you will need to run `rake spec` twice:

```
> rake spec  # runs iOS specs
> rake spec platform=osx  # OS X specs
```


# Goodbye Teacup
###### by [colinta][Colin]

If you've worked with XIB/NIB files, you might know that while they can be
cumbersome to deal with, they have the great benefit of keeping your controllers
free of layout and styling concerns. [Teacup][] brought some of this benefit, in
the form of stylesheets, but you still built the layout in the body of your
controller file.

Plus Teacup is a beast! Imported stylesheets, orientation change events,
auto-layout support. It's got a ton of features, but with that comes a lot of
complexity. This has led to an unfortunate situation - I'm the *only* person who
understands the code base! This was never the intention of Teacup. It started
out as, and was always meant to be, a community project, with contributions
coming from all of its users.

When [ProMotion][] and later [RMQ][] were released, they both included their own
styling mechanisms. Including Teacup as a dependency would have placed a huge
burden on their users, and they would have had to ensure compatibility. Since
Teacup does a lot of method swizzling on base classes, this is not a trivial
undertaking.

If you use RMQ or ProMotion already, you'll find that MotionKit fits right in.
We designed it to be something that can easily be brought into an existing
project, too; it does not extend any base classes (the cross platform support is
handled by the [style handlers][handlers]), and it's completely opt-in.

Unlike Teacup, you won't have your styles reapplied due to orientation changes,
but it's *really* easy to set that up, as you'll see.

Big thanks to everyone who contributed on this project!  I hope it serves you
as well as Teacup, and for even longer into the future.

Sincerely,

Colin T.A. Gray
Feb 13, 2014
