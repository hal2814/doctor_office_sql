class Doctor
  attr_reader(:name,:id_specialties)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id_specialties = attributes.fetch(:id_specialties)
  end

  def self.all
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      id_specialties = doctor.fetch("id_specialties").to_i
      doctors.push(Doctor.new({:id_specialties => id_specialties, :name => name}))
    end
    doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, id_specialties) VALUES ('#{@name}', '#{@id_specialties}') RETURNING id;")
    # @id_specialties = result.first().fetch("id").to_i()
  end

  def ==(another_doctor)
    (self.name==another_doctor.name).&(self.id_specialties==another_doctor.id_specialties)
  end

  def self.find(id)
    found_doctor = nil
    Doctor.all().each() do |doctor|
      if doctor.id_specialties().==(id)
        found_doctor = doctor
      end
    end
    found_doctor
  end

  # def tasks
  #   doctor_tasks = []
  #   tasks = DB.exec("SELECT * FROM tasks WHERE doctor_id = #{self.id()};")
  #   tasks.each() do |task|
  #     description = task.fetch("description")
  #     doctor_id = task.fetch("doctor_id").to_i()
  #     doctor_tasks.push(Task.new({:description => description, :doctor_id => doctor_id}))
  #   end
  #   doctor_tasks
  # end
end
