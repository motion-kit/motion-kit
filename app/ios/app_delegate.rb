class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    p Foo.style
    p Foo.style.login_button
    true
  end
end


class Styler

  def method_missing(method_name, *args)
    NSLog('styling %@', method_name)
  end

end


class Foo
  def self.style
    @style ||= Styler.new
  end

  def style.login_button
    'hi!'
  end

end
