# @provides MotionKit::NSTableViewLayout
# @requires MotionKit::NSViewLayout
module MotionKit
  class NSTableViewLayout < NSViewLayout
    targets NSTableView

    def add_column(column_or_identifier, &block)
      if column_or_identifier.is_a?(NSTableColumn)
        column = column_or_identifier
      else
        column = NSTableColumn.alloc.initWithIdentifier(column_or_identifier)
        column.headerCell.stringValue = column_or_identifier
      end
      target.addTableColumn(column)
      context(column, &block)

      column
    end
    alias add_table_column add_column

  end
end
