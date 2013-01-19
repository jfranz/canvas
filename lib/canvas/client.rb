module Canvas
  # Wrapper for the Canvas REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {TODO:doc_URL the Canvas API Documentation}.
  # @see TODO:doc_url
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include Canvas::Client::Utils

    include Canvas::Client::Users
    include Canvas::Client::Enrollments
    include Canvas::Client::Admins
  end
end