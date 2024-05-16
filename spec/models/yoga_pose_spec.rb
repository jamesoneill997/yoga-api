require 'rails_helper'

RSpec.describe YogaPose, type: :model do
  subject {
    YogaPose.new(name: "Downward Dog", description: "A yoga pose that stretches the whole body.")
  }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

end
