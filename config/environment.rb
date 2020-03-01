require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require "hanami/middleware/body_parser"
require_relative '../lib/dev_to_voice'
require_relative '../apps/web/application'
require_relative '../apps/webhooks/application'

Hanami.configure do
  mount Webhooks::Application, at: '/webhooks'
  mount Web::Application, at: '/'
  middleware.use Hanami::Middleware::BodyParser, :json

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/dev_to_voice_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/dev_to_voice_development'
    #    adapter :sql, 'mysql://localhost/dev_to_voice_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/dev_to_voice/mailers'

    # See https://guides.hanamirb.org/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    end
  end
end
