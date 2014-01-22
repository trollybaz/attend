class Serializer < ActiveModel::Serializer

  class << self
    def eager_loads(options = {})
      excludes = options[:excludes] || []
      load_array = []

      # go through all associations 
      _associations.each do |attr, association|
        next if excludes.include?(attr)
        if (includes = association.serializer_from_options.eager_loads).present?
          load_array << { attr => includes }
        else
          load_array << attr
        end
      end

      load_array
    end # end eager_loads

    def collection_eager_load(collection, options = {})
      if collection.respond_to?(:loaded?) && 
        !collection.loaded?  && 
        collection.respond_to?(:includes) && 
        (associations = eager_loads(options))

        collection.includes(associations)
      else
        collection
      end
    end

    def collection(objects, options = {})
      options[:serialization_cache] ||= {}
      options[:each_serializer] = self
      options[:root] = :root if !options[:root]

      objects = collection_eager_load(objects) if !options.delete(:disable_eager_load)
      ActiveModel::ArraySerializer.new(objects, options)
    end

    def model_eager_load(object, options = {})
      # go through each assocation, find the has_many associations,
      # and eager load those associations only
      _associations.each do |attr, association|
        if association.kind_of? ActiveModel::Serializer::Association::HasMany 
          # eager load the association if it's already been loaded
          if (includes = association.serializer_from_options.eager_loads).present?
            association_proxy = object.send(attr)
            if association_proxy.respond_to?(:loaded?) &&
              !association_proxy.loaded?

              ActiveRecord::Associations::Preloader.new(association_proxy, includes).run
            end
          end
        end
      end       
    end # end model_eager_load

  end
end
