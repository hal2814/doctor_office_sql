require('sinatra')
require('sinatra/reloader')
require('./lib/patient')
require('./lib/doctor')
require('./lib/specialty')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "doctor_office_test"})


get("/") do
  @specialty = Specialty.all()
  erb(:index)
end

# get('/specialty') do
#   #to view specialty on page
#   @specialty = Specialty.all()
#   erb(:/)
# end

post("/") do
  special = params.fetch("spec_name")
  specialty = Specialty.new({:special => special, :id => nil})
  specialty.save()
  erb(:index)
end

post("/:id") do
  @spec= Specialty.find(params.fetch("id").to_i())
  erb(:/)
end

get("/specialty/:id") do

  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:/)
end

post("/doctor/:id") do
  name = params.fetch("name")
  birthdate = params.fetch("birthdate")
  id_doctor = params.fetch("id_doctor").to_i()
  @doctor = Doctor.find(id_doctor)
  @patient = Patient.new({:name => name,:birthdate => birthdate, :id_doctor => id_doctor})
  @patient.save()
  erb(:doctor)
end
