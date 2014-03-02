class Object
  attr_accessor :motion_kit_meta

  def motion_kit_id=(element_id)
    motion_kit_meta[:id] = element_id
  end

  def motion_kit_id
    motion_kit_meta[:id]
  end

  def motion_kit_meta
    @motion_kit_meta ||= {}
  end

end
