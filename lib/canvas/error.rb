module Canvas
  # Custom error class for rescuing from all Canvas errors
  class Error < StandardError; end

  # Raised when Canvas returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Canvas returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Canvas returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Canvas returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Raised when a subscription payload hash is invalid
  class InvalidSignature < Error; end
end