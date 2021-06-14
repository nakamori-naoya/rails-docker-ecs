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
end
