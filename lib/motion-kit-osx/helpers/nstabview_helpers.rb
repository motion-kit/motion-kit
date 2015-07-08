class NSTabViewHelpers < MK::NSViewHelpers
  targets NSTabView

  def add_tab(identifier, label, &block)
    tab_view_item = NSTabViewItem.alloc.initWithIdentifier(identifier)
    tab_view_item.label = label
    target.addTabViewItem(tab_view_item)
    tab_view_item.view = NSView.alloc.initWithFrame(target.contentRect)
    context(tab_view_item.view, &block)
  end
end
