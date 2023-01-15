module ApiException
  EXCEPTIONS = {
    #400
    "BadRequest" => { status: 400, error_code: 40001, message: "User cannot follow themselves." },
    #404
    "ActiveRecord::RecordNotFound" => { status: 404, error_code: 40401, message: "Cannot find record" },
  }

  class BaseError < StandardError
    def initialize(msg = nil)
      @message = msg
    end

    def message
      @message || nil
    end
  end

  module Handler
    def self.included(klass)
      klass.class_eval do
        EXCEPTIONS.each do |exception_name, context|
          unless ApiException.const_defined?(exception_name)
            ApiException.const_set(exception_name, Class.new(BaseError))
            exception_name = "ApiException::#{exception_name}"
          end

          rescue_from exception_name do |exception|
            render status: context[:status], json: { error_code: context[:error_code], message: context[:message], detail: (exception.message) }.compact
          end
        end
      end
    end
  end
end