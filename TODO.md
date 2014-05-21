- add UIMotionEffect DSL
- add 'replace' to constraints DSL, to support animation
- spec for the 'NSTableView - add_column' case, where inside the 'add_column'
  block, the context was being set on the *delegate* layout, not the actual
  layout
- spec to make sure that layers and views are restyled on iOS
- spec for nested layouts
