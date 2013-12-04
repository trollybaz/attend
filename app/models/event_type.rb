class EventType < ActiveRecord::Base

  belongs_to :workspace 
  has_many   :events
  has_many   :enrollments           
  has_many   :enrollees, through: :enrollments, source: :person 

  after_save do
    self.name = 'Foozzzzz'
  end
  
end
