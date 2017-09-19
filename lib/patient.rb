class Patient
  attr_reader(:id,:name,:birthdate,:id_doctor)

  def initialize(attributes)
    # @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @id_doctor = attributes.fetch(:id_doctor)
  end

  def self.all
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |list|
      name = patient.fetch("name")
      birthdate = patient.fetch("birthdate")
      id_doctor = patient.fetch("id_doctor").to_i
      patients.push(Patient.new({:name => name,:birthdate =>birthdate, :id_doctor => id_doctor }))
    end
    patients
  end

  def save
    DB.exec("INSERT INTO tasks (description, list_id, deadline) VALUES ('#{@name}', '#{@id_doctor}', '#{@birthdate};')")
  end

  def self.sort
    patient_sort = DB.exec("SELECT * FROM patients ORDER BY name;")
    patients = []
    patient_sort.each() do |patient|
      name = patient.fetch("name")
      id_doctor = patient.fetch("id_doctor").to_i() # The information comes out of the database as a string.
      birthdate = patient.fetch("birthdate")
      patients.push(Patient.new({:name => name,:birthdate =>birthdate, :id_doctor => id_doctor }))
    end
    patients
  end

  # def ==(another_patient)
  #   (self.name.==another_list.name).&(self.id.==another_list.id)
  # end

  # def self.find(id)
  #   found_patient = nil
  #   Patient.all().each() do |patient|
  #     if patient.id().==(id)
  #       found_patient = patient
  #     end
  #   end
  #   found_patient
  # end

  # def patients
  #   list_tasks = []
  #   tasks = DB.exec("SELECT * FROM tasks WHERE id_doctor = #{self.id()};")
  #   tasks.each() do |task|
  #     description = task.fetch("description")
  #     list_id = task.fetch("list_id").to_i()
  #     list_tasks.push(Task.new({:description => description, :list_id => list_id}))
  #   end
  #   list_tasks
  # end
end
