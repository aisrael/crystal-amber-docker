Amber::Server.configure do |app|
  pipeline :web do
    # Plug is the method to use connect a pipe (middleware)
    # A plug accepts an instance of HTTP::Handler
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    plug Amber::Pipe::Flash.new
    plug Amber::Pipe::CSRF.new
    # Reload clients browsers (development only)
    plug Amber::Pipe::Reload.new if Amber.env.development?
  end

  # All static content will run these transformations
  pipeline :static do
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Static.new("./public")
  end

  routes :static do
    # Each route is defined as follow
    # verb resource : String, controller : Symbol, action : Symbol
    get "/*", Amber::Controller::Static, :index
  end

  routes :web do
      get "/hello/index", HelloController, :index
    get "/", HomeController, :index
  end
end
