class ApplicationController < ActionController::API
    include Knock::Authenticable  #全てのコントローラーでJWTのAuthenticationの利用をできるようにする
end
