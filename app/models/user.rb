require "digest/sha1"

class User < ActiveRecord::Base


  # rails g scaffold user name:string hashed_password:string salt:string

  attr_accessible :password, :name, :salt
  
  validates_presence_of :name                  #验证用户名不能为空
  validates_uniqueness_of :name                #验证用户名不能重复

  validate  :password_non_blank

  # XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  # attr_accessor :password_confirmation         #getter setter 方法
  # validates_confirmation_of :password

  def self.authenticate(name,password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password,user.salt)
      if(user.hashed_password != expected_password)
        user = nil
      end
    end
    user
  end

  # 明文密码 is a virtual attribute
  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password,self.salt)
  end
  
  private
  
  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end


  def self.encrypted_password(password,salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    # self.salt
    # 用一个随机数和对象的id组合起来，就得到我们需要的salt字符串
    # 私有方法，放到private后
    self.salt = self.object_id.to_s + rand.to_s
  end




end
