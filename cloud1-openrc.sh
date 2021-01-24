export OS_AUTH_URL=https://linktoidentity.tld
export OS_TENANT_ID=tenantuuid
export OS_TENANT_NAME="tenantname"
unset OS_PROJECT_ID
unset OS_PROJECT_NAME
unset OS_USER_DOMAIN_NAME
unset OS_INTERFACE
export OS_USERNAME="username"
export OS_PASSWORD="p@$$w0rd"
export OS_REGION_NAME="RegionOne"
if [ -z "$OS_REGION_NAME" ]; then unset OS_REGION_NAME; fi
export OS_ENDPOINT_TYPE=publicURL
export OS_IDENTITY_API_VERSION=2
