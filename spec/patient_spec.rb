require('rspec')
require('pg')
require('patient')
require('spec_helper')

DB = PG.connect({:dbname => 'doctor_office_test'})

describe(Patient) do
  describe(".all") do
    it("starts off with no patients") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      patient = Patient.new({:id_doctor => 1, :name => "Patient 0",:birthdate => "1890-09-03"})
      expect(patient.name()).to(eq("Patient 0"))
    end
  end

  describe("#id_doctor") do
    it("sets its ID when you save it") do
      patient = Patient.new({:id_doctor => 1, :name => "Patient 0",:birthdate => "1890-09-03"})
      patient.save()
      expect(patient.id_doctor()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#birthdate") do
    it("sets its birthdate when you save it") do
      patient = Patient.new({:id_doctor => 1, :name => "Patient 0",:birthdate => "1890-09-03"})
      patient.save()
      expect(patient.birthdate()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save patients to the database") do
      patient = Patient.new({:id_doctor => 1, :name => "Patient 0",:birthdate => "1890-09-03"})
      patient.save()
      expect(Patient.all()).to(eq([patient]))
    end
  end

  # describe("#==") do
  #   it("is the same patient if it has the same name") do
  #     patient1 = Patient.new({:name => "Patient 0", :id_doctor => 1})
  #     patient2 = Patient.new({:name => "Patient 0", :id_doctor => 1})
  #     expect(patient1).to(eq(patient2))
  #   end
  # end

  describe(".sort") do
    it("returns a patient list ordered alphabetically") do
      test_patient = Patient.new({:id_doctor => 1, :name => "Steve Jobs",:birthdate => "1890-09-03"})
      test_patient.save()
      test_patient2 = Patient.new({:id_doctor => 2, :name => "Andy Turtle",:birthdate => "1890-09-03"})
      test_patient2.save()
      expect(Patient.sort).to(eq([test_patient2,test_patient]))
    end
  end

  # describe("#tasks") do
  #   it("returns an array of tasks for that patient") do
  #     test_patient = Patient.new({:name => "Patient 0", :id_doctor => 1})
  #     test_patient.save()
  #     test_task = Task.new({:description => "Learn SQL", :patient_id_doctor => test_patient.id_doctor(), :deadline => "2017-09-05 00:00:00"})
  #     test_task.save()
  #     test_task2 = Task.new({:description => "Review Ruby", :patient_id_doctor => test_patient.id_doctor(), :deadline => "2017-09-05 00:00:00"})
  #     test_task2.save()
  #     expect(test_patient).to(eq([test_task, test_task2]))
  #   end
  # end
end
