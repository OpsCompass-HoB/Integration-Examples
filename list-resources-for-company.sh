## This script assumes you have the dependency jq installed 
## Read more about jq https://jqlang.github.io/jq/

## Set the company name here
company_name="xxx"

resource_counter=0

while true; do
  resource_list=$(opscompass resources list --company "$company_name" --skip "$resource_counter" | jq -c '.[]')

  # Check to see if we have any more resources to process
  if [ -z "$resource_list" ]; then
    echo "Received an empty array. Exiting."
    break
  fi


  # Iterate over each JSON object
  while IFS= read -r resource; do
    ## Increment this for each resource we get
    ((resource_counter++))
    echo "Processing JSON object #$resource_counter"
    echo "Resource ID: $(echo "$resource" | jq -r '.id')"
  done <<< "$resource_list"

done
