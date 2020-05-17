# The repository for pastes.
class PasteRepository

  # Initializes a new repository for pastes.
  def initialize(@pastes_directory : Path)
  end

  # INTERNAL Retrieves a path of a paste by the ID.
  protected def get_path_to_paste(id : String)
    return @pastes_directory.join(id)
  end

  # Counts the pastes
  def count()
    pastes_directory = Dir.new(@pastes_directory.to_s)
    return pastes_directory.children.size
  end

  # Retrieves a paste by the ID.
  def retrieve(id : String)
    path = self.get_path_to_paste(id)

    begin
      File.read(path)
    rescue
      nil
    end
  end

  # Stores a new paste with given ID and contents.
  def store(id : String, contents : String)
    path = self.get_path_to_paste(id)
    File.write(path, contents)
  end
end
