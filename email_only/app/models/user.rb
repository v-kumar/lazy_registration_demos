class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :emails

  devise :recoverable, :rememberable, :trackable, :registerable

  # You should not declare :confirmable and :multi_email_confirmable at the same time.
  devise :multi_email_authenticatable, :multi_email_validatable, :multi_email_confirmable

  devise :lockable

  validates :first_name, presence: true
  validates :last_name, presence: true

  def password_required?
    # Password is required if it is being set, but not for new records
    if !persisted?
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

  # provide access to protected method unless_confirmed
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  # set the password without knowing the current password used in our confirmation controller.
  def update_password(params)
    update_attributes({password: params[:password], password_confirmation: params[:password_confirmation]})
  end

  def blank_password?
    self.encrypted_password.blank?
  end

  def name
    [first_name, last_name].join(" ")
  end
end
