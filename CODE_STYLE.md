# Code style
###### by colinta

We're not TOO picky here, but a few guidelines:

### Code

- one space after ',' and ':' in an argument list:

  ```ruby
  foo(a, b, c)
  [[1, 2], [3, 4]]
  do_something(arg1, with: arg2)
  ```

- One blank line between `class, module, def, end` keywords, with the exception
  of placing a class definition directly inside a module.

  *Two* blank lines between class definitions, though please consider whether
  making a separate file is appropriate.

  Example:
  ```ruby
  module MotionKit
    class Foo

      class << self

        def bar
          # ...
        end

      end

      def hi!
        'hello!'
      end

    end


    class Bar
      # ...
    end
  end
  ```
- In *most* cases you should use `do..end` over `{ ... }`.  The exception is
  when you have a VERY short one line block.
- Avoid using `statement if @condition`; while they benefit from readability,
  they suffer when you need to parse code quickly later. It's easier for others
  to read:
  ```ruby
  if @condition
    statement
  end
  ```
- You don't HAVE to truncate lines to 80 characters, but fancy shmansy
  one-liners are only clever in the short term. In the long term they are harder
  to maintain. Break it up into smaller chunks.
- Write small methods, don't write big behemoths. Method names are some of the
  BEST documentation, and they encourage good, isolated code.

### Comments

When writing comments, focus on *why* the code works a certain way, rather than
describing *what* the code is doing. We should be able to read the code and see
what it is doing (if we can't, there might be an issue there), but we might need
to be reminded why there is a certain order-of-operations (for instance, if a
method has a side-effect that we need to be careful around)

#### Comment Styles

- They should be on their own line, preceding the code.
- They should have a space after the hash, e.g. `# isn't this nice?`
- If you want to mark a large section of code, use these adornments:

  ```ruby
  ##|
  ##|  Section Title
  ##|
  ```

### We reserve the right...

...to refactor your code. We will make every attempt to keep the spirit of the
code intact, but please don't be prideful if we change variable names or
something trivial like that. We're just trying to keep the code consistent,
that's all! :-)
