require "spec_helper"

RSpec.describe Webhooks::Views::ApplicationLayout, type: :view do
  let(:layout)   { Webhooks::Views::ApplicationLayout.new({ format: :html }, "contents") }
  let(:rendered) { layout.render }

  it 'contains application name' do
    expect(rendered).to include('Webhooks')
  end
end
