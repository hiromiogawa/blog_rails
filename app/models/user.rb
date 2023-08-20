class User < ApplicationRecord
  has_secure_password

  # Constants
  PERMISSIONS = {
    post_own_articles:       1 << 0,
    edit_own_articles:       1 << 1,
    save_drafts:             1 << 2,
    edit_profile:            1 << 3,
    change_password:         1 << 4,
    edit_all_articles:       1 << 5,
    delete_all_articles:     1 << 6,
    post_categories:         1 << 7,
    edit_categories:         1 << 8,
    delete_categories:       1 << 9,
    view_users:              1 << 10,
    edit_users:              1 << 11,
    delete_users:            1 << 12,
    change_system_settings:  1 << 13
  }.freeze

  # Validations
  validates :username, presence: true, uniqueness: true, length: { in: 3..50 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  
  # トークンを発行するメソッド
  def generate_jwt
    JwtHelper.encode(self.id)
  end
  

# 特定の権限を付与する
def grant_permission!(permission_value)
  permission_key = PERMISSIONS.key(permission_value.to_i)
  if permission_key
    self.permissions |= PERMISSIONS[permission_key]
    save!
  else
    raise "Invalid permission value: #{permission_value}"
  end
end

  # 特定の権限を取り消す
  def revoke_permission!(permission)
    self.permissions &= ~PERMISSIONS[permission]
    save!
  end

  # 特定の権限があるかを確認
  def has_permission?(permission)
    permissions & PERMISSIONS[permission] == PERMISSIONS[permission]
  end

end
