# class ImageValidator < ActiveModel::EachValidator
#   include ActiveSupport::NumberHelper
#   # recordにはモデルのインスタンス、attributeには属性名、valueには属性値が入る。
#   def validate_each(record, attribute, value)
#     return if value.blank? || !value.attached?
#     has_error = false


#       if options[:content_type]
#         has_error = true unless 
#             validate_content_type(record, attribute, value)
#         end        
#       end
# end

#   private

#   def validate_content_type(record, attribute, value)
#     if value.content_type.match?(options[:content_type])
#       true
#     else
#       record.errors[attribute] << (options[:message] || 'は対応できないファイル形式です')
#       false
#     end
#   end

# end