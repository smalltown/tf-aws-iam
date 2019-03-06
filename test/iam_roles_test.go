package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestIamRoles(t *testing.T) {
	t.Parallel()

	// A unique ID we can use to namespace resources so we don't clash with anything already in the AWS account or
	// tests running in parallel
	uniqueID := random.UniqueId()
	readAccountName := fmt.Sprintf("read-%s", uniqueID)
	writeAccountName := fmt.Sprintf("write-%s", uniqueID)
	robotAccountName := fmt.Sprintf("robot-%s", uniqueID)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/iam-roles",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"read_account_name":  readAccountName,
			"write_account_name": writeAccountName,
			"robot_account_name": robotAccountName,
		},

		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"default.tfvars", "read.tfvars", "write.tfvars"},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	readAccountNameOutput := terraform.Output(t, terraformOptions, "read_role_name")
	writeAccountNameOutput := terraform.Output(t, terraformOptions, "write_role_name")
	robotAccountNameOutput := terraform.Output(t, terraformOptions, "robot_role_name")

	// Verify we're getting back the outputs we expect
	assert.Equal(t, readAccountName, readAccountNameOutput)
	assert.Equal(t, writeAccountName, writeAccountNameOutput)
	assert.Equal(t, robotAccountName, robotAccountNameOutput)
}
