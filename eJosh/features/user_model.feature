@user
Feature: Creation of User

#Background process contains all the statements which are common throughout all the scenarios
Background:
Given the user object

Scenario: User should be created successfully
When all the valid mandatory values are specified
Then User should be created successfully

Scenario: Login for the user not specified
When Login for user is not specified
Then user creation should be invalid with message "Login can't be blank"

Scenario: Email for the user not specified
When Email for user is not specified
Then user creation should be invalid with message "Email can't be blank"

Scenario: Password for the user not specified
When Password for user is not specified
Then user creation should be invalid with message "Password can't be blank"

Scenario: Password_confirmation for the user not specified
When Password_confirmation for user is not specified
Then user creation should be invalid with message "Password_confirmation can't be blank"

Scenario: Role_ID for the user not specified
When Role_ID for user is not specified
Then user creation should be invalid with message "Role can't be blank"

Scenario: Minimum password length for user should be 4
When password specified for user has length less than 4
Then user creation should be invalid with message "Minimum password length should be 4"
When password specified for user has length 4
Then user creation should be valid for entered minimum password length

Scenario: Password may contain only characters
When password specified for user contain only characters
Then user creation should be invalid with entered password of characters 

Scenario: Password may contain only numbers
When password specified for user contain only digits
Then user creation should be invalid with entered password of digits

Scenario: Maximum password length for user should be 40
When maximum length of the password specified for user exceeds 40
Then user creation should be invalid with message "Maximum password length should not exceed 40"
When maximum length of the password specified for user is 40
Then user creation should be valid for entered maximum password length

Scenario: Password and Password_confirmation should be same for user
When password and Password_confirmation specified for user are not identical
Then user creation should be invalid for the specified password values

Scenario: Minimum Login length for user should be 3
When minimum length of the Login specified for user is less than 3
Then user creation should be invalid with message "Minimum Login length for user should be 3"
When length of the Login specified for user is  3
Then user creation should be valid for the specified minimum Login length

Scenario: Maximum Login length for user should be 40
When maximum length of the Login specified for user exceeds 40
Then user creation should be invalid with message "Maximum Login length should not exceed 40"
When length of the Login specified for user is 40
Then user creation should be valid for the specified maximum Login length

Scenario: Minimum Email length for user should be 7
When minimum length of the Email specified for user is less than 7
Then user creation should be invalid with message "Minimum Email length for user should be 7"
When length of the Email specified for user is  7
Then user creation should be valid for the specified minimum Email length

Scenario: Maximum Email length for user should be 100
When maximum length of the Email specified for user exceeds 100
Then user creation should be invalid with message "Maximum Email length should not exceed 100"
When length of the Email specified for user is 100
Then user creation should be valid for the specified maximum Email length

Scenario: Invalid Email format for user should not be accepted
When format of Email provided by user does not include "@"
Then user creation should be invalid with message1 "Email should contain characters "@" & ".""

Scenario: Invalid Email format for user should not be accepted
When format of  Email provided by user does not include "."
Then user creation should also be invalid with message2 "Email should contain characters "@" & ".""

Scenario: Login for the user should be unique
Given second user object
When duplicate Login for user is specified
Then user creation should be invalid with message "Login for the user should be unique"

Scenario: Email for the user should be unique
Given second user object
When duplicate Email for user is specified
Then user creation should be invalid with message "Email for the user should be unique"

Scenario: Login for the user should be unique considering case sensitiveness
Given second user object
When duplicate Login for user is specified with different cases
Then also user creation should be invalid with message "Login for the user should be unique"

Scenario: Email for the user should be unique considering case sensitiveness
Given second user object
When duplicate Email for user is specified with different cases
Then also user creation should be invalid with message "Email for the user should be unique"

Scenario: Password for the user should be encrypted before saving into db
When Password for user is specified
Then it should be encrypted before saving into database

