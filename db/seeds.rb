%w(groups users meetings presentations pages).each do |path|
  Dir.glob(File.join(Rails.root, 'db', 'seeds', "#{path}.rb")) do |file|
    load(file)
  end
end
