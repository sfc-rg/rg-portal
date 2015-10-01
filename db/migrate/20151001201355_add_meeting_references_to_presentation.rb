class AddMeetingReferencesToPresentation < ActiveRecord::Migration
  def change
    add_reference :presentations, :meeting, index: true
  end
end
