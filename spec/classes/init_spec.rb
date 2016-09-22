require 'spec_helper'

describe 'rbldnsd' do
  context 'with default values' do
    it do
      is_expected.to contain_compile
    end
  end
end
