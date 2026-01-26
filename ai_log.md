# AI Log

## The Prompts:

### Prompt 1

I want to build a Node.js REST API using Express and SQLite.
Create a clean folder structure (routes, controllers, services, repositories, database, config etc)
Also include basic Express and SQLite setup.

### Prompt 2

Now create a POST API to store device vitals in SQLite.
Data format:
{
"device_id": "string",
"timestamp": "ISO8601 datetime",
"thermal_value": "number (0-3)",
"battery_level": "number (0-100)",
"memory_usage": "number (0-100)"
}
Requirements: Validate all fields, Use controller, service, and repository layers, Save data in SQLite

### Prompt 3

I want to host this Node.js API on Vercel for free.
How can I deploy it?

## The Wins

**Clean Folder Structure:** The prompt was clear about the desired folder structure, which was followed in the code.

- Before using AI:
  1. I knew how to build an Express API locally
  2. I did not know how Vercel hosts backend code
  3. I assumed I could just run app.listen() like a normal server

- After using AI:
  1. AI explained that Vercel uses serverless functions
  2. AI helped me restructure my API to work without a long-running server
  3. AI saved time by explaining deployment steps clearly instead of trial-and-error

## The Failures

## The Understanding
