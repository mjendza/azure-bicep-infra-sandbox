targetScope = 'subscription'

param policyName string = 'audit-resource-group-tag-pd'
param policyDisplayName string = 'Audit a tag on resource groups'
param policyDescription string = 'Audits existence of a tag. Does not apply to individual resources.'

resource policy 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: policyName
  properties: {
    displayName: policyDisplayName
    description: policyDescription
    policyType: 'Custom'
    mode: 'All'
    metadata: {
      category: 'Tags'
    }

    parameters: {
      tagName: {
        type: 'String'
        metadata: {
          displayName: 'Tag name'
          description: 'A tag to audit'
        }
      }
    }

    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Resources/subscriptions/resourceGroups'
          }
          {
            field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]'
            exists: false
          }
        ]
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

output policyId string = policy.id