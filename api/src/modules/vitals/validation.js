const { z } = require("zod");

const vitalSchema = z
  .object({
    device_id: z.string().min(1),
    timestamp: z.string().datetime(),
    thermal_value: z.number().min(0).max(100),
    battery_level: z.number().min(0).max(100),
    memory_usage: z.number().min(0).max(100),
  })
  .refine((data) => new Date(data.timestamp) <= new Date(), {
    message: "Future timestamp not allowed",
  });

module.exports = { vitalSchema };
