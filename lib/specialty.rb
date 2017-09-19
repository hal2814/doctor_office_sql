class Specialty
  attr_reader(:id,:special)

  def initialize(attributes)
    @id = attributes.fetch(:id).to_i
    @special = attributes.fetch(:special)
  end

  def self.all
    returned_specialties = DB.exec("SELECT * FROM specialties;")
    specialties = []
    returned_specialties.each() do |special|
      id = special.fetch("id")
      special = special.fetch("special")
      specialties.push(Specialty.new({:id => id, :special => special}))
    end
    specialties
  end

  def save
    result = DB.exec("INSERT INTO specialties (special,id) VALUES ('#{@special}','#{@id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end


  #Needed to compare two objects for testing
  def ==(another_special)
    (self.special==another_special.special).&  (self.id==another_special.id)
  end

  def self.find(id)
    found_special = nil
    Specialty.all().each() do |special|
      if special.id().==(id)
        found_special = special
      end
    end
    found_special
  end

  # def tasks
  #   special_tasks = []
  #   tasks = DB.exec("SELECT * FROM tasks WHERE special_id = #{self.id()};")
  #   tasks.each() do |task|
  #     description = task.fetch("description")
  #     special_id = task.fetch("special_id").to_i()
  #     special_tasks.push(Task.new({:description => description, :special_id => special_id}))
  #   end
  #   special_tasks
  # end
end
