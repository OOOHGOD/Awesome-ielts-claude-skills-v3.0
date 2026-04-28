const { z } = require("zod");

const readingSchema = z.object({
  type: z.literal("reading"),
  date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  passage: z.string(),
  total_questions: z.number().int().min(1),
  correct: z.number().int().min(0),
  score: z.number().min(0).max(9).multipleOf(0.5),
  errors_by_type: z.record(z.string(), z.number().int()),
  synonyms_extracted: z.array(
    z.object({
      question: z.string(),
      passage: z.string(),
    })
  ),
});

module.exports = { readingSchema };
