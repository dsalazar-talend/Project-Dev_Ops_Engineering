stackname="KubernetesStack"
tempfile="kubernetes.yml"
# Check if the stack exists
if [[ ! $(aws cloudformation describe-stacks --region us-west-2 --stack-name $stackname) ]]
then
    # No description means stack is empty
    echo "Creating Stack"
    aws cloudformation create-stack --stack-name $stackname --template-body file://$tempfile --parameters ParameterKey=EnvironmentName,ParameterValue=UdagramDEV --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2
    # Wait for stack creation to complete
    aws cloudformation wait stack-create-complete --stack-name $stackname
else
    # Description means stack exists
    echo "Stack exists, attempting to update instead"
    # Update stack
    update_output=$( \
        aws cloudformation update-stack --stack-name $stackname --template-body file://$tempfile --parameters ParameterKey=EnvironmentName,ParameterValue=UdagramDEV --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2 \
        # Parse the StackId
        ${@:3}  2>&1)
    status=$?
    trap 'exit' ERR
    echo "${update_output}"
    # If the status is not empty
    if [[ $status -ne 0 ]]
    then
        # Either the yaml file is invalid or Stack is up to date
        if [[ $update_output == *"ValidationError"* && $update_output == *"No updates"* ]]
        then
            echo "Stack is already up to date"
            exit 0
        else
            exit $status
        fi
    fi
    # Wait for stack update to complete
    aws cloudformation wait stack-create-complete --stack-name $stackname
fi