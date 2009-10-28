module ActiveRecord
  module Has
    module Guid
      
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        def has_guid(field)
          unless included_modules.include? InstanceMethods
            include ActiveRecord::Has::Guid::InstanceMethods
            class_inheritable_accessor :has_guid_field
            validates_uniqueness_of :guid
          end
          self.has_guid_field = field.to_sym
          define_method("#{has_guid_field.to_s}=".to_sym) do |method_name, *args|
            super
            update_guid
          end
        end
      end
      
      module InstanceMethods  
        
        def update_guid
          write_attribute(:guid, make_guid(has_guid_field)) unless read_attribute(has_guid_field).nil?
        end
        
        protected
        # Creates a guid based off an attrbute
        def make_guid(attribute)
          unless (field = read_attribute(attribute.to_sym)).nil?
            field = field.split(" ").each{|i| i.downcase!; i.gsub!(/[^a-zA-Z0-9]/,'') }.join("-")
            if self.class.find_by_guid(field)
              tmp = "#{field}-#{i=1}"
              while !self.class.find_by_guid(tmp).nil?
                tmp = "#{field}-#{i+=1}"
              end
              field = tmp
            end
            field
          else
            field = nil
          end
        end
      end
      
    end
  end
end