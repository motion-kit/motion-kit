# MotionKit

*The RubyMotion layout and styling gem.*

## How it all works

You can think of MotionKit as a framework that makes it easy to:

- apply methods to objects
- provide DSLs to facilitate common usage
- build and customize tree structures.

`UIView` hierarchies are a tree structure, and of course so is `NSView`.  Also
`CALayer` and the combination of `NSMenu/NSMenuItem`.  But MotionKit can be used
on non-hierarchical systems as well, for instance there are helpers for
`NSTableColumn`.

To build your tree structure, you will use the primitive `add` method. This
method delegates the actual adding of the view to the layout subclass via the
`add_child` method.  The `add` method may also instantiate the object,
initialize it, and if a block is passed, it will set it up as the new context
and then execute the block.

There are a few other primitives: `create` is called from `add` to instantiate
the object, and it has the responsibility of calling the `_style` method. If a
block is passed, it will be executed in the context of the new object.

If you are creating a layout in the `def layout` method you might want to
specify or modify the `root` object. You can!

```ruby
def layout
  root(UIView, :root) do
    add UILabel, :label
  end
end
```

You can *only* call root from inside the `layout` method, and you can only call
it once, and you must call it before any views are added. You do not need to
specify the type of view if you just want to assign an element_id. The
`default_root` view will be created in that case.

```ruby
def layout
  root(:root) do
    # ...
  end
end
```


--------------------------------------------------------------------------------


## Migrating from Teacup

MotionKit is meant to replace Teacup, so you’ll find a lot of familiar features.
 First and foremost, both MotionKit and Teacup are supposed to help you build
 view hierarchies and style views.  Some differences are:

- Teacup implemented its own logic for extending styles and importing
  stylesheets.  With MotionKit, it’s plain ol’ Ruby classes.
- Teacup focused on just two things: adding and styling views.  MotionKit adds
  to that the *management* of views, ie animation and user interaction.
- Teacup added methods to `UIView` and `UIViewController` to assist in creating
  the view hierarchy.  MotionKit is opt-in only, and so is non-polluting.
- Constraints in Teacup were a little awkward.  They are similar-yet-nicer in MotionKit.

As an example we will convert a simple "Login" screen from Teacup to MotionKit.

```ruby
class LoginController < UIViewController
  stylesheet :login_controller

  layout do
    add UILabel, :username_label
    add UITextField, :username_field

    add UILabel, :password_label
    add UITextField, :password_field

    add UIButton, :submit
  end

end


Teacup::Stylesheet.new(:app_styles) do
  style :label,
    font: UIFont.fontWithName('Helvetica Neue', size: 30),
    textAlignment: NSTextAlignmentLeft
end


Teacup::Stylesheet.new(:login_controller) do
  import :app_styles

  style :username_label, extends: :label,
    text: 'Username',
    constraints: [
      constrain_top.equals(:superview).plus(10),
      constrain_left.equals(:superview),
      constrain_width.equals(80),
      constrain_height.equals(40),
    ]

  style :password_label, extends: :label,
    text: 'Password',
    constraints: [
      constrain_top.equals(:username_label, :bottom).plus(10),
      constrain_left.equals(:superview),
      constrain_width.equals(80),
      constrain_height.equals(40),
    ]

  style :submit,
    title: 'Submit',
    constraints: [
      constraint_bottom.equals(:superview),
      constraint_right.equals(:superview).minus(8)
    ]
end
```

###### Here’s a straightforward port to MotionKit

```ruby
class LoginController < UIViewController

  def viewDidLoad
    super

    @layout = LoginLayout.new(root: self.view)
    @layout.build
  end

end


module AppStyles

  def apply_label_styles
    font UIFont.fontWithName('Helvetica Neue', size: 30)
    text_alignment NSTextAlignmentLeft
  end

end


class LoginLayout < MK::Layout
  include AppStyles

  def layout
    add UILabel, :username_label
    add UITextField, :username_field

    add UILabel, :password_label
    add UITextField, :password_field

    add UIButton, :submit
  end

  def username_label_style
    apply_label_styles

    text 'Username'
    constraints do
      top.equals(:superview).plus(10)
      left.equals(:superview)
      width.equals(80)
      height.equals(40)
    end
  end

  def password_label_style
    apply_label_styles

    text 'Password'
    constraints do
      top.equals(:username_label, :bottom).plus(10)
      left.equals(:superview)
      width.equals(80)
      height.equals(40)
    end
  end

  def submit_style
    title 'Submit'
    constraints do
      bottom.equals(:superview)
      right.equals(:superview).minus(8)
    end
  end

end
```


--------------------------------------------------------------------------------


## UIKit

Most of the [README][] is dedicated to examples for iOS/UIKit, so please read
that first to see how MotionKit can help you organize you `UIView` code. Then
[read below](#coreanimation) to see how it can help your `CALayer` code, too!

Here are some helpers that come with MotionKit.  These are meant to be
*examples* of what can be done with MotionKit helpers, not an exhaustive set of
helpers.  For that, check out the [SweetKit][] gem.

### UIView

```ruby
gradient do
  colors [UIColor.whiteColor, UIColor.startColor]
  start_point [0, 0]
  end_point [1, 1]
end
```

### UIButton

```ruby
title 'Button title'
title 'Button title', state: UIControlStateHighlighted
# these all accept a `:state` option
title_shadow UIColor.blackColor
image UIImage.new
background_image UIImage.new, state: UIControlStateDisabled
```

--------------------------------------------------------------------------------


## ApplicationKit

MotionKit can create view hierarchies inside a window (`MK::WindowLayout`) or a
view (`MK::Layout`).  You'll get a lot of mileage out of the `MK::WindowLayout`,
but if you are embedding a complicated `NSView`, you might break it out into its
own `NSViewController/NSView` pair, and use `MK::Layout` to create your UI.

When you are building a window for OS X, you will make heavy use of
`NSWindow#setFrameAutosaveName`. To help, MotionKit allows you to pass an
identifier to the `frame` helper as the second argument, and it will use that
value as the `frameAutosaveName`

```ruby
def window_style
  frame [[10, 10], [100, 100]], :main_window
  # or you can call the 'frameAutosaveName' method yourself. be sure to call it
  # *after* you call 'frame'
  frame_autosave_name :main_window
end
```


--------------------------------------------------------------------------------


## AutoLayout

Since we don't have Interface Builder to help us create constraints (and since
the ASCII format leaves much to be desired), many RubyMotion developers never
bother to start using AutoLayout.  But with the number of resolutions always
increasing, it's a good idea to start learning them.  They are here to stay!

You can use MotionKit's AutoLayout DSL in iOS and OS X, and they work
identically.  First, you start a constraints block:

```ruby
constraints do
  # constraint helpers go here
end
```

And here is the complete list of methods available:

| Selecting a view  |
| ----------------- |
| `first`           |
| `last`            |
| `nth`             |

| left / x   | center x       | right       |
| ---------- | :------------: | ----------: |
| `left`     | `center_x`     | `right`     |
| `min_left` | `min_center_x` | `min_right` |
| `max_left` | `max_center_x` | `max_right` |

| leading        | trailing       | baseline       |
| -------------- | -------------- | -------------- |
| `leading`      | `trailing`     | `baseline`     |
| `min_leading`  | `min_trailing` | `min_baseline` |
| `max_leading`  | `max_trailing` | `max_baseline` |

| top / y    | center y       | bottom      |
| ---------- | :------------: | ----------: |
| `top`      | `center_y`     | `bottom`    |
| `min_top`  | `min_center_y` | `min_bottom`|
| `max_top`  | `max_center_y` | `max_bottom`|

| width       | height       |
| ----------- | ------------ |
| `width`     | `height`     |
| `min_width` | `min_height` |
| `max_width` | `max_height` |

| size       | center       |
| ---------- | ------------ |
| `size`     | center       |
| `min_size` | min_center   |
| `max_size` | max_center   |

| corner         |
| -------------- |
| `top_left`     |
| `top_right`    |
| `bottom_left`  |
| `bottom_right` |

| relative location |
| ----------------- |
| `above`           |
| `below`           |
| `before`          |
| `after`           |

Dang, that's a lot of methods... OK, so each of these methods returns a special
`MK::Constraints` object, and you can set up constraints using relationships
like `equals`, `is ==`, `is_less_than`, `is_at_least` along with constants or
other views.  They look like this:

```ruby
constraints do
  min_left.is 8
  min_top.is 8
  left.equals(:another_view, :right).plus(8)  # my left side is 8 pixels to the right of another_view's right side
  width.equals(:superview).times(0.5)
  height.is == 30  # you have to use `is` here
  center.equals(:superview)
  size.equals(:superview).times(0.5)

  bottom_right.equals(:superview).minus(8)
  # and so on!
end
```

--------------------------------------------------------------------------------

## Frames

If AutoLayout wasn't dizzying enough, there is also an entire suite of frame
calculation helpers.  These are just as expressive, but order matters here
because if you want to make calculations on a view that hasn't been instantiated
yet, you'll need to use a `deferred` block.  This requirement is not placed on
constraints (they use `deferred` automatically).

First, you can set an individual side or dimension:

```ruby
left 10
right 300 # make sure to set the width *first*; this sets `frame.origin.x`
center_x 160
```

With these frame helpers you can make calculations based on the *relative size*
of the superview.  The format is `"x% [+=] y"`.  There are also helpers for
`center, size, origin`, and these can take calculation values as well.

```ruby
width '100% - 16',
height 16
left 8
center ['50%', '50%']
size ['100%', '100%']
frame [[8, '100% - 28'], ['100% - 16', 20]]
```

The `size, width, height` helpers accepts special values `:auto` and `:scale`.
`:auto` indicates that the intrinsic size should be used (or 0 if there is no
intrinsic size), and `:scale` uses a combination of the intrinsic size and the
*other dimension* to calculate a *scaled* value.  For instance, if we have an
image that is 1600x1000 and we do the following:

```ruby
width 320
height :scale
```

Then the height will be `320 / 1600 * 1000 = 200`.

The really *cool* methods are the frame calculation helpers.  Notice we set the
return value of these methods to the `frame` method.  These expect a hash.

These methods place your view in a corner or along a side.  The hash you pass
will *move* them from this location.  So in this context `right` no longer
refers to the "right side" of your view, it means "move the view to the right".

```ruby
frame from_bottom_left(up: 8, right: 8, size: ['100% - 16', 20])
```

The methods that are relative to a corner assume that the calculations should
be based on the superview, but you can pass a view (or view name) as the first
argument and the frame will be set relative to that view.

Here are the available methods:

| corner              | side     |
| ------------------- | -------- |
| `from_top_left`     | `above`  |
| `from_top`          | `below`  |
| `from_top_right`    | `before` |
| `from_left`         | `after`  |
| `from_center`       |
| `from_right`        |
| `from_bottom_left`  | general purpose
| `from_bottom`       | ---------------
| `from_bottom_right` | `relative_to`

--------------------------------------------------------------------------------


## NSMenu (OS X)

Building menus with MotionKit is a total breeze, and it can even assist in
creating menus with changing content. Only available on OS X.

```ruby
class MainMenu < MK::MenuLayout

  def layout
    add app_menu  # oh yeah, there's a helper for that!

    # create a menu w/ submenus by passing a block
    add 'File' do
      # you'll need a title, and probably an action, and optionally a shortcut key
      add 'New', key: 'n', action: 'new:'
      add 'Open', key: 'o', action: 'open:'
      # if you need to add a custom key mask you can do that, too
      add 'Export', key: 'e', mask: NSCommandKeyMask | NSAlternateKeyMask, action: 'export:'

      # there are lots of helpers, actually:
      add new_item
      add open_item
      add separator_item
      # you can pass in options like title, key, action
      add close_item(title: 'Close', key: 'w', action: 'performClose:')
      add save_item
      add save_as_item
      add revert_to_save_item
      add separator_item
      add page_setup_item
      add print_item
    end

    add 'Format' do
      add 'Font' do
        add item('Show Fonts', action: 'orderFrontFontPanel:', keyEquivalent: 't')
        add item('Bold', action: 'addFontTrait:', keyEquivalent: 'b')
        add item('Italic', action: 'addFontTrait:', keyEquivalent: 'i')
        # ...
        add item('Smaller', action: 'modifyFont:', keyEquivalent: '-')
      end

      add 'Text' do
        add item('Align Left', action: 'alignLeft:', keyEquivalent: '{')
        add item('Center', action: 'alignCenter:', keyEquivalent: '|')
        add item('Justify', action: 'alignJustified:', keyEquivalent: '')
        # ...
        item = add item('Paste Ruler', action: 'pasteRuler:', keyEquivalent: 'v')
        item.keyEquivalentModifierMask = NSCommandKeyMask|NSControlKeyMask
      end
    end
  end

end
```


--------------------------------------------------------------------------------


## CoreAnimation

Not much to see here, but know that you can create hierarchies of `CALayer`
objects.

```ruby
class MainLayout < MK::Layout

  def layout
    # start simple enough
    add UIView, :container do
      # open up the 'layer' for editing
      layer do
        # and add a CAGradientLayer to it!
        add CAGradientLayer, :gradient
      end
    end
  end

  def gradient_style
    # there is a CAGradientLayer helper that accepts an array of UIColors (or NSColors on OS X)
    colors [UIColor.whiteColor, UIColor.blackColor]
  end

end
```


[README]: https://github.com/rubymotion/motion-kit/blob/master/README.md
[SweetKit]: https://github.com/rubymotion/sweet-kit/blob/master/README.md
