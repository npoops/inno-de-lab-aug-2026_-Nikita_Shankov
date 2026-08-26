# Task 4: Access Rights Audit and Deduplication
# List of roles passed in the authorization request (contains duplicates)
requested_roles = ["guest", "developer", "guest", "admin",
                   "developer", "guest"]

# Set of roles required to perform administrative functions
required_admin_roles = {"admin", "security_officer", "audit_manager"}

# Convert the list to a set to instantly remove all duplicate roles
unique_requested_roles = set(requested_roles)

# Find roles that exist in both the requested set and the required admin roles set
# Using the intersection operator "&" for set comparison
common_roles = unique_requested_roles & required_admin_roles

# Find admin roles that were NOT requested by the user
# Using the difference operator "-" to subtract requested from required
missing_roles = required_admin_roles - unique_requested_roles

# Check if "security_officer" is present in the deduplicated set
# Using the "in" operator which runs in O(1) time on a set
has_security_officer = "security_officer" in unique_requested_roles

# Print all audit results
print(f"Unique requested roles: {unique_requested_roles}")
print(f"Common admin roles: {common_roles}")
print(f"Missing admin roles: {missing_roles}")
print(f"security_officer role present in request: {has_security_officer}")