# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Creates default users, one for each role

User.create(
  email: 'admin.1@osu.edu',
  password: 'Buckeye123$',
  password_confirmation: 'Buckeye123$',
  role: 'admin',
  user_approved: true,
  first_name: 'Admin',
  last_name: 'Default'
)

User.create(
  email: 'studenttest.1@osu.edu',
  password: 'foradmin$only123',
  password_confirmation: 'foradmin$only123',
  role: 'student',
  user_approved: true,
  first_name: 'Student',
  last_name: 'Default'
)

User.create(
  email: 'instructortest.1@osu.edu',
  password: 'foradmin$only123',
  password_confirmation: 'foradmin$only123',
  role: 'instructor',
  user_approved: true,
  first_name: 'Instructor',
  last_name: 'Default'
)