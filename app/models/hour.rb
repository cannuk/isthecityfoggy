class Hour < ActiveRecord::Base
   attr_accessible :foggy, :hour, :created_at, :updated_at

   def as_json(options={})
     super({ except: [:id, :created_at] }.merge(options || {}))
   end
end
