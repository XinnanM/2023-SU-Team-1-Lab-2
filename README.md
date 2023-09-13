# OSU Student Grader Management System (Final Project CSE 3901)

## Table of Contents

1. [Description](#description)
2. [General Functionality](#general-functionality)
   - [Home Page](#home-page)
   - [Course Catalog Page](#course-catalog-page)
   - [ADMIN ONLY: Permission Request Inbox Page](#admin-only-permission-request-inbox-page)
   - [ADMIN ONLY: Reloading Database](#admin-only-reloading-database)
   - [ADMIN ONLY: Grader Applications Inbox Page](#admin-only-grader-applications-inbox-page)
   - [INSTRUCTOR ONLY: Student Recommendation Submission Page](#instructor-only-student-recommendation-submission-page)
   - [STUDENT ONLY: Student-Grader Application Submission Page](#student-only-student-grader-application-submission-page)

3. [API Documentation](#api-documentation)
4. [Installation](#installation)
5. [Troubleshooting and Issues](#troubleshooting-and-issues)
7. [Features](#features)
8. [Common Errors](#common-errors)
9. [Contributors](#contributors)
10. [License](#license)

## Description

Welcome to the Course Grader Management System! This web application is designed to streamline the process of hiring undergraduate students as graders for various CSE department courses at the university. It aims to replace the ad hoc manual matching of students with course sections with a more efficient and consistent digital workflow. The system provides a user-friendly interface for Students, Instructors, and Admins to manage the grader hiring process.

## General Functionality
Note: Screenshots provided are all accurate in their functionality, but the UI may look slightly different.
### Home Page 

- Options to Sign up (register), Sign in, or if already logged in, browse the course catalog, and other permission specific actions.

- Home Page (Not logged in):

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/f6b17af4-5fad-4f98-b9d9-6d1d7f22468e)

- During signup, users can specify if they are a Student, Instructor, or Admin. Instructor access and additional Admins must be approved by an existing Admin from the Permission Inbox Page, only available to admins.

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/762bccbb-2688-462e-8a57-2eb3c265efe2)

- Home Page (Logged in as student). This will also show you the permissions that the user currently has. If selected Instructor or Admin role on sign up, an existing Admin has to take action from their Admin permission request page, but they will be defaulted to student permissions until they are approved, and if denied they can stay at student permissions.
This is shown on the home screen. We have it to where it shows the user their permissions, and the permissions they requested, if they did request. If they are denied, the thought process is that it is their responsibility to check the status from an admin, or an admin will tell them.

- Landing Page for Student or Denied Instructor/Admin

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/4ca2f155-4d86-49d7-b654-fe131b0fc4a6)

- Landing page for approved Admin. The admin also has a drop down with various actions they can perform:

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/98329ae6-c5a3-4624-888d-462816439ff0)

- On the far right of the nav bar, users can see their first name, with a dropdown to edit their profile, view this readme page, and sign out

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/d8356c87-f13a-476b-b12f-8124cd299820)

- If logged in, then the user can reset their password and edit credentials from the edit profile page on the NAV bar. This will not be available for the default admin however. This is because we would not want anyone to change this user.
  
- We also have it where the user cannot change their email. This is because the email is a primary/foreign key for some features, so this could cause inconsistant data

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/ff626d09-5947-431c-9ca2-6137717b11bd)
 
- User IDs (email) are restricted to the OSU name.#@osu.edu format
- Note: one can do name.0@osu.edu

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/7f98baef-7dff-4131-98c9-9816abef0cc6)

### Course Catalog Page

- On default this will not be populated and an Admin will have to navigate to the Course Fetcher to reload the database with courses.
- After admin loads courses, all roles will be able to view CSE courses and sections within them:
- Admins are able to also create, edit and delete courses and sections
- Both the courses and sections can be searched in their respective pages and the results are paginated as well
- Also courses and sections can be sorted by clicking on the table head for the attribute you want to sort by
  
- Course Catalog from nav bar (Admin View):
  
![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/e7a7af59-9be1-4a96-9ec7-211325b773ba)

- Sections within Course(Admin View):

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/cb5885dc-81af-4ef9-98e4-f2e982013588)

- Section Catalog from nav bar (Admin View)

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/5a43b6fa-abc6-4474-9916-664ec8a5f861)

- If an instructor or student tries to create, edit and/or delete courses or sections, they will be brought back to the home screen with this message:
  
![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/06583243-287c-4e04-a39d-bd17d743b665)

- Admins can create courses/sections from the course/section catalog page, withing a specific course (for section creation), or from the nav bar:

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/56b1d3dc-59b4-4e26-b52c-17dce925b016)

### ADMIN ONLY: Permission Request Inbox Page

- Like mentioned previously, if a user on sign up selected Instructor or Admin role, an existing Admin has to take action from their Admin permission request page on the nav bar.

- Here you can either approve (giving them the Role indicated on the table), or deny them (having them keep their student role)
  
![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/7d320d87-2d91-4654-a20a-2b0aec279423)

### ADMIN ONLY: Reloading Database

- On first start up, admins will have to fetch courses to be populated in the database
- This can be done through the course fetcher, located on the nav bar or in the course catalog:
- In the course fetcher, one can reload the database where you can select a drop down for the campus and the term
- Note: Fetching classes will delete all current classes, sections, and related recommendation/grader applications

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/16f5af6e-d969-443d-bd0d-173d6df1bcbe)

### ADMIN ONLY: Grader Applications Inbox Page

- Admins can access grader applications from the nav bar:

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/52d72e77-6e40-42ae-8d83-89e04ac0d77c)

- Admins can accept or deny the request. Accepting application will increase the number of required graders by one for the section they are with.

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/c7ddd90d-96b3-4824-ba19-87a9bca016ec)

- If the application has recommendations, they can be viewed as well

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/401dd24c-2b99-40d9-82aa-bb7bfff8d0cb)

### INSTRUCTOR ONLY: Student Recommendation Submission Page

- Instructors can create, view, update, delete recommendations for students to be hired located in the nav bar:

![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/b6482e94-3026-4ed4-bd24-06069aac664c)

- On creation or edit, instructor can use the drop downs to select the course and the section, enter the students email, and give notes about the student if they want:
  
![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/8a0a6cc6-3245-4cec-8c14-6314f9119a49)
  
- If the student does not have an account, then it is up to the instructor to tell the student that they can log in with a temporary password (123123), and the student should change it after log in.
- Also as mentioned, these recommendations will appear with the associated grader application
- We also have it where admins can create/read/update/delete recommendations as well. The reasoning behind this is for admins to be aware of all recommendations, as well as the ability to control things better.

### STUDENT ONLY: Student-Grader Application Submission Page

- Students can create, view, update, delete their student-grader applications:
- Note: For admins, creating an application is one of the only things they cannot do. This is because we have the application associated with the current users email. Also, the thought process was that if the admin needed to create one, they could create a student account for the student, or just ask the student to create one.
  
![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/50204a20-b29e-403b-962f-eb84d7c4ccef)
![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/b636436a-5ed4-423c-9dc3-eaed0d73d22e)

- On creation or edit, student can use the drop downs to select the course and the section, enter their Grade Received in that course (this will be verified by admin), and their availability
- Days of the week available: User needs to Enter values 1-7 where 1 = Monday, 2 = Tuesday, etc. Example: 34 = Wed and Thur
  
![image](https://github.com/cse-3901-sharkey/2023-SU-Team-1-Lab-2/assets/64297592/88a3e77c-fc20-4d11-bb4f-81aaea50d6bb)

- This gets sent to admin for approval/denial.

## API Documentation

The class information is available at the following URL: [OSU Class Search](https://classes.osu.edu/class-search/#/)

The API URL is [OSU Content API](https://content.osu.edu/v2/classes/search)

Valid parameters for the API are:

- `q=` (can be blank, or "cse" for CSE Classes)
- `campus=` (col for Columbus)
- `p=` (page #, starting at 1)
- `term=` (1222 for Spring 2022, 1232=Spring 2023, 1234=Summer 2023, 1238 for Autumn 2023)
- `academic-career=ugrad` (for undergrad only classes)
- `subject=` (blank, or "cse")

A valid query would be: `https://content.osu.edu/v2/classes/search?q=&campus=col&p=1&term=1222`

## Installation

To install and run the Course Grader Management System locally, follow these steps:

1. Clone the repository
2. Install Ruby and Rails if you haven't already (follow instructions for your OS).
3. Install necessary gems: `bundle install`
4. Set up the database: `rails db:migrate` and `rails db:seed`
5. Doing this will populate default admin, student and instructor accounts
   - Admin username: admin.1@osu.edu password: Buckeye123$
   - Student username: studenttest.1@osu.edu password: foradmin$only123
   - Instructor username: instructortest.1@osu.edu password: foradmin$only123
6. Run the server: `rails server`

## Troubleshooting and Issues

While installing and running the Course Grader Management System, you may encounter some common issues. Here are potential troubleshooting steps to address them:

### 1. Ruby and Rails Installation Issues

- **Problem**: You encounter errors during the installation of Ruby and Rails.
- **Solution**: Double-check the installation instructions for your operating system and ensure you have followed all the steps correctly. Verify that you have the required dependencies and that the installation was successful. If you still encounter issues, refer to the Ruby and Rails community forums or documentation for help.

### 2. Bundle Install Fails

- **Problem**: Running `bundle install` results in gem installation errors.
- **Solution**: Check if all required gems are specified correctly in the project's Gemfile. Confirm that you have an active internet connection to download the gems. If some gems are outdated or incompatible, try updating them manually. In some cases, you might need to run `bundle update` or delete the `Gemfile.lock` and then rerun `bundle install`.

### 3. Database Setup Errors

- **Problem**: Running `rails db:migrate` and `rails db:seed` encounters database-related issues.
- **Solution**: Ensure you have the correct database configurations set up in `config/database.yml`. Double-check the database credentials, adapter, and encoding. If you are using a different database management system, make sure you have installed and configured it correctly. If the issue persists, check the Rails community forums or documentation for database-specific troubleshooting tips.

### 4. Default Accounts Not Created

- **Problem**: The default admin, student, and instructor accounts are not populated as expected.
- **Solution**: Verify that you have executed the database seed task correctly (`rails db:seed`). Check the seed file for any errors or modifications that might prevent the default accounts from being created. If the seed task fails, run it again to ensure the database is populated with the necessary data.

### 5. Authentication or Login Issues

- **Problem**: You are unable to log in with the provided default credentials.
- **Solution**: Double-check the provided usernames and passwords for accuracy. If the issue persists, confirm that the authentication process is functioning correctly and that the database contains the correct user records. Make sure the password encryption and validation mechanisms are implemented correctly. If necessary, try resetting the passwords for the default accounts using the Rails console.

### 6. Server Startup Problems

- **Problem**: Running `rails server` fails to start the application.
- **Solution**: Examine the error message displayed in the console for clues about the issue. Common reasons for server startup failures include port conflicts and missing gem dependencies. Ensure that the required gems are installed and updated. If there's a port conflict, try changing the default port (usually 3000) by using the `-p` option with the `rails server` command, for example: `rails server -p 3001`. 

If you encounter any other specific issues that are not covered here, it is recommended to check the error messages for clues, search for relevant information in the project's documentation or community forums. Remember to keep your development environment up-to-date and ensure you have the latest versions of Ruby, Rails, and other dependencies.


## Features

- Secure user authentication and authorization with the 'devise' gem.
- Integration with the OSU Content API to fetch CSE course information and store it in the database (SQLite or Postgres).
- Ability to reload the course catalog from the API, accessible only by Admin users.
- Application submission for Students to be considered as graders for specific courses.
- Administrator can view and manage applicant information, approve Instructors or additional Admins, and edit the number of graders required for each section.
- Recommendation submission form for Instructors to endorse or request specific students as graders.
- User-friendly interface for a streamlined and efficient workflow.

## Common Errors

- General Validations
- Having some roles being able to access features/pages they are not allowed to


## Contributors

* Alex Dippolito - Project Manager
* Chang Lu - HTTParty/Validations
* Evan Smith - Student Recommendations
* Jeff Thompson - Devise/Permissions
* Kayla Liggett - UI/Design
* Stephanie Dietrich - Admin Inboxes
* Xinnan Miao - Grader Applications

## License

[MIT License](LICENSE)
