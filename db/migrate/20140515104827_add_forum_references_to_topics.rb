class AddForumReferencesToTopics < ActiveRecord::Migration
  def change
    add_reference :topics, :forum, index: true
  end
end
