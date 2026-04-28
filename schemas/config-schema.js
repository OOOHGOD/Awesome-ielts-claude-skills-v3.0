const { z } = require("zod");

const bandScore = z.number().min(0).max(9).multipleOf(0.5);

const configSchema = z.object({
  target: z.object({
    overall: bandScore,
    listening: bandScore,
    reading: bandScore,
    writing: bandScore,
    speaking: bandScore,
  }),
  exam: z.object({
    date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  }),
  level: z.object({
    current: z.enum(["beginner", "intermediate", "advanced"]),
    mock_scores: z.object({
      listening: bandScore,
      reading: bandScore,
      writing: bandScore,
      speaking: bandScore,
    }),
  }),
  preferences: z.object({
    study_hours_per_day: z.number().min(0.5).max(12),
    focus: z.enum(["listening", "reading", "writing", "speaking"]),
  }),
});

module.exports = { configSchema, bandScore };
