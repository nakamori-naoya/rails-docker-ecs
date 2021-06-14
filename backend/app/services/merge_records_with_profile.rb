class MergeRecordsWithProfile
  def self.call(records)
    if records.length > 1
      result = records.map {|record|
        merge_record_with_association_model(record)
      }
      result
    else
      result = merge_record_with_association_model(records)
      result
    end
  end

  private
  def self.merge_record_with_association_model(record)
    if record.user.profile && record.user.profile.image.attached?
        record.user.profile.attributes.merge({image: url_for(chat.user.profile.image)}) 
    elsif record.user.profile
        record.user.profile.attributes
    else
      {}
    end
  end
end