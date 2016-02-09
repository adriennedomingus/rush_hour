class Url < ActiveRecord::Base
  has_many :payload_request
end
