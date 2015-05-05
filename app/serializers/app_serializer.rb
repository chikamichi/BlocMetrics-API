class AppSerializer < ActiveModel::Serializer
  attributes :id, :domain
  has_many :events #JSON representations of the app's events.
end
