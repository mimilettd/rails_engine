class ApplicationController < ActionController::API
  include Swagger::Docs::ImpotentMethods
  include ActionController::MimeResponds
end
