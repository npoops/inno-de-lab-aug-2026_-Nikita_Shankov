# Task 3: Safe API Configuration Parsing
# Configuration dictionary received from the initialization service
db_config = {
    "connection": {
        "host": "production-db.internal",
        "port": 5432,
        "user": "postgres"
    }
}

# Safely retrieve the nested "connection" dictionary using .get()
# If the key is missing, an empty dict is used as a fallback
connection = db_config.get("connection", {})

# Extract "host" and "port" values safely with default fallback values
host = connection.get("host", "localhost")
port = connection.get("port", 5432)

# Safely check for the "ssl_settings" key and nested "ssl_mode" key
# If either key is missing, the default value "verify-full" is used
ssl_mode = db_config.get("ssl_settings", {}).get("ssl_mode", "verify-full")

# Update the "user" field inside the connection dictionary to "admin"
connection["user"] = "admin"

# Add a new parameter "max_connections" with the value 100 to the connection dictionary
connection["max_connections"] = 100

# Iterate over the updated connection dictionary using .items() and print each key-value pair
print(f"SSL Mode: {ssl_mode}")
print("Connection parameters:")
for key, value in connection.items():
    print(f"  * {key}: {value}")