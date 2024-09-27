targetScope = 'subscription'


param servicesPrefix string = 'PL-VC-Feature'

module policyTagDef 'azure-policies/tag-watcher.bicep' = {
  name: '${servicesPrefix}-Portal-AccessPolicies-Module'
  params: {
  }
}

module policyTagAss 'azure-policies/tag-watcher-assignment.bicep' = {
  name: '${servicesPrefix}-Portal-AccessPolicies-Assignment-Module'
  params: {
    policyId: policyTagDef.outputs.policyId
    tagToWatch: 'sandbox'
  }
}
