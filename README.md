# AWS Gameday with Prisma Cloud Vulnerable Infrastructure Provisioning Script
This is a simple script to provision a vulnerable infrastructure for AWS Gameday together with Prisma Cloud. The intention of this vulnerable infrastructure is for educational purpose only.

## General 
The vulnerable infrastructure include the following:
* Network components for the vulnerable infrastructure, such as VPC, subnets, security groups, route tables, etc
* EC2 instances that are generated as part of the game, which includes vulnerable and non-vulnerable instances
* S3 bucket with dummy sensitive data
The script will generate several instances which different combinations, such as log4j vulnerability, public exposure, IMDSv1/v2, with/without access to sensitive data. The goal is to get the participants to provide the correct answer on the questions asked. 

### Prerequisites

- Terraform installed
- AWS credentials configured (via `~/.aws/credentials` or environment variables)
- AWS account with appropriate permissions for VPC, EC2, IAM, S3

### Usage

1. Clone the repository:
   ```
   bash
   git clone https://github.com/chiangyaw/aws-gameday-vul-infra-provisioning.git
   cd aws-gameday-vul-infra-provisioning
   ```

2. Initialize Terraform:
    ```
    terraform init
    ```

3. Apply the Terraform plan:
    ```
    terraform apply
    ```

4. After the deployment is complete, run through the challenge below and see how many you can answer correctly.

5. Optional - to check on the answers, you can unmask the resource blocks on ```output.tf```, and run ```terraform apply``` to get the details.

### Challenge
1. Utilizing the native security tools in AWS, such as AWS Inspector, etc, provide the ```frontend``` EC2 instance ID with the following:
    * vulnerable to Log4j vulnerability
    * publicly exposed
    * not configured with IMDSv2
    * have s3:GetObject and s3:ListBucket permission to S3 with sensitive data

2. Utilizing native controls in AWS, configure/remediate the same instance as above, with IMDSv2.

3. It have been identified that the same instance is accessible via SSH from public network, provide the Security Group ID for the instance.

4. Utilizing native controls in AWS, remove/remediate the SSH access from public network for this particular Security Group.

5. Utilizing Prisma Cloud, provide the ```backend``` EC2 instance ID with the following:
    * vulnerable to Log4j vulnerability
    * publicly exposed
    * not configured with IMDSv2
    * have s3:GetObject and s3:ListBucket permission to S3 with sensitive data

6. Utilizing Prisma Cloud, configure/remediate the same instance as above, with IMDSv2.

7. It have been identified that the same instance is accessible via SSH from public network, provide the Security Group ID for the instance on Prisma Cloud.

8. Utilizing Prisma Cloud, remove/remediate the SSH access from public network for this particular Security Group.

### Cleanup
To remove the deployed infrastructure, run:
    ```
    terraform destroy
    ```


