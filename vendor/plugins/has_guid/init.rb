require File.dirname(__FILE__) + '/lib/has_guid'
ActiveRecord::Base.send(:include, ActiveRecord::Has::Guid)