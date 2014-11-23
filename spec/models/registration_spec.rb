require 'rails_helper'

describe Registration do
  it "disallows duplicates" do
    create(:registration, uid: '123', provider: 'twitter')

    build(:registration, uid: '123', provider: 'twitter').should_not be_valid
    build(:registration, uid: '234', provider: 'twitter').should be_valid
    build(:registration, uid: '123', provider: 'facebook').should be_valid
  end

  it "lets us check if the registration data is already there" do
    create(:registration, uid: '123', provider: 'twitter')
    Registration.should be_already_created(uid: '123', provider: 'twitter')
    Registration.should_not be_already_created(uid: '234', provider: 'twitter')
    Registration.should_not be_already_created(uid: '123', provider: 'facebook')
  end
end
