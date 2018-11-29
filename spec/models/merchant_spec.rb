require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { is_expected.to have_many(:invoices)}
  it { is_expected.to have_many(:items)}

  describte "class methods" do
    it '.top_merchants_by_revenue' do
      merchants = create_list(:merchant, 10)
      
    end
  end
end
