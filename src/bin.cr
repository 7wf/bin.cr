require "router"
require "hashids"

class Application
  include Router

  def self.new(pastes_directory : Path)
    application = Application.allocate
    application.initialize pastes_directory
    application
  end

  def initialize(pastes_directory : Path)
    @pastes_directory_path = pastes_directory
    @hashids = Hashids.new
  end

  def count_pastes
    pastes_directory = Dir.new(@pastes_directory_path.to_s)
    pastes_directory.children.size
  end

  def get_paste_path(paste_id)
    @pastes_directory_path.join paste_id
  end

  def get_paste(paste_id = "help")
    paste_path = get_paste_path paste_id

    begin
      File.read paste_path
    rescue
      nil
    end
  end

  def create_paste(paste_id, paste_contents)
    paste_path = @pastes_directory_path.join paste_id
    File.write(paste_path, paste_contents)
  end

  def exists_paste(paste_id)
    paste_path = get_paste_path paste_id

    File.exists? paste_path
  end

  def routes
    get "/" do |context, paramethers|
      help_text = get_paste "help.txt"

      if help_text == nil
        context.response.print "Failed to get help text."
        context
      end

      context.response.print help_text
      context
    end

    post "/pastes" do |context, paramethers|
      pastes_size = count_pastes
      paste_contents = context.request.body.not_nil!.gets_to_end
      paste_id = @hashids.encode [1, pastes_size + 1]

      create_paste paste_id, paste_contents

      context.response.print paste_id
      context
    end

    get "/:id" do |context, paramethers|
      paste_id = paramethers["id"]
      paste_contents = get_paste paste_id

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

application = Application.new PASTES_PATH
application.routes

puts "The server is listening at port #{SERVER_PORT}"
application.start SERVER_PORT
