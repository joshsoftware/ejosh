#attr_accessible :login, :email, :password, :password_confirmation, :role_id, :is_active

Given /^the user object$/ do
@user=User.new
end

Given /^second user object$/ do
@user2=User.new
end  

When /^all the valid mandatory values are specified$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password='3c2b1a'
@user.password_confirmation='3c2b1a'
@user.role_id=2
end

Then /^User should be created successfully$/ do
@user.should be_valid
end  

#------------------------------------------------------------------------------------------

When /^Login for user is not specified$/ do
@user.login=''
@user.email='np@xyz.com'
@user.password='3c2b1a'
@user.password_confirmation='3c2b1a'
@user.role_id=2
end  

Then /^user creation should be invalid with message "Login can't be blank"$/ do
@user.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^Email for user is not specified$/ do
@user.login='ninad'
@user.email=''
@user.password='3c2b1a'
@user.password_confirmation='3c2b1a'
@user.role_id=2
end

Then /^user creation should be invalid with message "Email can't be blank"$/ do
@user.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^Password for user is not specified$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password=''
@user.password_confirmation='3c2b1a'
@user.role_id=2
end

Then /^user creation should be invalid with message "Password can't be blank"$/ do
@user.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^Password_confirmation for user is not specified$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password='3c2b1a'
@user.password_confirmation=''
@user.role_id=2
end

Then /^user creation should be invalid with message "Password_confirmation can't be blank"$/ do
@user.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^Role_ID for user is not specified$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password='3c2b1a'
@user.password_confirmation='3c2b1a'
@user.role_id=''
end  

Then /^user creation should be invalid with message "Role can't be blank"$/ do
@user.should_not be_valid
end  
#------------------------------------------------------------------------------------------

When /^password specified for user has length less than 4$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password='3c'
@user.password_confirmation='3c'
@user.role_id=2
end

Then /^user creation should be invalid with message "Minimum password length should be 4"$/ do
@user.should_not be_valid
end  

When /^password specified for user has length 4$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password='3c2b'
@user.password_confirmation='3c2b'
@user.role_id=2
end  

Then /^user creation should be valid for entered minimum password length$/ do
@user.should be_valid
end  

#------------------------------------------------------------------------------------------
When /^password specified for user contain only characters$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password='zaxy'
@user.password_confirmation='zaxy'
@user.role_id=2
end

Then /^user creation should be invalid with entered password of characters$/ do 
@user.should_not be_valid
end

#------------------------------------------------------------------------------------------
When /^password specified for user contain only digits$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password='9732'
@user.password_confirmation='9732'
@user.role_id=2
end  

Then /^user creation should be invalid with entered password of digits$/ do
@user.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^maximum length of the password specified for user exceeds 40$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password='54321abcde12345vwxyz12345lmnop67891ghjkl66666'
@user.password_confirmation='54321abcde12345vwxyz12345lmnop67891ghjkl66666'
@user.role_id=2
end

Then /^user creation should be invalid with message "Maximum password length should not exceed 40"$/ do
@user.should_not be_valid
end

When /^maximum length of the password specified for user is 40$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password='54321abcde12345vwxyz12345lmnop67891ghjkl'
@user.password_confirmation='54321abcde12345vwxyz12345lmnop67891ghjkl'
@user.role_id=2
end  

Then /^user creation should be valid for entered maximum password length$/ do
@user.should be_valid
end  

#------------------------------------------------------------------------------------------

When /^password and Password_confirmation specified for user are not identical$/ do
@user.login='ninad'
@user.email='np@xyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321'
@user.role_id=2
end

Then /^user creation should be invalid for the specified password values$/ do
@user.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^minimum length of the Login specified for user is less than 3$/ do
@user.login='np'
@user.email='np@xyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end  

Then /^user creation should be invalid with message "Minimum Login length for user should be 3"$/ do
@user.should_not be_valid
end  

When /^length of the Login specified for user is  3$/ do
@user.login='npp'
@user.email='np@xyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end  

Then /^user creation should be valid for the specified minimum Login length$/ do
@user.should be_valid
end  

#------------------------------------------------------------------------------------------

When /^maximum length of the Login specified for user exceeds 40$/ do
@user.login='54321abcde12345vwxyz12345lmnop67891ghjkl66666'
@user.email='np@xyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end  

Then /^user creation should be invalid with message "Maximum Login length should not exceed 40"$/ do
@user.should_not be_valid
end

When /^length of the Login specified for user is 40$/ do
@user.login='54321abcde12345vwxyz12345lmnop67891ghjkl'
@user.email='np@xyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end

Then /^user creation should be valid for the specified maximum Login length$/ do
@user.should be_valid
end  

#------------------------------------------------------------------------------------------

When /^minimum length of the Email specified for user is less than 7$/ do
@user.login='npp'
@user.email='n@z.co'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end

Then /^user creation should be invalid with message "Minimum Email length for user should be 7"$/ do
@user.should_not be_valid
end

When /^length of the Email specified for user is  7$/ do
@user.login='npp'
@user.email='n@z.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end

Then /^user creation should be valid for the specified minimum Email length$/ do
@user.should be_valid
end  

#------------------------------------------------------------------------------------------

When /^maximum length of the Email specified for user exceeds 100$/ do
@user.login='npp'
@user.email='nnnnnnnnnnzzzzzzzzzzmmmmmmmmmmnnnnnnnnnnzzzzzzzzzzmmmmmmmmmm@znnnnnnnnnnzzzzzzzzzzmmmmmmmmmmnnnnnnnnnnzzzzzzzzzz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end

Then /^user creation should be invalid with message "Maximum Email length should not exceed 100"$/ do
@user.should_not be_valid
end

When /^length of the Email specified for user is 100$/ do
@user.login='npp'
@user.email='nnnnaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@z.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end

Then /^user creation should be valid for the specified maximum Email length$/ do
@user.should be_valid
end  

#------------------------------------------------------------------------------------------

When /^format of Email provided by user does not include "@"$/ do
@user.login='npp'
@user.email='npxyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end  
  
Then /^user creation should be invalid with message1 "Email should contain characters "@" & ".""$/ do
@user.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^format of  Email provided by user does not include "."$/ do
@user.login='npp'
@user.email='np@xyzcom'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end  
  
Then /^user creation should also be invalid with message2 "Email should contain characters "@" & ".""$/ do
@user.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^duplicate Login for user is specified$/ do
@user.login='npp'
@user.email='np@xyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
#save record to db for comparison
@user.save

@user2.login='npp'
@user2.email='abc@pqr.com'
@user2.password='21abcd'
@user2.password_confirmation='21abcd'
@user2.role_id=2
end

Then /^user creation should be invalid with message "Login for the user should be unique"$/ do
@user.should be_valid
@user2.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^duplicate Email for user is specified$/ do
@user.login='npp'
@user.email='np@xyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
#save record to db for comparison
@user.save

@user2.login='ppn'
@user2.email='np@xyz.com'
@user2.password='2abcd1'
@user2.password_confirmation='2abcd1'
@user2.role_id=2
end

Then /^user creation should be invalid with message "Email for the user should be unique"$/ do
@user.should be_valid
@user2.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^duplicate Login for user is specified with different cases$/ do
@user.login='xyz'
@user.email='np@xyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
#save record to db for comparison
@user.save

@user2.login='XYZ'
@user2.email='abc@pqr.com'
@user2.password='21abcd'
@user2.password_confirmation='21abcd'
@user2.role_id=2
end

Then /^also user creation should be invalid with message "Login for the user should be unique"$/ do
@user.should be_valid
@user2.should_not be_valid
end 

#------------------------------------------------------------------------------------------

When /^duplicate Email for user is specified with different cases$/ do
@user.login='npp'
@user.email='np@xyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
#save record to db for comparison
@user.save

@user2.login='ppn'
@user2.email='NP@XYZ.COM'
#@user2.email='NP@xyz.COM'
@user2.password='2abcd1'
@user2.password_confirmation='2abcd1'
@user2.role_id=2
end  
  
Then /^also user creation should be invalid with message "Email for the user should be unique"$/ do
@user.should be_valid
@user2.should_not be_valid
end  

#------------------------------------------------------------------------------------------

When /^Password for user is specified$/ do
@user.login='npp'
@user.email='np@xyz.com'
@user.password='54321abcde'
@user.password_confirmation='54321abcde'
@user.role_id=2
end  

Then /^it should be encrypted before saving into database$/ do
#save record to db for comparison
#While saving data into db initial password will be encrypted
@user.save
#Before saving object into db value for "crypted_password" will be nil
#But after saving it will be assigned with some value
@encrypted_pswd=@user.crypted_password
p @encrypted_pswd
@encrypted_pswd.should_not==""
end  

