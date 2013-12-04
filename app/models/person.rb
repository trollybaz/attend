class Person < ActiveRecord::Base
  
  belongs_to :workspace

  E_AREL = Enrollment.arel_table

  scope :non_enrollees_for_event_type, ->(event_type) {
    where(workspace_id: event_type.workspace_id).
    joins(E_AREL.join(E_AREL, 
      Arel::Nodes::OuterJoin).
      on(E_AREL[:person_id].eq(arel_table[:id]).
         and(E_AREL[:event_type_id].eq(event_type.id))).
      join_sources.first).
    where(E_AREL[:id].eq(nil))
  }

  ### convenience methods

  def name
    name = first_name || ""
    if name.present?
      name += " #{last_name}" if last_name.present?
    elsif last_name.present?
      name = last_name
    end

    if name.present?
      if email.present? 
        name += " [#{email}]"
      end
    else
      name = email || ""
    end
    name
  end

  

end
