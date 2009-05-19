module Waves

  module Dispatchers

    class Default < Base

      # Takes a Waves::Request and returns a Waves::Response
      #
      def safe(request)
        # Safeish default
        request.response.content_type =  Waves::MimeTypes[request.ext].first || request.accept.default || "text/html"

        resource = Waves.config.resource.new request

        # TODO: Get rid of this? --rue
        if request.response.body.empty?
          request.response.write resource.process.to_s
        else
          resource.process
        end

        request.response.finish
      end

    end

  end

end
