require 'test_helper'

class WebhookTriggerTest < ActiveSupport::TestCase
  test 'should call request with tag name' do
    webhook = WebhookTrigger.new('pending')
    webhook.send_tag_with_highest_count
    payload = { tag: 'pending' }
    assert_send([webhook, :request, payload])    
  end
end
