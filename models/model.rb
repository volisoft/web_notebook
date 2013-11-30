class Note
  include DataMapper::Resource

  property :id,           Serial
  property :title,        String
  property :content,      Text
  property :created_at,   DateTime
  property :updated_at,   DateTime

  belongs_to :user
end

class User
  include DataMapper::Resource
  include BCrypt

  property :id,           Serial, :key => true
  property :email,        String
  property :first_name,   String
  property :last_name,    String
  property :username,     String, :length => 3..50
  property :password,     BCryptHash

  has n, :notes

  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end