require "serverspec"
require "docker"

NODE_PORT = 4000

describe "Dockerfile" do
  before(:all) do
    @image = Docker::Image.get(ENV['IMAGE'])

    set :backend, :docker
    set :docker_image, @image.id
  end

  describe file('/src/package.json') do
    it { should exist }
  end

  describe file('/src/server.js') do
    it { should exist }
  end

  describe 'Dockerfile#config' do
    it 'should expose the node port' do
      expect(@image.json['ContainerConfig']['ExposedPorts']).to include("#{NODE_PORT}/tcp")
    end
  end

  describe "Container" do
    before(:all)  do
      @container = Docker::Container.create(
        'Image'       => @image.id,
        'HostConfig'  => {
          'PortBindings' => { "#{NODE_PORT}/tcp" => [{ 'HostPort' => "#{NODE_PORT}" }]}
        }
      )
      @container.start
    end

    describe command("curl -sS http://localhost:#{NODE_PORT}") do
      its(:stdout) { should eq "Hello World" }
      its(:stderr) { should eq "" }
    end

    after(:all) do
      @container.kill
      @container.delete(:force => true)
    end
  end
end