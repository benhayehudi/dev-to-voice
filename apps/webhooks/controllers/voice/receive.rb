require 'nexmo'

module Webhooks
  module Controllers
    module Voice
      class Receive
        include Webhooks::Action
        accept :json
        
        @nexmo = Nexmo::Client.new
        @nexmo.config.application_id = ENV['NEXMO_APPLICATION_ID']
        @nexmo.config.private_key = ENV['NEXMO_PRIVATE_KEY']

        def call(params)
          ncco = [
            {
              :action => 'talk',
              :text => 'Hello from Nexmo',
              :voiceName => 'Amy'
            }
          ].to_json
          self.body = ncco
          puts params.to_h
        end
      end
    end
  end
end
