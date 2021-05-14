# lambda-layer-terraform

Create a AWS lambda layer for Terraform runtime. Inspire from https://github.com/aws-samples/aws-lambda-layer-kubectl

# Build and deploy the layer
```shell
export AWS_PROFILE=your-profile
./build.sh && ./publish.sh
```

# Sample lambda function
To deploy the sample lambda function
```shell
export AWS_PROFILE=your-profile
cd sample && terraform init -input=false && terraform apply -input=false -auto-approve
```
