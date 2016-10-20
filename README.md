# MotionKit

[![Join the chat at https://gitter.im/motion-kit/motion-kit](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/motion-kit/motion-kit?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Build Status](https://travis-ci.org/motion-kit/motion-kit.svg?branch=master)](https://travis-ci.org/motion-kit/motion-kit)
[![Version](https://badge.fury.io/rb/motion-kit.svg)](https://rubygems.org/gems/motion-kit)

*The RubyMotion layout and styling gem.*

1. Crossplatform compatibility: iOS, OSX, tvOS and planned support for Android
2. Simple, easy to learn DSL
3. Crossframework compatibility:
   - [UIKit][readmore-uikit]
   - [AppKit][readmore-appkit]
   - [AutoLayout][readmore-autolayout]
   - [Frame geometry][readmore-frames]
   - [CoreAnimation][readmore-coreanimation]
   - [NSMenu/NSMenuItem][readmore-nsmenu]
4. Easily extendable to support custom, mini-DSLs
5. Non-polluting
6. ProMotion/RMQ/SugarCube-compatible (kind of goes hand-in-hand with being non-polluting)
7. Styles and layouts are "just code" (not hash-based like in Teacup)
8. Written by [the authors][authors] of [ProMotion][] and [Teacup][]

[authors]: CONTRIBUTORS.yaml
[Colin]: https://github.com/colinta
[Jamon]: https://github.com/jamonholmgren
[ProMotion]: https://github.com/clearsightstudio/ProMotion
[RMQ]: https://github.com/infinitered/rmq
[Teacup]: https://github.com/rubymotion/teacup
[SweetKit]: https://github.com/rubymotion/sweet-kit

[READMORE]: https://github.com/rubymotion/motion-kit/blob/master/READMORE.md
[readmore-migrating]:      https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#migrating-from-teacup
[readmore-uikit]:          https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#uikit
[readmore-appkit]: https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#appkit
[readmore-coreanimation]:  https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#coreanimation
[readmore-frames]:         https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#frames
[readmore-autolayout]:     https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#autolayout
[readmore-nsmenu]:         https://github.com/rubymotion/motion-kit/blob/master/READMORE.md#nsmenu-os-x


## What happened to Teacup??

You can [read all about](#goodbye-teacup) why Colin decided that Teacup needed to
be replaced with a new project, rather than upgraded or refactored.

If you need to update your app to use MotionKit, see
[READMORE.md][readmore-migrating] for an example of migrating stylesheets,
styles, and constraints.


## Usage

In your Gemfile

```ruby
gem 'motion-kit'
```

From your controller you will instantiate a `MotionKit::Layout` instance, and
request views from it.  `layout.view` is the root view, and it's common to
assign this to `self.view` in your `loadView` method.  You'll also want to hook
up your instance variables, using `layout.get(:id)` or using instance variables.

```ruby
class LoginController < UIViewController
  def loadView
    @layout = LoginLayout.new
    self.view = @layout.view

    @button = @layout.get(:button)  # This will be created in our layout (below)
    @button = @layout.button  # Alternatively you can use instance variables and accessor methods
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
app.  But in a real application, you'll want to include a Stylesheet module so
your layout isn't cluttered with all your styling code.

Here's a layout that just puts a label and a button in the middle of the screen:

```ruby
class SimpleLayout < MotionKit::Layout
  # this is a special attr method that calls `layout` if the view hasn't been
  # created yet. So you can call `layout.button` before `layout.view` and you
  # won't get nil, and layout.view will be built.
  view :button

  def layout
    add UILabel, :label

    @button = add UIButton, :button
  end

  def label_style
    text 'Hi there! Welcome to MotionKit'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size_to_fit

    # note: there are better ways to set the center, see the frame helpers below
    center [CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds)]
    text_alignment NSTextAlignmentCenter
    text_color UIColor.whiteColor

    # if you prefer to use shorthands from another gem, you certainly can!
    background_color rmq.color.white  # from RMQ
    background_color :white.uicolor   # from SugarCube
  end

  def button_style
    # this will call 'setTitle(forState:)' via a UIButton helper
    title 'Press it!'
    size_to_fit

    # this shorthand is much better!  More about frame helpers below.
    center ['50%', '50% + 50']
  end

end
```

That's easy enough, right? In this next, more complicated layout, we'll
create a login page with a 'Login' button and inputs for username and password.
I will assign the frame in the `layout` method instead of in the `_style` methods.
This is purely an aesthetic choice. Some people like to have their frame code in
the `layout` method, others like to put it in the `*_style` methods.

```ruby
class LoginLayout < MotionKit::Layout
  # we write our `_style` methods in a module
  include LoginStyles

  def layout
    # we know it's easy to add a subview, with a stylename...
    add UIImageView, :logo

    # inside a block you can set properties on that view
    add UIImageView, :logo do
      frame [[0, 0], [320, 568]]
    end

    # you can set the size to fill horizontally and keep the aspect ratio
    add UIImageView, :logo do
      frame [[0, 0], ['100%', :scale]]
    end

    # many other examples here
    add UIView, :button_container do

      # Like I said, the frame method is very powerful. It will try to
      # apply the correct autoresizingMask for you; the from_bottom method will
      # set the UIAutoresizingMask to "FlexibleTop", and using '100%' in the
      # width will ensure the frame stays the width of its parent.
      frame from_bottom(height: 50, width: '100%')
      frame from_bottom(h: 50, w: '100%')  # is fine, too

      # same as above; assumes full width
      frame from_bottom(height: 50)

      # views added inside a block are added to that
      # container.  You can reference the container with 'superview', but then
      # you're working on the object directly, so no method translation (foo_bar
      # => fooBar) will be done for you.
      add UIButton, :login_button do
        background_color superview.backgroundColor

        # 'parent' is not instance of a view; it's a special object that
        # acts like a placeholder for various values. If you want to assign
        # *any* superview property, use 'superview' instead.  'parent' is mostly
        # useful for setting the frame.
        frame [[ 10, 5 ], [ 50, parent.height - 10 ]]
      end
    end

    add UIView, :inputs do
      frame x: 0, y: 0, width: '100%', height: '100% - 50'

      # setting autoresizing_mask should handle rotation events
      autoresizing_mask :pin_to_top, :flexible_height, :flexible_width

      # we'll use 'sizeToFit' to calculate the height
      add UITextField, :username_input do
        frame [[10, 10], ['100% - 10', :auto]]
      end
      add UITextField, :password_input do
        frame below(:username_input, down: 8)
      end
    end
  end
end
```


### Dynamically adding views

In MotionKit, it is easy to add views on the fly using the same API as used during layout. 
```ruby
def add_button style, button_title

  context get(:inputs) do #Two very useful methods for accessing/modifying previously added views
    add UIButton, :dynamic_button do 
      title button_title
      constraints do # if using autolayout
        ...
      end
    end
  end
end
```

During layout, z-order is determined by the sequence in which views are added to the hierarchy. You can control this dynamically by supplying :behind, :in_front_of, or :z_index options
```ruby
add UIImageView, :highlight_square, behind: get(:dynamic_button)
add UIImageView, :x_marks_the_spot, in_front_of: @selected_label 
add UILabel, :subterranian_marker, z_index: 4 #becomes the 4th view in the subview hierarchy
```


### Styles are compiled, simple, and clean

In MotionKit, when you define a method that has the same name as a view
stylename with the suffix "_style", that method is called and is expected to
style that view.

```ruby
class LoginLayout < MK::Layout

  def layout
    add UIImageView, :logo do
      # this can be moved into `logo_style` below:
      frame [[0, 0], ['100%', :scale]]
    end
    add UIView, :button_container
  end

  def logo_style
    frame [[0, 0], ['100%', :scale]]
    image UIImage.imageNamed('logo')
  end

  def button_container_style
    background_color UIColor.clearColor
  end

  # In case you're curious, the MK::Layout#initialize method takes no arguments.
  # Just be sure to call `super`
  def initialize
    super
    # ...
  end

end
```

So as an additional code-cleanup step, why not put those methods in a module,
and include them in your layout! Sounds clean and organized to me! You can
include multiple stylesheets this way, just be careful around name collisions.

```ruby
# app/styles/login_styles.rb
module LoginStyles

  def login_button_style
    # this example uses SugarCube to create UIColor and CGColor objects.
    background_color '#51A8E7'.uicolor
    title 'Log In'
    # `layer` returns a CALayer, which in turn becomes the new context inside
    # this block
    layer do
      corner_radius 7.0
      shadow_color '#000000'.cgcolor
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
    add UIButton, :login_button
    # ...
  end

end
```


### Using child-layouts

If you have a very complicated layout that you want to break up into child
layouts, that is supported as well:

```ruby
class ParentLayout < MK::Layout

  def layout
    add ChildLayout, :child_id
  end

end
```

The id is (as always) optional, but allows you to fetch the layout using
`get(id)`.

```ruby
layout.get(:child_id)  # => ChildLayout
```

Calling `get(:child_id).view` will return the *view* associated with that
layout.


### Setting a custom root view

If you need to use a custom root view, you can use the `root` method from within
the `layout` method.  When you create or assign the root view this way, you must
assign subviews and styles *inside* a block that you pass to `root`.

```ruby
def layout
  root(SomeOtherViewclass) do
    add UILabel
  end
end
```

You can also pass in a root view to your layout, like this:

```ruby
def loadView
  @layout = MyLayout.new(root: self.view).build
end
```

Make sure to call `.build`; otherwise, the layout will be returned but the view not built.

In this case, if you want to style the root view, just refer to it in your layout:

```ruby
def layout
  root :my_root_view do
    # ...
  end
end

def my_root_view_style
  background_color UIColor.grayColor
end
```

This is especially useful with collection views, table views, and table cells,
where you can assign a root view explicitly:

```ruby
return MyCellLayout.new(root: cell).build
```

Keep in mind that MotionKit will **not** retain a strong reference when you
provide a root view, so retain it yourself to prevent it from being
deallocated.

### How do styles get applied?

If you've used RMQ's Stylers, you'll recognize a very similar pattern here. In
RMQ the 'style' methods are handed a 'Styler' instance, which wraps access to
the view.  In MotionKit we make use of `method_missing` to call these methods
indirectly.  That takes care of most methods related to styling, but you might
want to write some "helper" methods so that your styling code is more concise.
Some examples are included in the MotionKit core, but the [SweetKit][] gem has
many more.  If you are writing helpers for UIKit or AppKit, please consider
adding them to SweetKit, so we can all share in the productivity boost! :smiley:

```ruby
  def login_label_style
    text 'Press me'  # this gets delegated to UILabel#text
  end

  # It's not hard to add extensions for common tasks, like setting the "normal"
  # title on a UIButton
  def login_button_style
    title 'Press me'
    # this gets delegated to UIButtonHelpers#title(title), which in turn calls
    # button.setTitle(title, forState: UIControlStateNormal)
    # See uibutton_helpers.rb for implementation.
  end
```

MotionKit offers shortcuts and mini-DSLs for frames, auto-layout, and
miscellaneous helpers.  But if a method is not defined, it is sent to the view
after a little introspection. If you call a method like `title_color value`, MotionKit
will try to call:

- `setTitle_color(value)`
- `title_color=(value)`
- `title_color(value)`
- (try again, converting to camelCase)
- `setTitleColor(value)`
- `titleColor=(value)`
- `titleColor(value)`
- (failure:) `raise NoMethodError`

```ruby
  def login_button_style
    background_color UIColor.clearColor  # this gets converted to `self.target.backgroundColor = ...`
  end
```

Introspection and method_missing add a little overhead to your code, but in our
benchmarking it is insignificant and undetectable. Let us know if you find any
performance issues.

You can easily add your own helpers to MotionKit. They
should all be named consistenly, e.g. `MotionKit::UIViewHelpers`,
`MotionKit::UILabelHelpers`, etc.  You just need to specify the "target class" that
your helper class is meant to work with.  Each class can only have *one helper
class*.

```ruby
module MotionKit
  # these helpers will only be applied to instances of UILabel and UILabel
  # subclasses
  class UILabelHelpers < UIViewHelpers
    targets UILabel

    # style methods can accept any number of arguments, and a block. The current
    # view should be referred to via the method `target`
    def color(color)
      target.textColor = color
    end

    # If a block is passed it is your responsibility to call `context(val, &block)`
    # if that is appropriate.  I'll use `UIView#layer` as an example,
    # but actually if you pass a block to a method that returns an object, that
    # block will be called with that object as the context.
    def layer(&block)
      context(target.layer, &block)
    end

    # Sure, you can add flow-control mechanisms if that's your thing!
    #
    # You can use the block to conditionally call code; on iOS there are
    # orientation helpers `portrait`, `landscape`, etc that apply styles based
    # on the current orientation.
    def sometimes(&block)
      if rand > 0.5
        yield
      end
    end

  end
end
```

### Adding your own helper methods

For your own custom classes, or when you want to write
helper methods for a built-in class, you will need to write a class that
"`targets`" that class.  This will be a subclass of `MK::UIViewHelpers`; it looks
and *feels* like a `MK::Layout` subclass, but these classes are used to extend
the MotionKit DSL, and should not be instantiated or used to build layouts.

Again, to be clear: you should be subclassing `MK::Layout` when you build your
controller layouts, and you should write a subclass of `MK::UIViewHelpers` *only*
when you are adding extensions to the MotionKit DSL.

```ruby
# Be sure to extend an existing Helpers class, otherwise you'll lose a lot of
# functionality.  Often this will be `MK::UIViewHelpers` on iOS and
# `MK::NSViewHelpers` on OS X.
class CustomViewHelpers < MK::UIViewHelpers
  targets CustomView

  def fore_color(value)
    target.foregroundColor = value
  end

end
```

### Even more information...

...is in the [READMORE][] document.  I re-explain some of these topics, go into
some more detail, that kinda thing.  Basically an overflow document for topics I
don't want to stuff into the README.


## MotionKit extensions

These are all built-in, unless otherwise specified.

### Frames

There are lots of frame helpers for NSView and UIView subclasses.  It's cool
that you can set position and sizes as percents, but scroll down to see examples
of setting frames *based on any other view*.  These are super useful!  Most of
the ideas, method names, and some code came straight out of
[geomotion](https://github.com/clayallsopp/geomotion).  It's not *quite as
powerful* as geomotion, but it's close!

One advantage over geomotion is that many of these frame helpers accept a view
or view name, so that you can place the view relative to that view.

```ruby
# most direct way to set the frame, using pt values
frame [[0, 0], [320, 568]]

# using sizes relative to superview
frame [[5, 5], ['100% - 10pt', '100% - 10pt']]
# the 'pt' suffix is optional, and ignored.  in the future we could add support
# for other suffixes - would that even be useful?  probably not...

# other available methods:
origin [5, 5]
x 5  # aka left(..)
right 5  # right side of the view is 5px from the left side of the superview
bottom 5  # bottom of the view is 5px from the top of the superview
size ['100% - 10', '100% - 10']
width '100% - 10'  # aka w(...)
height '100% - 10'  # aka h(...)

size ['90%', '90%']
center ['50%', '50%']

########
# +--------------------------------------------------+
# |from_top_left       from_top        from_top_right|
# |                                                  |
# |from_left          from_center          from_right|
# |                                                  |
# |from_bottom_left   from_bottom   from_bottom_right|
# +--------------------------------------------------+
```

You can position the view *relative to other views*, either the superview or any
other view.  You must pass the return value to `frame`.

```ruby
# If you don't specify a view to base off of, the view is positioned relative to
# the superview:
frame from_bottom_right(size: [100, 100])  # 100x100 in the BR corner
frame from_bottom(size: ['100%', 32])  # full width, 32pt height
frame from_top_right(left: 5)

# But if you pass a view or symbol as the first arg, the position will be
# relative to that view
from_top_right(:info_container, left: 5)


########
#          above
#          +---+
#  left_of |   | right_of
# (before) |   | (after)
#          +---+
#          below

# these methods *require* another view.
frame above(:foo, up: 8)

frame above(:foo, up: 8)
frame before(:foo, left: 8)
frame relative_to(:foo, down: 5, right: 5)

# it's not common, but you can also pass a view to any of these methods
foo = self.get(:foo)
frame from_bottom_left(foo, up: 5, left: 5)
```


### Autoresizing mask

You can pass symbols like `autoresizing_mask :flexible_width`, or use
symbols that have more intuitive meaning than the usual
`UIViewAutoresizingFlexible*` constants.  These work in iOS and OS X.

All of the `:pin_to_` shorthands have a fixed size, whereas the `:fill_`
shorthands have flexible size.

```ruby
# the :fill shorthands will get you a ton of mileage
autoresizing_mask :fill_top
# but if you want the size to stay constant, use :pin_to
autoresizing_mask :pin_to_bottom
# or, a list of flexible sides
autoresizing_mask :flexible_right, :flexible_bottom, :flexible_width
# or, combine them in some crazy fancy way
autoresizing_mask :pin_to_left, :rigid_top  # 'rigid' undoes a 'flexible' setting

flexible_left:       Sticks to the right side
flexible_width:      Width varies with parent
flexible_right:      Sticks to the left side
flexible_top:        Sticks to the bottom
flexible_height:     Height varies with parent
flexible_bottom:     Sticks to the top

rigid_left:          Left side stays constant (undoes :flexible_left)
rigid_width:         Width stays constant (undoes :flexible_width)
rigid_right:         Right side stays constant (undoes :flexible_right)
rigid_top:           Top stays constant (undoes :flexible_top)
rigid_height:        Height stays constant (undoes :flexible_height)
rigid_bottom:        Bottom stays constant (undoes :flexible_bottom)

fill:                The size increases with an increase in parent size
fill_top:            Width varies with parent and view sticks to the top
fill_bottom:         Width varies with parent and view sticks to the bottom
fill_left:           Height varies with parent and view sticks to the left
fill_right:          Height varies with parent and view sticks to the right

pin_to_top_left:     View stays in top-left corner, size does not change.
pin_to_top:          View stays in top-center, size does not change.
pin_to_top_right:    View stays in top-right corner, size does not change.
pin_to_left:         View stays centered on the left, size does not change.
pin_to_center:       View stays centered, size does not change.
pin_to_right:        View stays centered on the right, size does not change.
pin_to_bottom_left:  View stays in bottom-left corner, size does not change.
pin_to_bottom:       View stays in bottom-center, size does not change.
pin_to_bottom_right: View stays in bottom-right corner, size does not change.
```


### Constraints / Auto Layout

Inside a `constraints` block you can use similar helpers as above, but you'll
be using Cocoa's Auto Layout system instead.  This is the recommended way to set
your frames, now that Apple is introducing multiple display sizes.  But beware,
Auto Layout can be frustrating... :-/

Here are some examples to get started:

```ruby
constraints do
  top_left x: 5, y: 10
  # the MotionKit::Constraint class has lots of aliases and "smart" methods,
  # so you can write very literate code:
  top_left.equals([5, 10])
  top_left.is([5, 10])
  top_left.is.equal_to(x: 5, y: 10)
  top_left.is == { x: 5, y: 10 }
  top_left.is >= { x: 5, y: 10 }
  top_left.is <= { x: 5, y: 10 }

  # this is all the same as setting these two constraints:
  x 5   # aka `left 5`
  y 10  # aka `top 10`

  # You can have multiple constraints on the same property, and if the
  # priorities are set appropriately you can easily have minimum margins,
  # minimum widths, that kind of thing:
  x.is.at_least(10).priority(:required)
  x.is(15).priority(:low)
  width.is.at_least(100).priority(:required)
  width.is(150).priority(:low)

  # using the `Constraint#is` method you can even use ==, <= and >=
  x.is >= 10
  x.is == 15

  # setting the priority:
  (x.is >= 10).priority(:required)
  (x.is == 15).priority(:low)
  # setting the identifier
  x.equals(15).identifier('foo')
end
```

But of course with AutoLayout you set up *relationships* between views. Using
the element-id as a placeholder for a view works especially well here.

```ruby
constraints do
  top_left.equals x: 5, y: 5     # this sets the origin relative to the superview
  top_left.equals(:superview).plus([5, 5])  # this will do the same thing!

  width.equals(:foo).minus(10)  # searches for a view named :foo
  height.equals(:foo).minus(10)
  # that's repetitive, so just set 'size'
  size.equals(:foo).minus(10)
  size.equals(:foo).minus([10, 15])  # 10pt thinner, 15pt shorter

  # if you are using a view that has a sensible intrinsic size, like an image,
  # you can use :scale to have the width or height adjusted according to the
  # other size
  width.equals(:superview)
  height(:scale)  # scale the height according to the width
end
```

Just like with frame helpers you can use the `:element_id` to refer to another
view, but get this: the view need not be created yet!  This is because when you
setup a constraints block, it isn't resolved immediately; the symbols are
resolved at the end.  This feature uses the `deferred` method behind the scenes
to accomplish this.

```ruby
add UIView, :foo do
  constraints do
    width.equals(:bar).plus(10)  # :bar has not been added yet!
  end
end

add UIView, :bar do
  constraints do
    width.equals(:foo).minus(10)
    width.equals(100).minus(10)
    # believe it or not, this ^ code works!  AutoLayout is a strange beast; it's
    # not an "imperative" system, it solves a system of equations.  In this
    # case, :bar will have width 110, and :foo will have width 100, because
    # those values solve these equations:
    #     foo.width = 100
    #     foo.width = bar.width - 10
    #     foo.width = bar.width + 10
    # If you have constraints that conflict you'll get error messages or
    # nonsensical values.

    # There are helpers that act as placeholders for views, if you have multiple
    # views with the same name:
    #     first, last, nth
    width.equals(last(:foo))
    width.equals(first(:foo))
    width.equals(nth(:foo, 5))
  end
end
```

One common use case is to use a child layout to create many instances of the
same layout that repeat, for instance a "row" of content.  In this case you will
probably have many views with the same id, and you will not know the index of
the container view that you want to add constraints to.  In this situation, use
the `nearest`, `prev` or `next` method to find a container, sibling, or
child view.

`prev` and `next` are easy; they just search for a sibling view.  No
superviews or subviews are searched.

`nearest` will search child views, siblings, and superviews, in that order.  The
"distance" is calculated as such:

- the current view
- subviews
- siblings
- superview
- superview's siblings, or a child of the sibling (depth-first search)
- continue up the tree

See the AutoLayout sample app for an example of this usage.

```ruby
items.each do |item|
  add UIView, :row do
    add UIImageView, :avatar
    add UILabel, :title
  end
end

def title_style
  constraints do
    # center the view vertically
    center.equals(nearest(:row))
    # and place it to the right of the :avatar
    left.equals(nearest(:avatar), :right).plus(8)
    right.equals(nearest(:row)).minus(8)
  end
end
```

One pain point in working with constraints is determining when to add them to
your views.  We tried really hard to figure out a way to automatically add them,
but it's just an untenable problem (Teacup suffers from a similar conundrum).

Essentially, the problem comes down to this: you will often want to set
constraints that are related to the view controller's `view`, but those must be
created/set *after* `controller.view = @layout.view`.  Without doing some crazy
method mangling on NS/UIView we just can't do this automatically

Long story short: If you need to create constraints that refer to the controller
view, you need to use a separate method that is called after the view hierarchy
is created.

```ruby
class MainLayout < MK::Layout

  def layout
    add UILabel, :label do
      constraints do
        x 0
        width('100%')
      end
    end
  end

  # You should call this method from `UIViewController#updateViewConstraints`
  # and pass in your controller
  def add_constraints(controller)
    # guard against adding these constraints more than once
    unless @layout_constraints_added
      @layout_constraints_added = true
      constraints(:label) do
        top.equals(controller.topLayoutGuide)
      end
    end
  end

end

class MainController < UIViewController

  def loadView
    @layout = MainLayout.new
    self.view = @layout.view
  end

  # for the constraints to work reliably they should be added in this method:
  def updateViewConstraints
    @layout.add_constraints(self)
    super
  end

end
```

#### Animating and Changing constraints

It might feel natural to treat constraints as "frame setters", but they are
persistent objects that are attached to your views.  This means if you create
new constraints, like during a screen rotation, your old constraints don't “go
away”.  For example:

```ruby
def label_style
  portrait do
    left 10
  end

  landscape do
    left 15  # adds *another* constraint on the left attribute - in addition to the `left 10` constraint!
  end
end
```

Instead, you should retain the constraint and make changes to it directly:

```ruby
  constraints do
    @label_left_constraint = left 10
  end

  # reapply blocks are called via the Layout#reapply! method.
  reapply do
    portrait do
      @label_left_constraint.equals 10
    end

    landscape do
      @label_left_constraint.equals 15
    end
  end
```

If you want to animate a constraint change, you can use `layoutIfNeeded` from
within a UIView animation block.  The sample app "Chatty" does this to move a
text field when the keyboard is displayed.  `kbd_height` is the height of the
keyboard.

```ruby
@container_bottom.minus kbd_height  # set @container_bottom.constant = 0 when the keyboard disappears

UIView.animateWithDuration(duration, delay: 0, options: curve, animations: -> do
  self.view.layoutIfNeeded  # applies the constraint change
end, completion: nil)
```

You can also activate/deactivate constraints selectively, and animate the
transitions between them.

```ruby
class MyLayout < MK::Layout

  def layout
    add UIButton, :my_button do
      constraints do
        @top_constraint = top.equals(:superview, :bottom)
        @bottom_constraint = bottom.equals(:superview).deactivate
        left.equals(:superview)
        right.equals(:superview)
        height 48
      end
  end

  def show_button
    @top_constraint.deactivate
    @bottom_constraint.activate
    UIView.animateWithDuration(0.3, animations: -> do
      self.view.layoutIfNeeded
    end)
  end

  def hide_button
    @bottom_constraint.deactivate
    @top_constraint.activate
    UIView.animateWithDuration(0.3, animations: -> do
      self.view.layoutIfNeeded
    end)
  end

end
```

### MotionKit::Events

    gem install motion-kit-events

Adds `on :event` and `trigger :event` methods to `MK::Layout` objects.  These
can be used to send events from the Layout to your controller, further
simplifying the controller code (and usually making it more testable).  See the
[MotionKit::Events documentation][motion-kit-events] for more information.

[motion-kit-events]: https://github.com/rubymotion/motion-kit-events


### MotionKit::Templates

    gem install motion-kit-templates

Adds project templates, for use with `motion create`.

    motion create foo --template=mk-ios
    motion create foo --template=mk-osx


## Some handy tricks and Features

### Orientation specific styles

These are available on iOS.

```ruby
add UIView, :container do
  portrait do
    frame from_top(width: '100%', height: 100)
  end
  landscape do
    frame from_top_left(width: 300, height: 100)
  end
end
```

### Update views via 'always', 'reapply', and 'deferred'

In your style methods, you can register blocks that get called during
"restyling", which is usually triggered by a rotation change (though, if you're
making good use of autoresizingMask or AutoLayout constraints, you should not
have to do this, right?).

It's important to note that the style methods are not actually called again. The
blocks are retained on the view, along with the "context", and calling
`reapply!` calls all those blocks with the context set as you'd expect.

If you have code that you want to be called during initialization *and* during
reapply, use the `always` helper:

```ruby
def login_button_style
  # only once, when the layout is first being created
  title 'initial title'

  # only during reapply
  reapply do
    title 'something happened!'
  end

  # applied every time
  always do
    title 'You win!'
  end
end
```

Or, you might need to set a frame or other property based on a view that hasn't
been created yet. In this case, you can use `deferred` to have a block of code
run after the current layout is completed.

```ruby
def login_button_style
  deferred do
    frame below(last(:label), height: 20)
  end
end
```


### Apply styles via module

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

### Using SweetKit

The [SweetKit][] gem combines MotionKit and SugarCube.  The helpers it provides
allow for even more expressiveness, for instance:

```ruby
add UITextField do
  return_key_type :email
  text_alignment :right
end
```

The OS X helpers are really nice, because it tries to hide most of the
annoying subtletees of the NSCell/NSControl dichotomy.

    gem install sweet-kit


# Gotchas

### A Note on `add` and `remove`

When you use the `add` method to add a subview, that view will be retained by
the Layout *even if you remove it from the view hierarchy*.  If you want the
Layout to forget all about the view, call `remove(view)` (which also calls
`removeFromSuperview`) or `forget(element_id)` (which only removes it from the
Layout) on the Layout.

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
controller file.  This needed to be fixed.

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
project, too; it does not extend any base classes, so it's completely opt-in.

Unlike Teacup, you won't have your styles reapplied due to orientation changes,
but it's *really* easy to set that up, as you'll see.  Or, use AutoLayout (the
DSL is better than Teacup's, I think) and you'll get orientation changes for
free!

Big thanks to everyone who contributed on this project!  I hope it serves you
as well as Teacup, and for even longer into the future.

Sincerely,

Colin T.A. Gray
Feb 13, 2014
