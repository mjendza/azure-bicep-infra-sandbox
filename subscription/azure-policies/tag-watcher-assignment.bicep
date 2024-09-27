targetScope = 'subscription'

param policyId string
param tagToWatch string
resource policyAssignment 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: 'audit-${tagToWatch}-resource-tag-pa' //Should be unique whithin your target scope
  properties: {
    policyDefinitionId: policyId // Reference a policy specified in the same Bicep file
    displayName: 'Audit the ${tagToWatch} on resources'
    description: 'Policy will Audit resources for tagging with a specific tag'
    parameters: {
      tagName: {
        value: tagToWatch
      }
    }
  }
}
