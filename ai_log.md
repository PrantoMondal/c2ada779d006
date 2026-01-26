# AI Log

### Prompt 1

I want to build a Node.js REST API using Express and SQLite.
Create a clean folder structure (routes, controllers, services, repositories, database, config etc)
Also include basic Express and SQLite setup.

### Prompt 2

Now create a POST API to store device vitals in SQLite.

Data format:
{\n
"device_id": "string",\n
"timestamp": "ISO8601 datetime",\n
"thermal_value": "number (0-3)",\n
"battery_level": "number (0-100)",\n
"memory_usage": "number (0-100)"\n
}\n

Requirements: Validate all fields, Use controller, service, and repository layers, Save data in SQLite
