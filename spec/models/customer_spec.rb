require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations" do
    it {is_expected.to have_many(:transactions) }
    it {is_expected.to have_many(:invoices) }
  end

end
