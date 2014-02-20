# MotionKit

*The RubyMotion layout and styling gem.*

1. Non-polluting
2. Simple, easy to remember syntax
3. ProMotion/RMQ/Sugarcube-compatible
4. Styles and layouts are compiled
5. Crossplatform compatibility (iOS, OSX)
6. Written by [the authors][authors] of [ProMotion][] and [Teacup][]

[authors]: CONTRIBUTORS.md
[Colin]: https://github.com/colinta
[Jamon]: https://github.com/jamonholmgren
[ProMotion]: https://github.com/clearsightstudio/ProMotion
[RMQ]: https://github.com/infinitered/rmq
[Teacup]: https://github.com/rubymotion/teacup


## What happened to Teacup??

You can [read all about](#goodbye-teacup) why Colin decided that Teacup needed to
be replaced with a new project, rather than upgraded or refactored.


## Usage

From your controller you will instantiate a `MotionKit::Layout` instance, and
request views from it.  `layout.view` is the root view, and it's common to
assign this to `self.view` in your `loadView` method.  You'll also want to hook
up your instance variables.

```ruby
class LoginController < UIViewController
  def loadView
    @layout = LoginLayout.new
    self.view = @layout.view

    @button = @layout.get(:button)
  end

  def viewDidLoad
    @button.on(:touch) { my_code } # Mix with some Sugarcube for sweetness!
    rmq(@button).on(:touch) { my_code } # and of course RMQ works just as well
  end
end
```


### Lay out your subviews with a clean DSL

In a layout file, the `layout` method is expected to create the view hierarchy,
and it should also take care of frames and layout.  You can also apply styles
here, and it's handy to do so when you are creating a quick mock-up, or a very
small app.  But in a real application, you'll want to include a Stylesheet
module, so your layout isn't cluttered with all your styling code.

Here's a layout that just puts a label in the middle of the screen:

```ruby
class SimpleLayout < MotionKit::Layout

  def layout
    add UILabel, :simple_label
  end

  def simple_label
    center superview.center
    text 'Hi there! Welcome to MotionKit'
    text_alignment UITextAlignmentCenter
    font UIFont.fontWithName('Comis Sans', size: 24)
    text_color UIColor.whiteColor
    background_color UIColor.clearColor
  end

end
```

Nice, that should be pretty easy to follow, right?  Actually, according to
MotionKit's preferred code style, the layout code (`center superview.center`)
should be moved into the layout.  The reason is we want to be able to visualize
the view hierarchy AND placement in the layout.  You don't have to do things
this way, it's just a recommendation.

```ruby
class SimpleLayout < MotionKit::Layout

  def layout
    add UILabel, :simple_label do
      center superview.center
    end
  end
```

Mkay, in this next, more complicated layout we'll create a login page, with a
'Login' button and inputs for username and password.

```ruby
class LoginLayout < MotionKit::Layout
  include LoginStyles

  def layout
    # we know it's easy to add a subview, with a stylename...
    add UIImageView, :logo

    # but even better, pass the 'frame' in, too:
    add UIImageView, :logo, [[0, 0], [320, 568]]  # hardcoded dimensions!? no way

    # This frame argument will be handed to the 'MotionKit::Layout#frame'
    # method, which can accept lots of shorthands.  Let's use one to scale the
    # imageview so that it fills the width, and keeps its aspect ratio.
    add UIImageView, :logo, [[0, 0], ['100%', :scale]]
    # 'scale' uses sizeToFit and the other width/height property to keep the
    # aspect ratio the same. Neat, huh?

    add UIView, :button_container do
      # Like I said, the frame method is very powerful, there are lots of
      # ways it can help with laying out your rects, and it will even try to
      # apply the correct autoresizingMask for you
      frame from_bottom(height: 50, width: '100%')

      # same as above; assumes full width
      frame from_bottom(50)

      # like in Teacup, views added inside a block are added to that container.
      # you can reference the container with 'superview' or 'parent'. 'parent'
      # won't be an instance of a view, it's a special object that acts like a
      # placeholder for various values; if you want to assign any superview
      # property, use 'superview' instead.  'parent' is mostly useful for
      # setting the frame
      add UIButton, :login_button do
        frame [[ 10, 5 ], [ 50, parent.height - 10 ]]
        title 'Login'
      end
    end

    # 'container' is a generic view method, and will return 'UIView' on iOS and
    # 'NSView' on OS X.  Totally optional.
    add container, :inputs do
      frame [[0, 0], ['100%', '100% - 50']]
      # setting autoresizing_mask should handle rotation events
      autoresizing_mask :pin_to_top, :flexible_height, :flexible_width

      # we'll use 'sizeToFit' to calculate the height
      add text_field, :username_input, [[10, 10], ['100% - 10', :auto]]
      add text_field, :password_input, below(:username_input)
    end
  end
end
```


### Styles are compiled, simple, and clean

So simple, they're not even their own class!  This is just a "best practice"
recommendation.  In MotionKit, when you define a method that has the same name
as a view stylename with the suffix "_style", that method is called and is
expected to style that view. So why not put those methods in a module, and
include them in your layout! Sounds clean and organized to me! You can include
multiple stylesheets this way, just be careful around name collisions.

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
```

### Some handy tricks

```ruby
module AppStyles

  def rounded_button
    layer do
      cornerRadius 7
      masksToBounds true
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


## Goodbye Teacup
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
