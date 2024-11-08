# alloy-terraform

Components:
VPC - The VPC is created with 1 public and 2 private subnets across 2 availability zones. 
1 public subnet contains a NAT gateway and the other a bastion host. 2 of the private 
subnets are for our application and 2 are for our database. The goal was to 
increase availability by using multiple AZs and to increase security by making our 
application and db only available from inside of our VPC.

Application Load Balancer - This points to our 2 application ec2 instances and distributes 
traffic. It could be changed to a network load balancer if this was a high volume service, 
however I designed with a smaller web app in mind. 

EC2 - I created 3 instances, two to run our application in each subnet and one to run our 
bastion host. I kept these lean for the sake of simplicity but would likely be looking to 
add containerization and scaling for most use cases.

RDS - This is deployed across both availability zones in our private subnets. Currently 
has a standby instance for resiliency however this could benefit from scaling as well.

Possible improvements:
    -Add TLS to load balancer for security 
    -Scaling for RDS 
    -Containerize ec2 instances
    -Orchestration via kubernetes or AWS autoscaler
    -Add remote backend for terraform state
    -Use secrets manager
    -Add support for multiple environments

Organization:
I decided not to create modules here as the code mostly uses other modules already. I would
prefer to create a new module as a wrapper if I wanted to control what variables could be tweaked
by someone. In this case I believe the variables files offers enough reusability (though more 
could be added). I also decided to not leave all of the modules in the main.tf and separate them 
by component for readability.

