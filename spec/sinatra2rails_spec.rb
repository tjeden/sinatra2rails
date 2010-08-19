require 'sinatra2rails'

describe Sinatra2Rails do
  describe '#migrate_controllers' do
    before(:each) do
      file_name = 'test_rails_app/sinatra_controller.rb'
      File.delete(file_name) if File.exists?(file_name)
      s2r = Sinatra2Rails.new('test_sinatra_app/pong.rb')
      s2r.migrate_controllers
    end

    it 'creates sinatra controller file' do
      File.exists?('test_rails_app/sinatra_controller.rb').should be_true
    end

    it 'creates correct sinatra controller' do
      created_file = File.open('test_rails_app/sinatra_controller.rb').read
      expected_file = File.open('spec/example_rails_app/sinatra_controller.rb').read
      created_file.should eql(expected_file)
    end
  end

  describe '#migrate_routes' do
    before(:each) do
      file_name = 'test_rails_app/routes.rb'
      File.delete(file_name) if File.exists?(file_name)
      s2r = Sinatra2Rails.new('test_sinatra_app/pong.rb')
      s2r.migrate_routes
    end

    it 'creates sinatra routes file' do
      File.exists?('test_rails_app/routes.rb').should be_true
    end

    it 'creates correct routes file' do
      created_file = File.open('test_rails_app/routes.rb').read
      expected_file = File.open('spec/example_rails_app/routes.rb').read
      created_file.should eql(expected_file)
    end
  end
end
