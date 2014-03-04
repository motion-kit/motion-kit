# MotionKit

*The RubyMotion layout and styling gem.*

## How it all works

You can think of MotionKit as a framework to build and customize tree
structures. `UIView` hierarchies are a tree structure, and of course so is
`NSView`.  Also `CALayer` and the combination of `NSMenu/NSMenuItem`.  And how
about Joybox/SpriteKit's combination of scenes and nodes?  For sure!

To build your tree structure, you will use the primitive `add` method. This
method delegates the actual "adding" of the view to the layout subclass via the
`add_child` method.  The `add` method may also instantiate the object,
initialize it, and if a block is passed, it will set it up as the new context.

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

You can *only* call root from inside the `layout` method, you can only call it
once, and you must call it before any views are added. You do not need to
specify the type of view if you just want to assign an element_id. The
`default_root` view will be created in that case.

```ruby
def layout
  root(:root) do
    # ...
  end
end
```


## UIKit

Most of the [README][] is dedicated to examples for iOS/UIKit, so please read
that first to see how MotionKit can help you organize you `UIView` code. Then
[read below](#coreanimation) to see how it can help your `CALayer` code, too!

## ApplicationKit

MotionKit can create view hierarchies as a window (`MK::WindowLayout`) or as a
view (`MK::Layout`).  You'll get a lot of mileage out of the `MK::WindowLayout`,
but if you are embedding a complicated `NSView`, you might break it out into its
own `NSViewController/NSView` pair, and use `MK::Layout` to create that view.

When you are building a window frame, you should make heavy use of
`NSWindow#setFrameAutosaveName`. To help, MotionKit allows you to pass an
identifier to the `frame` helper as the second argument, and it will use that
value as the `frameAutosaveName`

```ruby
def window_style
  frame [[10, 10], [100, 100]], 'main_window'
  # or you can call the 'frameAutosaveName' method your self, be sure to call it
  # *after* you call 'frame'
  frame_autosave_name 'main_window'
end
```

## NSMenu

Building menus with MotionKit is a total breeze, and it can even assist in
creating menus with changing content. Only available on OS X.

```ruby
class MainMenu < MK::MenuLayout

  def layout
    add app_menu  # oh yeah, there's a helper for that!

    add 'File' do
      add 'New', key: 'n', action: 'new:'
      add 'Open', key: 'o', action: 'open:'

      # lots of helpers, actually:
      add new_item
      add open_item
      add separator_item
      # you can pass in options like title, key, action
      add close_item(title: 'Close', key: 'w', action: 'performClose:')
      add save_item
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

## CoreAnimation

Not much to see here, really, but know that you can create hierarchies of
`CALayer` objects.

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
    # ...
  end

end
```

## SpriteKit

*TODO*

## Joybox

*TODO*

[README]: https://github.com/rubymotion/motion-kit/blob/master/README.md
