require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:mail))
    assert_equal "Book store order confirmation", mail.subject
    assert_equal ["test@example.com"], mail.to
    assert_equal ["me@fadhb.com"], mail.from
    #assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:mail))
    assert_equal "Book store order has shipped", mail.subject
    assert_equal ["test@example.com"], mail.to
    assert_equal ["me@fadhb.com"], mail.from
    #assert_match /<td>1&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.body.encoded
  end

end
