# username:string
# password_digest:string
#
# password:string virtual
# passwrd_confirmation:string virtual

class User < ApplicationRecord
    has_secure_password

    validates :username, presence: true
end
