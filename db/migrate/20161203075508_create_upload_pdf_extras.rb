class CreateUploadPdfExtras < ActiveRecord::Migration
  def change
    create_table :upload_pdf_extras do |t|
      t.references :upload, index: true
      t.text :pdf_version
      t.integer :num_of_pages
      t.timestamps null: false
    end

    reversible do |r|
      r.up { Upload.all.select(&:pdf?).map { |upload| upload.build_pdf_extra.save } }
    end
  end
end
