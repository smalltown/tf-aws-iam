package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/collections"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestIamUsers(t *testing.T) {
	t.Parallel()

	// A unique ID we can use to namespace resources so we don't clash with anything already in the AWS account or
	// tests running in parallel
	uniqueID := random.UniqueId()

	groupNames := make(map[string]string)
	groupNames["read"] = fmt.Sprintf("read-%s", uniqueID)
	groupNames["write"] = fmt.Sprintf("write-%s", uniqueID)
	groupNames["robot"] = fmt.Sprintf("robot-%s", uniqueID)

	robotAccountName := fmt.Sprintf("robot-%s", uniqueID)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/iam-users",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"read_group_name":    groupNames["read"],
			"write_group_name":   groupNames["write"],
			"robot_group_name":   groupNames["robot"],
			"robot_account_name": robotAccountName,
		},

		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"default.tfvars"},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	groupNamesOutput := make(map[string][]string)
	groupNamesOutput["read"] = terraform.OutputList(t, terraformOptions, "read_group_names")
	groupNamesOutput["write"] = terraform.OutputList(t, terraformOptions, "write_group_names")
	groupNamesOutput["robot"] = terraform.OutputList(t, terraformOptions, "robot_group_names")

	accountIDMappingOutput := terraform.OutputMap(t, terraformOptions, "account_id_mapping")

	// Verify we're getting back the outputs we expect
	for groupRole, groupName := range groupNames {
		for accountAlias := range accountIDMappingOutput {
			assert.True(
				t,
				collections.ListContains(groupNamesOutput[groupRole], fmt.Sprintf("%s-%s", accountAlias, groupName)),
			)
		}
	}
}
