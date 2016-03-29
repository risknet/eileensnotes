# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


Note.destroy_all
Answer.destroy_all
Review.destroy_all

#
#
# the following lines populate tables for testing only
#
# make sure you have three test users already setup
# testuser01@test.com, testuser02@test.com, testuser03@test.com
#

# test user 1 
100.times do |c|
  n = Note.new
  n.title = c.to_s + ' u1 title text'
  n.question  = c.to_s + ' u1 question of EileensNotes comes here'
  n.user_id  = User.name_to_id("testuser01@test.com")
  n.save
  8.times do
    a = Answer.new
    a.answer = c.to_s + ' u1 title text - u1 question of EileensNotes comes here - and answer here'
    a.note_id = n.id
    a.user_id = n.user_id
    a.save
  end
end

# test user 2
100.times do |c|
  n = Note.new
  n.title = c.to_s + ' u2 title text'
  n.question  = c.to_s + ' u2 question of EileensNotes comes here'
  n.user_id  = User.name_to_id("testuser02@test.com")
  n.save
  8.times do
    a = Answer.new
    a.answer = c.to_s + ' u2 title text - u2 question of EileensNotes comes here - and answer here'
    a.note_id = n.id
    a.user_id = n.user_id
    a.save
  end
end

# test user 3
100.times do |c|
  n = Note.new
  n.title = c.to_s + ' u3 title text'
  n.question  = c.to_s + ' u3 question of EileensNotes comes here'
  n.user_id  = User.name_to_id("testuser03@test.com")
  n.save
  8.times do
    a = Answer.new
    a.answer = c.to_s + ' u3 title text - u3 question of EileensNotes comes here - and answer here'
    a.note_id = n.id
    a.user_id = n.user_id
    a.save
  end
end
