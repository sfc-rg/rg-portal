class SetPresentationOrdersCreatePrivilegeToUsers < ActiveRecord::Migration
  def up
    Privilege.where(model: :user_judgments, action: :index).each do |p1|
      p1.user.privileges.each do |p2|
        if p2.model == 'meetings'
          p1.user.privileges.create!(model: 'presentation_orders', action: 'create')
        end
      end
    end
  end

  def down
  end
end
