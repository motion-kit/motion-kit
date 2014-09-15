class Object

  def motion_kit_meta
    @motion_kit_meta ||= {}
  end

  def motion_kit_id=(id)
    motion_kit_meta[:motion_kit_ids] ||= []
    motion_kit_meta[:motion_kit_ids] << id
  end

  def motion_kit_id
    if motion_kit_meta[:motion_kit_ids]
      motion_kit_meta[:motion_kit_ids][-1]
    end
  end

end
