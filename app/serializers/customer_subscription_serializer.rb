class CustomerSubscriptionSerializer
  include JSONAPI::Serializer

  set_id :id
  set_type :subscriptions
  attribute :title do |object|
    object.title
  end
  attribute :price do |object|
    object.price
  end
  attribute :frequency do |object|
    object.frequency
  end
  attribute :status do |object|
    object.status
  end
  attribute :teas do |object|
    object.teas.map { |tea| tea.title }
  end

end
