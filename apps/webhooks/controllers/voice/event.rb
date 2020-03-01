module Webhooks
  module Controllers
    module Voice
      class Event
        include Webhooks::Action
        accept :json

        def call(params)
          puts params.to_h
          self.body = params
        end
      end
    end
  end
end
