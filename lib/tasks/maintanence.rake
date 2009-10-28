namespace :maintanence do
  desc "Creates all roles needed for system permissions."
  task :force_guid => :environment do
    Item.find_all_by_guid(nil).each do |item|
      item.update_attribute(:name,item.name)
      puts "Updated Item: #{item.guid}"
    end
    Category.find_all_by_guid(nil).each do |item|
      item.update_attribute(:name,item.name)
      puts "Updated Category: #{item.guid}"
    end
    Section.find_all_by_guid(nil).each do |item|
      item.update_attribute(:name,item.name)
      puts "Updated Section: #{item.guid}"
    end
    Question.find_all_by_guid(nil).each do |item|
      item.update_attribute(:name,item.name)
      puts "Updated Question: #{item.guid}"
    end
  end
end