class Enrollment < ActiveRecord::Base
  belongs_to :event_type
  belongs_to :person
end
