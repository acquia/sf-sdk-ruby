# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Profile do
  before :each do
    @conn = SFRest.new("http://#{@mock_endpoint}", @mock_user, @mock_pass)
  end

  it 'gets profiles' do
    expect(@conn).to receive(:get).with('/api/v1/profiles')
    @conn.profile.profile_list

    expect(@conn).to receive(:get).with('/api/v1/profiles?enabled=true')
    @conn.profile.profile_list(enabled: true)

    expect(@conn).to receive(:get).with('/api/v1/profiles?stack_id=1')
    @conn.profile.profile_list(stack_id: 1)

    expect(@conn).to receive(:get).with('/api/v1/profiles?stack_id=1&enabled=true')
    @conn.profile.profile_list(stack_id: 1, enabled: true)
  end

  it 'enables a profile' do
    expect(@conn).to receive(:post).with('/api/v1/profiles/standard/enable', '{}')
    @conn.profile.enable('standard')

    expect(@conn).to receive(:post).with('/api/v1/profiles/acquia_cms/enable?stack_id=3', '{}')
    @conn.profile.enable('acquia_cms', stack_id: 3)
  end

  it 'disables a profile' do
    expect(@conn).to receive(:post).with('/api/v1/profiles/standard/disable', '{}')
    @conn.profile.disable('standard')

    expect(@conn).to receive(:post).with('/api/v1/profiles/acquia_cms/disable?stack_id=4', '{}')
    @conn.profile.disable('acquia_cms', stack_id: 4)
  end

  it 'sets the default profile' do
    expect(@conn).to receive(:post).with('/api/v1/profiles/standard/set_default', '{}')
    @conn.profile.set_default('standard')

    expect(@conn).to receive(:post).with('/api/v1/profiles/acquia_cms/set_default?stack_id=4', '{}')
    @conn.profile.set_default('acquia_cms', stack_id: 4)
  end
end
