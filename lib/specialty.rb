class Specialty
  attr_reader(:id,:specialty)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @specialty = attributes.fetch(:specialty)
  end

  def self.all
    returned_specialties = DB.exec("SELECT * FROM specialties;")
    specialties = []
    returned_specialties.each() do |specialty|
      id = specialty.fetch("id")
      specialty = specialty.fetch("specialty")
      specialties.push(Specialty.new({:id => id, :specialty => specialty}))
    end
    specialties
  end

  def save
    result = DB.exec("INSERT INTO specialties (specialty) VALUES ('#{@specialty}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  # def ==(another_specialty)
  #   (self.name.==another_specialty.name).&(self.id.==another_specialty.id)
  # end

  def self.find(id)
    found_specialty = nil
    Specialty.all().each() do |specialty|
      if specialty.id().==(id)
        found_specialty = specialty
      end
    end
    found_specialty
  end

  # def tasks
  #   specialty_tasks = []
  #   tasks = DB.exec("SELECT * FROM tasks WHERE specialty_id = #{self.id()};")
  #   tasks.each() do |task|
  #     description = task.fetch("description")
  #     specialty_id = task.fetch("specialty_id").to_i()
  #     specialty_tasks.push(Task.new({:description => description, :specialty_id => specialty_id}))
  #   end
  #   specialty_tasks
  # end
end
