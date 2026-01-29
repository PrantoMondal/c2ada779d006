const { z } = require("zod");

const vitalSchema = z
  .object({
    device_id: z
      .string({
        required_error: "Device ID is required",
        invalid_type_error: "Device ID must be a string",
      })
      .min(1, "Device ID cannot be empty"),

    timestamp: z
      .string({
        required_error: "Timestamp is required",
        invalid_type_error: "Timestamp must be a string",
      })
      .datetime({ message: "Timestamp must be a valid ISO datetime" }),

    thermal_value: z
      .number({
        required_error: "Thermal value is required",
        invalid_type_error: "Thermal value must be a number",
      })
      .int("Thermal value must be an integer")
      .min(0, "Thermal value cannot be less than 0")
      .max(3, "Thermal value cannot be greater than 3"),

    battery_level: z
      .number({
        required_error: "Battery level is required",
        invalid_type_error: "Battery level must be a number",
      })
      .min(0, "Battery level cannot be less than 0")
      .max(100, "Battery level cannot be greater than 100"),

    memory_usage: z
      .number({
        required_error: "Memory usage is required",
        invalid_type_error: "Memory usage must be a number",
      })
      .min(0, "Memory usage cannot be less than 0")
      .max(100, "Memory usage cannot be greater than 100"),
  })
  .refine(
    (data) => new Date(data.timestamp) <= new Date(),
    {
      message: "Future timestamp not allowed",
      path: ["timestamp"],
    }
  );

module.exports = { vitalSchema };
