module SettingsHelper
  def group_list
    Group.all.map{ |t| [t.name, t.id] }
  end
end
