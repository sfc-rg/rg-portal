class AddAttachedObjectReferencesToUploadFile < ActiveRecord::Migration
  def change
    add_reference :upload_files, :attached_object, polymorphic: true
  end
end
