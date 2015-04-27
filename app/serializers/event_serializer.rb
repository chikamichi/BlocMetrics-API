class EventSerializer < ActiveModel::Serializer
  attributes :id, :domain, :event, :url, :ip_address, :created_at
end
