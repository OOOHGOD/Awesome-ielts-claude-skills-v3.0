const { z } = require("zod");

const listeningSchema = z.object({
  type: z.literal("listening"),
  date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  section: z.enum(["section1", "section2", "section3", "section4", "full"]),
  total_questions: z.number().int().min(1),
  correct: z.number().int().min(0),
  score: z.number().min(0).max(9).multipleOf(0.5),
  errors_by_type: z.record(z.string(), z.number().int()),
  error_details: z.array(
    z.object({
      question: z.string(),
      user_answer: z.string(),
      correct_answer: z.string(),
      error_type: z.enum([
        "spelling",
        "synonym",
        "distraction",
        "speed",
        "grammar",
        "number",
        "attention",
      ]),
    })
  ),
});

module.exports = { listeningSchema };
