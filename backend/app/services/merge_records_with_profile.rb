class MergeRecordsWithProfile
  #url_for問題がどうしても解決できない。ヘルパーメソッドについての理解が足りていない可能性が高い。。。。
    include Rails.application.routes.url_helpers


  def self.call(records)
    if records.respond_to?(:length)  #レコードが複数か1つかを分岐したいのだが、いいメソッドが思い浮かばず、lengthメソッドが使えるか？で分岐している。。。
      result = records.map {|record|
        merge_record_with_profile(record)
      }
      result
    else 
      result = merge_record_with_profile(records)
      result
    end
  end

  private
  def self.merge_record_with_profile(record)
    if record.user
      if record.user.profile && record.user.profile.image.attached?
        with_image_profile = record.user.profile.attributes.merge({image: url_for(record.user.profile.image)}) 
        record.attributes.merge(with_image_profile)
      elsif record.user.profile
          record.attributes.merge(record.user.profile.attributes)
      else
          record
      end
    else 
      record
    end
  end
end