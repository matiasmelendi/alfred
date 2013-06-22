class Assignment
  include DataMapper::Resource

  belongs_to :course

  property :id, Serial
  property :name, String
  property :deadline, DateTime

  remix n, 'Storage::File', :as => 'files'
end