class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :email
      t.timestamps

      t.string    :crypted_password,    :null => false
      t.string    :password_salt,       :null => false
      t.string    :persistence_token,   :null => false
      t.string    :single_access_token, :null => false
      t.string    :perishable_token,    :null => false

      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
    end

    Admin.create!(:email => 'danigb@gmail.com', :password => 'danidani', :password_confirmation => 'danidani')
    Admin.create!(:email => 'dani.berzas@gmail.com', :password => 'danidani', :password_confirmation => 'danidani')


  end
  
  def self.down
    drop_table :admins
  end
end
