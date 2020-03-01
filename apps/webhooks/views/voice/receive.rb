module Webhooks
  module Views
    module Voice
      class Receive
        include Webhooks::View

        def render
          raw {
            [
              {
                :action => 'talk',
                :text => 'Hello from Nexmo',
                :voiceName => 'Amy'
              }
            ]
          }.to_json
        end
      end
    end
  end
end
