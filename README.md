# myec2multiregion
deploy two ec2's one in us-west-2 (with an EIP) and the other in us-east-1

Have some fun with this and get the hang of Terraform. 

Make sure you run a terraform init command before running the code and download AWS CLI. 
AWS CLI will hold your secret key and accesss key given by AWS. 

https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html
  - Download according to your OS
  - Follow the steps then run 
  
Then open up your terminal and run this command:
  aws configure
  
Put in your secrets and you will no longer require to put your access key and secret key in your Terraform code which will help you follow best practices.

Enjoy and have a great day!
AJ Cottrell
