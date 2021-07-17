class ApplicationController < ActionController::API
  include Knock::Authenticable
    # 200 Success
  def response_success(class_name, action_name)
    render status: 200, json: { status: 200, message: "Success #{class_name.capitalize} #{action_name.capitalize}" }
  end

  # 400 Bad Request
  def response_bad_request
    render status: 400, json: { status: 400, message: 'Bad Request' }
  end

  # 401 Unauthorized
  def response_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 404 Not Found
  def response_not_found(class_name = 'page')
    render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
  end

  # 409 Conflict
  def response_conflict(class_name)
    render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
  end

  # 500 Internal Server Error
  def response_internal_server_error
    render status: 500, json: { status: 500, message: 'Internal Server Error' }
  end

  
  def except_records_fields(records, except_keywords_in_array)
    result = records.map{|record|
      except_fields(record, except_keywords_in_array)
    }
    result
  end


  def except_fields(a_record, except_keywords_in_array) 
      a_json_data = a_record.to_json()
      parsed_data = JSON.parse(a_json_data)
      result = parsed_data.except(*except_keywords_in_array)
      result
  end



  #url_for問題が解決できず、仕方なくapp_controllerに実装
  def merge_records_with_profile(records)
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

  def merge_records_with_images(records)
    if records.respond_to?(:length)  #レコードが複数か1つかを分岐したいのだが、いいメソッドが思い浮かばず、lengthメソッドが使えるか？で分岐している。。。
      result = records.map {|record|
        merge_record_with_images(record)
      }
      result
    else 
      result = merge_record_with_images(records)
      result
    end
  end

  #メソッドの中身がかなり重複しているので、引数にisMultipleをtrueもしくはfalseで送るのはどうだろう？
  def merge_records_with_image(records)
    if records.respond_to?(:length)  #レコードが複数か1つかを分岐したいのだが、いいメソッドが思い浮かばず、lengthメソッドが使えるか？で分岐している。。。
      result = records.map {|record|
        merge_record_with_image(record)
      }
      result
    else 
      result = merge_record_with_image(records)
      result
    end
  end

  private

  def merge_record_with_profile(record)
    if record.user
      if record.user.profile && record.user.profile.image.attached?
        with_image_profile = record.user.profile.attributes.merge({image: url_for(record.user.profile.image)}) 
        record.attributes.merge({profile: with_image_profile})
      elsif record.user.profile
          record.attributes.merge({profile: record.user.profile.attributes})
      else
          record.attributes
      end
    else 
      record.attributes
    end
  end

  def merge_record_with_images(record)
      if record.images.attached?
        result =record.attributes.merge({images: url_for(record.images.last)}) 
        result
      else
        record.attributes
      end
  end

  def merge_record_with_image(record)
    if record.image.attached?
      result =record.attributes.merge({image: url_for(record.image)}) 
      result
    else
      record.attributes
    end
end





end
