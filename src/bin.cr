require "router"
require "hashids"

require "./paste_repository.cr"

class Application
  include Router

  def initialize(paste_repository : PasteRepository)
    @pastes = paste_repository
    @hashids = Hashids.new
  end

  def routes
    get "/" do |context, paramethers|
      help_text = @pastes.retrieve("help.txt")

      if help_text == nil
        context.response.print "Failed to get help text."
        context
      end

      context.response.print help_text
      context
    end

    post "/pastes" do |context, paramethers|
      pastes_size = @pastes.count
      paste_contents = context.request.body.not_nil!.gets_to_end
      paste_id = @hashids.encode [1, pastes_size + 1]

      @pastes.store(paste_id, paste_contents)

      context.response.print paste_id
      context
    end

    get "/:id" do |context, paramethers|
      paste_id = paramethers["id"]
      paste_contents = @pastes.retrieve(paste_id)

      if paste_contents != nil
        context.response.print paste_contents
      else
        context.response.print "Paste not found."
      end

      context
    end
  end

  def start(port)
    server = HTTP::Server.new(route_handler)
    server.bind_tcp port

    server.listen
  end
end

PASTES_PATH = Path.new "pastes"
SERVER_PORT = 8080

paste_repository = PasteRepository.new(PASTES_PATH)

application = Application.new(paste_repository)
application.routes

puts "The server is listening at port #{SERVER_PORT}"
application.start SERVER_PORT
