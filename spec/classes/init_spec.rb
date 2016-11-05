require 'spec_helper'

describe 'rbldnsd' do
  context 'with default values' do
    it do
      is_expected.to compile.with_all_deps
    end
  end
end
