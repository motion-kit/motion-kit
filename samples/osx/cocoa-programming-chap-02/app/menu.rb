class MainMenu < MK::MenuLayout

  def layout
    add app_menu
    NSApp.windowsMenu = add window_menu
    NSApp.helpMenu = add help_menu
  end

end
