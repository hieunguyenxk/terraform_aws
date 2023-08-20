I. Setup credential for terraform

Create a profile named FADevOps with the required credentials

By default, these files are located at $HOME/.aws/config and $HOME/.aws/credentials on Linux and macOS, and "%USERPROFILE%\.aws\config" and "%USERPROFILE%\.aws\credentials" on Windows.

Example:
On Linux/Macos:
in the file $HOME/.aws/config, add the profile for this course.

[FADevOps]
aws_access_key_id = <Your Access Key>
aws_secret_access_key = <Your Profile Key>

II. To write the terraform code:

1. Create common modules on /common_modules folder
2. Create the main logic handler for all lab in /main_logic folder
3. Create variable file for each lab in /lab_var folder

III. Push your code to the same repo on the your branch follow this naming convention: <YourAccountID> Eg: thangtd18

NOTE: DO NOT USE FPT EMAIL FOR GIT
git config user.email "<your email address>"
git config user.name "your name" (DO NOT USE ACCOUNTID)