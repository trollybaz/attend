class Context

  class_attribute :use_transaction
  self.use_transaction = true

  # TODO:
  # attr_accessor instance transaction override

  class << self
    def trigger(*args)
      if use_transaction
        ActiveRecord::Base.transaction do
	  inner_trigger *args
	end
      else
        inner_trigger *args
      end
    end

   private

    def inner_trigger(*args)
      instance = new(*args)
      instance.call
      instance
    end
  end

  # override in subclasses
  def call
  end

end
