# Task 5*: Infrastructure Metrics Collector
# Telemetry data stream from cluster servers
# Each tuple contains: (node_name, cpu_load, ram_usage, status)
system_telemetry = [
    ("srv_01", 12.5, 64, "online"),
    ("srv_02", 85.0, 92, "online"),
    ("srv_03", 0.0,  0,  "offline"),
    ("srv_04", 45.2, 78, "online"),
    ("srv_05", 95.1, 99, "online")
]

# Unpack each tuple into variables and filter out servers with "offline" status
# Unpacking is done directly in the "for" clause of the list comprehension
active_nodes = [
    node_name
    for node_name, cpu_load, ram_usage, status in system_telemetry
    if status != "offline"
]

# Collect CPU load values only from active servers
active_cpu = [
    cpu_load
    for node_name, cpu_load, ram_usage, status in system_telemetry
    if status != "offline"
]

# Collect RAM usage values only from active servers
active_ram = [
    ram_usage
    for node_name, cpu_load, ram_usage, status in system_telemetry
    if status != "offline"
]

# Calculate aggregated metrics using built-in functions
# Count the total number of active servers using len()
active_count = len(active_nodes)

# Calculate average CPU load rounded to 2 decimal places using sum() and len()
average_cpu = round(sum(active_cpu) / len(active_cpu), 2)

# Find the peak RAM usage value using max()
max_ram = max(active_ram)

# Build the final nested report dictionary with all calculated metrics
telemetry_report = {
    "active_nodes_count": active_count,
    "metrics": {
        "average_cpu": average_cpu,
        "max_ram": max_ram
    }
}

# Print the list of active node names
print(f"Active nodes online: {active_nodes}")

# Print the final telemetry report dictionary
print("Final telemetry report:")
print(telemetry_report)