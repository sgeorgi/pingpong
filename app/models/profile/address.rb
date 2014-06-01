class Profile::Address < ActiveRecord::Base
  belongs_to :user_profile

  validates :postal_code, presence: true,
            allow_blank: true,
            format: { with: /\d/ },
            length: { is: 5 },
            on: :update
end
